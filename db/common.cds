using {
    sap,
    managed
} from '@sap/cds/common';


extend sap.common.Currencies with {
    numcode  : Integer;
    exponent : Integer;
    minor    : String;
};

aspect custom.managed {
    createdAt     : managed:createdAt;
    createdBy     : managed:createdBy;
    LastChangedAt : managed:modifiedAt;
    LastChangedBy : managed:modifiedBy;
}
