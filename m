Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNCuS-0002fK-Pi
 for kexec@lists.infradead.org; Sat, 11 Apr 2020 09:58:46 +0000
Received: by mail-wm1-f70.google.com with SMTP id s15so1557278wmc.0
 for <kexec@lists.infradead.org>; Sat, 11 Apr 2020 02:58:31 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/3] kexec: Prevent removal of memory in use by a loaded
 kexec image
Date: Sat, 11 Apr 2020 11:58:28 +0200
Message-Id: <B70AA95F-1C6C-48BC-B5BD-18FF83354568@redhat.com>
References: <20200411093009.GH25745@shell.armlinux.org.uk>
In-Reply-To: <20200411093009.GH25745@shell.armlinux.org.uk>
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
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Baoquan He <bhe@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, David Hildenbrand <david@redhat.com>, kexec@lists.infradead.org, linux-mm@kvack.org, James Morse <james.morse@arm.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org

Cgo+IEFtIDExLjA0LjIwMjAgdW0gMTE6NDAgc2NocmllYiBSdXNzZWxsIEtpbmcgLSBBUk0gTGlu
dXggYWRtaW4gPGxpbnV4QGFybWxpbnV4Lm9yZy51az46Cj4gCj4g77u/T24gU2F0LCBBcHIgMTEs
IDIwMjAgYXQgMTE6NDQ6MTRBTSArMDgwMCwgQmFvcXVhbiBIZSB3cm90ZToKPj4gQmVjYXVzZSBX
ZSB0ZW5kIHRvIHVzZSBrZXhlY19maWxlX2xvYWQgbW9yZSBhbmQgaW1wcm92ZS9lbmhhbmNlIGl0
IGluIHRoZQo+PiBmdXR1cmUsIGFuZCBncmFkdWFsbHkgb2Jzb2xldGUgdGhlIG9sZCBrZXhlY19s
b2FkIGludGVyZmFjZSB3aGljaCB0aGlzCj4+IHBhdGNoc2V0IGlzIHRyeWluZyB0byBmaXggb24u
IAo+IAo+IFRoYXQncyBub3QgZ29pbmcgdG8gaGFwcGVuOyAzMi1iaXQgQVJNIGtleGVjIHVzZXMg
dGhlIGtleGVjX2xvYWQKPiBpbnRlcmZhY2UgcmF0aGVyIHRoYW4gdGhlIGtleGVjX2ZpbGVfbG9h
ZCB2ZXJzaW9uLCBhbmQgSSBzZWUgbm8gb25lCj4gd2l0aCBhbnkgaW50ZXJlc3QgaW4gY2hhbmdp
bmcgdGhhdCAtIGFuZCB0aGVyZSdzIHVzZXJzIG9mIHRoZSBmb3JtZXIuCj4gCj4gSSBkb24ndCBz
ZWUgaG93IGl0J3MgcG9zc2libGUgdG8gY29udmVydCAzMi1iaXQgQVJNIGtleGVjIHRvIHRoZQo+
IGtleGVjX2ZpbGVfbG9hZCBpbnRlcmZhY2UgLSB0aGlzIGFzc3VtZXMgdGhhdCBhbGwgeW91IGhh
dmUgYXJlIHRoZQo+IGtlcm5lbCwgaW5pdHJkLCBhbmQgY29tbWFuZGxpbmUsIGJ1dCBvbiAzMi1i
aXQgQVJNIGtleGVjLCB3ZSBoYXZlCj4ga2VybmVsLCBpbml0cmQgYW5kIHRoZSBkdGIgYmxvYiB3
aGljaCB0aGUgdXNlciBjYW4gc3BlY2lmeS4KPiAKPiBTbywgaWYgd2Ugd2FudGVkIHRvIG9ic29s
ZXRlIHRoZSBrZXhlY19sb2FkIGludGVyZmFjZSwgX2ZpcnN0XyB0aGVyZQo+IG5lZWRzIHRvIGJl
IGEgd2F5IHRvIHByb3ZpZGUgdXNlcnMgd2l0aCB0aGUgZXhpc3RpbmcgZnVuY3Rpb25hbGl0eQo+
IHRoZXkgaGF2ZSBhbHJlYWR5IGluIHBsYWNlIG9uIDMyLWJpdCBBUk0gLSBvdGhlcndpc2Ugd2Un
cmUgbG9va2luZwo+IGF0IGEgdXNlcnNwYWNlIHJlZ3Jlc3Npb24uICBFc3BlY2lhbGx5IGFzIGtl
eGVjX2ZpbGVfbG9hZCB0YWtlcwo+IHByZWNlZGVuY2Ugb24gc29tZSBkaXN0cm8gcGF0Y2hlZCB2
ZXJzaW9ucyBvZiB0aGUga2V4ZWMgdG9vbCwKPiBpcnJlc3BlY3RpdmUgb2Ygd2hpY2ggaW50ZXJm
YWNlIHRoZSB1c2VyIHJlcXVlc3RzIG9mIHRoZSB0b29sLgo+IAoKT24gMzJiaXQgYXJjaGl0ZWN0
dXJlcyB3ZSB1c3VhbGx5IGRvbuKAmHQgcmVhbGx5IGNhcmUgYWJvdXQgbWVtb3J5IGhvdHBsdWcu
IFNvIHdlIGNvdWxkIGRlcHJlY2F0ZSBpdCBvbmx5IGZvciA2NGJpdCBhcmNoaXRlY3R1cmVzIEFG
QUlLUy4KCgo+IC0tIAo+IFJNSydzIFBhdGNoIHN5c3RlbTogaHR0cHM6Ly93d3cuYXJtbGludXgu
b3JnLnVrL2RldmVsb3Blci9wYXRjaGVzLwo+IEZUVEMgYnJvYWRiYW5kIGZvciAwLjhtaWxlIGxp
bmUgaW4gc3VidXJiaWE6IHN5bmMgYXQgMTAuMk1icHMgZG93biA1ODdrYnBzIHVwCj4gCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGlu
ZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
