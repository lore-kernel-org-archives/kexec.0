Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQKkD-0003mn-2N
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 22:48:02 +0000
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w55MiC6d078389
 for <kexec@lists.infradead.org>; Tue, 5 Jun 2018 18:47:47 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2je3988m1r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 18:47:47 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 5 Jun 2018 23:47:45 +0100
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
In-Reply-To: <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com>
 <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com>
 <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
 <1528234513.3557.16.camel@linux.vnet.ibm.com>
 <CAGXu5j+9P9HLvwC4WfHoxXsz7vYA_raStVDPzA=tNR9f9vr9=Q@mail.gmail.com>
Date: Tue, 05 Jun 2018 18:40:11 -0400
Mime-Version: 1.0
Message-Id: <1528238411.3557.32.camel@linux.vnet.ibm.com>
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
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kexec Mailing List <kexec@lists.infradead.org>, "Luis
 R . Rodriguez" <mcgrof@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, James Morris <jmorris@namei.org>, Andres Rodriguez <andresx7@gmail.com>

T24gVHVlLCAyMDE4LTA2LTA1IGF0IDE1OjI2IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6Cj4gT24g
VHVlLCBKdW4gNSwgMjAxOCBhdCAyOjM1IFBNLCBNaW1pIFpvaGFyIDx6b2hhckBsaW51eC52bmV0
LmlibS5jb20+IHdyb3RlOgo+ID4gT24gVHVlLCAyMDE4LTA2LTA1IGF0IDEyOjQ1IC0wNzAwLCBL
ZWVzIENvb2sgd3JvdGU6Cj4gPgo+ID4+IEFuZCBpZiB5b3UgbXVzdCBoYXZlIGEgc2VwYXJhdGUg
ZW51bSwgcGxlYXNlIGNoYW5nZSB0aGlzIHRvIGZhaWwKPiA+PiBjbG9zZWQgaW5zdGVhZCBvZiBv
cGVuIChhbmQgbWFyayB0aGUgZmFsbC10aHJvdWdoKToKPiA+Pgo+ID4+IGludCByYyA9IC1FUEVS
TTsKPiA+Pgo+ID4+IHN3aXRjaCAoaWQpIHsKPiA+PiBjYXNlIExPQURJTkdfTU9EVUxFOgo+ID4+
ICAgICByYyA9IGxvYWRwaW5fcmVhZF9maWxlKE5VTEwsIFJFQURJTkdfTU9EVUxFKTsKPiA+PiAg
ICAgLyogRmFsbC10aHJvdWdoICovCj4gPj4gZGVmYXVsdDoKPiA+PiAgICAgYnJlYWs7Cj4gPj4g
fQo+ID4KPiA+IFRoaXMgd2lsbCBmYWlsIHRoZSBzeXNmcyBmaXJtd2FyZSBmYWxsYmFjayBsb2Fk
aW5nIGFuZCB0aGUga2V4ZWNfbG9hZAo+ID4gc3lzY2FsbCB3aXRob3V0IGFueSBtZXNzYWdlLCBh
cyB5b3UgaGF2ZSBmb3IgaW5pdF9tb2R1bGUuICBJcyB0aGF0Cj4gPiB3aGF0IHlvdSB3YW50Pwo+
IAo+IEknZCBwcmVmZXIgdGhlcmUgYmUgYSBmdWxsIG1hcHBpbmcgb2YgdGhlIGVudW1zIHNvIHRo
YXQgZXZlcnl0aGluZwo+IGdldHMgcGFzc2VkIGludG8gbG9hZHBpbl9yZWFkX2ZpbGUoKSA6KQo+
IAo+IENhbiB0aGUgZW51bSBiZSBzaGFyZWQgb3IgaXMgdGhhdCBub25zZW5zaWNhbD8KCkNvbnNp
ZGVyaW5nIHRoaXMgaXMgdjQgb2YgdGhlIHBhdGNoIHNldCwgaXQncyBwcmV0dHkgb2J2aW91cyBJ
IGRpZApldmVyeXRoaW5nIHBvc3NpYmxlIG5vdCB0byBkZWZpbmUgYSBuZXcgTFNNIGhvb2suIMKg
RXZlbiBpZiB3ZSBjYW4ndApyZS11c2UgdGhlIGV4aXN0aW5nIGVudW0sIHdlIGNvdWxkIGRlZmlu
ZSB0aGUgbmV3IGVudW0gaW4gdGVybXMKb2bCoF9fa2VybmVsX3JlYWRfZmlsZV9pZC4KCmVudW0g
a2VybmVsX2xvYWRfZGF0YV9pZCB7CiAgICAgICAgX19rZXJuZWxfcmVhZF9maWxlX2lkKF9fZGF0
YV9pZF9lbnVtaWZ5KQp9OwoKc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBrZXJuZWxfbG9hZF9k
YXRhX3N0cltdID0gewogICAgICAgIF9fa2VybmVsX3JlYWRfZmlsZV9pZChfX2RhdGFfaWRfc3Ry
aW5naWZ5KQp9OwoKRXJpYywgU2VyZ2UsIHdvdWxkIHVzaW5nIGVpdGhlciB0aGUgZXhpc3Rpbmcg
X19rZXJuZWxfcmVhZF9maWxlX2lkCmVudW0gb3IgdGhlIGFib3ZlIGRlZmluaXRpb25zIGJlIGFj
Y2VwdGFibGU/CgpNaW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
