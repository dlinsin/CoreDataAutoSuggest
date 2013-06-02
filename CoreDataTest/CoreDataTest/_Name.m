// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Name.m instead.

#import "_Name.h"

const struct TestAttributes TestAttributes = {
	.desc = @"desc",
	.ident = @"ident",
	.name = @"name",
};

const struct TestRelationships TestRelationships = {
};

const struct TestFetchedProperties TestFetchedProperties = {
};

@implementation TestID
@end

@implementation _Name

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Name" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Name";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Name" inManagedObjectContext:moc_];
}

- (TestID*)objectID {
	return (TestID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"identValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"ident"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic desc;






@dynamic ident;



- (int64_t)identValue {
	NSNumber *result = [self ident];
	return [result longLongValue];
}

- (void)setIdentValue:(int64_t)value_ {
	[self setIdent:[NSNumber numberWithLongLong:value_]];
}

- (int64_t)primitiveIdentValue {
	NSNumber *result = [self primitiveIdent];
	return [result longLongValue];
}

- (void)setPrimitiveIdentValue:(int64_t)value_ {
	[self setPrimitiveIdent:[NSNumber numberWithLongLong:value_]];
}





@dynamic name;











@end
