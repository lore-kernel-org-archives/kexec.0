Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bZXPT-0001gL-NY
 for kexec@lists.infradead.org; Tue, 16 Aug 2016 05:59:36 +0000
Date: Tue, 16 Aug 2016 07:59:11 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH 3/3] close_dump_bitmap: simplify logic
Message-ID: <20160816075911.09a0659d@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E5CE94@BPXM01GP.gisp.nec.co.jp>
References: <20160810125658.23366-1-mwilck@suse.de>
 <20160810125658.23366-4-mwilck@suse.de>
 <20160810150846.6a257447@hananiah.suse.cz>
 <1470836145.3194.31.camel@suse.de>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E5CE94@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, Martin Wilck <mwilck@suse.de>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

T24gVHVlLCAxNiBBdWcgMjAxNiAwMDozNzowOSArMDAwMApBdHN1c2hpIEt1bWFnYWkgPGF0cy1r
dW1hZ2FpQHdtLmpwLm5lYy5jb20+IHdyb3RlOgoKPiA+PiA+IFRoZSBib29sZWFuIGV4cHJlc3Np
b24gcmVwbGljYXRlcyB0aGUgbG9naWMgb2Ygb3Blbl9kdW1wX2JpdG1hcCgpLgo+ID4+ID4gSXQn
cyBzaW1wbGVyIGFuZCBsZXNzIGVycm9yLXByb25lIHRvIHNpbXBseSBjaGVjayBpZiBmZF9iaXRt
YXAgaXMKPiA+PiA+IHZhbGlkLgo+ID4+ID4KPiA+PiA+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBX
aWxjayA8bXdpbGNrQHN1c2UuZGU+Cj4gPj4gPiAtLS0KPiA+PiA+IMKgbWFrZWR1bXBmaWxlLmMg
fCAzICstLQo+ID4+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pCj4gPj4gPgo+ID4+ID4gZGlmZiAtLWdpdCBhL21ha2VkdW1wZmlsZS5jIGIvbWFrZWR1
bXBmaWxlLmMKPiA+PiA+IGluZGV4IDQzMjc4ZjEuLjc3MWFiN2MgMTAwNjQ0Cj4gPj4gPiAtLS0g
YS9tYWtlZHVtcGZpbGUuYwo+ID4+ID4gKysrIGIvbWFrZWR1bXBmaWxlLmMKPiA+PiA+IEBAIC04
NTc5LDggKzg1NzksNyBAQCBjbG9zZV9kdW1wX2ZpbGUodm9pZCkKPiA+PiA+IMKgdm9pZAo+ID4+
ID4gwqBjbG9zZV9kdW1wX2JpdG1hcCh2b2lkKQo+ID4+ID4gwqB7Cj4gPj4gPiAtCWlmICghaW5m
by0+d29ya2luZ19kaXIgJiYgIWluZm8tPmZsYWdfcmVhc3NlbWJsZSAmJiAhaW5mby0KPiA+PiA+
ID5mbGFnX3JlZmlsdGVyaW5nCj4gPj4gPiAtCcKgwqDCoMKgJiYgIWluZm8tPmZsYWdfc2FkdW1w
ICYmICFpbmZvLT5mbGFnX21lbV91c2FnZSkKPiA+PiA+ICsJaWYgKCFpbmZvLT5mZF9iaXRtYXAp
Cj4gPj4KPiA+PiBTdHJpY3RseSBzcGVha2luZywgemVybyBpcyBhIHZhbGlkIEZELiBJIGNhbiBz
ZWUgdGhhdCBpdCBpcyBoaWdobHkKPiA+PiB1bmxpa2VseSB0byBiZSB0aGUgYml0bWFwIEZELCBi
dXQgaXQgd291bGQgYmUgYSBuaWNlIGNsZWFudXAgdG8KPiA+PiBpbml0aWFsaXplIGZkX2JpdG1h
cCB0byBhIG5lZ2F0aXZlIG51bWJlciBhbmQgY2hlY2sgaW5mby0+ZmRfYml0bWFwIDwKPiA+PiAw
Lgo+ID4+IEknbSBqdXN0IG5vdCBzdXJlIHdoZXJlIHRvIHB1dCB0aGUgaW5pdGlhbGl6aXRpb24u
Li4KPiA+Cj4gPgo+ID4+ID4gT1RPSCBJIGtub3cgSSdtIGFza2luZyB5b3UgdG8gZml4IHNvbWV0
aGluZyB0aGF0IHlvdSBkaWRuJ3QgYnJlYWsuCj4gPgo+ID5JIGhhZCB0aGUgc2FtZSB0aG91Z2h0
LCBhbmQgdGhlIHNhbWUgZXhjdXNlIG5vdCB0byBhZGRyZXNzIGl0IGluIHRoaXMKPiA+cGF0Y2gg
c2V0LiBJZiB5b3UgZ3JlcCBtYWtlZHVtcGZpbGUuYyBmb3IgImZkX2JpdG1hcCIsIHlvdSdsbCBz
ZWUgbWFueQo+ID5jaGVja3MgbGlrZSAiaWYgKGluZm8tPmZkX2JpdG1hcCkiLiBJIGp1c3QgZm9s
bG93ZWQgdGhhdCBwYXR0ZXJuIGZvcgo+ID5ub3cuCj4gCj4gSSBzZWUsIGl0IHdvdWxkIGJlIGJl
dHRlciB0byBtYWtlIHRoZSBjaGVja3Mgc3RyaWN0IG9uIHRoaXMgb2NjYXNpb24uCj4gU28sIGNv
dWxkIHlvdSB3b3JrIGZvciB0aGF0IGNsZWFudXAgYmVmb3JlIHlvdXIgdGhyZWUgcGF0Y2hlcyBh
cyBhbgo+IGFkZGl0aW9uYWwgY2xlYW51cCBwYXRjaCA/CgpPSywgSSB0YWtlIGl0LiA7LSkKCk1h
cnRpbiwgZG8geW91IG1pbmQgcmViYXNpbmcgeW91ciBwYXRjaCB3aGVuIEknbSBkb25lIHdpdGgg
dGhlIGNsZWFudXA/CgpQZXRyIFQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
