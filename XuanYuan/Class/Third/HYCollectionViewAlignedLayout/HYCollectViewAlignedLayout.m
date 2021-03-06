//
//  HYCollectViewAlignedLayout.m
//  HYCollectionViewAlignedLayoutDemo
//
//  Created by 李思良 on 16/6/26.
//  Copyright © 2016年 lsl. All rights reserved.
//

#import "HYCollectViewAlignedLayout.h"


@interface HYCollectViewAlignedLayout ()

@end

@implementation HYCollectViewAlignedLayout


- (instancetype)initWithType:(HYCollectViewAlignType)type {
    if(self = [super init]) {
        _alignType = type;
    }
    return self;
}

#pragma mark - UICollectionViewLayout


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger left = -1, right = -1;//记录每一行最左和最右
    CGFloat width = 0;
    NSInteger section = 0;
    CGFloat lastx = self.collectionView.frame.size.width;
    NSMutableArray *updatedAttributes = [[NSMutableArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    for (NSInteger i = 0; i < [updatedAttributes count]; i ++) {
        UICollectionViewLayoutAttributes *attributes = updatedAttributes[i];
        if (!attributes.representedElementKind) {
            section = attributes.indexPath.section;
            if(attributes.frame.origin.x < lastx) {
                if(left != -1) {
                   //处理上一行的内容
                [self getAttributesForLeft:left right:right offset:[self calOffset:section width:width] originalAttributes:updatedAttributes];
                }
                left = i;
                lastx = attributes.frame.origin.x + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
                width = [self evaluatedSectionInsetForItemAtIndex:section].left + [self evaluatedSectionInsetForItemAtIndex:section].right - [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
            }
            lastx = attributes.frame.origin.x + attributes.frame.size.width + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
            right = i;
            width += attributes.frame.size.width + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:section];
            
        }
    }
    //确保最后一行更新
    if (left != -1) {
        [self getAttributesForLeft:left right:right offset:[self calOffset:section width:width] originalAttributes:updatedAttributes];
    }
    
    return updatedAttributes;
}

- (CGFloat)calOffset:(NSInteger)section width:(CGFloat)width {
    CGFloat offset = [self evaluatedSectionInsetForItemAtIndex:section].left;
    switch (_alignType) {
        case HYCollectViewAlignLeft:
            break;
        case HYCollectViewAlignRight:
            offset += self.collectionView.frame.size.width - width;
            break;
        case HYCollectViewAlignMiddle:
            offset += (self.collectionView.frame.size.width - width) / 2;
            break;
        default:
            break;
    }
    return offset;
}

- (void)getAttributesForLeft:(NSInteger)left right:(NSInteger) right offset:(CGFloat)offset originalAttributes:(NSMutableArray *)updatedAttributes {
    CGFloat currentOffset = offset;
    for(NSInteger i = left; i <= right; i ++) {
        
        UICollectionViewLayoutAttributes *attributes = updatedAttributes[i];
        CGRect frame = attributes.frame;
        frame.origin.x = currentOffset;
        attributes.frame = frame;
        currentOffset += frame.size.width + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:attributes.indexPath.section];
        [updatedAttributes setObject:attributes atIndexedSubscript:i];
    }
}

- (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        
        return [(id)self.collectionView.delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
    } else {
        return self.minimumInteritemSpacing;
    }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index {
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        
        return [(id)self.collectionView.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    } else {
        return self.sectionInset;
    }
}


@end
