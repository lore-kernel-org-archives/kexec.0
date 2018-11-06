Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gK2y9-0007fj-MJ
 for kexec@lists.infradead.org; Tue, 06 Nov 2018 15:08:42 +0000
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wA6F581D030112
 for <kexec@lists.infradead.org>; Tue, 6 Nov 2018 10:08:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2nkcg32tbb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 06 Nov 2018 10:08:27 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.ibm.com>;
 Tue, 6 Nov 2018 15:08:25 -0000
Subject: Re: [PATCH v2 2/3] keys: export find_keyring_by_name()
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 06 Nov 2018 10:08:05 -0500
In-Reply-To: <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
 <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
Mime-Version: 1.0
Message-Id: <1541516885.8568.29.camel@linux.ibm.com>
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
To: Nayna Jain <nayna@linux.vnet.ibm.com>, dhowells@redhat.com
Cc: pjones@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, dyoung@redhat.com, vgoyal@redhat.com

SGkgTmF5bmEsCgpPbiBGcmksIDIwMTgtMDMtMDkgYXQgMjE6MDggKzA1MzAsIE5heW5hIEphaW4g
d3JvdGU6Cj4gVGhpcyBwYXRjaCBleHBvcnRzIHRoZSBmdW5jdGlvbiBmaW5kX2tleXJpbmdfYnlf
bmFtZSgpIHRvIGJlIHVzZWQgYnkKPiBvdGhlciBzdWJzeXN0ZW1zLgoKTG9va2luZyB0aGlzIHBh
dGNoIG92ZXIgYWdhaW4sIEkgcmVhbGl6ZSB0aGF0IGV4cG9ydGVkIGZ1bmN0aW9ucyBtdXN0CmJl
IHByZWZpeGVkIHdpdGggdGhlIHN1YnN5c3RlbSBuYW1lLiDCoEknbSBhbHNvIGEgYml0IGNvbmNl
cm5lZCB3aXRoCmV4cG9ydGluZyBmaW5kX2tleXJpbmdfYnlfbmFtZSgpLiDCoERhdmlkLCBhbnkg
Y29tbWVudHM/CgpQZXJoYXBzIGl0IHdvdWxkIGJlIGJldHRlciBpZiBJTUEgY3JlYXRlcyB0aGUg
LnBsYXRmb3JtIGtleXJpbmcgc28KdGhhdCBpdCBoYXMgYWNjZXNzIHRvIHRoZSBrZXlyaW5nIGlk
IGluc3RlYWQuCgpNaW1pCsKgwqAKPiAKPiBTaWduZWQtb2ZmLWJ5OiBOYXluYSBKYWluIDxuYXlu
YUBsaW51eC52bmV0LmlibS5jb20+Cj4gLS0tCj4gQ2hhbmdlbG9nOgo+IAo+IHYyOgo+ICogRml4
IHRoZSBwYXRjaCBkZXNjcmlwdGlvbiBwZXIgbGluZSBsZW5ndGggYXMgc3VnZ2VzdGVkIGJ5IE1p
bWkKPiAKPiAgaW5jbHVkZS9saW51eC9rZXkuaCAgICAgIHwgMiArKwo+ICBzZWN1cml0eS9rZXlz
L2ludGVybmFsLmggfCAyIC0tCj4gIHNlY3VyaXR5L2tleXMva2V5cmluZy5jICB8IDEgKwo+ICAz
IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9rZXkuaCBiL2luY2x1ZGUvbGludXgva2V5LmgKPiBpbmRl
eCBlNThlZTEwZjZlNTguLmM4ZDMzMmQ0MTAzYyAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L2tleS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC9rZXkuaAo+IEBAIC0zNDYsNiArMzQ2LDggQEAg
c3RhdGljIGlubGluZSBrZXlfc2VyaWFsX3Qga2V5X3NlcmlhbChjb25zdCBzdHJ1Y3Qga2V5ICpr
ZXkpCj4gCj4gIGV4dGVybiB2b2lkIGtleV9zZXRfdGltZW91dChzdHJ1Y3Qga2V5ICosIHVuc2ln
bmVkKTsKPiAKPiArZXh0ZXJuIHN0cnVjdCBrZXkgKmZpbmRfa2V5cmluZ19ieV9uYW1lKGNvbnN0
IGNoYXIgKm5hbWUsIGJvb2wgdWlkX2tleXJpbmcpOwo+ICsKPiAgLyoKPiAgICogVGhlIHBlcm1p
c3Npb25zIHJlcXVpcmVkIG9uIGEga2V5IHRoYXQgd2UncmUgbG9va2luZyB1cC4KPiAgICovCj4g
ZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tleXMvaW50ZXJuYWwuaCBiL3NlY3VyaXR5L2tleXMvaW50
ZXJuYWwuaAo+IGluZGV4IDlmODIwOGRjMGU1NS4uOGFhOGQzNDdhMWFiIDEwMDY0NAo+IC0tLSBh
L3NlY3VyaXR5L2tleXMvaW50ZXJuYWwuaAo+ICsrKyBiL3NlY3VyaXR5L2tleXMvaW50ZXJuYWwu
aAo+IEBAIC0xNDEsOCArMTQxLDYgQEAgZXh0ZXJuIGtleV9yZWZfdCBrZXlyaW5nX3NlYXJjaF9h
dXgoa2V5X3JlZl90IGtleXJpbmdfcmVmLAo+ICBleHRlcm4ga2V5X3JlZl90IHNlYXJjaF9teV9w
cm9jZXNzX2tleXJpbmdzKHN0cnVjdCBrZXlyaW5nX3NlYXJjaF9jb250ZXh0ICpjdHgpOwo+ICBl
eHRlcm4ga2V5X3JlZl90IHNlYXJjaF9wcm9jZXNzX2tleXJpbmdzKHN0cnVjdCBrZXlyaW5nX3Nl
YXJjaF9jb250ZXh0ICpjdHgpOwo+IAo+IC1leHRlcm4gc3RydWN0IGtleSAqZmluZF9rZXlyaW5n
X2J5X25hbWUoY29uc3QgY2hhciAqbmFtZSwgYm9vbCB1aWRfa2V5cmluZyk7Cj4gLQo+ICBleHRl
cm4gaW50IGluc3RhbGxfdXNlcl9rZXlyaW5ncyh2b2lkKTsKPiAgZXh0ZXJuIGludCBpbnN0YWxs
X3RocmVhZF9rZXlyaW5nX3RvX2NyZWQoc3RydWN0IGNyZWQgKik7Cj4gIGV4dGVybiBpbnQgaW5z
dGFsbF9wcm9jZXNzX2tleXJpbmdfdG9fY3JlZChzdHJ1Y3QgY3JlZCAqKTsKPiBkaWZmIC0tZ2l0
IGEvc2VjdXJpdHkva2V5cy9rZXlyaW5nLmMgYi9zZWN1cml0eS9rZXlzL2tleXJpbmcuYwo+IGlu
ZGV4IDQxYmNmNTdlOTZmMi4uNGI5YzNmMTE2NmQxIDEwMDY0NAo+IC0tLSBhL3NlY3VyaXR5L2tl
eXMva2V5cmluZy5jCj4gKysrIGIvc2VjdXJpdHkva2V5cy9rZXlyaW5nLmMKPiBAQCAtMTE1Miw2
ICsxMTUyLDcgQEAgc3RydWN0IGtleSAqZmluZF9rZXlyaW5nX2J5X25hbWUoY29uc3QgY2hhciAq
bmFtZSwgYm9vbCB1aWRfa2V5cmluZykKPiAgCXJlYWRfdW5sb2NrKCZrZXlyaW5nX25hbWVfbG9j
ayk7Cj4gIAlyZXR1cm4ga2V5cmluZzsKPiAgfQo+ICtFWFBPUlRfU1lNQk9MKGZpbmRfa2V5cmlu
Z19ieV9uYW1lKTsKPiAKPiAgc3RhdGljIGludCBrZXlyaW5nX2RldGVjdF9jeWNsZV9pdGVyYXRv
cihjb25zdCB2b2lkICpvYmplY3QsCj4gIAkJCQkJIHZvaWQgKml0ZXJhdG9yX2RhdGEpCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
