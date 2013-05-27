Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ugmi2-00050Z-63
 for kexec@lists.infradead.org; Mon, 27 May 2013 01:58:51 +0000
Message-ID: <51A2BCCB.2090900@cn.fujitsu.com>
Date: Mon, 27 May 2013 09:54:19 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
References: <51A1AC4A.60506@gmail.com> <51A1AD67.4030800@gmail.com>
 <51A2BAE9.40307@jp.fujitsu.com>
In-Reply-To: <51A2BAE9.40307@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

5LqOIDIwMTPlubQwNeaciDI35pelIDA5OjQ2LCBIQVRBWUFNQSBEYWlzdWtlIOWGmemBkzoKPiAo
MjAxMy8wNS8yNiAxNTozNiksIFpoYW5nIFlhbmZlaSB3cm90ZToKPj4gRnJvbTogWmhhbmcgWWFu
ZmVpIDx6aGFuZ3lhbmZlaUBjbi5mdWppdHN1LmNvbT4KPj4KPj4gU2lnbmVkLW9mZi1ieTogWmhh
bmcgWWFuZmVpIDx6aGFuZ3lhbmZlaUBjbi5mdWppdHN1LmNvbT4KPj4gQ2M6IERhdmUgSm9uZXMg
PGRhdmVqQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNlcy50eHQg
fCAgICAzICstLQo+PiAgIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4dCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNlcy50eHQKPj4gaW5kZXggMDhmMDFlNy4uYzhlNDAwMiAxMDA2NDQK
Pj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4dAo+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXMudHh0Cj4+IEBAIC0xMDAsOCArMTAwLDcgQEAgWW91ciBjb29wZXJhdGlvbiBpcyBh
cHByZWNpYXRlZC4KPj4gICAgICAgICAgICAxMCA9IC9kZXYvYWlvICAgICAgICBBc3luY2hyb25v
dXMgSS9PIG5vdGlmaWNhdGlvbiBpbnRlcmZhY2UKPj4gICAgICAgICAgICAxMSA9IC9kZXYva21z
ZyAgICAgICAgV3JpdGVzIHRvIHRoaXMgY29tZSBvdXQgYXMgcHJpbnRrJ3MsIHJlYWRzCj4+ICAg
ICAgICAgICAgICAgICAgICAgICBleHBvcnQgdGhlIGJ1ZmZlcmVkIHByaW50ayByZWNvcmRzLgo+
PiAtICAgICAgICAgMTIgPSAvZGV2L29sZG1lbSAgICBVc2VkIGJ5IGNyYXNoZHVtcCBrZXJuZWxz
IHRvIGFjY2Vzcwo+PiAtICAgICAgICAgICAgICAgICAgICB0aGUgbWVtb3J5IG9mIHRoZSBrZXJu
ZWwgdGhhdCBjcmFzaGVkLgo+PiArICAgICAgICAgMTIgPSAvZGV2L29sZG1lbSAgICBPQlNPTEVU
RQo+Pgo+PiAgICAgMSBibG9jayAgICBSQU0gZGlzawo+PiAgICAgICAgICAgICAwID0gL2Rldi9y
YW0wICAgICAgICBGaXJzdCBSQU0gZGlzawo+Pgo+IAo+IFRoaXMgaXMgdGhlIG5ldyBwYXRjaC4g
TG9va2luZyBhdCBvdGhlciBwYXJ0cyBvZiBkZXZpY2VzLnR4dCwgb2Jzb2xldGUgaXMKPiBzb21l
dGltZXMgdXNlZCB0b2dldGhlciB3aXRoIHVudXNlZC4gSSBndWVzcyBvYnNvbGV0ZSBtZWFucyB0
aGlzIGlzIG9sZCBpbnRlcmZhY2Ugc28KPiBkb24ndCB1c2UgaXQgYXMgbXVjaCBhcyBwb3NzaWJs
ZSBhbmQgdW51c2VkIG1lYW5zIHRoaXMgaXMgbm90IHVzZWQgYXQgYWxsIG5vdy4KPiBZb3UgcmVt
b3ZlIG9sZCBtZW1vcnkgaW50ZXJmYWNlIGNvbXBsZXRlbHkgaW4gdGhpcyBwYXRjaCBzZXQsIHNv
IGlzIGl0IGJldHRlciB0byBhZGQKPiB1bnVzZWQsIHRvbz8KPiAKCkRvZXMgb2Jzb2xldGUgYWxz
byBtZWFuICJub3QgdXNlZCBhbnltb3JlIj8gSSBkb24ndCBrbm93LiBJIHRoaW5rIHdlIGNhbiB3
YWl0IGZvciBzb21lIG5hdGl2ZQpFbmdsaXNoIHNwZWFrZXJzIHRvIGNvbW1lbnQgb24gdGhpcy4K
ClRoYW5rcwpaaGFuZwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
