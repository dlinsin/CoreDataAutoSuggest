// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Test.h instead.

#import <CoreData/CoreData.h>


extern const struct TestAttributes {
	__unsafe_unretained NSString *desc;
	__unsafe_unretained NSString *ident;
	__unsafe_unretained NSString *name;
} TestAttributes;

extern const struct TestRelationships {
} TestRelationships;

extern const struct TestFetchedProperties {
} TestFetchedProperties;






@interface TestID : NSManagedObjectID {}
@end

@interface _Test : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (TestID*)objectID;





@property (nonatomic, strong) NSString* desc;



//- (BOOL)validateDesc:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* ident;



@property int64_t identValue;
- (int64_t)identValue;
- (void)setIdentValue:(int64_t)value_;

//- (BOOL)validateIdent:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;






@end

@interface _Test (CoreDataGeneratedAccessors)

@end

@interface _Test (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveDesc;
- (void)setPrimitiveDesc:(NSString*)value;




- (NSNumber*)primitiveIdent;
- (void)setPrimitiveIdent:(NSNumber*)value;

- (int64_t)primitiveIdentValue;
- (void)setPrimitiveIdentValue:(int64_t)value_;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




@end
