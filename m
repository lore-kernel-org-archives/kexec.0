Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S6y95-00019q-GW
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 05:50:13 +0000
Message-ID: <4F5D8E63.60606@zytor.com>
Date: Sun, 11 Mar 2012 22:49:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
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
In-Reply-To: <4F5D8D0E.8060702@oss.ntt.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: =?UTF-8?B?RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8=?= <fernando@oss.ntt.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

T24gMDMvMTEvMjAxMiAxMDo0MyBQTSwgRmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8gd3JvdGU6
Cgo+IAo+IFRvIHRhY2tsZSB0aGlzIGlzc3VlIHdlIGNhbiBlaXRoZXIgc3RvcCB0aGUgaGFyZGxv
Y2t1cCBkZXRlY3Rvcgo+IG9yIGRpc2FibGUgdGhlIExBUElDICh0aGUgTk1JcyBuZWVkZWQgYnkg
eDg2J3MgaGFyZGxvY2t1cCBkZXRlY3Rvcgo+IGFyZSBnZW5lcmF0ZWQgdXNpbmcgcGVyZm9ybWFu
Y2UgY291bnRlcnMgaW4gdGhlIExBUElDKSwgbGVhdmluZwo+IHRoZSBJL08gQVBJQ3MgdW50b3Vj
aGVkLiBUaGUgc2Vjb25kIGlzIHNpbXBsZXIgYW5kIEkgdGhpbmsgaXQKPiBpcyB0aGUgYXBwcm9h
Y2ggRG9uIHRvb2sgdG8gZml4IHRoaXMgaXNzdWUgaW4gUkhFTCBrZXJuZWxzLgo+IAo+IFVuZm9y
dHVuYXRlbHksIHRoaXMgaXMgbm90IGVub3VnaCwgd2UgYXJlIHN0aWxsIGV4cG9zZWQgdG8gZXh0
ZXJuYWwKPiBOTUlzIG5vdCByb3V0ZWQgdGhyb3VnaCB0aGUgTEFQSUMuIEluIG90aGVyIHdvcmRz
LCB3ZSBoYXZlIHRvIG1ha2UKPiBzdXJlIHRoYXQgd2UgYWx3YXlzIGhhdmUgYW5kIElEVCB0aGF0
IGlzIGFibGUgdG8gaGFuZGxlIE5NSXMgd2l0aG91dAo+IHNlZW1pbmdseSByYW5kb20gcmVib290
cyBhbmQgbG9ja3Vwcy4gVG8gYWNoaWV2ZSB0aGlzIGdvYWwgd2UgbmVlZAo+IHRvIGZpeCBtYWNo
aW5lX2tleGVjKCkgYW5kIHRoZSBlYXJseSBJRFQgaGFuZGxlcnMuIFRoZSBjdXJyZW50IHBhdGNo
Cj4gc2V0IHRha2VzIGNhcmUgb2YgdGhlIGxhdHRlci4KPiAKClRoZSBvbmx5IHNvdXJjZSBvZiBO
TUlzIG90aGVyIHRoYW4gdGhlIExBUElDIHNob3VsZCBiZSB0aGUgc3lzdGVtIGVycm9yCndoaWNo
IGNhbiBiZSBkaXNhYmxlZCB0aHJvdWdoIHRoZSBSVEMgcG9ydCwgc28gSSB0aGluayB5b3VyIHNl
Y29uZApwYXJhZ3JhcGggaGVyZSBpcyB3YXkgbW9yZSBtZWNoYW5pc20gdGhhbiB5b3UgbmVlZCBm
b3IgdmVyeSBsaXR0bGUgZ2Fpbi4KCgktaHBhCgotLSAKSC4gUGV0ZXIgQW52aW4sIEludGVsIE9w
ZW4gU291cmNlIFRlY2hub2xvZ3kgQ2VudGVyCkkgd29yayBmb3IgSW50ZWwuICBJIGRvbid0IHNw
ZWFrIG9uIHRoZWlyIGJlaGFsZi4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
