Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URiOx-0000ao-Hk
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 12:20:52 +0000
In-Reply-To: <2471280.iW0sCiTc3x@skinner.arch.suse.de>
References: <1365683207-42425-1-git-send-email-trenn@suse.de>
 <1365683207-42425-6-git-send-email-trenn@suse.de>
 <5167DA38.3050600@cn.fujitsu.com> <2471280.iW0sCiTc3x@skinner.arch.suse.de>
MIME-Version: 1.0
Subject: Re: [PATCH 5/5] kexec: X86: Pass memory ranges via e820 table instead
 of memmap= boot parameter
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Mon, 15 Apr 2013 05:20:24 -0700
Message-ID: <be30cb86-285f-4ff0-af0d-ea7d18a3490c@email.android.com>
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
To: Thomas Renninger <trenn@suse.de>, Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, yinghai@kernel.org, cpw@sgi.com, vgoyal@redhat.com

RXhjZXB0IHRoYXQgaXMgd3JvbmcuIFRoZSBrZXJuZWwgY2FuIHJlY2VpdmUgbW9yZSB0aGFuIDEy
OCBlODIwIGVudHJpZXMsIHRoZXkganVzdCBoYXZlIHRvIGJlIHBhc3NlZCB2aWEgYSBkaWZmZXJl
bnQgbWVjaGFuaXNtLgoKVGhvbWFzIFJlbm5pbmdlciA8dHJlbm5Ac3VzZS5kZT4gd3JvdGU6Cgo+
T24gRnJpZGF5LCBBcHJpbCAxMiwgMjAxMyAwNTo1NjowOCBQTSBaaGFuZyBZYW5mZWkgd3JvdGU6
Cj4+IOS6jiAyMDEz5bm0MDTmnIgxMeaXpSAyMDoyNiwgVGhvbWFzIFJlbm5pbmdlciDlhpnpgZM6
Cj4+ID4gQ3VycmVudGx5IHJhbmdlcyBhcmUgcGFzc2VkIHZpYSBrZXJuZWwgYm9vdCBwYXJhbWV0
ZXJzOgo+PiA+IG1lbW1hcD1leGFjdG1hcCBtZW1tYXA9WCNZIG1lbW1hcD0KPj4gPiAKPi4uLgo+
PiA+IC0JaWYgKCEoZW5kIC0gc3RhcnQpKQo+PiA+IC0JCXJldHVybiAwOwo+PiA+ICsJLyoKPj4g
PiArCSAqIElnbm9yZSB1c2FibGUgbWVtb3J5IHJhbmdlcyBmb3Iga2R1bXAga2VybmVsIHNtYWxs
ZXIKPj4gPiArCSAqIHRoYW4gMTAwayB0byBhdm9pZCB0b28gbXVjaCByYW5nZXMgcGFzc2VkCj4+
ID4gKwkgKiBTYXZlIHRoZSBuZXcgcmFuZ2VzIChleGx1ZGluZyBsb3dlciB0aGFuIDEwMGsgcmFu
Z2VzKSBpbgo+dG1wX21hcAo+PiA+ICsJICogYW5kIHN0b3JlIHRoZSBudW1iZXIgb2YgZWxlbWVu
dHMgaW4gdG1wX21hcF9yYW5nZXMKPj4gPiArCSAqLwo+PiA+ICsJZm9yIChtID0gMCwgaSA9IDA7
IGkgPCBDUkFTSF9NQVhfTUVNTUFQX05SOyBpKyspIHsKPj4gPiArCQl1bnNpZ25lZCBsb25nIHN0
YXJ0aywgZW5kazsKPj4gPiArCQlzdGFydGsgPSAodXNhYmxlX21lbVtpXS5zdGFydC8xMDI0KTsK
Pj4gPiArCQllbmRrID0gKCh1c2FibGVfbWVtW2ldLmVuZCArIDEpLzEwMjQpOwo+PiA+ICsJCWlm
ICghc3RhcnRrICYmICFlbmRrKQo+PiA+ICsJCQkvKiBBbGwgcmVnaW9ucyB0cmF2ZXJzZWQuICov
Cj4+ID4gKwkJCWJyZWFrOwo+PiA+ICsKPj4gPiArCQkvKiBBIHJlZ2lvbiBpcyBub3Qgd29ydGgg
YWRkaW5nIGlmIHJlZ2lvbiBzaXplIDwgMTAwSy4gSXQgZWF0cwo+PiA+ICsJCSAqIHVwIHByZWNp
b3VzIGNvbW1hbmQgbGluZSBsZW5ndGguICovCj4+IAo+PiBOb3cgeW91IGFyZSBwYXNzaW5nIHRo
ZSBlODIwIHRhYmxlIGRpcmVjdGx5IGluc3RlYWQgb2YgdGhlCj5jb21tYW5kbGluZSwgc28KPj4g
ZG9lcyB0aGlzIGNvbW1lbnQgbWFrZSBzZW5zZSBub3c/Cj5ZZXMgeW91IGFyZSByaWdodCwgdGhl
IGNvbW1lbnQgaXMgd3JvbmcuCj5JdCBzaG91bGQgbW9yZSBiZSBsaWtlOgo+LyoKPkEgcmVnaW9u
IGlzIG5vdCB3b3J0aCBhZGRpbmcgaWYgcmVnaW9uIHNpemUgPCAxMDBLLiBlODIwIGVudHJpZXMg
YXJlIAo+cmVzdHJpY3RlZCB0byAxMjggaW4ga2VybmVsLCB3aXRoIGtkdW1wIHdlIG1heSBoYXZl
IHRvIHBhc3MgdGhlIG9uZSBvcgo+b3RoZXIKPm1vcmUgYW5kIHdlIHdhbnQgdG8gdHJ5IHRvIHN0
YXkgYXQgMTI4IG1heCBlbnRyaWVzIChmcm9tIG9yaWdpbmFsCj50YWJsZSkgYXMgCj5jbG9zZSBh
cyBwb3NzaWJsZS4KPiovCj4KPlRoYW5rcywKPgo+ICAgICAgVGhvbWFzCgotLSAKU2VudCBmcm9t
IG15IG1vYmlsZSBwaG9uZS4gUGxlYXNlIGV4Y3VzZSBicmV2aXR5IGFuZCBsYWNrIG9mIGZvcm1h
dHRpbmcuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpr
ZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
