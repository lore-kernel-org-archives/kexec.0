Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv2.oss.ntt.co.jp ([222.151.198.100])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S7Gm9-0001qA-Ma
 for kexec@lists.infradead.org; Tue, 13 Mar 2012 01:43:48 +0000
Message-ID: <4F5EA649.2060002@oss.ntt.co.jp>
Date: Tue, 13 Mar 2012 10:43:37 +0900
From: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?= <fernando@oss.ntt.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] boot: ignore early NMIs
References: <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com> <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org> <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org> <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org> <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <4F573E74.5040504@oss.ntt.co.jp> <m1eht31z8e.fsf@fess.ebiederm.org>
 <4F58495B.5080308@oss.ntt.co.jp> <m1r4x3yrsv.fsf@fess.ebiederm.org>
 <4F5A6D87.4050809@zytor.com> <4F5D8D0E.8060702@oss.ntt.co.jp>
 <4F5D8E63.60606@zytor.com> <4F5D943C.5020403@oss.ntt.co.jp>
 <4F5E431D.8010305@zytor.com>
In-Reply-To: <4F5E431D.8010305@zytor.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

T24gMDMvMTMvMjAxMiAwMzo0MCBBTSwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cgo+IE9uIDAzLzEx
LzIwMTIgMTE6MTQgUE0sIEZlcm5hbmRvIEx1aXMgVsOhenF1ZXogQ2FvIHdyb3RlOgo+PiBUaGUg
dGhpbmcgaXMgdGhhdCB3ZSB3YW50IHRvIGF2b2lkIHBsYXlpbmcgd2l0aCBoYXJkd2FyZSBpbiB0
aGUga2R1bXAKPj4gcmVib290IHBhdGNoIHdoZW4gd2UgY2FuIGF2b2lkIGl0LCB0aGUgcHJlbWlz
ZSBiZWluZyB0aGF0IGl0IGNhbm5vdAo+PiBiZSBhY2Nlc3NlZCB3aXRob3V0IHJpc2tpbmcgYSBs
b2NrdXAgb3Igd29yc2UgKGFzIHRoZSBkZWFkbG9jayBhY2Nlc3NpbmcKPj4gdGhlIEkvTyBBUElD
IHNob3dlZCkuIFRoZSBrZXJuZWwgaXMgY3Jhc2hpbmcgYWZ0ZXIgYWxsLiBXaGF0IGlzIG1vcmUs
Cj4+IEkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCB0aGUgbG9uZyB0ZXJtIGdvYWwgaXMgdG8gbGVh
dmUgdGhlIExBUElDCj4+IHVudG91Y2hlZCB0b28gKHdlIHJlYWxseSB3YW50IHRvIGtlZXAgdGhl
IG51bWJlciBvZiB0aGluZ3Mgd2UgZG8gaW4gdGhlCj4+IGNvbnRleHQgb2YgdGhlIGNyYXNoaW5n
IGtlcm5lbCB0byB0aGUgYmFyZSBtaW5pbXVtKSwgc28gd2Ugd291bGQgc3RpbGwKPj4gbmVlZCB0
byBmaXggdGhlIGVhcmx5IElEVC4KPj4KPj4gTXkgcGF0Y2ggc2V0IGp1c3QgaW5zdGFsbHMgYSBz
cGVjaWFsIGhhbmRsZXIgZm9yIHRoZSBOTUkgY2FzZSBzbyBJIHRoaW5rCj4+IGl0IGlzIHByZXR0
eSBzaW1wbGUgYW5kIHNlbGYgY29udGFpbmVkLgo+Pgo+PiBBbm90aGVyIHJlYXNvbiB0byBhcHBs
eSB0aGVzZSBwYXRjaGVzIGlzIHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdAo+PiBvZiB0
aGUga2VybmVsLiBTcHVyaW91cyBOTUlzIHRoYXQgd291bGQgaGF2ZSBiZWVuIGlnbm9yZWQgYWZ0
ZXIgaW5zdGFsbGluZwo+PiB0aGUgZmluYWwgSURUIHdvdWxkIGNhdXNlIHRoZSBzeXN0ZW0gdG8g
aGFsdCBpZiB0aGV5IGhhcHBlbgo+PiB0byBhcnJpdmUgd2hpbGUgdGhlIGVhcmx5IElEVCBpcyBp
biBwbGFjZS4KPiBJJ20gY29uY2VybmVkIHRoYXQgeW91J3JlIGFkZGluZyBmYWlsdXJlIG1vZGVz
CgoKVGhpcyBwYXRjaCBzZXQganVzdCBicmluZ3MgdGhlIGVhcmx5IElEVCBpbiBsaW5lIHdpdGgg
d2hhdCB3ZSBkbyBhZnRlcgpzd2l0Y2hpbmcgdG8gdGhlIGZpbmFsIElEVCwgaS5lLiB3ZSBpZ25v
cmUgTk1Jcy4gVGhlIG9ubHkgZGlmZmVyZW5jZSBpcwp0aGF0IHdlIGRvIG5vdCBob25vciBwYW5p
YypubWkgYW5kIHVua25vd25fbm1pX3BhbmljLiBBcyB0aGluZ3MKc3RhbmQgbm93IHRoZSBrZXJu
ZWwgd2lsbCBzb21ldGltZXMgbXlzdGVyaW91c2x5IGhhbmcuIEkgcmVhbGx5CnRoaW5rIHRoYXQg
aW5kZXBlbmRlbnRseSBvZiB0aGUga2R1bXAgcHJvYmxlbSBpdCB3b3VsZCBiZSBuaWNlCnRvIGJl
IGNvbnNpc3RlbnQgaW4gdGhpcyByZWdhcmQuCgo+IGJlY2F1c2UgeW91IGRvbid0IHdhbnQgdG8K
PiBzb2x2ZSB0aGUgcmVhbCBwcm9ibGVtIHdoaWNoIGlzIHlvdSBuZWVkIHRvIGJsb2NrIHRoaXMg
YXQgdGhlIHNvdXJjZS4KCkluZGVlZCwgSSB3YW50IHRvIGRvIGJvdGguIFRyeSB0byBibG9jayBO
TUlzIGF0IHRoZSBzb3VyY2Ugd2hlbgpwb3NzaWJsZSBhbmQgaW5zdGFsbCBhbiBJRFQgdGhhdCBp
Z25vcmVzIE5NSXMgdG8gaGF2ZSBvdXIgYmFja3MKY292ZXJlZCAoYXZvaWQgdHJpcGxlIGZhdWx0
cyBhbmQgbG9ja3VwcykuIEFzIEVyaWMgbWVudGlvbmVkCml0IGlzIG5vdCBjbGVhciB0aGF0IHdl
IGNhbiBhbHdheXMgaWRlbnRpZnkgYW5kIHN0b3AgYWxsIHRoZSBzb3VyY2VzLgoKCj4gSXQgaXMg
d2F5IG1vcmUgdGhhbiB0aGUgSURUIHRoYXQgaGFzIHRvIHdvcmsgKGF0IHRoZSB2ZXJ5IGxlYXN0
LCB5b3UKPiBuZWVkIHRoZSBHRFQgYW5kIGEgd29ya2luZyBzdGFjaykgYXQgYWxsIHRpbWVzIGlu
IG9yZGVyIGZvciBOTUlzIHRvIGJlCj4gcmVjZWl2YWJsZS4KCk9mIGNvdXJzZSwgYW5kIHRoYXQg
aXMgd2hhdCB0aGUgZm9sbG93LXVwIHBhdGNoIHNldCBkb2VzLiBJdCBqdXN0IG5lZWRzCnNvbWUg
bW9yZSB0ZXN0aW5nLiBUaGUgcGF0Y2hlcyBJIHNlbnQgbWFrZSB1c2Ugb2YgdGhlIGVhcmx5IEdE
VCBhbmQKaXQgd29ya3MgYXMgZXhwZWN0ZWQuCgo+IFRoYXQgZG9lc24ndCBhZGRyZXNzIHdoYXQg
aGFwcGVucyBpZiB5b3UncmUgZ2V0dGluZyBhbiBOTUkKPiBzdG9ybSBlaXRoZXIuCgpXZWxsLCB0
aGUgc2FtZSBhcHBsaWVzIHRvIHRoZSBmaW5hbCBJRFQuIEFzIEkgbWVudGlvbmVkIGJlZm9yZQpJ
IHRoaW5rIHdlIHNob3VsZCBhbHNvIHRyeSB0byBzdG9wIHRoaW5ncyBhdCB0aGUgc291cmNlIHdo
ZW4KaXQgaXMgc2FmZSAob2YgY291cnNlLCBmaXJzdCB3ZSBuZWVkIHRvIGlkZW50aWZ5IGFsbCB0
aGUgc291cmNlcykuCgotIEZlcm5hbmRvCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
