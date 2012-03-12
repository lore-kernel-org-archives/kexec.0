Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from serv2.oss.ntt.co.jp ([222.151.198.100])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S6yX0-0001Xf-TT
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 06:14:56 +0000
Message-ID: <4F5D943C.5020403@oss.ntt.co.jp>
Date: Mon, 12 Mar 2012 15:14:20 +0900
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
 <4F5D8E63.60606@zytor.com>
In-Reply-To: <4F5D8E63.60606@zytor.com>
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

T24gMDMvMTIvMjAxMiAwMjo0OSBQTSwgSC4gUGV0ZXIgQW52aW4gd3JvdGU6Cgo+IE9uIDAzLzEx
LzIwMTIgMTA6NDMgUE0sIEZlcm5hbmRvIEx1aXMgVsOhenF1ZXogQ2FvIHdyb3RlOgo+PiBUbyB0
YWNrbGUgdGhpcyBpc3N1ZSB3ZSBjYW4gZWl0aGVyIHN0b3AgdGhlIGhhcmRsb2NrdXAgZGV0ZWN0
b3IKPj4gb3IgZGlzYWJsZSB0aGUgTEFQSUMgKHRoZSBOTUlzIG5lZWRlZCBieSB4ODYncyBoYXJk
bG9ja3VwIGRldGVjdG9yCj4+IGFyZSBnZW5lcmF0ZWQgdXNpbmcgcGVyZm9ybWFuY2UgY291bnRl
cnMgaW4gdGhlIExBUElDKSwgbGVhdmluZwo+PiB0aGUgSS9PIEFQSUNzIHVudG91Y2hlZC4gVGhl
IHNlY29uZCBpcyBzaW1wbGVyIGFuZCBJIHRoaW5rIGl0Cj4+IGlzIHRoZSBhcHByb2FjaCBEb24g
dG9vayB0byBmaXggdGhpcyBpc3N1ZSBpbiBSSEVMIGtlcm5lbHMuCj4+Cj4+IFVuZm9ydHVuYXRl
bHksIHRoaXMgaXMgbm90IGVub3VnaCwgd2UgYXJlIHN0aWxsIGV4cG9zZWQgdG8gZXh0ZXJuYWwK
Pj4gTk1JcyBub3Qgcm91dGVkIHRocm91Z2ggdGhlIExBUElDLiBJbiBvdGhlciB3b3Jkcywgd2Ug
aGF2ZSB0byBtYWtlCj4+IHN1cmUgdGhhdCB3ZSBhbHdheXMgaGF2ZSBhbmQgSURUIHRoYXQgaXMg
YWJsZSB0byBoYW5kbGUgTk1JcyB3aXRob3V0Cj4+IHNlZW1pbmdseSByYW5kb20gcmVib290cyBh
bmQgbG9ja3Vwcy4gVG8gYWNoaWV2ZSB0aGlzIGdvYWwgd2UgbmVlZAo+PiB0byBmaXggbWFjaGlu
ZV9rZXhlYygpIGFuZCB0aGUgZWFybHkgSURUIGhhbmRsZXJzLiBUaGUgY3VycmVudCBwYXRjaAo+
PiBzZXQgdGFrZXMgY2FyZSBvZiB0aGUgbGF0dGVyLgo+IFRoZSBvbmx5IHNvdXJjZSBvZiBOTUlz
IG90aGVyIHRoYW4gdGhlIExBUElDIHNob3VsZCBiZSB0aGUgc3lzdGVtIGVycm9yCj4gd2hpY2gg
Y2FuIGJlIGRpc2FibGVkIHRocm91Z2ggdGhlIFJUQyBwb3J0LCBzbyBJIHRoaW5rIHlvdXIgc2Vj
b25kCj4gcGFyYWdyYXBoIGhlcmUgaXMgd2F5IG1vcmUgbWVjaGFuaXNtIHRoYW4geW91IG5lZWQg
Zm9yIHZlcnkgbGl0dGxlIGdhaW4uCgpUaGUgdGhpbmcgaXMgdGhhdCB3ZSB3YW50IHRvIGF2b2lk
IHBsYXlpbmcgd2l0aCBoYXJkd2FyZSBpbiB0aGUga2R1bXAKcmVib290IHBhdGNoIHdoZW4gd2Ug
Y2FuIGF2b2lkIGl0LCB0aGUgcHJlbWlzZSBiZWluZyB0aGF0IGl0IGNhbm5vdApiZSBhY2Nlc3Nl
ZCB3aXRob3V0IHJpc2tpbmcgYSBsb2NrdXAgb3Igd29yc2UgKGFzIHRoZSBkZWFkbG9jayBhY2Nl
c3NpbmcKdGhlIEkvTyBBUElDIHNob3dlZCkuIFRoZSBrZXJuZWwgaXMgY3Jhc2hpbmcgYWZ0ZXIg
YWxsLiBXaGF0IGlzIG1vcmUsCkkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCB0aGUgbG9uZyB0ZXJt
IGdvYWwgaXMgdG8gbGVhdmUgdGhlIExBUElDCnVudG91Y2hlZCB0b28gKHdlIHJlYWxseSB3YW50
IHRvIGtlZXAgdGhlIG51bWJlciBvZiB0aGluZ3Mgd2UgZG8gaW4gdGhlCmNvbnRleHQgb2YgdGhl
IGNyYXNoaW5nIGtlcm5lbCB0byB0aGUgYmFyZSBtaW5pbXVtKSwgc28gd2Ugd291bGQgc3RpbGwK
bmVlZCB0byBmaXggdGhlIGVhcmx5IElEVC4KCk15IHBhdGNoIHNldCBqdXN0IGluc3RhbGxzIGEg
c3BlY2lhbCBoYW5kbGVyIGZvciB0aGUgTk1JIGNhc2Ugc28gSSB0aGluawppdCBpcyBwcmV0dHkg
c2ltcGxlIGFuZCBzZWxmIGNvbnRhaW5lZC4KCkFub3RoZXIgcmVhc29uIHRvIGFwcGx5IHRoZXNl
IHBhdGNoZXMgaXMgdG8gYmUgY29uc2lzdGVudCB3aXRoIHRoZSByZXN0Cm9mIHRoZSBrZXJuZWwu
IFNwdXJpb3VzIE5NSXMgdGhhdCB3b3VsZCBoYXZlIGJlZW4gaWdub3JlZCBhZnRlciBpbnN0YWxs
aW5nCnRoZSBmaW5hbCBJRFQgd291bGQgY2F1c2UgdGhlIHN5c3RlbSB0byBoYWx0IGlmIHRoZXkg
aGFwcGVuCnRvIGFycml2ZSB3aGlsZSB0aGUgZWFybHkgSURUIGlzIGluIHBsYWNlLgoKLSBGZXJu
YW5kbwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtl
eGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
