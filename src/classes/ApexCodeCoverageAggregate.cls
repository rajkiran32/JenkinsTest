public with sharing class ApexCodeCoverageAggregate {

    public class Attributes {
        public String type;
        public String url;
    } // END Attributes

    public class Records {
        public Attributes attributes;
        public String Id;
        public String ApexClassOrTriggerId;
        public Integer NumLinesCovered;
        public Integer NumLinesUncovered;
    } // END Records
 
    public Integer size;
    public Integer totalSize;
    public Boolean done;
    public Object queryLocator;
    public List<Records> records;
    public String entityTypeName;
 
    public static ApexCodeCoverageAggregate parse(String json) {
        return (ApexCodeCoverageAggregate) System.JSON.deserialize(json, ApexCodeCoverageAggregate.class);
    }
 
} // END ApexCodeCoverageAggregate