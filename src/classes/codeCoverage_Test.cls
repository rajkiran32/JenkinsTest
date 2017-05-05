@isTest (SeeAllData = false)
public class codeCoverage_Test {
    static testMethod void codeCoverage_Test() {

        Test.startTest();
        datetime dt = system.now();
        PageReference pageRef = Page.APEX_Code_Coverage;
        Test.setCurrentPage(pageRef);
        codeCoverage con = new codeCoverage();
        con.ViewData();
        con.updateTotalCoverage();
        con.saveTotalCoverage();
        
        List<codeCoverage.apexWrapper> lstAW = new List<codeCoverage.apexWrapper>();
        lstAW.add( new codeCoverage.apexWrapper('APEXName', 'ID', 1.0, dt, 'Robert Nunemaker', 10, 10, 0, 1.00) );
        lstAW.add( new codeCoverage.apexWrapper('APEXName2', 'ID2', 1.0, dt, 'Robert Nunemaker', 100, 72, 28, 0.72) );
        lstAW.add( new codeCoverage.apexWrapper('APEXName3', 'ID3', 1.0, dt, 'Robert Nunemaker', 10, 0, 10, 0.00) );
        lstAW.add( new codeCoverage.apexWrapper('APEXName4', 'ID4', 1.0, dt, 'Robert Nunemaker', 100, 78, 22, 0.78) );
        lstAW.add( new codeCoverage.apexWrapper('APEXName5', 'ID5', 1.0, dt, 'Robert Nunemaker', 100, 82, 18, 0.82) );
        lstAW.sort();
        codeCoverage.sortField = 'apexName_SortField';
        codeCoverage.sortDirection = 'ASC';
        lstAW.sort();
        codeCoverage.sortField = 'apexName_SortField';
        codeCoverage.sortDirection = 'DESC';
        lstAW.sort();
        codeCoverage.sortField = 'api_SortField';
        codeCoverage.sortDirection = 'ASC';
        lstAW.sort();
        codeCoverage.sortField = 'api_SortField';
        codeCoverage.sortDirection = 'DESC';
        lstAW.sort();
        codeCoverage.sortField = 'LengthWithoutComments_SortField';
        codeCoverage.sortDirection = 'ASC';
        lstAW.sort();
        codeCoverage.sortField = 'LengthWithoutComments_SortField';
        codeCoverage.sortDirection = 'DESC';
        lstAW.sort();
        codeCoverage.sortField = 'linescovered_SortField';
        codeCoverage.sortDirection = 'ASC';
        lstAW.sort();
        codeCoverage.sortField = 'linescovered_SortField';
        codeCoverage.sortDirection = 'DESC';
        lstAW.sort();
        codeCoverage.sortField = 'linesUncovered_SortField';
        codeCoverage.sortDirection = 'ASC';
        lstAW.sort();
        codeCoverage.sortField = 'linesUncovered_SortField';
        codeCoverage.sortDirection = 'DESC';
        lstAW.sort();

        Test.stopTest();
    } // END codeCoverage_Test

    static testMethod void testParse() {
        String json = '{\"size\":17,\"totalSize\":17,\"done\":true,\"queryLocator\":null,\"records\":[' +
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
        ApexCodeCoverageAggregate obj = ApexCodeCoverageAggregate.parse(json);
        System.assert(obj != null);
 
        ApexCodeCoverageAggregate.Attributes attrib = new ApexCodeCoverageAggregate.Attributes();
        ApexCodeCoverageAggregate.Records rec = new ApexCodeCoverageAggregate.Records();
 
        ApexCodeCoverageAggregate J2 = new ApexCodeCoverageAggregate();
 
        J2.done = true;
        J2.entityTypeName = 'Test';
        J2.size = 10;
        J2.totalSize = 100;
 
    } // END testParse

} // END codeCoverage_Test