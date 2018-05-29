Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fNnp1-000878-2F
 for kexec@lists.infradead.org; Tue, 29 May 2018 23:14:32 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TNDiRv092662
 for <kexec@lists.infradead.org>; Tue, 29 May 2018 19:14:16 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2j9ewn2qt0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 29 May 2018 19:14:15 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Wed, 30 May 2018 00:14:14 +0100
Subject: Re: [PATCH v4 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 29 May 2018 19:14:05 -0400
In-Reply-To: <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1527635645.3534.39.camel@linux.vnet.ibm.com>
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
To: Paul Moore <paul@paul-moore.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R
 . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, Andres Rodriguez <andresx7@gmail.com>

T24gVHVlLCAyMDE4LTA1LTI5IGF0IDE4OjM5IC0wNDAwLCBQYXVsIE1vb3JlIHdyb3RlOgpbLi4u
XQo+ID4gQEAgLTQwNDMsNiArNDAzNywyNSBAQCBzdGF0aWMgaW50IHNlbGludXhfa2VybmVsX21v
ZHVsZV9mcm9tX2ZpbGUoc3RydWN0IGZpbGUgKmZpbGUpCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFNZU1RFTV9fTU9EVUxFX0xPQUQsICZhZCk7Cj4gPiAgfQo+ID4KPiA+ICtz
dGF0aWMgaW50IHNlbGludXhfa2VybmVsX2xvYWRfZGF0YShlbnVtIGtlcm5lbF9sb2FkX2RhdGFf
aWQgaWQpCj4gPiArewo+ID4gKyAgICAgICB1MzIgc2lkOwo+ID4gKyAgICAgICBpbnQgcmMgPSAw
Owo+ID4gKwo+ID4gKyAgICAgICBzd2l0Y2ggKGlkKSB7Cj4gPiArICAgICAgIGNhc2UgTE9BRElO
R19NT0RVTEU6Cj4gPiArICAgICAgICAgICAgICAgc2lkID0gY3VycmVudF9zaWQoKTsKPiA+ICsK
PiA+ICsgICAgICAgICAgICAgICAvKiBpbml0X21vZHVsZSAqLwo+ID4gKyAgICAgICAgICAgICAg
IHJldHVybiBhdmNfaGFzX3Blcm0oJnNlbGludXhfc3RhdGUsIHNpZCwgc2lkLCBTRUNDTEFTU19T
WVNURU0sCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTWVNURU1fX01P
RFVMRV9MT0FELCBOVUxMKTsKPiA+ICsgICAgICAgZGVmYXVsdDoKPiA+ICsgICAgICAgICAgICAg
ICBicmVhazsKPiA+ICsgICAgICAgfQo+ID4gKwo+ID4gKyAgICAgICByZXR1cm4gcmM7Cj4gPiAr
fQo+IAo+IEknbSBub3QgYSBmYW4gb2YgdGhlIGR1cGxpY2F0aW9uIGhlcmUuICBJZiB3ZSBtdXN0
IGhhdmUgYSBuZXcgTFNNIGhvb2sKPiBmb3IgdGhpcywgY2FuIHdlIGF0IGxlYXN0IGhhdmUgaXQg
Y2FsbAo+IHNlbGludXhfa2VybmVsX21vZHVsZV9mcm9tX2ZpbGUoKSBzbyB3ZSBoYXZlIGFsbCB0
aGUga2VybmVsIG1vZHVsZQo+IGxvYWRpbmcgbG9naWMvY29udHJvbHMgaW4gb25lIGZ1bmN0aW9u
PyAgWWVzLCBJIHVuZGVyc3RhbmQgdGhlcmUgYXJlCj4gZGlmZmVyZW5jZXMgYmV0d2VlbiBpbml0
X21vZHVsZSgpIGFuZCBmaW5pdF9tb2R1bGUoKSBidXQgSSBsaWtlCj4gaGFuZGxpbmcgdGhlbSBi
b3RoIGluIG9uZSBmdW5jdGlvbiBhcyB3ZSBkbyB0b2RheS4KClRoZXJlJ3Mgc29tZSBkaXNhZ3Jl
ZW1lbnQgYXMgdG8gd2hldGhlciB3ZSByZWFsbHkgbmVlZCB0d28gTFNNIGhvb2tzLgrCoFRoaXMg
c291bmRzIGxpa2UgeW91IHdvdWxkIHByZWZlciBhIHNpbmdsZSBMU00gaG9vaywgbm90IHRoZSB0
d28gdGhhdAp0aGlzIHBhdGNoIHNldCBpbnRyb2R1Y2VzLgoKV2UgbmVlZCB0byBjb21lIHRvIHNv
bWUgY29uc2Vuc3VzLiDCoChDb21tZW50cyBhcHByZWNpYXRlZCBpbiAwLzguKQoKTWltaQoKPiAK
PiA+ICBzdGF0aWMgaW50IHNlbGludXhfa2VybmVsX3JlYWRfZmlsZShzdHJ1Y3QgZmlsZSAqZmls
ZSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0ga2VybmVsX3Jl
YWRfZmlsZV9pZCBpZCkKPiA+ICB7Cj4gPiBAQCAtNjk1MCw2ICs2OTYzLDcgQEAgc3RhdGljIHN0
cnVjdCBzZWN1cml0eV9ob29rX2xpc3Qgc2VsaW51eF9ob29rc1tdIF9fbHNtX3JvX2FmdGVyX2lu
aXQgPSB7Cj4gPiAgICAgICAgIExTTV9IT09LX0lOSVQoa2VybmVsX2FjdF9hcywgc2VsaW51eF9r
ZXJuZWxfYWN0X2FzKSwKPiA+ICAgICAgICAgTFNNX0hPT0tfSU5JVChrZXJuZWxfY3JlYXRlX2Zp
bGVzX2FzLCBzZWxpbnV4X2tlcm5lbF9jcmVhdGVfZmlsZXNfYXMpLAo+ID4gICAgICAgICBMU01f
SE9PS19JTklUKGtlcm5lbF9tb2R1bGVfcmVxdWVzdCwgc2VsaW51eF9rZXJuZWxfbW9kdWxlX3Jl
cXVlc3QpLAo+ID4gKyAgICAgICBMU01fSE9PS19JTklUKGtlcm5lbF9sb2FkX2RhdGEsIHNlbGlu
dXhfa2VybmVsX2xvYWRfZGF0YSksCj4gPiAgICAgICAgIExTTV9IT09LX0lOSVQoa2VybmVsX3Jl
YWRfZmlsZSwgc2VsaW51eF9rZXJuZWxfcmVhZF9maWxlKSwKPiA+ICAgICAgICAgTFNNX0hPT0tf
SU5JVCh0YXNrX3NldHBnaWQsIHNlbGludXhfdGFza19zZXRwZ2lkKSwKPiA+ICAgICAgICAgTFNN
X0hPT0tfSU5JVCh0YXNrX2dldHBnaWQsIHNlbGludXhfdGFza19nZXRwZ2lkKSwKPiA+IC0tCj4g
PiAyLjcuNQo+ID4KPiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
