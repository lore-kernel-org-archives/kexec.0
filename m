Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dSDM9-00083b-1w
 for kexec@lists.infradead.org; Tue, 04 Jul 2017 02:14:26 +0000
Received: by mail-pg0-x244.google.com with SMTP id d193so6386379pgc.2
 for <kexec@lists.infradead.org>; Mon, 03 Jul 2017 19:14:04 -0700 (PDT)
Message-ID: <1499134187.1734.42.camel@gmail.com>
Subject: Re: [PATCH] kexec:arm: support zImage with appended device tree
From: Hoeun Ryu <hoeun.ryu@gmail.com>
Date: Tue, 04 Jul 2017 11:09:47 +0900
In-Reply-To: <20170704014145.GA8657@dhcp-128-65.nay.redhat.com>
References: <1498208138-19283-1-git-send-email-hoeun.ryu@gmail.com>
 <20170626091412.GE837@flint.armlinux.org.uk>
 <1498531003.1734.13.camel@gmail.com>
 <20170627085359.GH837@flint.armlinux.org.uk>
 <BA3D72AC-402C-4148-B49A-560720267961@gmail.com>
 <20170703164109.GJ22756@flint.armlinux.org.uk>
 <20170704014145.GA8657@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Russell King <rmk@armlinux.org.uk>
Cc: Matthew Leach <matthew.leach@arm.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Wang Nan <wangnan0@huawei.com>

T24gVHVlLCAyMDE3LTA3LTA0IGF0IDA5OjQxICswODAwLCBEYXZlIFlvdW5nIHdyb3RlOgo+IE9u
IDA3LzAzLzE3IGF0IDA1OjQxcG0sIFJ1c3NlbGwgS2luZyB3cm90ZToKPiA+IAo+ID4gT24gVHVl
LCBKdW4gMjcsIDIwMTcgYXQgMDY6NTE6NTBQTSArMDkwMCwgSG9ldW4gUnl1IHdyb3RlOgo+ID4g
PiAKPiA+ID4gPiAKPiA+ID4gPiBXaGF0IGFib3V0IHRoZSBpbml0cmQ/wqDCoERvIHlvdSB3YW50
IHRvIGFwcGVuZCB0aGF0IGFzIHdlbGw/Cj4gPiA+IEkgaGF2ZSB0aG91Z2h0IG9mIGl0Lgo+ID4g
PiBJIHRoaW5rIEl0IHdvdWxkIGJlIGJldHRlciB0byBoYXZlIGl0Lgo+ID4gPiBCdXQgSSB0aGlu
ayB0aGlzIGlzIHRoZSBmaXJzdCBzdGVwIHRvIGRvIHNvLgo+ID4gVGhhdCBpcyBzb21ldGhpbmcg
d2UgZG9uJ3Qgc3VwcG9ydCB3aXRoIHRoZSBrZXJuZWwsIGFuZCB3b3VsZCBiZQo+ID4gaW5zYW5l
Cj4gPiB0byBkbyBzbyAtIGl0IHdvdWxkIG1lYW4gdGhhdCB0aGUgdmVyeSBkdW1iIGRlY29tcHJl
c3NvciB3b3VsZCBoYXZlCj4gPiB0byByZWxvY2F0ZSBub3Qgb25seSB0aGUgZHRiIGltYWdlLCBi
dXQgYWxzbyB0aGUgaW5pdHJkIGltYWdlIHRvCj4gPiBzb21lIG90aGVyIHBhcnQgb2YgbWVtb3J5
LsKgwqBJdCBtb3ZlcyB0aGUgYXBwZW5kZWQgZHRiIGltYWdlIGFsb25nCj4gPiB3aXRoCj4gPiB0
aGUgcmVzdCBvZiB0aGUgekltYWdlIGFzIG9uZSBjb21wbGV0ZSBibG9iLCBidXQgdGhhdCBkb2Vz
bid0IHdvcmsKPiA+IHNvIHdlbGwgZm9yIGFuIGFwcGVuZGVkIGluaXRyZC7CoMKgSXQgd2lsbCBh
bHNvIGJlIHJhdGhlciBzbG93Lgo+ID4gCj4gPiBTbyBJJ2QgbGlrZSB0byBjb250aW51ZSBteSBk
aXNjb3VyYWdlbWVudCBvZiB0aGlzIGVudGlyZSBhcHByb2FjaAo+ID4gYW5kCj4gPiBzYXkgdGhh
dCBrZXhlYy10b29scyBzaG91bGQgKm5vdCogYWRkIHN1cHBvcnQgZm9yIGFuIGFwcGVuZGVkIERU
Qgo+ID4gbm9yCj4gPiBhbiBhcHBlbmRlZCBpbml0cmQuCj4gSSBhbHNvIGFncmVlIHRoYXQgd2Un
ZCBiZXR0ZXIgbm90IGFkZGluZyB0aGlzIGluIGtleGVjLXRvb2xzLCAtLWR0Ygo+IHdvcmtzIHdl
bGwsIHRoZSBhcHBlbmRlZCBkdGIgZG9lcyBub3QgZ2FpbiBtdWNoIGJ1dCBpdCBpbnRyb2R1Y2Vz
Cj4gbW9yZQo+IGNvZGUgdG8gbWFpbnRhaW4uCj4gCgpJIHVuZGVyc3RhbmQgYW5kIHJlc3BlY3Qg
eW91ciBvcGluaW9uLgpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcuCgo+ID4gCj4gPiAKPiA+IFRo
ZSBrZXJuZWwgYnVpbGQgcHJvY2VzcyBnaXZlcyB5b3UgdGhlIGtlcm5lbCBpbWFnZSBhbmQgZHRi
IGZpbGUuCj4gPiBUaGUgYXBwZW5kZWQtZHRiIGltYWdlIHN1cHBvcnQgdGhhdCB3ZSBoYXZlIGlu
IHRoZSBrZXJuZWwgaXMgZm9yCj4gPiBiYWNrd2FyZHMgY29tcGF0aWJpbGl0eSB3aXRoIG5vbi1E
VCBhd2FyZSBib290IGxvYWRlcnMgdGhhdCBvbmx5Cj4gPiBrbm93IGhvdyB0byBkZWFsIHdpdGgg
b25lIG9yIHR3byBpbWFnZXMgYXQgYm9vdCB0aW1lLgo+ID4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
