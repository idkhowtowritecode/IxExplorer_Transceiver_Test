import os, sys, subprocess, datetime, json, re, configparser
from constants import *

@timer
def resource_path(relative_path):
    if hasattr(sys, '_MEIPASS'):
        return os.path.join(sys._MEIPASS, relative_path)
    return os.path.join(os.path.abspath("."), relative_path)
@timer
def load_config(configFile='config.ini'):
    userconfig = configparser.ConfigParser()
    userconfig.read(configFile)

    start_time = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")
    config = {}
    config['start_time'] = start_time
    # read test config
    config['host'] = userconfig.get("TEST", "host", fallback="192.168.11.109")
    config['ixos_version'] = userconfig.get("TEST", "ixos_version", fallback="10.80.8001.4")
    config['tester'] = userconfig.get("TEST", "tester", fallback="AresONE800MDUAL")
    config['test_ports'] = userconfig.get("TEST", "test_ports", fallback="1 2")
    config['test_mode'] = userconfig.get("TEST", "test_mode", fallback="Framed")
    config['test_speed'] = userconfig.get("TEST", "test_speed", fallback="800")
    config['serdes'] = userconfig.get("TEST", "serdes", fallback="112")
    config['test_duration'] = userconfig.get("TEST", "test_duration", fallback="30")
    config['test_frameSize_list'] = userconfig.get("TEST", "test_frameSize_list", fallback="64")
    config['wait_time_before_startTest'] = userconfig.get("TEST", "wait_time_before_startTest", fallback="30")
    config['result_option'] = userconfig.get("TEST", "result_option", fallback="portStats portPcsLaneStats transceiverDomStats transceiverAppSelStats bertLaneStats i2cStats")
    # read threshold config
    config['pre_fec_standard'] = userconfig.get("THRESHOLD", "pre_fec_standard", fallback="2.4e-4")
    config['post_fec_standard'] = userconfig.get("THRESHOLD", "post_fec_standard", fallback="9.2e-13")
    test_speed = config['test_speed']
    config['log_dir'] = f'/log/{start_time}_{test_speed}G'
    config['tmp_dir'] = f'/tmp'
    config['result_dir'] = f'./result/{start_time}_{test_speed}G/'
    config['verbose'] = userconfig.get("TEST", 'verbose', fallback="true")

    return config
@timer
def load_json_data(json_folder):
    all_data = {}
    for filename in os.listdir(json_folder):
        if filename.endswith(".json"):
            filepath = os.path.join(json_folder, filename)
            with open(filepath, encoding="utf-8") as f:
                try:
                    data = json.load(f)
                    key = os.path.splitext(os.path.basename(filename))[0]
                    all_data[key] = data
                except Exception as e:
                    print(f"Load Json Fail {filename}: {e}")
                    exit
    return all_data

@timer
def check_result(all_data):
    import check_result
    result  = check_result.result(all_data)
    return result.process()

@timer
def generate_report(result):
    import report_formatter
    report = report_formatter.Keysight_Report(result)
    report.generate()
    return 0

if __name__ == "__main__":
    config = load_config()

    log_dir = config['log_dir']
    result_dir = config['result_dir']
    tmp_dir = config['tmp_dir']

    if not os.path.exists("./log"):
        os.mkdir("./log")
    if not os.path.exists(f'.{log_dir}'):
        os.mkdir(f'.{log_dir}')
    if not os.path.exists("./result"):
        os.mkdir("./result")
    if not os.path.exists(f'{result_dir}'):
        os.mkdir(f'{result_dir}')
    if not os.path.exists("./tmp"):
        os.mkdir("./tmp")
    
    tcl_exec = resource_path("transceivertest.tcl")
    log_pattern = re.compile(r"\[\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}\]")
    with subprocess.Popen(['C:/Program Files (x86)/ixia/Tcl/8.5.17.0/bin/tclsh.exe', tcl_exec,
                            config["host"], config["ixos_version"], config["tester"], 
                           config["test_ports"], config["test_mode"], config["test_speed"], 
                           config["serdes"], config["test_duration"], config["test_frameSize_list"], 
                           config["wait_time_before_startTest"] , log_dir, tmp_dir, config["result_option"]], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True) as proc:
        for line in proc.stdout:
            line = line.strip()
            if  config['verbose'].lower() == 'true':
                print(line) 
            else :
                if log_pattern.search(line):
                    print(line) 
    config['end_time'] = datetime.datetime.now().strftime("%Y%m%d-%H%M%S")

    ### Load Result ###

    all_result = load_json_data(f'.{tmp_dir}')
    all_result['config'] = config

    ### Generate Report ###
    report_data = check_result(all_result)

    if  config['verbose'].lower() == 'true':
        with open(f'tmp_report_data.json', 'w+') as f:
            f.write(json.dumps(report_data))
    generate_report(report_data)

    try:
        for _tmpfile in os.listdir('./tmp'):
            os.remove(f'./tmp/{_tmpfile}')
        os.rmdir("./tmp")
    except:
        pass