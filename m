Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XsoiG-00025U-Nu
 for kexec@lists.infradead.org; Mon, 24 Nov 2014 08:09:37 +0000
Date: Mon, 24 Nov 2014 16:07:34 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH V5 4/5] Add module of calculating start_pfn and end_pfn
 in each dumpfile
Message-ID: <20141124080734.GC3015@dhcp-16-105.nay.redhat.com>
References: <1415263768-15821-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1415263768-15821-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <20141124071856.GB3015@dhcp-16-105.nay.redhat.com>
 <5472DE1D.3090608@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5472DE1D.3090608@cn.fujitsu.com>
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
To: =?utf-8?B?Ilpob3UsIFdlbmppYW4v5ZGo5paH5YmRIg==?= <zhouwj-fnst@cn.fujitsu.com>
Cc: kexec@lists.infradead.org

T24gMTEvMjQvMTQgYXQgMDM6MjhwbSwgIlpob3UsIFdlbmppYW4v5ZGo5paH5YmRIiB3cm90ZToK
PiBPbiAxMS8yNC8yMDE0IDAzOjE4IFBNLCBCYW9xdWFuIEhlIHdyb3RlOgo+ID5PbiAxMS8wNi8x
NCBhdCAwNDo0OXBtLCBaaG91IFdlbmppYW4gd3JvdGU6Cj4gPj4rCXdoaWxlICgqY3VyX3NwbGl0
YmxvY2tfbnVtPCAgc3BsaXRibG9jay0+bnVtJiYgIHBmbl9uZWVkZWQ+ICAwKSB7Cj4gPj4rCQlw
Zm5fbmVlZGVkIC09IHJlYWRfZnJvbV9zcGxpdGJsb2NrX3RhYmxlKHNwbGl0YmxvY2tfdmFsdWVf
b2Zmc2V0KTsKPiA+PisJCXNwbGl0YmxvY2tfdmFsdWVfb2Zmc2V0ICs9IHNwbGl0YmxvY2stPmVu
dHJ5X3NpemU7Cj4gPj4rCQkrKypjdXJfc3BsaXRibG9ja19udW07Cj4gPj4rCX0KPiA+Cj4gPkhp
IFdlbmppYW4sCj4gPgo+ID5JZiBzcGxpdGJsb2NrLT5wYWdlX3Blcl9zcGxpdGJsb2NrIGlzIDFH
LCBhbmQgdGhlIHN5c3RlbSByYW0gaXMgNEcuIE5vdwo+ID5JIHNldCA4IGR1bXBmaWxlcyB0byBz
dG9yZSB0aGUgc3BsaXR0ZWQgdm1jb3JlLCBzYXkgZHVtcDAuLi43LiBUaGVuCj4gPmR1bXAwLzEv
Mi8zIHdpbGwgc3RvcmUgMUcgb2YgZGF0YSwgZHVtcDQvNS82Lzcgd2lsbCBiZSBlbXB0eS4gU28g
aXMgaXQKPiA+T0s/Cj4gPgo+ID5DYW4gd2UgZG8gYW55dGhpbmcgdG8gYXZvaWQgdGhpcyBjYXNl
IG9yIGdpdmUgc29tZSBub3RlIHRvIGxldCBwZW9wbGUgbm90Cj4gPmJlIHBhbmlra2VkIGJ5IGVt
cHR5IGR1bXAgZmlsZXM/Cj4gPgo+ID5UaGFua3MKPiA+QmFvcXVhbgo+ID4KPiA+Cj4gCj4gSGVs
bG8gQmFvcXVhbiwKPiAKPiBBY3R1YWxseSwgd2UgaGF2ZSB0aG91Z2h0IGFib3V0IGl0IGFuZCB0
YWxrZWQgYXQKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwva2V4ZWMvMjAx
NC1Ob3ZlbWJlci8wMTI4ODAuaHRtbCAuCgpPSywgdGhhbmtzIGZvciB0ZWxsaW5nLgoKCj4gCj4g
LS0gCj4gVGhhbmtzCj4gWmhvdSBXZW5qaWFuCj4gCj4gX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KPiBrZXhlYyBtYWlsaW5nIGxpc3QKPiBrZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9rZXhlYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
