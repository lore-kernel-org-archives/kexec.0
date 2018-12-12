Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX8PY-0002D8-WD
 for kexec@lists.infradead.org; Wed, 12 Dec 2018 17:35:10 +0000
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBCHXiKv012771
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 12:34:51 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2pb68t1w0b-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 12 Dec 2018 12:34:51 -0500
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <nayna@linux.ibm.com>;
 Wed, 12 Dec 2018 17:34:49 -0000
Subject: Re: [PATCH v2 5/7] efi: Import certificates from UEFI Secure Boot
References: <20181208202705.18673-1-nayna@linux.ibm.com>
 <20181208202705.18673-6-nayna@linux.ibm.com>
 <alpine.LRH.2.21.1812120547110.11653@namei.org>
From: Nayna Jain <nayna@linux.ibm.com>
Date: Wed, 12 Dec 2018 23:01:15 +0530
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.1812120547110.11653@namei.org>
Content-Language: en-US
Message-Id: <d36bfd7c-7564-778b-1e75-5b835d40b6f1@linux.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: James Morris <jmorris@namei.org>
Cc: linux-efi@vger.kernel.org, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, seth.forshee@canonical.com, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, ebiederm@xmission.com, jforbes@redhat.com, linux-integrity@vger.kernel.org, Josh Boyer <jwboyer@fedoraproject.org>, vgoyal@redhat.com

