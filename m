Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhDEK-00053z-3V
 for kexec@lists.infradead.org; Tue, 28 May 2013 06:17:56 +0000
Received: by mail-oa0-f46.google.com with SMTP id h2so9500943oag.19
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 23:17:34 -0700 (PDT)
Date: Tue, 28 May 2013 01:17:31 -0500
From: Rob Landley <rob@landley.net>
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
In-Reply-To: <51A2BCCB.2090900@cn.fujitsu.com> (from
 zhangyanfei@cn.fujitsu.com on Sun May 26 20:54:19 2013)
Message-Id: <1369721851.2776.37@driftwood>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="Flowed"; DelSp="Yes"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

T24gMDUvMjYvMjAxMyAwODo1NDoxOSBQTSwgWmhhbmcgWWFuZmVpIHdyb3RlOgo+IOS6jiAyMDEz
5bm0MDXmnIgyN+aXpSAwOTo0NiwgSEFUQVlBTUEgRGFpc3VrZSDlhpnpgZM6Cj4gPiAoMjAxMy8w
NS8yNiAxNTozNiksIFpoYW5nIFlhbmZlaSB3cm90ZToKPiA+PiBGcm9tOiBaaGFuZyBZYW5mZWkg
PHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29tPgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTogWmhh
bmcgWWFuZmVpIDx6aGFuZ3lhbmZlaUBjbi5mdWppdHN1LmNvbT4KPiA+PiBDYzogRGF2ZSBKb25l
cyA8ZGF2ZWpAcmVkaGF0LmNvbT4KPiA+PiAtLS0KPiA+PiAgIERvY3VtZW50YXRpb24vZGV2aWNl
cy50eHQgfCAgICAzICstLQo+ID4+ICAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCj4gPj4KPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2VzLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNlcy50eHQKPiA+PiBpbmRleCAwOGYwMWU3Li5j
OGU0MDAyIDEwMDY0NAo+ID4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNlcy50eHQKPiA+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXMudHh0Cj4gPj4gQEAgLTEwMCw4ICsxMDAsNyBAQCBZ
b3VyIGNvb3BlcmF0aW9uIGlzIGFwcHJlY2lhdGVkLgo+ID4+ICAgICAgICAgICAgMTAgPSAvZGV2
L2FpbyAgICAgICAgQXN5bmNocm9ub3VzIEkvTyBub3RpZmljYXRpb24gIAo+IGludGVyZmFjZQo+
ID4+ICAgICAgICAgICAgMTEgPSAvZGV2L2ttc2cgICAgICAgIFdyaXRlcyB0byB0aGlzIGNvbWUg
b3V0IGFzICAKPiBwcmludGsncywgcmVhZHMKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgZXhw
b3J0IHRoZSBidWZmZXJlZCBwcmludGsgcmVjb3Jkcy4KPiA+PiAtICAgICAgICAgMTIgPSAvZGV2
L29sZG1lbSAgICBVc2VkIGJ5IGNyYXNoZHVtcCBrZXJuZWxzIHRvIGFjY2Vzcwo+ID4+IC0gICAg
ICAgICAgICAgICAgICAgIHRoZSBtZW1vcnkgb2YgdGhlIGtlcm5lbCB0aGF0IGNyYXNoZWQuCj4g
Pj4gKyAgICAgICAgIDEyID0gL2Rldi9vbGRtZW0gICAgT0JTT0xFVEUKPiA+Pgo+ID4+ICAgICAx
IGJsb2NrICAgIFJBTSBkaXNrCj4gPj4gICAgICAgICAgICAgMCA9IC9kZXYvcmFtMCAgICAgICAg
Rmlyc3QgUkFNIGRpc2sKPiA+Pgo+ID4KPiA+IFRoaXMgaXMgdGhlIG5ldyBwYXRjaC4gTG9va2lu
ZyBhdCBvdGhlciBwYXJ0cyBvZiBkZXZpY2VzLnR4dCwgIAo+IG9ic29sZXRlIGlzCj4gPiBzb21l
dGltZXMgdXNlZCB0b2dldGhlciB3aXRoIHVudXNlZC4gSSBndWVzcyBvYnNvbGV0ZSBtZWFucyB0
aGlzIGlzICAKPiBvbGQgaW50ZXJmYWNlIHNvCj4gPiBkb24ndCB1c2UgaXQgYXMgbXVjaCBhcyBw
b3NzaWJsZSBhbmQgdW51c2VkIG1lYW5zIHRoaXMgaXMgbm90IHVzZWQgIAo+IGF0IGFsbCBub3cu
Cj4gPiBZb3UgcmVtb3ZlIG9sZCBtZW1vcnkgaW50ZXJmYWNlIGNvbXBsZXRlbHkgaW4gdGhpcyBw
YXRjaCBzZXQsIHNvIGlzICAKPiBpdCBiZXR0ZXIgdG8gYWRkCj4gPiB1bnVzZWQsIHRvbz8KPiA+
Cj4gCj4gRG9lcyBvYnNvbGV0ZSBhbHNvIG1lYW4gIm5vdCB1c2VkIGFueW1vcmUiPyBJIGRvbid0
IGtub3cuIEkgdGhpbmsgd2UgIAo+IGNhbiB3YWl0IGZvciBzb21lIG5hdGl2ZQo+IEVuZ2xpc2gg
c3BlYWtlcnMgdG8gY29tbWVudCBvbiB0aGlzLgoKT2Jzb2xldGUgaW1wbGllcyB0aGF0IGl0IHNo
b3VsZG4ndCBiZSB1c2VkIGFueW1vcmUuIFRoZXJlIGFyZSAgCmV4Y2VwdGlvbnMgdG8gZXZlcnl0
aGluZywgb2YgY291cnNlLi4uCgooVW51c2VkIG1lYW5zIG5vdGhpbmcgaXMgdXNpbmcgaXQuIElm
IHRoZXJlJ3Mgc3RpbGwgY29kZSB1c2luZyBpdCwgaXQncyAgCm5vdCB1bnVzZWQuIFNvIHllYWgg
dW51c2VkIHdvdWxkIGltcGx5IHJlbW92ZWQuKQoKUm9iCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
a2V4ZWMK
