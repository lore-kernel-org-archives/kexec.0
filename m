Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNCpP-0004W0-HE
 for kexec@lists.infradead.org; Wed, 23 Oct 2019 09:21:17 +0000
Subject: Re: [PATCH 1/3 v4] x86/kdump: always reserve the low 1MiB when the
 crashkernel option is specified
References: <20191017094347.20327-1-lijiang@redhat.com>
 <20191017094347.20327-2-lijiang@redhat.com> <20191022083015.GB31700@zn.tnic>
 <75648e8d-4ef7-0537-618e-e4a57f0d3b9b@redhat.com>
 <20191023074602.GB16060@zn.tnic>
From: lijiang <lijiang@redhat.com>
Message-ID: <98c9f97d-de22-2041-d0a4-214542807706@redhat.com>
Date: Wed, 23 Oct 2019 17:20:50 +0800
MIME-Version: 1.0
In-Reply-To: <20191023074602.GB16060@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, vgoyal@redhat.com

5ZyoIDIwMTnlubQxMOaciDIz5pelIDE1OjQ2LCBCb3Jpc2xhdiBQZXRrb3Yg5YaZ6YGTOgo+IE9u
IFdlZCwgT2N0IDIzLCAyMDE5IGF0IDAxOjM1OjA5UE0gKzA4MDAsIGxpamlhbmcgd3JvdGU6Cj4+
IFdvdWxkIHlvdSBtaW5kIGlmIGkgaW1wcm92ZSB0aGlzIHBhdGNoIGFzIGZvbGxvdz8gVGhhbmtz
Lgo+IAo+IFlhcCwgbG9va3MgZ29vZCB0byBtZS4KPiAKVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQu
CgpPSy4gSSB3aWxsIHBvc3QgdGhpcyBvbmUgYW5kIHRoZSB0aGlyZCBwYXRjaCBpbiB0aGlzIHNl
cmllcyBsYXRlci4KClRoYW5rcy4KTGlhbmJvCgoKPiBUaHguCj4gCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVj
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9rZXhlYwo=
