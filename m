Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaf2X-0002wX-3f
 for kexec@lists.infradead.org; Mon, 18 May 2020 12:38:42 +0000
Message-ID: <1589805462.5111.107.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 18 May 2020 08:37:42 -0400
In-Reply-To: <20200518062255.GB15641@infradead.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
 <20200518062255.GB15641@infradead.org>
Mime-Version: 1.0
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
To: Christoph Hellwig <hch@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>
Cc: rafael@kernel.org, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, ebiederm@xmission.com, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

SGkgQ2hyaXN0b3BoLAoKT24gU3VuLCAyMDIwLTA1LTE3IGF0IDIzOjIyIC0wNzAwLCBDaHJpc3Rv
cGggSGVsbHdpZyB3cm90ZToKPiBPbiBGcmksIE1heSAxNSwgMjAyMCBhdCAwOToyOTozM1BNICsw
MDAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOgo+ID4gT24gV2VkLCBNYXkgMTMsIDIwMjAgYXQg
MTE6MTc6MzZBTSAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiA+IENhbiB5b3Ug
YWxzbyBtb3ZlIGtlcm5lbF9yZWFkXyogb3V0IG9mIGZzLmg/ICBUaGF0IGhlYWRlciBnZXRzIHB1
bGxlZAo+ID4gPiBpbiBqdXN0IGFib3V0IGV2ZXJ5d2hlcmUgYW5kIGRvZXNuJ3QgcmVhbGx5IG5l
ZWQgZnVuY3Rpb24gbm90IHJlbGF0ZWQKPiA+ID4gdG8gdGhlIGdlbmVyYWwgZnMgaW50ZXJmYWNl
Lgo+ID4gCj4gPiBTdXJlLCB3aGVyZSBzaG91bGQgSSBkdW1wIHRoZXNlPwo+IAo+IE1heWJlIGEg
bmV3IGxpbnV4L2tlcm5lbF9yZWFkX2ZpbGUuaD8gIEJvbnVzIHBvaW50cyBmb3IgYSBzbWFsbCB0
b3AKPiBvZiB0aGUgZmlsZSBjb21tZW50IGV4cGxhaW5pbmcgdGhlIHBvaW50IG9mIHRoZSBpbnRl
cmZhY2UsIHdoaWNoIEkKPiBzdGlsbCBkb24ndCBnZXQgOikKCkluc3RlYWQgb2Ygcm9sbGluZyB5
b3VyIG93biBtZXRob2Qgb2YgaGF2aW5nIHRoZSBrZXJuZWwgcmVhZCBhIGZpbGUsCndoaWNoIHJl
cXVpcmVzIGNhbGwgc3BlY2lmaWMgc2VjdXJpdHkgaG9va3MsIHRoaXMgaW50ZXJmYWNlIHByb3Zp
ZGVzIGEKc2luZ2xlIGdlbmVyaWMgc2V0IG9mIHByZSBhbmQgcG9zdCBzZWN1cml0eSBob29rcy7C
oMKgVGhlCmtlcm5lbF9yZWFkX2ZpbGVfaWQgZW51bWVyYXRpb24gcGVybWl0cyB0aGUgc2VjdXJp
dHkgaG9vayB0bwpkaWZmZXJlbnRpYXRlIGJldHdlZW4gY2FsbGVycy4KClRvIGNvbXBseSB3aXRo
IHNlY3VyZSBhbmQgdHJ1c3RlZCBib290IGNvbmNlcHRzLCBhIGZpbGUgY2Fubm90IGJlCmFjY2Vz
c2libGUgdG8gdGhlIGNhbGxlciB1bnRpbCBhZnRlciBpdCBoYXMgYmVlbiBtZWFzdXJlZCBhbmQv
b3IgdGhlCmludGVncml0eSAoaGFzaC9zaWduYXR1cmUpIGFwcHJhaXNlZC4KCkluIHNvbWUgY2Fz
ZXMsIHRoZSBmaWxlIHdhcyBwcmV2aW91c2x5IHJlYWQgdHdpY2UsIGZpcnN0IHRvIG1lYXN1cmUK
YW5kL29yIGFwcHJhaXNlIHRoZSBmaWxlIGFuZCB0aGVuIHJlYWQgYWdhaW4gaW50byBhIGJ1ZmZl
ciBmb3IKdXNlLsKgwqBUaGlzIGludGVyZmFjZSByZWFkcyB0aGUgZmlsZSBpbnRvIGEgYnVmZmVy
IG9uY2UsIGNhbGxzIHRoZQpnZW5lcmljIHBvc3Qgc2VjdXJpdHkgaG9vaywgYmVmb3JlIHByb3Zp
ZGluZyB0aGUgYnVmZmVyIHRvIHRoZSBjYWxsZXIuCsKgKE5vdGUgdXNpbmcgZmlybXdhcmUgcHJl
LWFsbG9jYXRlZCBtZW1vcnkgbWlnaHQgYmUgYW4gaXNzdWUuKQoKUGFydGlhbCByZWFkaW5nIGZp
cm13YXJlIHdpbGwgcmVzdWx0IGluIG5lZWRpbmcgdG8gcHJlLXJlYWQgdGhlIGVudGlyZQpmaWxl
LCBtb3N0IGxpa2VseSBvbiB0aGUgc2VjdXJpdHkgcHJlIGhvb2suCgpNaW1pCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
