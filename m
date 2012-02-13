Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RwvLs-0002cA-1B
 for kexec@lists.infradead.org; Mon, 13 Feb 2012 12:49:53 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [tip:x86/debug] x86/kdump: No need to disable ioapic/ lapic in
 crash path
References: <tip-d9bc9be89629445758670220787683e37c93f6c1@git.kernel.org>
 <CAE9FiQWRjvu_uNcx_bJXYHeg4D4k6YzHHmSudsq7EyubLi7+nw@mail.gmail.com>
 <m1ipjc3fsk.fsf@fess.ebiederm.org>
 <CAE9FiQVLnyRB+pAqi22C5mCbHOOVKxsBhQKaB6P0p9f2LBL8bA@mail.gmail.com>
Date: Mon, 13 Feb 2012 04:52:10 -0800
In-Reply-To: <CAE9FiQVLnyRB+pAqi22C5mCbHOOVKxsBhQKaB6P0p9f2LBL8bA@mail.gmail.com>
 (Yinghai Lu's message of "Sat, 11 Feb 2012 20:17:43 -0800")
Message-ID: <m1zkcmyjyd.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: dzickus@redhat.com, linux-tip-commits@vger.kernel.org, mingo@elte.hu, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, tglx@linutronix.de, vgoyal@redhat.com

WWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPiB3cml0ZXM6Cgo+IE9uIFNhdCwgRmViIDEx
LCAyMDEyIGF0IDc6MTMgUE0sIEVyaWMgVy4gQmllZGVybWFuCj4gPGViaWVkZXJtQHhtaXNzaW9u
LmNvbT4gd3JvdGU6Cj4+IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4gd3JpdGVzOgo+
Pj4gQWZ0ZXIgcmV2ZXJ0aW5nIHRoaXMgY29tbWl0LCBrZHVtcCBpcyB3b3JraW5nIGFnYWluLgo+
Pj4KPj4+IFNvIGFzc3VtZSB5b3UgbmVlZCB0byBkcm9wIHRoaXMgcGF0Y2guCj4+Cj4+IEl0IHNv
dW5kcyBsaWtlIHRoZXJlIGlzIGEgYnVnIGluIGlvYXBpYyBpbml0aWFsaXphdGlvbiBpbiB0aGUg
Y29udGV4dCBvZgo+PiBWVC1kLiDCoFdoZXJlIGRvIHlvdSBmYWlsPwo+Pgo+IGJlZm9yZSBnZXQg
ZGVidWcgcHJpbnQgb3V0IGZyb20gc2Vjb25kIGtlcm5lbCwgdGhlIHN5c3RlbSBnZXQgcmVzZXQu
CgpPdWNoLgoKRG9uIGNhbiB5b3Ugd29yayB3aXRoIHdpdGggWWluZ2hhaSB0byBmaWd1cmUgb3V0
IHdoYXQgaXMgZGlmZmVyZW50CmJldHdlZW4geW91ciB0ZXN0IGNvbmZpZ3VyYXRpb24gYW5kIGhp
cz8KCllIIGRpZCB5b3UgaGF2ZSBlYXJseSBwcmludGsgZW5hYmxlZD8KCllIIERpZCBJIHVuZGVy
c3RhbmQgeW91IHByb3Blcmx5IHRoYXQgdGhpbmdzIHdvcmsgaWYgeW91IGRvbid0IGVuYWJsZQpW
VC1kPyAgIEJ5IFZULWQgYXJlIHlvdSByZWZlcnJpbmcgdG8gaW50ZXJydXB0IHJlbWFwcGluZz8K
CkZvciBhbnlvbmUgd2F0Y2hpbmcuICBUaGUgcHJlbWlzZSBvZiB0aGlzIHBhdGNoIHdhcyB0aGF0
IHdlIGNhbiBib290CnRoZSBrZXJuZWwgd2l0aG91dCByZXNvcnRpbmcgdG8gbGVnYWN5IHRyaWNr
cyB0aGF0IHJlcXVpcmUgdXMgdG8KcHV0IHRoZSBpbnRlcnJ1cHQgY29udHJvbGxlcnMgaW4gUElU
IG1vZGUuCgpBcHBhcmVudGx5IHRoZXJlIGlzIHNvbWUgd2VpcmQgY29ybmVyIGNhc2UgdGhhdCBZ
SCBjYW4gcmVwcm9kdWNlIHRoYXQKRG9uIGRpZCBub3QgaGF2ZSBpbiBoaXMgdGVzdCBzZXQgdGhh
dCBZSCBkb2VzIHRoYXQgY2F1c2VzIHRoaW5ncyB0bwpmYWlsLgoKSSByZWFsbHkgZG9uJ3Qgc2Vl
IGFueSBsaWtlbHkgY2FuZGlkYXRlcyB3aGVuIGxvb2tpbmcgYXQgdGhlIGNvZGUuICBUaGUKbW9z
dCBJIGNhbiBzZWUgaXMgc29tZSBjb2RlIHRoYXQgd2UgZG9uJ3QgcnVuIHdoZW4gaW50ZXJydXB0
IHJlbWFwcGluZwppcyBlbmFibGVkIGluIGRpc2FibGVfSU9fQVBJQy4KClNvIEkgc3VzcGVjdCB3
ZSBoYXZlIGEgYnVnIGluIG91ciBhcGljIGluaXRpYWxpemF0aW9uIHNvbWV3aGVyZSwgYnV0CmFw
aWMgaW5pdGlhbGl6YXRpb24gc2hvdWxkIGhhcHBlbiBhZnRlciBwcmludGsgYXJlIGVuYWJsZWQu
ICBPciBhdCBsZWFzdAphZnRlciBlYXJseSBwcmludGtzIHNvIHRoZSByZXNldCBZSCBpcyByZXBv
cnRpbmcgZG9lc24ndCBtYWtlIG11Y2ggc2Vuc2UuCgpFcmljCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
