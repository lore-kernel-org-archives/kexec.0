Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWq4Q-0002HD-J4
 for kexec@lists.infradead.org; Thu, 07 May 2020 23:36:52 +0000
Date: Thu, 7 May 2020 19:36:34 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] kernel: add panic_on_taint
Message-ID: <20200507233634.GA367616@optiplex-lnx>
References: <20200507221503.GL205881@optiplex-lnx>
 <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
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
To: Qian Cai <cai@lca.pw>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com

T24gVGh1LCBNYXkgMDcsIDIwMjAgYXQgMDc6MDc6MjBQTSAtMDQwMCwgUWlhbiBDYWkgd3JvdGU6
Cj4gCj4gCj4gPiBPbiBNYXkgNywgMjAyMCwgYXQgNjoxNSBQTSwgUmFmYWVsIEFxdWluaSA8YXF1
aW5pQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gCj4gPiBJdCdzIGEgcmVhc29uYWJsZSBhbmQgc2Vs
Zi1jb250YWluZWQgZmVhdHVyZSB0aGF0IHdlIGhhdmUgYSB2YWxpZCB1c2UgZm9yLiAKPiA+IEkg
aG9uZXN0bHkgZmFpbCB0byBzZWUgaXQgY2F1c2luZyB0aGF0IGFtb3VudCBvZiBhbm5veWFuY2Ug
YXMgeW91IGFyZSAKPiA+IHN1Z2dlc3RpbmcgaGVyZS4KPiAKPiBJdCBpcyBub3QgYSBiaWcgdHJv
dWJsZSB5ZXQsIGJ1dCBrZWVwaW5nIGFuIG9ic29sZXRlIHBhdGNoIHRoYXQgbm90IHZlcnkgc3Ry
YWlnaHRmb3J3YXJkIHRvIGZpZ3VyZSBvdXQgdGhhdCBpdCB3aWxsIGJlIHN1cGVyc2VkZWQgYnkg
dGhlIHBhbmljX29uX3RhaW50IHBhdGNoIHdpbGwgb25seSBjYXVzZSBtb3JlIGNvbmZ1c2lvbiB0
aGUgbG9uZ2VyIGl0IGhhcyBzdGF5ZWQgaW4gbGludXgtbmV4dC4KPiAKPiBUaGUgdGhpbmcgaXMg
dGhhdCBldmVuIGlmIHlvdSBjYW7igJl0IGdldCB0aGlzIHBhbmljX29uX3RhaW50ICh0aGUgc3Vw
ZXJpb3Igc29sdXRpb24pIHBhdGNoIGFjY2VwdGVkIGZvciBzb21lIHJlYXNvbnMsIHNvbWVvbmUg
ZWxzZSBjb3VsZCBzdGlsbCB3b3JrIG9uIGl0IHVudGlsIGl0IGdldCBtZXJnZWQuCj4gCj4gVGh1
cywgSSBmYWlsZWQgdG8gc2VlIGFueSBwb3NzaWJpbGl0eSB3ZSB3aWxsIGdvIGJhY2sgdG8gdGhl
IGluZmVyaW9yIHNvbHV0aW9uIChtbS1zbHViLWFkZC1wYW5pY19vbl9lcnJvci10by10aGUtZGVi
dWctZmFjaWxpdGllcy5wYXRjaCkgYnkgYWxsIG1lYW5zLgo+CgpUaGVyZSBhcmUgcGxlbnR5IG9m
IGV4YW1wbGVzIG9mIHRoaW5ncyBiZWluZyBhZGRlZCwgY2hhbmdlZCwgYW5kCnJlbW92ZWQgaW4g
LW5leHQuIElPVywgbGl2aW5nIGluIGEgdHJhbnNpZW50IHN0YXRlLiBJIHRoaW5rIGl0J3MgCmEg
cmVhc29uYWJsZSBjb21wcm9taXNlIHRvIGtlZXAgaXQgd2hpbGUgdGhlIG90aGVyIG9uZSBpcyBi
ZWluZCAKaXJvbmVkIG91dC4KClRoZSBmYWN0IHRoYXQgeW91IHByZWZlciBvbmUgc29sdXRpb24g
dG8gYW5vdGhlciBkb2Vzbid0CmludmFsaWRhdGUgdGhlIG9uZSB5b3UgZGlzbGlrZS4gCgpDaGVl
cnMsCi0tIFJhZmFlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
