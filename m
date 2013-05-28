Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhDOg-0005IL-Of
 for kexec@lists.infradead.org; Tue, 28 May 2013 06:28:40 +0000
Message-ID: <51A44DD5.5050301@cn.fujitsu.com>
Date: Tue, 28 May 2013 14:25:25 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
References: <1369721851.2776.37@driftwood>
In-Reply-To: <1369721851.2776.37@driftwood>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Rob Landley <rob@landley.net>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

T24gMDUvMjgvMjAxMyAwMjoxNyBQTSwgUm9iIExhbmRsZXkgd3JvdGU6Cj4gT24gMDUvMjYvMjAx
MyAwODo1NDoxOSBQTSwgWmhhbmcgWWFuZmVpIHdyb3RlOgo+PiDkuo4gMjAxM+W5tDA15pyIMjfm
l6UgMDk6NDYsIEhBVEFZQU1BIERhaXN1a2Ug5YaZ6YGTOgo+PiA+ICgyMDEzLzA1LzI2IDE1OjM2
KSwgWmhhbmcgWWFuZmVpIHdyb3RlOgo+PiA+PiBGcm9tOiBaaGFuZyBZYW5mZWkgPHpoYW5neWFu
ZmVpQGNuLmZ1aml0c3UuY29tPgo+PiA+Pgo+PiA+PiBTaWduZWQtb2ZmLWJ5OiBaaGFuZyBZYW5m
ZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29tPgo+PiA+PiBDYzogRGF2ZSBKb25lcyA8ZGF2
ZWpAcmVkaGF0LmNvbT4KPj4gPj4gLS0tCj4+ID4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4
dCB8ICAgIDMgKy0tCj4+ID4+ICAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pCj4+ID4+Cj4+ID4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4dAo+PiA+PiBpbmRleCAwOGYwMWU3Li5j
OGU0MDAyIDEwMDY0NAo+PiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXMudHh0Cj4+ID4+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNlcy50eHQKPj4gPj4gQEAgLTEwMCw4ICsxMDAsNyBA
QCBZb3VyIGNvb3BlcmF0aW9uIGlzIGFwcHJlY2lhdGVkLgo+PiA+PiAgICAgICAgICAgIDEwID0g
L2Rldi9haW8gICAgICAgIEFzeW5jaHJvbm91cyBJL08gbm90aWZpY2F0aW9uIGludGVyZmFjZQo+
PiA+PiAgICAgICAgICAgIDExID0gL2Rldi9rbXNnICAgICAgICBXcml0ZXMgdG8gdGhpcyBjb21l
IG91dCBhcyBwcmludGsncywgcmVhZHMKPj4gPj4gICAgICAgICAgICAgICAgICAgICAgIGV4cG9y
dCB0aGUgYnVmZmVyZWQgcHJpbnRrIHJlY29yZHMuCj4+ID4+IC0gICAgICAgICAxMiA9IC9kZXYv
b2xkbWVtICAgIFVzZWQgYnkgY3Jhc2hkdW1wIGtlcm5lbHMgdG8gYWNjZXNzCj4+ID4+IC0gICAg
ICAgICAgICAgICAgICAgIHRoZSBtZW1vcnkgb2YgdGhlIGtlcm5lbCB0aGF0IGNyYXNoZWQuCj4+
ID4+ICsgICAgICAgICAxMiA9IC9kZXYvb2xkbWVtICAgIE9CU09MRVRFCj4+ID4+Cj4+ID4+ICAg
ICAxIGJsb2NrICAgIFJBTSBkaXNrCj4+ID4+ICAgICAgICAgICAgIDAgPSAvZGV2L3JhbTAgICAg
ICAgIEZpcnN0IFJBTSBkaXNrCj4+ID4+Cj4+ID4KPj4gPiBUaGlzIGlzIHRoZSBuZXcgcGF0Y2gu
IExvb2tpbmcgYXQgb3RoZXIgcGFydHMgb2YgZGV2aWNlcy50eHQsIG9ic29sZXRlIGlzCj4+ID4g
c29tZXRpbWVzIHVzZWQgdG9nZXRoZXIgd2l0aCB1bnVzZWQuIEkgZ3Vlc3Mgb2Jzb2xldGUgbWVh
bnMgdGhpcyBpcyBvbGQgaW50ZXJmYWNlIHNvCj4+ID4gZG9uJ3QgdXNlIGl0IGFzIG11Y2ggYXMg
cG9zc2libGUgYW5kIHVudXNlZCBtZWFucyB0aGlzIGlzIG5vdCB1c2VkIGF0IGFsbCBub3cuCj4+
ID4gWW91IHJlbW92ZSBvbGQgbWVtb3J5IGludGVyZmFjZSBjb21wbGV0ZWx5IGluIHRoaXMgcGF0
Y2ggc2V0LCBzbyBpcyBpdCBiZXR0ZXIgdG8gYWRkCj4+ID4gdW51c2VkLCB0b28/Cj4+ID4KPj4K
Pj4gRG9lcyBvYnNvbGV0ZSBhbHNvIG1lYW4gIm5vdCB1c2VkIGFueW1vcmUiPyBJIGRvbid0IGtu
b3cuIEkgdGhpbmsgd2UgY2FuIHdhaXQgZm9yIHNvbWUgbmF0aXZlCj4+IEVuZ2xpc2ggc3BlYWtl
cnMgdG8gY29tbWVudCBvbiB0aGlzLgo+IAo+IE9ic29sZXRlIGltcGxpZXMgdGhhdCBpdCBzaG91
bGRuJ3QgYmUgdXNlZCBhbnltb3JlLiBUaGVyZSBhcmUgZXhjZXB0aW9ucyB0byBldmVyeXRoaW5n
LCBvZiBjb3Vyc2UuLi4KPiAKPiAoVW51c2VkIG1lYW5zIG5vdGhpbmcgaXMgdXNpbmcgaXQuIElm
IHRoZXJlJ3Mgc3RpbGwgY29kZSB1c2luZyBpdCwgaXQncyBub3QgdW51c2VkLiBTbyB5ZWFoIHVu
dXNlZCB3b3VsZCBpbXBseSByZW1vdmVkLikKPiAKClNvLCBjb3VsZCBJIGp1c3QgdXNlIFVOU0VE
IHRvIHJlcGxhY2UgT0JTT0xFVEUgaGVyZT8gT3IgdXNlICJPQlNPTEVURS9VTlVTRUQiPwoKLS0g
ClRoYW5rcy4KWmhhbmcgWWFuZmVpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
