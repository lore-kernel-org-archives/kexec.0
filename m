Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1S7BNm-0002ul-Ls
 for kexec@lists.infradead.org; Mon, 12 Mar 2012 19:58:15 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAE9FiQVPnO8-tuPoio0Wxv=8rjdm2tJbBk3+3ystueyYtZn9BA@mail.gmail.com>
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
Date: Mon, 12 Mar 2012 13:01:12 -0700
In-Reply-To: <4F5E431D.8010305@zytor.com> (H. Peter Anvin's message of "Mon,
 12 Mar 2012 11:40:29 -0700")
Message-ID: <m1zkblmvw7.fsf@fess.ebiederm.org>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Don Zickus <dzickus@redhat.com>, akpm@linux-foundation.org, linux-tip-commits@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Fernando Luis =?utf-8?Q?V=C3=A1zquez?= Cao <fernando@oss.ntt.co.jp>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, torvalds@linux-foundation.org, mingo@elte.hu, vgoyal@redhat.com

IkguIFBldGVyIEFudmluIiA8aHBhQHp5dG9yLmNvbT4gd3JpdGVzOgoKPiBPbiAwMy8xMS8yMDEy
IDExOjE0IFBNLCBGZXJuYW5kbyBMdWlzIFbDoXpxdWV6IENhbyB3cm90ZToKPj4gCj4+IFRoZSB0
aGluZyBpcyB0aGF0IHdlIHdhbnQgdG8gYXZvaWQgcGxheWluZyB3aXRoIGhhcmR3YXJlIGluIHRo
ZSBrZHVtcAo+PiByZWJvb3QgcGF0Y2ggd2hlbiB3ZSBjYW4gYXZvaWQgaXQsIHRoZSBwcmVtaXNl
IGJlaW5nIHRoYXQgaXQgY2Fubm90Cj4+IGJlIGFjY2Vzc2VkIHdpdGhvdXQgcmlza2luZyBhIGxv
Y2t1cCBvciB3b3JzZSAoYXMgdGhlIGRlYWRsb2NrIGFjY2Vzc2luZwo+PiB0aGUgSS9PIEFQSUMg
c2hvd2VkKS4gVGhlIGtlcm5lbCBpcyBjcmFzaGluZyBhZnRlciBhbGwuIFdoYXQgaXMgbW9yZSwK
Pj4gSSBmb3Jnb3QgdG8gbWVudGlvbiB0aGF0IHRoZSBsb25nIHRlcm0gZ29hbCBpcyB0byBsZWF2
ZSB0aGUgTEFQSUMKPj4gdW50b3VjaGVkIHRvbyAod2UgcmVhbGx5IHdhbnQgdG8ga2VlcCB0aGUg
bnVtYmVyIG9mIHRoaW5ncyB3ZSBkbyBpbiB0aGUKPj4gY29udGV4dCBvZiB0aGUgY3Jhc2hpbmcg
a2VybmVsIHRvIHRoZSBiYXJlIG1pbmltdW0pLCBzbyB3ZSB3b3VsZCBzdGlsbAo+PiBuZWVkIHRv
IGZpeCB0aGUgZWFybHkgSURULgo+PiAKPj4gTXkgcGF0Y2ggc2V0IGp1c3QgaW5zdGFsbHMgYSBz
cGVjaWFsIGhhbmRsZXIgZm9yIHRoZSBOTUkgY2FzZSBzbyBJIHRoaW5rCj4+IGl0IGlzIHByZXR0
eSBzaW1wbGUgYW5kIHNlbGYgY29udGFpbmVkLgo+PiAKPj4gQW5vdGhlciByZWFzb24gdG8gYXBw
bHkgdGhlc2UgcGF0Y2hlcyBpcyB0byBiZSBjb25zaXN0ZW50IHdpdGggdGhlIHJlc3QKPj4gb2Yg
dGhlIGtlcm5lbC4gU3B1cmlvdXMgTk1JcyB0aGF0IHdvdWxkIGhhdmUgYmVlbiBpZ25vcmVkIGFm
dGVyIGluc3RhbGxpbmcKPj4gdGhlIGZpbmFsIElEVCB3b3VsZCBjYXVzZSB0aGUgc3lzdGVtIHRv
IGhhbHQgaWYgdGhleSBoYXBwZW4KPj4gdG8gYXJyaXZlIHdoaWxlIHRoZSBlYXJseSBJRFQgaXMg
aW4gcGxhY2UuCj4+IAo+Cj4gSSdtIGNvbmNlcm5lZCB0aGF0IHlvdSdyZSBhZGRpbmcgZmFpbHVy
ZSBtb2RlcyBiZWNhdXNlIHlvdSBkb24ndCB3YW50IHRvCj4gc29sdmUgdGhlIHJlYWwgcHJvYmxl
bSB3aGljaCBpcyB5b3UgbmVlZCB0byBibG9jayB0aGlzIGF0IHRoZSBzb3VyY2UuCj4gSXQgaXMg
d2F5IG1vcmUgdGhhbiB0aGUgSURUIHRoYXQgaGFzIHRvIHdvcmsgKGF0IHRoZSB2ZXJ5IGxlYXN0
LCB5b3UKPiBuZWVkIHRoZSBHRFQgYW5kIGEgd29ya2luZyBzdGFjaykgYXQgYWxsIHRpbWVzIGlu
IG9yZGVyIGZvciBOTUlzIHRvIGJlCj4gcmVjZWl2YWJsZS4gIFRoYXQgZG9lc24ndCBhZGRyZXNz
IHdoYXQgaGFwcGVucyBpZiB5b3UncmUgZ2V0dGluZyBhbiBOTUkKPiBzdG9ybSBlaXRoZXIuCgpH
b29kIGNyaXRpY2lzbS4KClRoZSBiYXNpYyBwcm9ibGVtIGlzIHdoYXQgZG8gd2UgZG8gd2hlbiB3
ZSByZWNlaXZlIE5NSXMgZHVyaW5nIHRoZQprZXJuZWwgYm9vdC4gIER5aW5nIG15c3RlcmlvdXNs
eSBjZXJ0YWlubHkgaXNuJ3QgYSBnb29kIHNvbHV0aW9uLgoKSW4gdGhlIGtleGVjIG9uIHBhbmlj
IGNvZGUgcGF0aCB3ZSBhbHJlYWR5IGhhdmUgYSBzdGFjayBhbmQgYXMgbG9uZwphcyB3ZSBjYW4g
Zml0IHRoZSBHRFQgYW5kIHRoZSBMRFQgb24gdGhhdCBzYW1lIHBhZ2Ugd2UgY2FuIGhhdmUgYWxs
IG9mCnRoZSByZXN0IGR1cmluZyB0aGUgZW50aXJlIHRyYW5zaXRpb24uCgpBZnRlciB0aGF0IGlz
IGJhc2ljYWxseSB0aGUga2VybmVsJ3MgYm9vdCBjb2RlLgoKVGhlIGJhc2ljIHByb2JsZW0gaXMg
d2hpY2ggc291cmNlIGRvIHdlIGJsb2NrIHRoaXMgYXQ/ICBIb3cgbWFueQpzb3VyY2VzIGFyZSB0
aGVpcj8gIEFuZCBhcmNoaXRlY3R1cmFsbHkgbGFzdCBJIGxvb2tlZCB4ODYgbm8gbG9uZ2VyCmhh
cyBhIE5NSSBkaXNhYmxlIEVGSSBhbmQgc2ltaWxhciBzeXN0ZW1zIHdhbnQgdG8gZ2V0IGF3YXkg
d2l0aG91dAphIENNT1MgbGVnYWN5IGNsb2NrIGJlY2F1c2UgZGVzaWduZXJzIHNvIG9mdGVuIGdl
dCB0aGVtIHdyb25nLgoKRXJpYwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
