Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fPq5u-0000iD-2y
 for kexec@lists.infradead.org; Mon, 04 Jun 2018 14:04:29 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w54DxnJR080217
 for <kexec@lists.infradead.org>; Mon, 4 Jun 2018 10:04:08 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jd59wwjgx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 04 Jun 2018 10:04:07 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Mon, 4 Jun 2018 15:04:04 +0100
Subject: Re: [PATCH v4 0/8] kexec/firmware: support system wide policy
 requiring signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Mon, 04 Jun 2018 10:03:45 -0400
In-Reply-To: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
Mime-Version: 1.0
Message-Id: <1528121025.3237.116.camel@linux.vnet.ibm.com>
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
To: Casey Schaufler <casey@schaufler-ca.com>, James Morris <james.l.morris@oracle.com>, Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jessica Yu <jeyu@kernel.org>, linux-integrity <linux-integrity@vger.kernel.org>, Andres Rodriguez <andresx7@gmail.com>

T24gVHVlLCAyMDE4LTA1LTI5IGF0IDE0OjAxIC0wNDAwLCBNaW1pIFpvaGFyIHdyb3RlOgo+IElu
c3RlYWQgb2YgYWRkaW5nIHRoZSBzZWN1cml0eV9rZXJuZWxfcmVhZF9maWxlIExTTSBob29rIC0g
b3IgZGVmaW5pbmcgYQo+IHdyYXBwZXIgZm9yIHNlY3VyaXR5X2tlcm5lbF9yZWFkX2ZpbGUgTFNN
IGhvb2sgYW5kIGFkZGluZyBpdCwgb3IKPiByZW5hbWluZyB0aGUgZXhpc3RpbmcgaG9vayB0byBz
ZWN1cml0eV9rZXJuZWxfcmVhZF9kYXRhKCkgYW5kIGFkZGluZyBpdAo+IC0gaW4gcGxhY2VzIHdo
ZXJlIHRoZSBrZXJuZWwgaXNuJ3QgcmVhZGluZyBhIGZpbGUsIHRoaXMgdmVyc2lvbiBvZiB0aGUK
PiBwYXRjaCBzZXQgZGVmaW5lcyBhIG5ldyBMU00gaG9vayBuYW1lZCBzZWN1cml0eV9rZXJuZWxf
bG9hZF9kYXRhKCkuCj4gCj4gVGhlIG5ldyBMU00gaG9vayBkb2VzIG5vdCByZXBsYWNlIHRoZSBl
eGlzdGluZyBzZWN1cml0eV9rZXJuZWxfcmVhZF9maWxlCj4gTFNNIGhvb2ssIHdoaWNoIGlzIHN0
aWxsIG5lZWRlZCwgYnV0IGRlZmluZXMgYSBuZXcgTFNNIGhvb2sgYWxsb3dpbmcKPiBMU01zIGFu
ZCBJTUEtYXBwcmFpc2FsIHRoZSBvcHBvcnR1bml0eSB0byBmYWlsIGxvYWRpbmcgdXNlcnNwYWNl
Cj4gcHJvdmlkZWQgZmlsZS9kYXRhLgo+IAo+IFRoZSBvbmx5IGRpZmZlcmVuY2UgYmV0d2VlbiB0
aGUgdHdvIExTTSBob29rcyBpcyB0aGUgTFNNIGhvb2sgbmFtZSBhbmQgYQo+IGZpbGUgZGVzY3Jp
cHRvci4gIFdoZXRoZXIgdGhpcyBpcyBjYXVzZSBlbm91Z2ggZm9yIHJlcXVpcmluZyBhIG5ldyBM
U00KPiBob29rLCBpcyBsZWZ0IHRvIHRoZSBzZWN1cml0eSBjb21tdW5pdHkuCgpQYXVsIGRvZXMg
bm90IGhhdmUgYSBwcmVmZXJlbmNlIGFzIHRvIGFkZGluZyBhIG5ldyBMU00gaG9vayBvciBjYWxs
aW5nCnRoZSBleGlzdGluZyBob29rLiDCoEVpdGhlciB3YXkgaXMgZmluZSwgYXMgbG9uZyBhcyBi
b3RoIHRoZSBuZXcgYW5kCmV4aXN0aW5nIGhvb2tzIGNhbGwgdGhlIGV4aXN0aW5nIGZ1bmN0aW9u
LgoKQ2FzZXkgZGlkbid0IGxpa2UgdGhlIGlkZWEgb2YgYSB3cmFwcGVyLgpKYW1lcyBzdWdnZXN0
ZWQgcmVuYW1pbmcgdGhlIExTTSBob29rLgoKVGhlIG1haW50YWluZXJzIGZvciB0aGUgY2FsbGVy
cyBvZiB0aGUgTFNNIGhvb2sgcHJlZmVyIGEgbWVhbmluZ2Z1bApMU00gaG9vayBuYW1lLiDCoFRo
ZSAibnVsbCIgYXJndW1lbnQgaXMgbm90IGFzIG11Y2ggb2YgYSBjb25jZXJuLiDCoE9ubHkKRXJp
YyBzZWVtcyB0byBiZSBhc2tpbmcgZm9yIGEgc2VwYXJhdGUsIG5ldyBMU00gaG9vaywgd2l0aG91
dCB0aGUKIm51bGwiIGFyZ3VtZW50LgoKVW5sZXNzIHNvbWVvbmUgcmVhbGx5IG9iamVjdHMsIHRv
IGFjY29tbW9kYXRlIEVyaWMgd2UnbGwgZGVmaW5lIGEgbmV3CkxTTSBob29rIG5hbWVkIHNlY3Vy
aXR5X2tlcm5lbF9sb2FkX2RhdGEuIMKgRXJpYywgYXJlIHlvdSBwbGFubmluZyBvbgpBY2snaW5n
IHBhdGNoZXMgMSAmIDI/CgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
