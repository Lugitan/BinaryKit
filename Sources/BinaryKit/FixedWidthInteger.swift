//
//  FixedWidthIntegerExtensions.swift
//  
//
//  Created by Devran on 01.10.19.
//
import Foundation

extension FixedWidthInteger {
    @inline(__always)
    @inlinable
    public var toNetworkByteOrder: Self { self.bigEndian }
    /// A collection containing the words of this value’s binary representation, in order from the least significant to most significant.
    @inline(__always)
    @inlinable
    public var data: Data {
        var copy = self
        return Data(bytes: &copy, count: MemoryLayout<Self>.size)
    }
}

extension FixedWidthInteger {
    @inline(__always)
    @inlinable
    public init(networkByteOrder value: Self) {
        self = Self(bigEndian: value)
    }
    @inline(__always)
    @inlinable
    public init<D>(bytes: D) where D: DataProtocol {
        var mutableSelf = Self()
        withUnsafeMutableBytes(of: &mutableSelf) { (pointer) in
            _ = bytes.copyBytes(to: pointer, count: Swift.min(bytes.count, MemoryLayout<Self>.size))
        }
        self = mutableSelf
    }
}
