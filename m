Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wjscg-0007vQ-Qy
 for kexec@lists.infradead.org; Mon, 12 May 2014 15:58:39 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <clg@fr.ibm.com>;
 Mon, 12 May 2014 16:58:14 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2BD7A2190046
 for <kexec@lists.infradead.org>; Mon, 12 May 2014 16:58:04 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4CFwCGh49283202
 for <kexec@lists.infradead.org>; Mon, 12 May 2014 15:58:12 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4CFwCpc012986
 for <kexec@lists.infradead.org>; Mon, 12 May 2014 09:58:12 -0600
Message-ID: <5370EF8D.3040604@fr.ibm.com>
Date: Mon, 12 May 2014 17:58:05 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] ppc64: detect zImage files and load the uncompressed
 vmlinux
References: <1397830120-13323-1-git-send-email-clg@fr.ibm.com>
 <1397830120-13323-4-git-send-email-clg@fr.ibm.com>
 <53709ABF.8060707@linux.vnet.ibm.com>
In-Reply-To: <53709ABF.8060707@linux.vnet.ibm.com>
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
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, kexec@lists.infradead.org
Cc: horms@verge.net.au

SGkgTGF1cmVudCwKClsgLi4uIF0KCj4+ICtpbnQgekltYWdlX3BwYzY0X3VuemlwKHN0cnVjdCBt
ZW1fZWhkciAqZWhkciwgdm9pZCAqKmJ1ZiwgaW50ICpsZW4pCj4+ICt7Cj4+ICsJc3RydWN0IG1l
bV9zaGRyICpzaGRyOwo+PiArCXZvaWQgKnZtbGludXpfYWRkcjsKPj4gKwl1bnNpZ25lZCBsb25n
IHZtbGludXpfc2l6ZTsKPj4gKwl1bnNpZ25lZCBpbnQgKnZtbGludXhfc2l6ZXA7Cj4+ICsKPj4g
Kwl2b2lkICp2bWxpbnV4X2FkZHI7Cj4+ICsJaW50IHZtbGludXhfc2l6ZTsKPj4gKwo+PiArCXNo
ZHIgPSBlbGZfcmVsX2ZpbmRfc2VjdGlvbihlaGRyLCAiLmtlcm5lbDp2bWxpbnV4LnN0cmlwIik7
Cj4+ICsJaWYgKCFzaGRyKQo+PiArCQlyZXR1cm4gLTE7Cj4+ICsKPj4gKwl2bWxpbnV6X2FkZHIg
PSAodm9pZCAqKSBzaGRyLT5zaF9kYXRhOwo+PiArCXZtbGludXpfc2l6ZSA9IHNoZHItPnNoX3Np
emU7Cj4+ICsKPj4gKwkgLyogVGhlIHNpemUgb2YgdGhlIHVuY29tcHJlc3NlZCBmaWxlIGlzIHN0
b3JlZCBpbiB0aGUgbGFzdCA0Cj4+ICsJICAqIGJ5dGVzLiBUaGUgdm1saW51eCBzaXplIHNob3Vs
ZCBiZSBsZXNzIHRoYW4gNEcgLi4uICovCj4+ICsJdm1saW51eF9zaXplcCA9ICh2bWxpbnV6X2Fk
ZHIgKyB2bWxpbnV6X3NpemUpIC0gNDsKPj4gKwo+PiArCWZwcmludGYoc3RkZXJyLCAiRm91bmQg
dm1saW51eiBhdCAlcCwgdW56aXBwaW5nICVkIGJ5dGVzXG4iLAo+PiArCQl2bWxpbnV6X2FkZHIs
ICp2bWxpbnV4X3NpemVwKTsKPiAKPiBIaSBDw6lkcmljLAo+IAo+IEknZCByYXRoZXIgdXNlIGRi
Z3ByaW50ZiBpbnN0ZWFkIG9mIGRpcmVjdGx5IGNhbGwgZnByaW50ZiBoZXJlLgoKU3VyZS4gVGhh
bmtzIGZvciB0aGUgcmV2aWV3LiBJIGhhdmUgYSBuZXcgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIHdo
aWNoIAphbHNvIGZpeGVzIHRoZSB3YXkgdGhlIHVuY29tcHJlc3NlZCBzaXplIGlzIHJlYWQsIGFz
IGl0IGlzIHN0b3JlZCBhcyAKYSBsaXR0bGUgZW5kaWFuIHVpbnQuCgpTaW1vbiwgZG8geW91IHdh
bnQgYSByZXNlbmQgb2YgdGhlIHBhdGNoc2V0IG9yIGEgZml4IG9uIHRvcCBvZiBpdCA/IAoKQ2hl
ZXJzLCAKCkMuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
