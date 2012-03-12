Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S7AB6-0006f4-Vs
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 18:41:05 +0000
Message-ID: <4F5E431D.8010305@zytor.com>
Date: Mon, 12 Mar 2012 11:40:29 -0700
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
 <4F5D8E63.60606@zytor.com> <4F5D943C.5020403@oss.ntt.co.jp>
In-Reply-To: <4F5D943C.5020403@oss.ntt.co.jp>
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

T24gMDMvMTEvMjAxMiAxMToxNCBQTSwgRmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8gd3JvdGU6
Cj4gCj4gVGhlIHRoaW5nIGlzIHRoYXQgd2Ugd2FudCB0byBhdm9pZCBwbGF5aW5nIHdpdGggaGFy
ZHdhcmUgaW4gdGhlIGtkdW1wCj4gcmVib290IHBhdGNoIHdoZW4gd2UgY2FuIGF2b2lkIGl0LCB0
aGUgcHJlbWlzZSBiZWluZyB0aGF0IGl0IGNhbm5vdAo+IGJlIGFjY2Vzc2VkIHdpdGhvdXQgcmlz
a2luZyBhIGxvY2t1cCBvciB3b3JzZSAoYXMgdGhlIGRlYWRsb2NrIGFjY2Vzc2luZwo+IHRoZSBJ
L08gQVBJQyBzaG93ZWQpLiBUaGUga2VybmVsIGlzIGNyYXNoaW5nIGFmdGVyIGFsbC4gV2hhdCBp
cyBtb3JlLAo+IEkgZm9yZ290IHRvIG1lbnRpb24gdGhhdCB0aGUgbG9uZyB0ZXJtIGdvYWwgaXMg
dG8gbGVhdmUgdGhlIExBUElDCj4gdW50b3VjaGVkIHRvbyAod2UgcmVhbGx5IHdhbnQgdG8ga2Vl
cCB0aGUgbnVtYmVyIG9mIHRoaW5ncyB3ZSBkbyBpbiB0aGUKPiBjb250ZXh0IG9mIHRoZSBjcmFz
aGluZyBrZXJuZWwgdG8gdGhlIGJhcmUgbWluaW11bSksIHNvIHdlIHdvdWxkIHN0aWxsCj4gbmVl
ZCB0byBmaXggdGhlIGVhcmx5IElEVC4KPiAKPiBNeSBwYXRjaCBzZXQganVzdCBpbnN0YWxscyBh
IHNwZWNpYWwgaGFuZGxlciBmb3IgdGhlIE5NSSBjYXNlIHNvIEkgdGhpbmsKPiBpdCBpcyBwcmV0
dHkgc2ltcGxlIGFuZCBzZWxmIGNvbnRhaW5lZC4KPiAKPiBBbm90aGVyIHJlYXNvbiB0byBhcHBs
eSB0aGVzZSBwYXRjaGVzIGlzIHRvIGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdAo+IG9mIHRo
ZSBrZXJuZWwuIFNwdXJpb3VzIE5NSXMgdGhhdCB3b3VsZCBoYXZlIGJlZW4gaWdub3JlZCBhZnRl
ciBpbnN0YWxsaW5nCj4gdGhlIGZpbmFsIElEVCB3b3VsZCBjYXVzZSB0aGUgc3lzdGVtIHRvIGhh
bHQgaWYgdGhleSBoYXBwZW4KPiB0byBhcnJpdmUgd2hpbGUgdGhlIGVhcmx5IElEVCBpcyBpbiBw
bGFjZS4KPiAKCkknbSBjb25jZXJuZWQgdGhhdCB5b3UncmUgYWRkaW5nIGZhaWx1cmUgbW9kZXMg
YmVjYXVzZSB5b3UgZG9uJ3Qgd2FudCB0bwpzb2x2ZSB0aGUgcmVhbCBwcm9ibGVtIHdoaWNoIGlz
IHlvdSBuZWVkIHRvIGJsb2NrIHRoaXMgYXQgdGhlIHNvdXJjZS4KSXQgaXMgd2F5IG1vcmUgdGhh
biB0aGUgSURUIHRoYXQgaGFzIHRvIHdvcmsgKGF0IHRoZSB2ZXJ5IGxlYXN0LCB5b3UKbmVlZCB0
aGUgR0RUIGFuZCBhIHdvcmtpbmcgc3RhY2spIGF0IGFsbCB0aW1lcyBpbiBvcmRlciBmb3IgTk1J
cyB0byBiZQpyZWNlaXZhYmxlLiAgVGhhdCBkb2Vzbid0IGFkZHJlc3Mgd2hhdCBoYXBwZW5zIGlm
IHlvdSdyZSBnZXR0aW5nIGFuIE5NSQpzdG9ybSBlaXRoZXIuCgoJLWhwYQoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QK
a2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2tleGVjCg==