CgpPbiAxMi8xMi8yMDE4IDEyOjE3IEFNLCBKYW1lcyBNb3JyaXMgd3JvdGU6Cj4gT24gU3VuLCA5
IERlYyAyMDE4LCBOYXluYSBKYWluIHdyb3RlOgo+Cj4+ICsvKgo+PiArICogQmxhY2tsaXN0IGFu
IFg1MDkgVEJTIGhhc2guCj4+ICsgKi8KPj4gK3N0YXRpYyBfX2luaXQgdm9pZCB1ZWZpX2JsYWNr
bGlzdF94NTA5X3Ricyhjb25zdCBjaGFyICpzb3VyY2UsCj4+ICsJCQkJCSAgIGNvbnN0IHZvaWQg
KmRhdGEsIHNpemVfdCBsZW4pCj4+ICt7Cj4+ICsJY2hhciAqaGFzaCwgKnA7Cj4+ICsKPj4gKwlo
YXNoID0ga21hbGxvYyg0ICsgbGVuICogMiArIDEsIEdGUF9LRVJORUwpOwo+PiArCWlmICghaGFz
aCkKPj4gKwkJcmV0dXJuOwo+PiArCXAgPSBtZW1jcHkoaGFzaCwgInRiczoiLCA0KTsKPj4gKwlw
ICs9IDQ7Cj4+ICsJYmluMmhleChwLCBkYXRhLCBsZW4pOwo+PiArCXAgKz0gbGVuICogMjsKPj4g
KwkqcCA9IDA7Cj4+ICsKPj4gKwltYXJrX2hhc2hfYmxhY2tsaXN0ZWQoaGFzaCk7Cj4+ICsJa2Zy
ZWUoaGFzaCk7Cj4+ICt9Cj4+ICsKPj4gKy8qCj4+ICsgKiBCbGFja2xpc3QgdGhlIGhhc2ggb2Yg
YW4gZXhlY3V0YWJsZS4KPj4gKyAqLwo+PiArc3RhdGljIF9faW5pdCB2b2lkIHVlZmlfYmxhY2ts
aXN0X2JpbmFyeShjb25zdCBjaGFyICpzb3VyY2UsCj4+ICsJCQkJCSBjb25zdCB2b2lkICpkYXRh
LCBzaXplX3QgbGVuKQo+PiArewo+PiArCWNoYXIgKmhhc2gsICpwOwo+PiArCj4+ICsJaGFzaCA9
IGttYWxsb2MoNCArIGxlbiAqIDIgKyAxLCBHRlBfS0VSTkVMKTsKPj4gKwlpZiAoIWhhc2gpCj4+
ICsJCXJldHVybjsKPj4gKwlwID0gbWVtY3B5KGhhc2gsICJiaW46IiwgNCk7Cj4+ICsJcCArPSA0
Owo+PiArCWJpbjJoZXgocCwgZGF0YSwgbGVuKTsKPj4gKwlwICs9IGxlbiAqIDI7Cj4+ICsJKnAg
PSAwOwo+PiArCj4+ICsJbWFya19oYXNoX2JsYWNrbGlzdGVkKGhhc2gpOwo+PiArCWtmcmVlKGhh
c2gpOwo+PiArfQo+Pgo+IFRoZXNlIGNvdWxkIGJlIHJlZmFjdG9yZWQgaW50byBvbmUgZnVuY3Rp
b24uCj4KPgoKVGhhbmtzIEphbWVzIGZvciByZXZpZXdpbmcuCgpZZXMsIHRoZSBjb2RlIHNob3Vs
ZCBiZSByZWZhY3RvcmVkLsKgIEhvd2V2ZXIsIEkgdGhpbmsgbWFraW5nIGl0IGEgc2luZ2xlIApm
dW5jdGlvbiB3b3VsZCByZXF1aXJlIGFkZGluZyBhIG5ldyBmaWVsZCB0byB0aGUgZnVuY3Rpb24g
Y2FsbGJhY2sgCmRlZmluaXRpb25zIGFzIHdlbGwuIFByb2JhYmx5LCBhIHNpbXBsZXIgYXBwcm9h
Y2ggd291bGQgYmUgdG8gZGVmaW5lIGEgCmNvbW1vbiBmdW5jdGlvbiB1ZWZpX2JsYWNrbGlzdF9o
YXNoKC4uLinCoCB3aGljaCBjYW4gdGhlbiBiZSB1c2VkIGJ5IHRoZSAKdHdvIGZ1bmN0aW9ucyB1
ZWZpX2JsYWNrbGlzdF94NTA5X3RicyguLi4pIGFuZCAKdWVmaV9ibGFja2xpc3RfYmluYXJ5KC4u
LikuIFRoZXNlIHR3byBmdW5jdGlvbnMgbm93IGFjdCBhcyB3cmFwcGVyIApmdW5jdGlvbnMuIEJl
bG93IGlzIHRoZSBleGFtcGxlIGNvZGU6CgorLyoKKyAqIEJsYWNrbGlzdCBhIGhhc2guCisgKi8K
K3N0YXRpYyBfX2luaXQgdm9pZCB1ZWZpX2JsYWNrbGlzdF9oYXNoKGNvbnN0IGNoYXIgKnNvdXJj
ZSwgY29uc3Qgdm9pZCAKKmRhdGEsCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVfdCBsZW4sIGNoYXIgKnR5cGUsIHNp
emVfdCB0eXBlX2xlbikKK3sKK8KgwqDCoMKgwqDCoCBjaGFyICpoYXNoLCAqcDsKKworwqDCoMKg
wqDCoMKgIGhhc2ggPSBrbWFsbG9jKHR5cGVfbGVuICsgbGVuICogMiArIDEsIEdGUF9LRVJORUwp
OworwqDCoMKgwqDCoMKgIGlmICghaGFzaCkKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuOworwqDCoMKgwqDCoMKgIHAgPSBtZW1jcHkoaGFzaCwgdHlwZSwgdHlwZV9sZW4pOwor
wqDCoMKgwqDCoMKgIHAgKz0gdHlwZV9sZW47CivCoMKgwqDCoMKgwqAgYmluMmhleChwLCBkYXRh
LCBsZW4pOworwqDCoMKgwqDCoMKgIHAgKz0gbGVuICogMjsKK8KgwqDCoMKgwqDCoCAqcCA9IDA7
CisKK8KgwqDCoMKgwqDCoCBtYXJrX2hhc2hfYmxhY2tsaXN0ZWQoaGFzaCk7CivCoMKgwqDCoMKg
wqAga2ZyZWUoaGFzaCk7Cit9CisKKy8qCisgKiBCbGFja2xpc3QgYW4gWDUwOSBUQlMgaGFzaC4K
KyAqLworc3RhdGljIF9faW5pdCB2b2lkIHVlZmlfYmxhY2tsaXN0X3g1MDlfdGJzKGNvbnN0IGNo
YXIgKnNvdXJjZSwKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qgdm9pZCAqZGF0YSwg
c2l6ZV90IGxlbikKK3sKK8KgwqDCoMKgwqDCoCB1ZWZpX2JsYWNrbGlzdF9oYXNoKHNvdXJjZSwg
ZGF0YSwgbGVuLCAidGJzOiIgLCA0KTsKK30KKworLyoKKyAqIEJsYWNrbGlzdCB0aGUgaGFzaCBv
ZiBhbiBleGVjdXRhYmxlLgorICovCitzdGF0aWMgX19pbml0IHZvaWQgdWVmaV9ibGFja2xpc3Rf
YmluYXJ5KGNvbnN0IGNoYXIgKnNvdXJjZSwKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCB2
b2lkICpkYXRhLCBzaXplX3QgbGVuKQoreworwqDCoMKgwqDCoMKgIHVlZmlfYmxhY2tsaXN0X2hh
c2goc291cmNlLCBkYXRhLCBsZW4sICJiaW46IiAsIDQpOworfQoKClRoYW5rcyAmIFJlZ2FyZHMs
CiDCoMKgIC0gTmF5bmEKCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
