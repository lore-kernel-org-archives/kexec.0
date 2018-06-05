Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fQJcK-0003wq-1o
 for kexec@lists.infradead.org; Tue, 05 Jun 2018 21:35:57 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w55LXbku048842
 for <kexec@lists.infradead.org>; Tue, 5 Jun 2018 17:35:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jdwrrd9mu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 05 Jun 2018 17:35:33 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Tue, 5 Jun 2018 22:35:24 +0100
Subject: Re: [PATCH v4a 8/8] module: replace the existing LSM hook in
 init_module
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 05 Jun 2018 17:35:13 -0400
In-Reply-To: <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-9-git-send-email-zohar@linux.vnet.ibm.com>
 <CAHC9VhQL+CsqKL83fSZhjEZVSjKKfmLULvehXZ8SZhtK5xzLMQ@mail.gmail.com>
 <1527635645.3534.39.camel@linux.vnet.ibm.com>
 <CAHC9VhQQX-JAnV-6jEOsug-6siyO9mrNa=rYK9Whg-MYcfHxgA@mail.gmail.com>
 <1527780226.3427.20.camel@linux.vnet.ibm.com>
 <CAGXu5jLXSEWHorm6=h9+1cP-y8ZX2_ALcra6g9x7Tm-O0kU3DQ@mail.gmail.com>
Mime-Version: 1.0
Message-Id: <1528234513.3557.16.camel@linux.vnet.ibm.com>
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
 R . Rodriguez" <mcgrof@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jeff Vander Stoep <jeffv@google.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity <linux-integrity@vger.kernel.org>, Andres Rodriguez <andresx7@gmail.com>

T24gVHVlLCAyMDE4LTA2LTA1IGF0IDEyOjQ1IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6Cgo+IEFu
ZCBpZiB5b3UgbXVzdCBoYXZlIGEgc2VwYXJhdGUgZW51bSwgcGxlYXNlIGNoYW5nZSB0aGlzIHRv
IGZhaWwKPiBjbG9zZWQgaW5zdGVhZCBvZiBvcGVuIChhbmQgbWFyayB0aGUgZmFsbC10aHJvdWdo
KToKPiAKPiBpbnQgcmMgPSAtRVBFUk07Cj4gCj4gc3dpdGNoIChpZCkgewo+IGNhc2UgTE9BRElO
R19NT0RVTEU6Cj4gICAgIHJjID0gbG9hZHBpbl9yZWFkX2ZpbGUoTlVMTCwgUkVBRElOR19NT0RV
TEUpOwo+ICAgICAvKiBGYWxsLXRocm91Z2ggKi8KPiBkZWZhdWx0Ogo+ICAgICBicmVhazsKPiB9
CgpUaGlzIHdpbGwgZmFpbCB0aGUgc3lzZnMgZmlybXdhcmUgZmFsbGJhY2sgbG9hZGluZyBhbmQg
dGhlIGtleGVjX2xvYWQKc3lzY2FsbCB3aXRob3V0IGFueSBtZXNzYWdlLCBhcyB5b3UgaGF2ZSBm
b3IgaW5pdF9tb2R1bGUuIMKgSXMgdGhhdAp3aGF0IHlvdSB3YW50PwoKTWltaQoKwqAKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5n
IGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
