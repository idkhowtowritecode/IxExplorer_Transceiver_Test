from datetime import timedelta
from constants import *

class result(object):
    def __init__(self, all_data: dict):
        self.data = all_data
        self.basic = all_data['config']
        self.summary = {}
        self.prbsCode = prbsPattern()
    @timer      
    def process(self):
        ### Port Statistics ###
        ### PCS Lane ###
        ### Transceiver DOM ###
        if self.basic['test_mode'].lower() == 'framed':
            for frameSize in self.basic['test_frameSize_list'].split(' '):
                self.summary[f"portStats{frameSize}"] = self.process_port_stats(self.data.get(f'portStats_{frameSize}Byte', {}), frameSize)
                # self.summary[f"pcsLane{frameSize}"] = self.process_pcs_lane_stats(self.data.get(f'pcsLane_{frameSize}Byte', {}))
                # self.summary[f"transceiverDOM{frameSize}"] = self.process_dom_stats(self.data.get(f'transceiverDOM_{frameSize}Byte', {}))
        elif self.basic['test_mode'].lower() == 'unframed':
            self.summary["portStatsBERT"] = self.process_port_stats(self.data.get("portStats_BERT", {}))
            self.summary["transceiverDOMBERT"] = self.process_dom_stats(self.data.get("transceiverDOM_BERT", {}))
        # self.summary["appSel"] = self.process_app_sel_stats(self.data.get("appSel", {}))
        # self.summary["berLane"] = self.process_bert_lane_stats(self.data.get(f'berLane', {}))
        #self.summary["i2c"] = self.process_i2c_stats(self.data.get("i2c", {}))
        self.save()
        self.summary['config'] = self.data['config']
        return self.summary
    @timer
    def save(self):
        for key in self.data.keys():
            if "portStats" in key:
                self.save_port_stats(self.data[key], key.split('_')[-1])
            elif "pcsLane" in key:
                self.save_pcs_stats(self.data[key], key.split('_')[-1])
            elif "transceiverDOM" in key:
                self.save_dom_stats(self.data[key], key.split('_')[-1])
            elif "appSel" in key:
                self.save_app_sel_stats(self.data[key])
            elif "berLane" in key:
                self.save_bert_lane_stats(self.data[key])
            elif "i2c" in key:
                self.save_i2c_stats(self.data[key])

    def format_seconds_to_HHMMSS(self, ns: int) -> str:
        seconds = ns/1000000000
        td = timedelta(seconds=seconds)
        total_minutes = td.total_seconds() // 60
        hours = int(total_minutes // 60)
        minutes = int(total_minutes % 60)
        seconds = int(td.total_seconds() % 60)
        ns = ns % 1000000000
        return f"{hours:02d}:{minutes:02d}:{seconds:02d}.{ns:09d}"

    def make_port_pairs(self, ports):
        port_pairs = []

        for i in range(0, len(ports) - 1, 2):
            port_pairs.append((ports[i], ports[i + 1]))

        return port_pairs

    def compare_port_pair(self, stats: dict):
        port_pairs = self.make_port_pairs(list(stats.keys()))
        if port_pairs == []:
            p1 = list(stats.keys())[0]
            tx = stats.get(p1, {}).get("framesSent", 0)
            rx = stats.get(p1, {}).get("framesReceived", 0)
            stats[p1]['Loss_Frames'] = int(tx) - int(rx)
            stats[p1]['Loss%'] = (int(tx) - int(rx)) / int(rx)
        else:
            for p1, p2 in port_pairs:
                p1_tx = stats.get(p1, {}).get("framesSent", 0)
                p1_rx = stats.get(p1, {}).get("framesReceived", 0)
                p2_tx = stats.get(p2, {}).get("framesSent", 0)
                p2_rx = stats.get(p2, {}).get("framesReceived", 0)
                stats[p1]['Loss_Frames'] = int(p1_tx) - int(p2_rx)
                stats[p1]['Loss%'] = (int(p1_tx) - int(p2_rx)) / int(p1_tx)
                stats[p2]['Loss_Frames'] = int(p2_tx) - int(p1_rx)
                stats[p2]['Loss%'] = (int(p2_tx) - int(p1_rx)) / int(p2_tx)
                stats[p1]['framesSent'] = p1_tx
                stats[p1]['framesReceived'] = p2_rx
                stats[p2]['framesSent'] = p2_tx
                stats[p2]['framesReceived'] = p1_rx
        return stats
    
    @timer
    def l2_summary(self, stats: dict):
        l2Summary = {}
        tx = 0
        rx = 0
        loss = 0
        for port in stats.keys():
            tx = tx + int(stats[port].get("framesSent", 0))
            rx = rx + int(stats[port].get("framesReceived", 0))
            loss = tx - rx
        l2Summary['tx'] = str(tx)
        l2Summary['rx'] = str(rx)
        l2Summary['loss'] = str(loss)
        if tx == 0:
            l2Summary['loss%'] = '0.00'
        else:
            l2Summary['loss%'] = str(loss/tx)
        return l2Summary
    @timer
    def fec_Summary(self, stats: dict):
        fecSummary = {}
        for port in stats.keys():
            fecSummary[port] = {}
            pre_fec = f'{float(stats[port].get("preFecBer", 0)):.6e}'
            post_fec = f'{float(stats[port].get("fecFrameLossRatio", 0)):.6e}'
            fecSummary[port]['pre_fec'] = 'PASS' if float(pre_fec) < float(self.basic.get("pre_fec_standard", '2.4e-4')) else "FAIL"
            fecSummary[port]['post_fec'] = 'PASS' if float(post_fec) < float(self.basic.get("post_fec_standard", '9.2e-13')) else "FAIL"
            fecSummary[port]['pre_fec_threshold'] = f'{float(self.basic.get("pre_fec_standard", "2.4e-4")):6e}'
            fecSummary[port]['post_fec_pre_fec_threshold'] = f'{float(self.basic.get("post_fec_standard", "9.2e-13")):6e}'
        return fecSummary
    
    @timer    
    def ber_summary(self, stats: dict):
        berSummary = {}
        for port in stats.keys():  
            berSummary[port] = {}
            ber = stats[port].get("bertBitErrorRatio",0)
            berSummary[port]['ber']  = 'PASS' if float(ber) < float(self.basic.get("pre_fec_standard", '2.4e-4')) else "FAIL"
            berSummary[port]['threshold']  = f'{float(self.basic.get("pre_fec_standard", "2.4e-4")):.6e}'
            #berSummary[port]['threshold']  = f'{float(berSummary[port].get("threshold", "2.4e-4")):.6e}'
            
        return berSummary
    @timer
    def process_port_stats(self, stats: dict, frameSize='0'):
        if self.basic['test_mode'].lower() == 'unframed':
            ### Unframed ###
            self.summary[f'berSummary'] = self.ber_summary(stats)
            for port in stats.keys():
                stats[port]['link'] = 'link up' if stats[port]['link'] == '1' else 'link down'
                stats[port]['encoding'] = 'PAM4 106G' if stats[port]['encoding'] == '2' else 'Unknown'
                stats[port]['bertBitErrorRatio'] = f'{float(stats[port].get("bertBitErrorRatio")):.6e}'
                stats[port]['bertTransmitDuration'] = self.format_seconds_to_HHMMSS(int(stats[port]['bertTransmitDuration']))
        elif self.basic['test_mode'].lower() == 'framed':
            self.summary[f'l2Summary{frameSize}'] = self.l2_summary(stats)
            self.summary[f'fecSummary{frameSize}'] = self.fec_Summary(stats) 
            ### Framed ###
            stats = self.compare_port_pair(stats)
            for port in stats.keys():
                stats[port]['link'] = 'link up' if stats[port]['link'] == '1' else 'link down'
                # stats[port]['encoding'] = 'PAM4 106G' if stats[port]['encoding'] == '2' else 'Unknown'
                # stats[port]['fecStatus'] = 'KP4-FEC' if stats[port]['fecStatus'] == '4' else 'Unknown'
                # stats[port]['preFecBer'] = f'{float(stats[port].get("preFecBer", 0)):.6e}'
                stats[port]['fecFrameLossRatio'] = f'{float(stats[port].get("fecFrameLossRatio", 0)):.6e}'
                stats[port]['transmitDuration'] = self.format_seconds_to_HHMMSS(int(stats[port]['transmitDuration']))
        return stats
    @timer
    def process_pcs_lane_stats(self, stats: dict):
        countableLaneStats = ["syncHeaderErrorCount", "pcsLaneMarkerErrorCount", "bip8ErrorCount", "fecSymbolErrorCount", "fecCorrectedBitsCount", "fecSymbolErrorRate", "fecCorrectedBitRate"]
        stateLaneStats = ["syncHeaderLock", "pcsLaneMarkerLock", "lostSyncHeaderLock", "lostPcsLaneMarkerLock"]
        for port in stats.keys():
            totalPcsLaneStat = {}
            totalPcsLaneStat['pcsLaneMarkerMap'] = 'all'
            totalPcsLaneStat['relativeLaneSkew'] = str(max(float(item['relativeLaneSkew']) for item in stats[port]))
            for countable in countableLaneStats:
                totalPcsLaneStat[countable] = str(sum(float(item[countable]) for item in stats[port]))
            for state in stateLaneStats:
                totalPcsLaneStat[state] = "0" if any(item.get(state, 0) == '0' for item in stats[port]) else "1"
            stats[port].insert(0,totalPcsLaneStat)
            for state in stateLaneStats:
                for perPcsLane in stats[port]:
                    perPcsLane[state] = 'Lock' if perPcsLane[state] == '1' else 'Unlock'
            for perPcsLane in stats[port]:
                perPcsLane['fecSymbolErrorRate'] = f'{float(perPcsLane["fecSymbolErrorRate"]):6e}'
                perPcsLane['fecCorrectedBitRate'] = f'{float(perPcsLane["fecCorrectedBitRate"]):6e}'
        return stats
    
    dataPathStat = {'0':'0','1':'1','2':'2','3':'3','4':'Activated (4)','5':'5','6':'6','7':'7','8':'8','9':'9','10':'10','11':'11','12':'12','13':'13','14':'14','15':'15'}
    txLos = {'0':'No','1':'Yes'}
    txCdrLol = {'0':'No','1':'Yes'}
    rxLos = {'0':'No','1':'Yes'}
    rxCdrLol = {'0':'No','1':'Yes'}
    @timer
    def process_dom_stats(self, stats: dict):
        for port in stats.keys():
            for k in stats[port].keys():
                if k == 'hostDataPathState':
                    for i in range(len(stats[port][k])):
                        stats[port][k][i] = self.dataPathStat[stats[port][k][i]]
                elif k == 'hostTxLos':
                    for i in range(len(stats[port][k])):
                        stats[port][k][i] = self.txLos[stats[port][k][i]]
                elif k == 'hostTxCdrLol':
                    for i in range(len(stats[port][k])):
                        stats[port][k][i] = self.txCdrLol[stats[port][k][i]]
                elif k == 'mediaRxLos':
                    for i in range(len(stats[port][k])):
                        stats[port][k][i] = self.rxLos[stats[port][k][i]]
                elif k == 'mediaRxCdrLol':
                    for i in range(len(stats[port][k])):
                        stats[port][k][i] = self.rxCdrLol[stats[port][k][i]]
                elif k == 'appSelCurrentValueProperty':
                    for i in range(len(stats[port][k])):
                        self.data.get("appSel", {})[port]['appSelCurrentValueProperty'] = stats[port][k][i]
        return stats
    @timer
    def process_app_sel_stats(self, stats: dict):
        return stats

    def findPrbsPattern(self, pattern, pattern_type, _type='tx'):
        if _type == 'tx':
            for key in self.prbsCode.txPrbsPattern:
                if str(pattern) == str(self.prbsCode.txPrbsPattern[key]):
                    pattern = key
                    break
        elif _type == 'rx':
            for key in self.prbsCode.rxPrbsPattern:
                if str(pattern) == str(self.prbsCode.rxPrbsPattern[key]):
                    pattern = key
                    break
        if pattern_type == "1":
            pattern += 'Q'
        return pattern

    def findLock(self, code=0):
        state = self.prbsCode.lockLostIcon[code]
        return state
    @timer
    def process_bert_lane_stats(self, stats: dict):
        countableLaneStats = ['bertBitsSent','bertBitsReceived','bertBitErrorsReceived','bertBitErrorRatio']
        stateLaneStats = ['bertPatternLock']
        for port in stats.keys():
            totalBerLaneStat = stats[port][0].copy()
            for countableLaneStat in countableLaneStats:
                totalBerLaneStat[countableLaneStat] = str(sum(float(item[countableLaneStat]) for item in stats[port]))
            for state in stateLaneStats:
                totalBerLaneStat[state] = "0" if any(item.get(state, 0) == '0' for item in stats[port]) else "1"
            stats[port].insert(0,totalBerLaneStat)
            for berLane in stats[port]:
                berLane['bertPatternLock'] = 'lock' if berLane['bertPatternLock'] == '1' else 'unlock'
                berLane['bertPatternTransmitted'] = self.findPrbsPattern(berLane['bertPatternTransmitted'], berLane['bertPam4QPattern'], 'tx')
                berLane['bertPatternReceived'] = self.findPrbsPattern(berLane['bertPatternReceived'], berLane['bertPam4QPattern'], 'rx')
                berLane['bertBitErrorRatio'] = f'{float(berLane["bertBitErrorRatio"]):6e}'
        return stats
    @timer
    def process_i2c_stats(self, stats: dict):
        return stats
    @timer
    def save_port_stats(self, stats: dict, frameSize='0'):
        first_key = next(iter(stats)) 
        portStatsCaption = list(stats[first_key].keys())
        lines = "Port Flow Statistics,"
        for port in stats.keys():
            portId = port.split(',')[-1]
            lines += f'Port {portId},'
        lines += '\n'
        for caption in portStatsCaption:
            lines += f'{caption},'
            for port in stats.keys():
                lines += f'{stats[port][caption]},'
            lines += '\n'
        dir = self.basic['result_dir']
        with open(f'{dir}portStats_{frameSize}.csv', 'w+') as f:
            f.write(lines)
        return
    @timer
    def save_pcs_stats(self, stats: dict, frameSize='0'):
        captions = ['pcsLaneMarkerLock', 'pcsLaneMarkerMap', 'relativeLaneSkew', 'pcsLaneMarkerErrorCount', 'fecSymbolErrorCount', 'fecCorrectedBitsCount', 'fecSymbolErrorRate', 'fecCorrectedBitRate']
        lines = "Physical Lane,PCS Lane Marker Lock,PCS Lane Marker Map,Relative Lane Skew (ns),PCS Lane Marker Error Count,FEC Symbol Error Count,FEC Corrected Bits Count,FEC Symbol Error Rate,FEC Corrected Bit Rate\n"
        for port in stats.keys():
            portId = port.split(',')[-1]
            lines += f'Port {portId}\n'
            _pcsIndex = 0
            for pcsLane in stats[port]:
                if _pcsIndex == 0:
                    lines += 'Totals, '
                else :
                    lines += f'Lane-{_pcsIndex-1},'
                for caption in captions:
                    lines += f'{pcsLane[caption]},'
                lines += '\n'
                _pcsIndex += 1
            lines += '\n\n\n'
        dir = self.basic['result_dir']
        with open(f'{dir}pcsLaneStats_{frameSize}.csv', 'w+') as f:
            f.write(lines)
        return 
    @timer
    def save_dom_stats(self, stats: dict, frameSize='0'):
        transceiverInfoCaptions = ['manufacturer','model','serialNumber','transceiverTypeProperty','revComplianceProperty','dateCodeProperty','mediaTechProperty','mediaConnectorProperty','identifierTypeProperty','powerClassProperty','maxPowerProperty']
        transceiverWarn1Captions = ['temperatureHighAlarm','temperatureHighWarn','temperatureLowWarn','temperatureLowAlarm']
        transceiverWarn2Captions = ['supplyVolHighAlarm','supplyVolHighWarn','supplyVolLowWarn','supplyVolLowAlarm']
        transceiverWarn3Captions = ['txOpticalPowerHighAlarm','txOpticalPowerHighWarn','txOpticalPowerLowWarn','txOpticalPowerLowAlarm']
        transceiverWarn4Captions = ['rxOpticalPowerHighAlarm','rxOpticalPowerHighWarn','rxOpticalPowerLowWarn','rxOpticalPowerLowAlarm']
        transceiverWarn5Captions = ['txBiasCurrentHighAlarm','txBiasCurrentHighWarn','txBiasCurrentLowWarn','txBiasCurrentLowAlarm']
        lanesCaptions = ['portName','hostDataPathState','hostTxLos','hostTxCdrLol','hostToMediaLane','mediaTxOpticalPower','mediaTxBiasCurrent','mediaRxOpticalPower','mediaRxLos','mediaRxCdrLol']
        lines = ""
        for port in stats.keys():
            lines += "Basic Info,"
            portId = port.split(',')[-1]
            lines += f'Port {portId}\n'
            for infoCaption in transceiverInfoCaptions:
                infoValue = stats[port][infoCaption].replace('{','').replace('}','').strip()
                lines += f'{infoCaption},{infoValue}\n'
            lines += '\n'
            lines += 'Module,High Alarm,High Warn,Low Warn,Low Alarm\n'
            lines += 'Temperature,'
            for warnCaption in transceiverWarn1Captions:
                warnValue = stats[port][warnCaption]
                lines += f'{warnValue},'
            lines += '\n'
            lines += 'Supply Voltage,'
            for warnCaption in transceiverWarn2Captions:
                warnValue = stats[port][warnCaption]
                lines += f'{warnValue},'
            lines += '\n\n'
            lines += 'Lane Limits,High Alarm,High Warn,Low Warn,Low Alarm\n'
            lines += 'Tx Optical Power,'
            for warnCaption in transceiverWarn3Captions:
                warnValue = stats[port][warnCaption]
                lines += f'{warnValue},'
            lines += '\n'
            lines += 'Rx Optical Power,'
            for warnCaption in transceiverWarn4Captions:
                warnValue = stats[port][warnCaption]
                lines += f'{warnValue},'
            lines += '\n'
            lines += 'Tx Bias Current,'
            for warnCaption in transceiverWarn5Captions:
                warnValue = stats[port][warnCaption]
                lines += f'{warnValue},'
            lines += '\n\n'
            lines += 'Host Lanes,Port,Data Path State,Tx LOS,Tx CDR LOL,Media Lane,Tx Optical Power,Tx Bias Current,Rx Optical Power,Rx LOS,Rx CDR LOL\n'
            columns = []
            for laneCaption in lanesCaptions:
                columns.append(stats[port][laneCaption])  
            _index = 1
            for row in zip(*columns):
                row_str = ",".join(str(cell) for cell in row)
                lines += f'{_index},{row_str}\n'
                _index += 1
            lines += '\n\n\n'
        dir = self.basic['result_dir']
        with open(f'{dir}transceiverDOM_{frameSize}.csv', 'w+') as f:
            f.write(lines)
        return
    @timer
    def save_app_sel_stats(self, stats: dict):
        lines = ""
        appsel_captions = ['App','hostElectricalIfName','hostLaneSpeed','hostModulation','hostLaneGroup','hostLaneCount','hostElectricalIfID','mediaIfName','mediaLaneSpeed','mediaLaneGroup','mediaLaneCount','mediaIfID']
        appselpre_captions = ['portMode','portModulation','moduleHostLaneGroup','moduleHostLaneCount','appSelId','link','moduleHostElectricalIfName','moduleHostLaneGroup','moduleHostLaneCount','note']
        for port in stats.keys():
            portId = port.split(',')[-1]
            lines += f'Port {portId}\n'
            line = ','.join(appsel_captions)
            lines += f'{line}\n'
            _index = 1
            for appsel in stats[port]['transceiverAppSel']:
                lines += f'{_index},'
                for caption in appsel_captions:
                    if caption == 'App':
                        continue
                    lines += f'{appsel[caption]},'
                lines += f'\n'
                _index += 1
            lines += f'\n'
            line = ','.join(appselpre_captions)
            lines += f'{line}\n'
            for appsel in stats[port]['transceiverAppSelPreview'].keys():
                for caption in appselpre_captions:
                    value = stats[port]['transceiverAppSelPreview'][appsel][caption]
                    lines += f'{value},'
                lines += '\n'
            lines += '\n\n\n'
        dir = self.basic['result_dir']
        with open(f'{dir}transceiverAppSel.csv', 'w+') as f:
            f.write(lines)
        return 
    @timer
    def save_bert_lane_stats(self, stats: dict):
        berLaneCaptions = ['bertPatternLock','bertPatternTransmitted','bertPatternReceived','bertBitsSent','bertBitsReceived','bertBitErrorsReceived','bertBitErrorRatio']
        lines = ""
        for port in stats.keys():
            lines += "Physical Lane,Pattern Lock,Pattern Transmit,Pattern Received,Bits Send,Bits Received,Bit Error Received Bit Error Ratio\n"
            for berLane in stats[port]:
                _index = 0
                if _index == 0:
                    lines += "Total,"
                else:
                    lines += f'{_index},'
                for laneCaption in berLaneCaptions:
                    lines += f'{berLane[laneCaption]},'
                lines += '\n'
                _index += 1
            lines += '\n\n\n'
        dir = self.basic['result_dir']
        with open(f'{dir}berLane.csv', 'w+') as f:
            f.write(lines)
        return 
    @timer
    def save_i2c_stats(self, stats: dict):
        i2cCaptions = ['manufacturer', 'model', 'serialNumber', 'revCompliance', 'msaType', 'msaRev']
        i2cPageCaptions = ['0x00', '0x01', '0x10', '0x11', '0x12', '0x24', '0x25', '0x26', '0x27']
        lines = "Basic Infomation,"
        for port in stats.keys():
            portId = port.split(',')[-1]
            lines += f'Port {portId},'
        lines += '\n'
        for i2cCaption in i2cCaptions:
            lines += f'{i2cCaption},'
            for port in stats.keys():
                lines += f'{stats[port][i2cCaption]},'
            lines += '\n'
        dir = self.basic['result_dir']
        with open(f'{dir}i2c_basicInfo.csv', 'w+') as f:
            f.write(lines)
        for i2cPageCaption in i2cPageCaptions:
            _index = 0
            lines = ""
            for port in stats.keys():
                portId = port.split(',')[-1]
                lines += f'Port {portId},'
            lines = f'Page {i2cPageCaption} Registers Name,{lines}\n'
            #name = stats[port][i2cPageCaption][_index]['name']
            #lines += f'{name},'
            registerCaptions = [registerName['name'] for registerName in stats[next(iter(stats))][i2cPageCaption]]
            _index = 0
            for registerCaption in registerCaptions:
                lines += f'{registerCaption},'
                for port in stats.keys():
                    registerValue = stats[port][i2cPageCaption][_index]['value']
                    lines += f'{registerValue},'
                _index += 1
                lines += '\n'
            dir = self.basic['result_dir']
            with open(f'{dir}i2c_{i2cPageCaption}.csv', 'w+') as f:
                f.write(lines)
        return 