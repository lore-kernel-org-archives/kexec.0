Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USHBw-0002hn-R8
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 01:29:46 +0000
Message-ID: <516DFA9C.5030704@cn.fujitsu.com>
Date: Wed, 17 Apr 2013 09:27:56 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH
 RESEND]kexec:i386/kexec-[bzImage|elf-x86]:x86_64/kexec-bzImage64:
 Use "\0" as command line instead of empty command line
References: <20130408092325.GA23318@udknight>
 <51628E04.8010002@cn.fujitsu.com> <516D5B8E.6070302@gmail.com>
 <20130417001314.GB21434@verge.net.au>
In-Reply-To: <20130417001314.GB21434@verge.net.au>
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
To: Simon Horman <horms@verge.net.au>
Cc: tjd21@cl.cam.ac.uk, kexec@lists.infradead.org, Wang YanQing <udknight@gmail.com>, ebiederm@xmission.com, hari@in.ibm.com, Zhang Yanfei <zhangyanfei.yes@gmail.com>

5LqOIDIwMTPlubQwNOaciDE35pelIDA4OjEzLCBTaW1vbiBIb3JtYW4g5YaZ6YGTOgo+IE9uIFR1
ZSwgQXByIDE2LCAyMDEzIGF0IDEwOjA5OjE4UE0gKzA4MDAsIFpoYW5nIFlhbmZlaSB3cm90ZToK
Pj4g5LqOIDIwMTPlubQwNOaciDA45pelIDE3OjI5LCBaaGFuZyBZYW5mZWkg5YaZ6YGTOgo+Pj4g
5LqOIDIwMTPlubQwNOaciDA45pelIDE3OjIzLCBXYW5nIFlhblFpbmcg5YaZ6YGTOgo+Pj4+IFRo
aXMgcGF0Y2ggcHJldmVudHMgdGhlIHByb2JsZW1zIHRvIGhhcHBlbiBiZWxvdzoKPj4+PiBJbiBz
ZXR1cF9saW51eF9ib290bG9hZGVyX3BhcmFtZXRlcnNfaGlnaAo+Pj4+IDEyMCAgICAgICAgIGNt
ZGxpbmVfcHRyID0gKChjaGFyICopcmVhbF9tb2RlKSArIGNtZGxpbmVfb2Zmc2V0Owo+Pj4+IDEy
MSAgICAgICAgIG1lbWNweShjbWRsaW5lX3B0ciwgY21kbGluZSwgY21kbGluZV9sZW4pOwo+Pj4+
IDEyMiAgICAgICAgIGNtZGxpbmVfcHRyW2NtZGxpbmVfbGVuIC0gMV0gPSAnXDAnOwo+Pj4+Cj4+
Pj4gaWYgY21kbGluZV9sZW4gPT0gMCwgTGluZSAxMjIgd2lsbCBjb3JydXB0IGtlcm5lbDE2IGJ1
ZiBqdXN0IGJlZm9yZSB0aGUgY29tbWFuZGxpbmUuCj4+Pj4gQW5kIGluIGRvX2J6SW1hZ2VfbG9h
ZCwgZm9yIGV4YW1wbGUsCj4+Pj4gMzY5ICAgICAgICAgY21kbGluZV9lbmQgPSBzZXR1cF9iYXNl
ICsga2VybjE2X3NpemVfbmVlZGVkICsgY29tbWFuZF9saW5lX2xlbiAtIDE7Cj4+Pj4gMzcwICAg
ICAgICAgZWxmX3JlbF9zZXRfc3ltYm9sKCZpbmZvLT5yaGRyLCAiY21kbGluZV9lbmQiLCAmY21k
bGluZV9lbmQsCj4+Pj4gMzcxICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZih1bnNp
Z25lZCBsb25nKSk7Cj4+Pj4gTGluZSAzNjkgd2lsbCBnbyB3cm9uZywgdG9vLgo+Pj4+Cj4+Pj4g
U2lnbmVkLW9mZi1ieTogV2FuZyBZYW5RaW5nIDx1ZGtuaWdodEBnbWFpbC5jb20+Cj4+Pj4gLS0t
Cj4+Pj4gIEhpIFpoYW5nIFlhbmZlaSwgY291bGQgeW91IGdpdmUgeW91ciBzaWduZWQtb2ZmLWJ5
IHRvCj4+Pj4gIHRoaXMgcGF0Y2g/Cj4+Pgo+Pj4gWWVhaC4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGFuZyBZYW5mZWkgPHpoYW5neWFuZmVpQGNuLmZ1aml0c3UuY29tPgo+Pj4KPj4+IEhpIFNp
bW9uLCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rIGF0IHRoaXMgdG8gc2VlIGlmIHRoZSBj
aGFuZ2UgaXMgcmVhc29uYWJsZT8KPj4+IEFmdGVyIGFsbCwgaWYgbm8gY29tbWFkbGluZSwgd2Ug
bWFrZSB0aGUgY29tbWFuZGxpbmVfbGVuIHRvIDEuIEkgZG9uJ3Qga25vdyBpZgo+Pj4gdGhpcyBi
ZWhhdmlvdXIgY291bGQgYmUgYWNjZXB0ZWQgYnkgeW91Lgo+Pj4KPj4KPj4gSGkgU2ltb24KPj4K
Pj4gV2hhdCBpcyB5b3VyIG9waW5pb24gYWJvdXQgdGhpcyBwYXRjaD8KPiAKPiBJdCBzZWVtcyBy
ZWFzb25hYmxlIHRvIG1lLCBJIGhhdmUgYXBwbGllZCBpdC4KPiAKPiBJIGhhdmUgYWRkZWQgeW91
ciBTaWduZWQtb2ZmLWJ5LiBIb3dldmVyLCBmb3IgcmVmZXJlbmNlOiB1bmxlc3MgeW91IGFyZSB0
aGUKPiBtYWludGFpbmVyIG9yIHdlcmUgaW52b2x2ZWQgaW4gd3JpdGluZyB0aGUgcGF0Y2ggSSB0
aGluayBhbiBBY2tlZC1ieSBvcgo+IFRlc3RlZC1ieSB3b3VsZCBiZSBtb3JlIGFwcHJvcHJpYXRl
Lgo+IAoKSSBhZGRlZCBzb21lIGNvZGVzIGluIHRoZSBtYWlsIHdoZW4gd2UgZGlzY3Vzc2VkIHRo
aXMgcGF0Y2gsIHNvIEkKYWRkIG15IFNpZ25lZC1vZmYtYnkuCgpBbnl3YXksIHRoYW5rcyBmb3Ig
eW91ciByZW1pbmRpbmc6LSkKClRoYW5rcwpaaGFuZwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9r
ZXhlYwo=
