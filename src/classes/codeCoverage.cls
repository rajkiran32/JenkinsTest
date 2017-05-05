public class codeCoverage {
    /*
    Created By: J.D. Hugger
    Created On: 03/06/2014
    Purpose: Show all class code coverage on a single page
    --------------------------------------------------------------------------
    Modified By: Robert Nunemaker    
    Modified On: 06/05/2014
    Modification: Modified to more efficiently retrieve results because of errors in size retrieved, display of data, sorting of data, as well as handle sporatic cases of NULL.
    */
        
    public class TotalsAggregate {
        //public String strTrigger = 'Trigger'; 
        public String strTriggerStatus {get;set;} // No Coverage, SubStd Coverage, etc
        public Decimal nTriggerTotal {get;set;} // Total for this Status/Type
        public Decimal nTriggerPct {get;set;} // Pct for this Status/Type
        public String strColor {get;set;} // Color for this Status/Type
        //public String strConstantEmpty = '     ';
        //public String strClass = 'Class'; 
        public String strClassStatus {get;set;} // No Coverage, SubStd Coverage, etc
        public Decimal nClassTotal {get;set;} // Total for this Status/Type
        public Decimal nClassPct {get;set;} // Pct for this Status/Type
    } // END TotalsAggregate
    
    public LIST<TotalsAggregate> totalsAgr {get;set;}
    public List<apexWrapper> apexPages {get;set;}
    private String sessionId;

    public codeCoverage(){
        this.sessionId = UserInfo.getSessionId();
        apexPages = codeCoverage();
    } // END codeCoverage
    
    public decimal totalCoverage{
        get;
        set;
    }
    
    public static string sortField{get;set;}
    public static string sortDirection{get;set;}
    public string sortToField{get;set;}
    public string sortToDirection{get;set;}
    
    // Sort Functionality 
    public void ViewData(){
        sortToDirection = (sortToDirection == 'ASC') ? 'DESC' : 'ASC';
        sortDirection = sortToDirection;
        sortField = sortToField;
        apexPages.sort();
    }
    
    // update total coverage
    public void updateTotalCoverage() {
        apexPages = codeCoverage();    
    } // END updateTotalCoverage
    
    // update total coverage
    public void saveTotalCoverage() {
        
    } // END saveTotalCoverage
    
    public List<apexWrapper> codeCoverage(){
        //Map<Id, ApexClass> apexClassMap = new Map<Id, ApexClass>( [SELECT Id, Name, ApiVersion, LengthWithoutComments FROM ApexClass WHERE Status = 'Active' AND NamespacePrefix = NULL LIMIT 500]);

        // INITIALIZE TOTALS AGGREGATES
        totalsAgr = new LIST<TotalsAggregate>();
        TotalsAggregate totalsAgrItem = new TotalsAggregate();
        totalsAgrItem.strTriggerStatus = 'No Coverage (0%)';
        totalsAgrItem.strClassStatus = 'No Coverage (0%)';
        totalsAgrItem.strColor = 'red';
        totalsAgrItem.nClassTotal = 0;
        totalsAgrItem.nTriggerTotal = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgr.add(totalsAgrItem);
        totalsAgrItem = new TotalsAggregate();
        totalsAgrItem.strTriggerStatus = 'SubStd Coverage (< 75%)';
        totalsAgrItem.strClassStatus = 'SubStd Coverage (< 75%)';
        totalsAgrItem.nClassTotal = 0;
        totalsAgrItem.nTriggerTotal = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgrItem.strColor = 'orange';
        totalsAgr.add(totalsAgrItem);
        totalsAgrItem = new TotalsAggregate();
        totalsAgrItem.strTriggerStatus = 'Marginal Coverage (< 80%)';
        totalsAgrItem.strClassStatus = 'Marginal Coverage (< 80%)';
        totalsAgrItem.nClassTotal = 0;
        totalsAgrItem.nTriggerTotal = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgrItem.strColor = 'yellow';
        totalsAgr.add(totalsAgrItem);
        totalsAgrItem = new TotalsAggregate();
        totalsAgrItem.strTriggerStatus = 'Acceptable Coverage (< 85%)';
        totalsAgrItem.strClassStatus = 'Acceptable Coverage (< 85%)';
        totalsAgrItem.nClassTotal = 0;
        totalsAgrItem.nTriggerTotal = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgrItem.strColor = 'lightgreen';
        totalsAgr.add(totalsAgrItem);
        totalsAgrItem = new TotalsAggregate();
        totalsAgrItem.strTriggerStatus = 'Good Coverage (85+%)';
        totalsAgrItem.strClassStatus = 'Good Coverage (85+%)';
        totalsAgrItem.nClassTotal = 0;
        totalsAgrItem.nTriggerTotal = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgrItem.strColor = 'green';
        totalsAgr.add(totalsAgrItem);
        totalsAgrItem = new TotalsAggregate();
        totalsAgrItem.strTriggerStatus = 'ALL';
        totalsAgrItem.strClassStatus = 'ALL';
        totalsAgrItem.nClassTotal = 0;
        totalsAgrItem.nTriggerTotal = 0;
        totalsAgrItem.nClassPct = 0;
        totalsAgrItem.nTriggerPct = 0;
        totalsAgr.add(totalsAgrItem);
        system.debug(totalsAgr);
        
        //String soql = 'SELECT Id, ApexClassorTriggerId, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate WHERE ApexClassOrTriggerId In (';
        String soql = 'SELECT Id, ApexClassorTriggerId, NumLinesCovered, NumLinesUncovered, LastModifiedDate ' 
            + 'FROM ApexCodeCoverageAggregate '
            + 'WHERE ApexClassOrTriggerId In ('
            + 'SELECT Id FROM ApexClass WHERE Status = \'Active\' AND NamespacePrefix = NULL) ';            
        /*
        for(ApexClass ap : apexClassMap.values()){        
            if(ap.LengthWithoutComments >= 1 ){
                //soql += 'ApexClassOrTriggerId=\'' + ap.Id + '\' OR ';
                soql += '\'' + ap.Id + '\',';
            } // END if(ap.LengthWithoutComments >= 1 )
        } // END for(ApexClass ap : apexClassMap.values())
        
        soql = soql.substring(0, soql.length() - 1) + ')';
        */

        System.debug('SOQL Query: ' + soql);

        Http h = new Http();
        HttpRequest queryReq = new HttpRequest();
        queryReq.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm().replace('c.', '').replace('visual.force', 'salesforce') + '/services/data/v29.0/tooling/query/?q=' + EncodingUtil.urlEncode(soql, 'UTF-8'));
        system.debug('EndPoint: ' + queryReq.getEndpoint());
        queryReq.setHeader('Authorization', 'OAuth ' + sessionId);
        queryReq.setHeader('Content-Type', 'application/json');
        queryReq.setTimeout(110000);
        queryReq.setMethod('GET');

        String response;
        if(!Test.isRunningTest()){
            HttpResponse queryRes = h.send(queryReq);
            response = queryRes.getBody();
            System.debug('%% What is the response1'+response);
        } else {
            // response = '{\"size\":17,\"totalSize\":17,\"done\":true,\"queryLocator\":null,\"records\":[{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA1IAO\"},\"Id\":\"715L0000000ANA1IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO2AAM\",\"NumLinesCovered\":7,\"NumLinesUncovered\":0},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA2IAO\"},\"Id\":\"715L0000000ANA2IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO1AAM\",\"NumLinesCovered\":9,\"NumLinesUncovered\":0},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA3IAO\"},\"Id\":\"715L0000000ANA3IAO\",\"ApexClassOrTriggerId\":\"01pL00000005aILIAY\",\"NumLinesCovered\":22,\"NumLinesUncovered\":0},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA4IAO\"},\"Id\":\"715L0000000ANA4IAO\",\"ApexClassOrTriggerId\":\"01pL00000005ZCqIAM\",\"NumLinesCovered\":15,\"NumLinesUncovered\":0},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA5IAO\"},\"Id\":\"715L0000000ANA5IAO\",\"ApexClassOrTriggerId\":\"01p30000000YjJDAA0\",\"NumLinesCovered\":87,\"NumLinesUncovered\":6},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA6IAO\"},\"Id\":\"715L0000000ANA6IAO\",\"ApexClassOrTriggerId\":\"01p30000000YWsEAAW\",\"NumLinesCovered\":101,\"NumLinesUncovered\":13},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA7IAO\"},\"Id\":\"715L0000000ANA7IAO\",\"ApexClassOrTriggerId\":\"01p30000000aoWAAAY\",\"NumLinesCovered\":174,\"NumLinesUncovered\":0},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA8IAO\"},\"Id\":\"715L0000000ANA8IAO\",\"ApexClassOrTriggerId\":\"01p30000000ZurzAAC\",\"NumLinesCovered\":169,\"NumLinesUncovered\":11},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA9IAO\"},\"Id\":\"715L0000000ANA9IAO\",\"ApexClassOrTriggerId\":\"01pL00000005ZDAIA2\",\"NumLinesCovered\":67,\"NumLinesUncovered\":74},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAAIA4\"},\"Id\":\"715L0000000ANAAIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YKAIA2\",\"NumLinesCovered\":191,\"NumLinesUncovered\":16},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANABIA4\"},\"Id\":\"715L0000000ANABIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YJlIAM\",\"NumLinesCovered\":86,\"NumLinesUncovered\":3},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANACIA4\"},\"Id\":\"715L0000000ANACIA4\",\"ApexClassOrTriggerId\":\"01pL00000005aGoIAI\",\"NumLinesCovered\":51,\"NumLinesUncovered\":0},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANADIA4\"},\"Id\":\"715L0000000ANADIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YLwIAM\",\"NumLinesCovered\":147,\"NumLinesUncovered\":10},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAEIA4\"},\"Id\":\"715L0000000ANAEIA4\",\"ApexClassOrTriggerId\":\"01pa0000001pKuPAAU\",\"NumLinesCovered\":98,\"NumLinesUncovered\":1},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAFIA4\"},\"Id\":\"715L0000000ANAFIA4\",\"ApexClassOrTriggerId\":\"01p30000000ZGdkAAG\",\"NumLinesCovered\":36,\"NumLinesUncovered\":2},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAGIA4\"},\"Id\":\"715L0000000ANAGIA4\",\"ApexClassOrTriggerId\":\"01pL00000005ZClIAM\",\"NumLinesCovered\":31,\"NumLinesUncovered\":27},{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v29.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAHIA4\"},\"Id\":\"715L0000000ANAHIA4\",\"ApexClassOrTriggerId\":\"01pa0000001pXO3AAM\",\"NumLinesCovered\":44,\"NumLinesUncovered\":2}],\"entityTypeName\":\"ApexCodeCoverageAggregate\"}';
            response = '{\"size\":18,\"totalSize\":18,\"done\":true,\"queryLocator\":null,\"records\":[' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA0IAO\"},\"Id\":\"715L0000000ANA0IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO0AAM\",\"NumLinesCovered\":7,\"NumLinesUncovered\":7},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA1IAO\"},\"Id\":\"715L0000000ANA1IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO2AAM\",\"NumLinesCovered\":7,\"NumLinesUncovered\":7},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA2IAO\"},\"Id\":\"715L0000000ANA2IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO1AAM\",\"NumLinesCovered\":9,\"NumLinesUncovered\":3},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA3IAO\"},\"Id\":\"715L0000000ANA3IAO\",\"ApexClassOrTriggerId\":\"01pL00000005aILIAY\",\"NumLinesCovered\":100,\"NumLinesUncovered\":22},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA4IAO\"},\"Id\":\"715L0000000ANA4IAO\",\"ApexClassOrTriggerId\":\"01pL00000005ZCqIAM\",\"NumLinesCovered\":100,\"NumLinesUncovered\":18},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA5IAO\"},\"Id\":\"715L0000000ANA5IAO\",\"ApexClassOrTriggerId\":\"01p30000000YjJDAA0\",\"NumLinesCovered\":87,\"NumLinesUncovered\":6},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA6IAO\"},\"Id\":\"715L0000000ANA6IAO\",\"ApexClassOrTriggerId\":\"01p30000000YWsEAAW\",\"NumLinesCovered\":101,\"NumLinesUncovered\":13},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA7IAO\"},\"Id\":\"715L0000000ANA7IAO\",\"ApexClassOrTriggerId\":\"01p30000000aoWAAAY\",\"NumLinesCovered\":174,\"NumLinesUncovered\":0},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA8IAO\"},\"Id\":\"715L0000000ANA8IAO\",\"ApexClassOrTriggerId\":\"01p30000000ZurzAAC\",\"NumLinesCovered\":169,\"NumLinesUncovered\":11},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA9IAO\"},\"Id\":\"715L0000000ANA9IAO\",\"ApexClassOrTriggerId\":\"01pL00000005ZDAIA2\",\"NumLinesCovered\":67,\"NumLinesUncovered\":74},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAAIA4\"},\"Id\":\"715L0000000ANAAIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YKAIA2\",\"NumLinesCovered\":191,\"NumLinesUncovered\":16},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANABIA4\"},\"Id\":\"715L0000000ANABIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YJlIAM\",\"NumLinesCovered\":86,\"NumLinesUncovered\":3},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANACIA4\"},\"Id\":\"715L0000000ANACIA4\",\"ApexClassOrTriggerId\":\"01pL00000005aGoIAI\",\"NumLinesCovered\":51,\"NumLinesUncovered\":0},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANADIA4\"},\"Id\":\"715L0000000ANADIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YLwIAM\",\"NumLinesCovered\":147,\"NumLinesUncovered\":10},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAEIA4\"},\"Id\":\"715L0000000ANAEIA4\",\"ApexClassOrTriggerId\":\"01pa0000001pKuPAAU\",\"NumLinesCovered\":98,\"NumLinesUncovered\":1},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAFIA4\"},\"Id\":\"715L0000000ANAFIA4\",\"ApexClassOrTriggerId\":\"01p30000000ZGdkAAG\",\"NumLinesCovered\":36,\"NumLinesUncovered\":2},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAGIA4\"},\"Id\":\"715L0000000ANAGIA4\",\"ApexClassOrTriggerId\":\"01pL00000005ZClIAM\",\"NumLinesCovered\":31,\"NumLinesUncovered\":27},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAHIA4\"},\"Id\":\"715L0000000ANAHIA4\",\"ApexClassOrTriggerId\":\"01pa0000001pXO3AAM\",\"NumLinesCovered\":44,\"NumLinesUncovered\":2}],\"entityTypeName\":\"ApexCodeCoverageAggregate\"}';
        } // END if(!Test.isRunningTest())

        ApexCodeCoverageAggregate acc = ApexCodeCoverageAggregate.parse(response);

        system.debug('RESPONSE: ' + response);
        system.debug('Wrapper: ' + acc);

        // Not done together because the result is too large for the 1st call
        soql = 'SELECT Id, ApexClassorTriggerId, NumLinesCovered, NumLinesUncovered, LastModifiedDate ' 
            + 'FROM ApexCodeCoverageAggregate '
            + 'WHERE ApexClassOrTriggerId In ('
            + 'SELECT Id FROM ApexTrigger WHERE Status = \'Active\' AND NamespacePrefix = NULL) ';          

        System.debug('SOQL Query: ' + soql);

        h = new Http();
        queryReq = new HttpRequest();
        queryReq.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm().replace('c.', '').replace('visual.force', 'salesforce') + '/services/data/v29.0/tooling/query/?q=' + EncodingUtil.urlEncode(soql, 'UTF-8'));
        system.debug('EndPoint: ' + queryReq.getEndpoint());
        queryReq.setHeader('Authorization', 'OAuth ' + sessionId);
        queryReq.setHeader('Content-Type', 'application/json');
        queryReq.setTimeout(110000);
        queryReq.setMethod('GET');

        response = null;
        if(!Test.isRunningTest()){
            HttpResponse queryRes = h.send(queryReq);
            response = queryRes.getBody();
            System.debug('%% What is the response2'+response);
        } else {
            response = '{\"size\":18,\"totalSize\":18,\"done\":true,\"queryLocator\":null,\"records\":[' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA0IAO\"},\"Id\":\"715L0000000ANA0IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO0AAM\",\"NumLinesCovered\":7,\"NumLinesUncovered\":7},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA1IAO\"},\"Id\":\"715L0000000ANA1IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO2AAM\",\"NumLinesCovered\":7,\"NumLinesUncovered\":7},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA2IAO\"},\"Id\":\"715L0000000ANA2IAO\",\"ApexClassOrTriggerId\":\"01pa0000001pXO1AAM\",\"NumLinesCovered\":9,\"NumLinesUncovered\":3},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA3IAO\"},\"Id\":\"715L0000000ANA3IAO\",\"ApexClassOrTriggerId\":\"01pL00000005aILIAY\",\"NumLinesCovered\":100,\"NumLinesUncovered\":22},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA4IAO\"},\"Id\":\"715L0000000ANA4IAO\",\"ApexClassOrTriggerId\":\"01pL00000005ZCqIAM\",\"NumLinesCovered\":100,\"NumLinesUncovered\":18},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA5IAO\"},\"Id\":\"715L0000000ANA5IAO\",\"ApexClassOrTriggerId\":\"01p30000000YjJDAA0\",\"NumLinesCovered\":87,\"NumLinesUncovered\":6},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA6IAO\"},\"Id\":\"715L0000000ANA6IAO\",\"ApexClassOrTriggerId\":\"01p30000000YWsEAAW\",\"NumLinesCovered\":101,\"NumLinesUncovered\":13},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA7IAO\"},\"Id\":\"715L0000000ANA7IAO\",\"ApexClassOrTriggerId\":\"01p30000000aoWAAAY\",\"NumLinesCovered\":174,\"NumLinesUncovered\":0},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA8IAO\"},\"Id\":\"715L0000000ANA8IAO\",\"ApexClassOrTriggerId\":\"01p30000000ZurzAAC\",\"NumLinesCovered\":169,\"NumLinesUncovered\":11},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANA9IAO\"},\"Id\":\"715L0000000ANA9IAO\",\"ApexClassOrTriggerId\":\"01pL00000005ZDAIA2\",\"NumLinesCovered\":67,\"NumLinesUncovered\":74},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAAIA4\"},\"Id\":\"715L0000000ANAAIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YKAIA2\",\"NumLinesCovered\":191,\"NumLinesUncovered\":16},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANABIA4\"},\"Id\":\"715L0000000ANABIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YJlIAM\",\"NumLinesCovered\":86,\"NumLinesUncovered\":3},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANACIA4\"},\"Id\":\"715L0000000ANACIA4\",\"ApexClassOrTriggerId\":\"01pL00000005aGoIAI\",\"NumLinesCovered\":51,\"NumLinesUncovered\":0},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANADIA4\"},\"Id\":\"715L0000000ANADIA4\",\"ApexClassOrTriggerId\":\"01pL00000005YLwIAM\",\"NumLinesCovered\":147,\"NumLinesUncovered\":10},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAEIA4\"},\"Id\":\"715L0000000ANAEIA4\",\"ApexClassOrTriggerId\":\"01pa0000001pKuPAAU\",\"NumLinesCovered\":98,\"NumLinesUncovered\":1},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAFIA4\"},\"Id\":\"715L0000000ANAFIA4\",\"ApexClassOrTriggerId\":\"01p30000000ZGdkAAG\",\"NumLinesCovered\":36,\"NumLinesUncovered\":2},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAGIA4\"},\"Id\":\"715L0000000ANAGIA4\",\"ApexClassOrTriggerId\":\"01pL00000005ZClIAM\",\"NumLinesCovered\":31,\"NumLinesUncovered\":27},' +
                '{\"attributes\":{\"type\":\"ApexCodeCoverageAggregate\",\"url\":\"/services/data/v35.0/tooling/sobjects/ApexCodeCoverageAggregate/715L0000000ANAHIA4\"},\"Id\":\"715L0000000ANAHIA4\",\"ApexClassOrTriggerId\":\"01pa0000001pXO3AAM\",\"NumLinesCovered\":44,\"NumLinesUncovered\":2}],\"entityTypeName\":\"ApexCodeCoverageAggregate\"}';
        } // END if(!Test.isRunningTest())

        ApexCodeCoverageAggregate acc2 = ApexCodeCoverageAggregate.parse(response);

        system.debug('RESPONSE: ' + response);
        system.debug('Wrapper: ' + acc);

        List<apexWrapper> apexPages = new List<apexWrapper>();

        Map<Id, ApexClass> apexClassMap = new Map<Id, ApexClass>( [SELECT Id, Name, ApiVersion, LengthWithoutComments, LastModifiedDate, LastModifiedBy.Name FROM ApexClass WHERE Status = 'Active' AND NamespacePrefix = NULL]);
        Map<Id, ApexTrigger> apexTriggerMap = new Map<Id, ApexTrigger>( [SELECT Id, Name, ApiVersion, LengthWithoutComments, LastModifiedDate, LastModifiedBy.Name FROM ApexTrigger WHERE Status = 'Active' AND NamespacePrefix = NULL]);
        
        decimal totalCovered = 0;
        decimal totalUncovered = 0;
        for(ApexCodeCoverageAggregate.Records r : acc.records){
            decimal covered  = (r.NumLinesCovered == null ? 0 : r.NumLinesCovered);
            decimal uncovered = (r.NumLinesUncovered == null ? 0 : r.NumLinesUncovered);
            //totalCovered += totalCovered;
            //totalUncovered += totalUncovered;
            totalCovered += covered;
            totalUncovered += uncovered;
            
            decimal percent  = 0;
            if (covered + uncovered > 0) percent  = (covered / (covered + uncovered) * 100);
            if (percent == 0) {
                totalsAgr[0].nClassTotal += 1;
            } else if (percent < 75) {
                totalsAgr[1].nClassTotal += 1;
            } else if (percent < 80) {
                totalsAgr[2].nClassTotal += 1;
            } else if (percent < 85) {
                totalsAgr[3].nClassTotal += 1;
            } else {
                totalsAgr[4].nClassTotal += 1;
            } // END if (percent == 0)
            
            if (apexClassMap.containsKey(r.ApexClassorTriggerId)) {
                apexPages.add(new apexWrapper(apexClassMap.get(r.ApexClassorTriggerId).Name, r.ApexClassorTriggerId, apexClassMap.get(r.ApexClassorTriggerId).ApiVersion, apexClassMap.get(r.ApexClassorTriggerId).LastModifiedDate, apexClassMap.get(r.ApexClassorTriggerId).LastModifiedBy.Name, apexClassMap.get(r.ApexClassorTriggerId).LengthWithoutComments, r.NumLinesUncovered, r.NumLinesCovered, percent.SetScale(2)));
            } // END if (apexClassMap.containsKey(r.ApexClassorTriggerId)

        } // END for(ApexCodeCoverageAggregate.Records r : acc.records)
        totalsAgr[5].nClassTotal = totalsAgr[0].nClassTotal + totalsAgr[1].nClassTotal + totalsAgr[2].nClassTotal + totalsAgr[3].nClassTotal + totalsAgr[4].nClassTotal;
        if (totalsAgr[5].nClassTotal > 0) {
            totalsAgr[5].nClassPct = (100.00).setScale(2);
            totalsAgr[0].nClassPct = (totalsAgr[0].nClassTotal / totalsAgr[5].nClassTotal * 100).setScale(2);            
            totalsAgr[1].nClassPct = (totalsAgr[1].nClassTotal / totalsAgr[5].nClassTotal * 100).setScale(2);
            totalsAgr[2].nClassPct = (totalsAgr[2].nClassTotal / totalsAgr[5].nClassTotal * 100).setScale(2);
            totalsAgr[3].nClassPct = (totalsAgr[3].nClassTotal / totalsAgr[5].nClassTotal * 100).setScale(2);
            totalsAgr[4].nClassPct = (totalsAgr[4].nClassTotal / totalsAgr[5].nClassTotal * 100).setScale(2);
        } // END if (totalsAgr[5].nClassTotal > 0)
        system.debug(totalsAgr);
        
        for(ApexCodeCoverageAggregate.Records r : acc2.records){
            decimal covered  = r.NumLinesCovered;
            decimal uncovered = r.NumLinesUncovered;
            //totalCovered += totalCovered;
            //totalUncovered += totalUncovered;
            totalCovered += (covered == null ? 0 : covered);
            totalUncovered += (uncovered == null ? 0 : uncovered);
            decimal percent  = 0;
            if (covered + uncovered > 0) percent  = (covered / (covered + uncovered) * 100);
            system.debug('Record: ' + r);
            if (percent == 0) {
                totalsAgr[0].nTriggerTotal += 1;
            } else if (percent < 75) {
                totalsAgr[1].nTriggerTotal += 1;
            } else if (percent < 80) {
                totalsAgr[2].nTriggerTotal += 1;
            } else if (percent < 85) {
                totalsAgr[3].nTriggerTotal += 1;
            } else {
                totalsAgr[4].nTriggerTotal += 1;
            } // END if (percent == 0)

            if (apexTriggerMap.containsKey(r.ApexClassorTriggerId)) {
                system.debug(apexTriggerMap.containsKey(r.ApexClassorTriggerId));
                system.debug(apexTriggerMap.get(r.ApexClassorTriggerId));
                apexPages.add(new apexWrapper(apexTriggerMap.get(r.ApexClassorTriggerId).Name, r.ApexClassorTriggerId, apexTriggerMap.get(r.ApexClassorTriggerId).ApiVersion, apexTriggerMap.get(r.ApexClassorTriggerId).LastModifiedDate, apexTriggerMap.get(r.ApexClassorTriggerId).LastModifiedBy.Name, apexTriggerMap.get(r.ApexClassorTriggerId).LengthWithoutComments, r.NumLinesUncovered, r.NumLinesCovered, percent.SetScale(2)));
            } // END if (apexTriggerMap.containsKey(r.ApexClassorTriggerId)

        } // END for(ApexCodeCoverageAggregate.Records r : acc.records)
        totalsAgr[5].nTriggerTotal = totalsAgr[0].nTriggerTotal + totalsAgr[1].nTriggerTotal + totalsAgr[2].nTriggerTotal + totalsAgr[3].nTriggerTotal + totalsAgr[4].nTriggerTotal;
        if (totalsAgr[5].nTriggerTotal > 0) {
            totalsAgr[5].nTriggerPct = (100.00).setScale(2);
            totalsAgr[0].nTriggerPct = (totalsAgr[0].nTriggerTotal / totalsAgr[5].nTriggerTotal * 100).setScale(2);
            totalsAgr[1].nTriggerPct = (totalsAgr[1].nTriggerTotal / totalsAgr[5].nTriggerTotal * 100).setScale(2);
            totalsAgr[2].nTriggerPct = (totalsAgr[2].nTriggerTotal / totalsAgr[5].nTriggerTotal * 100).setScale(2);
            totalsAgr[3].nTriggerPct = (totalsAgr[3].nTriggerTotal / totalsAgr[5].nTriggerTotal * 100).setScale(2);
            totalsAgr[4].nTriggerPct = (totalsAgr[4].nTriggerTotal / totalsAgr[5].nTriggerTotal * 100).setScale(2);
        } // END if (totalsAgr[5].nTriggerTotal > 0)
        system.debug(totalsAgr);

        if (totalCovered + totalUncovered > 0) totalCoverage = (totalCovered / (totalCovered + totalUncovered) * 100).setScale(2); 

        // Sort using the custom compareTo() method
        sortToField = 'percentCovered_SortField';
        sortField = 'percentCovered_SortField';
        sortDirection = 'ASC';
        sortToDirection = 'ASC';
        apexPages.sort();

        return apexPages;
    } // END codeCoverage

    public class apexWrapper implements Comparable {
        public string apexName {get;set;}
        public string Id {get;set;}
        public decimal ApiVersion {get;set;}
        public integer LengthWithoutComments {get;set;}
        public decimal linesUncovered {get;set;}
        public decimal linesCovered {get;set;}
        public decimal percentCovered {get;set;}
        public string LastModifiedDate {get;set;}
        public string LastModifiedBy {get;set;}

        // Code Coverage Wrapper
        public apexWrapper(string apexNameIn, string idIn, decimal ApiVersionIn, datetime lastModifiedDateIn, string lastModifiedByIn, integer LengthWithoutCommentsIn, decimal linesUncoveredIn, decimal linesCoveredIn, decimal percentCoveredIn) {
            apexName             = apexNameIn;
            id                   = idIn;
            ApiVersion           = ApiVersionIn;
            LengthWithoutComments = LengthWithoutCommentsIn;
            linesUncovered       = linesUncoveredIn;
            linesCovered         = linesCoveredIn;
            percentCovered       = percentCoveredIn;
            lastModifiedDate     = lastModifiedDateIn.format();
            lastModifiedBy       = lastModifiedByIn;
        } // END apexWrapper

        // Implement the compareTo() method
        public Integer compareTo(Object compareTo) {
            if(sortField == 'percentCovered_SortField'){
                apexWrapper compareToClass = (apexWrapper)compareTo;
                if(sortDirection == 'ASC'){
                    if (percentCovered == compareToClass.percentCovered){
                        if(LengthWithoutComments == compareToClass.LengthWithoutComments){
                            return 0;
                        }else if(LengthWithoutComments < compareToClass.LengthWithoutComments){
                            return -1;
                        }
                    } // END if (percentCovered == compareToClass.percentCovered)
        
                    if (percentCovered < compareToClass.percentCovered) return -1;
                    return 1;
                }// END if(sortDirection == 'ASC')
                else{
                    if (percentCovered == compareToClass.percentCovered){
                        if(LengthWithoutComments == compareToClass.LengthWithoutComments){
                            return 0;
                        }else if(LengthWithoutComments > compareToClass.LengthWithoutComments){
                            return -1;
                        }
                    } // END if (percentCovered == compareToClass.percentCovered)
        
                    if (percentCovered > compareToClass.percentCovered) return -1;
                    return 1; 
                }// END Else
            }// End if(sortField == 'percentCovered_SortField')
            else if(sortField == 'apexName_SortField'){
                if(sortDirection == 'ASC'){
                    return apexName.toUpperCase().compareTo(((apexWrapper)compareTo).apexName.toUpperCase());
                }// END if(sortDirection == 'ASC')
                else{
                    return ((apexWrapper)compareTo).apexName.toUpperCase().compareTo(apexName.toUpperCase());
                }// End Else
            }// End else if(sortField == 'apexName_SortField')
            else if(sortField == 'api_SortField'){
                apexWrapper compareToClass = (apexWrapper)compareTo;
                if(sortDirection == 'ASC'){
                    if (ApiVersion < compareToClass.ApiVersion) return -1;
                    return 1;
                }// END if(sortDirection == 'ASC')
                else{
                    if (ApiVersion > compareToClass.ApiVersion) return -1;
                    return 1;
                }// End Else
            }// End else if(sortField == 'api_SortField')
            else if(sortField == 'LengthWithoutComments_SortField'){
                apexWrapper compareToClass = (apexWrapper)compareTo;
                if(sortDirection == 'ASC'){
                    if (LengthWithoutComments < compareToClass.LengthWithoutComments) return -1;
                    return 1;
                }// END if(sortDirection == 'ASC')
                else{
                    if (LengthWithoutComments > compareToClass.LengthWithoutComments) return -1;
                    return 1;
                }// End Else
            }// End else if(sortField == 'LengthWithoutComments_SortField')
            else if(sortField == 'linescovered_SortField'){
                apexWrapper compareToClass = (apexWrapper)compareTo;
                if(sortDirection == 'ASC'){
                    if (linesCovered < compareToClass.linesCovered) return -1;
                    return 1;
                }// END if(sortDirection == 'ASC')
                else{
                    if (linesCovered > compareToClass.linesCovered) return -1;
                    return 1;
                }// End Else
            }// End else if(sortField == 'linescovered_SortField')
            else if(sortField == 'linesUncovered_SortField'){
                apexWrapper compareToClass = (apexWrapper)compareTo;
                if(sortDirection == 'ASC'){
                    if (linesUncovered < compareToClass.linesUncovered) return -1;
                    return 1;
                }// END if(sortDirection == 'ASC')
                else{
                    if (linesUncovered > compareToClass.linesUncovered) return -1;
                    return 1;
                }// End Else
            }// End else if(sortField == 'linesUncovered_SortField')
            return 1;
        } // END compareTo 
        
        /*public Integer compareTo(Object compareTo) {
            
        } // END compareTo */
    } // END apexWrapper
} // END codeCoverage