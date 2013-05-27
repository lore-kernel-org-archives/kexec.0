Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ugmzt-0005Do-Iv
 for kexec@lists.infradead.org; Mon, 27 May 2013 02:17:18 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id B20103EE0C1
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 11:16:55 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A37C745DE4D
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 11:16:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7696245DE52
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 11:16:55 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6559C1DB8043
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 11:16:55 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0E47E1DB803A
 for <kexec@lists.infradead.org>; Mon, 27 May 2013 11:16:55 +0900 (JST)
Message-ID: <51A2C1EB.6050207@jp.fujitsu.com>
Date: Mon, 27 May 2013 11:16:11 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/7] Documentation/devices.txt: Mark /dev/oldmem
 obsolete
References: <51A1AC4A.60506@gmail.com> <51A1AD67.4030800@gmail.com>
 <51A2BAE9.40307@jp.fujitsu.com> <51A2BCCB.2090900@cn.fujitsu.com>
In-Reply-To: <51A2BCCB.2090900@cn.fujitsu.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

KDIwMTMvMDUvMjcgMTA6NTQpLCBaaGFuZyBZYW5mZWkgd3JvdGU6Cj4g5LqOIDIwMTPlubQwNeac
iDI35pelIDA5OjQ2LCBIQVRBWUFNQSBEYWlzdWtlIOWGmemBkzoKPj4gKDIwMTMvMDUvMjYgMTU6
MzYpLCBaaGFuZyBZYW5mZWkgd3JvdGU6Cj4+PiBGcm9tOiBaaGFuZyBZYW5mZWkgPHpoYW5neWFu
ZmVpQGNuLmZ1aml0c3UuY29tPgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFpoYW5nIFlhbmZlaSA8
emhhbmd5YW5mZWlAY24uZnVqaXRzdS5jb20+Cj4+PiBDYzogRGF2ZSBKb25lcyA8ZGF2ZWpAcmVk
aGF0LmNvbT4KPj4+IC0tLQo+Pj4gICAgRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4dCB8ICAgIDMg
Ky0tCj4+PiAgICAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2VzLnR4dCBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNlcy50eHQKPj4+IGluZGV4IDA4ZjAxZTcuLmM4ZTQwMDIgMTAwNjQ0Cj4+
PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXMudHh0Cj4+PiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXMudHh0Cj4+PiBAQCAtMTAwLDggKzEwMCw3IEBAIFlvdXIgY29vcGVyYXRpb24gaXMg
YXBwcmVjaWF0ZWQuCj4+PiAgICAgICAgICAgICAxMCA9IC9kZXYvYWlvICAgICAgICBBc3luY2hy
b25vdXMgSS9PIG5vdGlmaWNhdGlvbiBpbnRlcmZhY2UKPj4+ICAgICAgICAgICAgIDExID0gL2Rl
di9rbXNnICAgICAgICBXcml0ZXMgdG8gdGhpcyBjb21lIG91dCBhcyBwcmludGsncywgcmVhZHMK
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgZXhwb3J0IHRoZSBidWZmZXJlZCBwcmludGsgcmVj
b3Jkcy4KPj4+IC0gICAgICAgICAxMiA9IC9kZXYvb2xkbWVtICAgIFVzZWQgYnkgY3Jhc2hkdW1w
IGtlcm5lbHMgdG8gYWNjZXNzCj4+PiAtICAgICAgICAgICAgICAgICAgICB0aGUgbWVtb3J5IG9m
IHRoZSBrZXJuZWwgdGhhdCBjcmFzaGVkLgo+Pj4gKyAgICAgICAgIDEyID0gL2Rldi9vbGRtZW0g
ICAgT0JTT0xFVEUKPj4+Cj4+PiAgICAgIDEgYmxvY2sgICAgUkFNIGRpc2sKPj4+ICAgICAgICAg
ICAgICAwID0gL2Rldi9yYW0wICAgICAgICBGaXJzdCBSQU0gZGlzawo+Pj4KPj4KPj4gVGhpcyBp
cyB0aGUgbmV3IHBhdGNoLiBMb29raW5nIGF0IG90aGVyIHBhcnRzIG9mIGRldmljZXMudHh0LCBv
YnNvbGV0ZSBpcwo+PiBzb21ldGltZXMgdXNlZCB0b2dldGhlciB3aXRoIHVudXNlZC4gSSBndWVz
cyBvYnNvbGV0ZSBtZWFucyB0aGlzIGlzIG9sZCBpbnRlcmZhY2Ugc28KPj4gZG9uJ3QgdXNlIGl0
IGFzIG11Y2ggYXMgcG9zc2libGUgYW5kIHVudXNlZCBtZWFucyB0aGlzIGlzIG5vdCB1c2VkIGF0
IGFsbCBub3cuCj4+IFlvdSByZW1vdmUgb2xkIG1lbW9yeSBpbnRlcmZhY2UgY29tcGxldGVseSBp
biB0aGlzIHBhdGNoIHNldCwgc28gaXMgaXQgYmV0dGVyIHRvIGFkZAo+PiB1bnVzZWQsIHRvbz8K
Pj4KPgo+IERvZXMgb2Jzb2xldGUgYWxzbyBtZWFuICJub3QgdXNlZCBhbnltb3JlIj8gSSBkb24n
dCBrbm93LiBJIHRoaW5rIHdlIGNhbiB3YWl0IGZvciBzb21lIG5hdGl2ZQo+IEVuZ2xpc2ggc3Bl
YWtlcnMgdG8gY29tbWVudCBvbiB0aGlzLgo+CgpZZXMuIFRvIGJlIGhvbmVzdCwgSSdtIHN0aWxs
IHN1c3BlY3RpbmcgInVudXNlZCIgZG9lc24ndCBpbmNsdWRlIG1lYW5pbmcgb2YgInJlbW92ZWQi
Li4uCgotLSAKVGhhbmtzLgpIQVRBWUFNQSwgRGFpc3VrZQoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
