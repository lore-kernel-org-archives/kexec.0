Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S5gG1-0006CT-HX
 for kexec@lists.infradead.org; Thu, 08 Mar 2012 16:32:03 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
 <20120216172735.GX9751@redhat.com>
 <CAE9FiQVhbAM9vjx-uFcuc0ndsUp0aez9_TsQHStje5G5iwYbag@mail.gmail.com>
 <20120216215603.GH9751@redhat.com> <m1y5s2ku36.fsf@fess.ebiederm.org>
 <m1fwe9bpk2.fsf@fess.ebiederm.org> <20120217195430.GO9751@redhat.com>
 <m1y5s07rn3.fsf@fess.ebiederm.org> <20120220151419.GU9751@redhat.com>
 <m1obss39a4.fsf@fess.ebiederm.org> <20120221135934.GF26998@redhat.com>
 <m1ipip6xe8.fsf@fess.ebiederm.org> <4F573E1C.2060909@oss.ntt.co.jp>
 <4F573E74.5040504@oss.ntt.co.jp> <m1eht31z8e.fsf@fess.ebiederm.org>
 <4F58495B.5080308@oss.ntt.co.jp>
Date: Thu, 08 Mar 2012 08:35:12 -0800
In-Reply-To: <4F58495B.5080308@oss.ntt.co.jp> ("Fernando Luis =?utf-8?Q?V?=
 =?utf-8?Q?=C3=A1zquez?= Cao"'s
 message of "Thu, 08 Mar 2012 14:53:31 +0900")
Message-ID: <m1r4x3yrsv.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] boot: ignore early NMIs
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
To: Fernando Luis =?utf-8?Q?V=C3=A1zquez?= Cao <fernando@oss.ntt.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

RmVybmFuZG8gTHVpcyBWw6F6cXVleiBDYW8gPGZlcm5hbmRvQG9zcy5udHQuY28uanA+IHdyaXRl
czoKCj4+IElzIGp1c3QgYSBqdW1wIGFuZCBub3QgYSBtb3ZlIGZvbGxvd2VkIGJ5IGEganVtcCBz
dGlsbCAxMCBieXRlcz8KPj4gSSBoYXRlIHRvIHNheSBpdCBidXQgSSB0aGluayB0aGlzIGZhaWxz
IG1pc2VyYWJseSBmb3IgYW55IGV4Y2VwdGlvbgo+PiBhZnRlciBhIG5taS4KPgo+IFRoYW5rIHlv
dSBmb3IgdGhlIGhlYWRzIHVwISBBY3R1YWxseSwgaXQgd2FzIHdvcmtpbmcgZm9yIHRoZQo+IGV4
Y2VwdGlvbnMgYWZ0ZXIgdGhlIG5taSBidXQgd2l0aCBhIGNvcnJ1cHRlZCBlc2kgKHZlY3Rvcgo+
IG51bWJlcikuIE15IG9yaWdpbmFsIGludGVudGlvbiB3YXMgdG8gZmlsbCB0aGUgZW1wdHkgc3Bh
Y2UKPiB3aXRoIG5vcHMgYnV0IGZvcmdvdCB0byBhY3R1YWxseSBpbXBsZW1lbnQgaXQuLi4gU29y
cnkgYWJvdXQKPiB0aGF0LiBXaWxsIGZpeCBmb3IgdGhlIG5leHQgaXRlcmF0aW9uLgoKU291bmQg
Z29vZCwgYW5kIHRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRhY2tsaW5nIHRoaXMuCgo+PiBJIGV4
cGVjdCB0aGUgc2ltcGxlc3Qgc29sdXRpb24gaXMgdG8gbW9kaWZ5IGVhcmx5X2lkdF9oYW5kbGVy
IHRvIHRlc3QKPj4gZm9yIHZlY3RvciA9PSAyLgo+Cj4gVGhhdCBpcyBwcmVjaXNlbHkgd2hhdCBJ
IGRpZCBvbiBhIHByZXZpb3VzIHZlcnNpb24gYnV0IHRoYXQgd291bGQKPiBpbnZvbHZlIHVzaW5n
IHJlZ2lzdGVycyB3aGljaCBuZWVkIHRvIGJlIHNhdmVkIGFuZCByZXN0b3JlZCBhbmQKPiBJIHdh
bnRlZCB0byBhdm9pZCB1c2luZyB0aGUgc3RhY2sgaW4gdGhlIE5NSSBwYXRoLiBXZSB3b3VsZCBh
bHNvCj4gbmVlZCB0byBhZGQgYSAicHVzaHEgcnNpICIgaW4gZWFybHlfaWR0X2hhbmRsZXJzIHdo
aWNoIGltcGxpZXMKPiBtb2RpZnlpbmcgImVhcmx5X2lkdF9oYW5kbGVycyIgZGVmaW5pdGlvbiBp
biAic2VnbWVudC5oIi4KPgo+IElmIHlvdSBhcmUgT0sgd2l0aCBpdCBJIHdvdWxkIGxpa2UgdG8g
Z28gd2l0aCB0aGUgYXBwcm9hY2ggaW4KPiB0aGUgdHdvIHBhdGNoZXMgSSBzZW50LgoKSSBhbSBm
aW5lIHdpdGggeW91ciBhcHByb2FjaC4gIEkgc3VnZ2VzdCBhIGJpZyBmYXQgY29tbWVudCBtZW50
aW9uaW5nCnRoZSAxMCBieXRlIHJlcXVpcmVtZW50IGFuZCB0aGUgcmVnaXN0ZXIgcmVxdWlyZW1l
bnQuCgpOZWl0aGVyIG9uZSBpcyBsb2NhbGx5IG9idmlvdXMgd2hpY2ggbWFrZXMgaXQgZWFzeSB0
byBnb29mIHdoZW4KbW9kaWZ5aW5nIHRoZSBjb2RlLgoKPj4gRG9pbmcgc29tZXRoaW5nIGxlc3Mg
YnJpdHRsZSB0aGFuOgo+Pj4gZXh0ZXJuIGNvbnN0IGNoYXIgZWFybHlfaWR0X2hhbmRsZXJzW05V
TV9FWENFUFRJT05fVkVDVE9SU11bMTBdOwo+PiBpbiBzZWdtZW50LmggbWlnaHQgYmUgYSBnb29k
IGlkZWEgYXMgd2VsbC4KPgo+IFllcywgSSBhZ3JlZS4gSSB3aWxsIGdpdmUgaXQgc29tZSB0aG91
Z2h0LgoKRXJpYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
