Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWqsg-0000WH-6T
 for kexec@lists.infradead.org; Fri, 08 May 2020 00:28:47 +0000
Received: by mail-qk1-x742.google.com with SMTP id c64so8253298qkf.12
 for <kexec@lists.infradead.org>; Thu, 07 May 2020 17:28:43 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] kernel: add panic_on_taint
From: Qian Cai <cai@lca.pw>
In-Reply-To: <20200507233634.GA367616@optiplex-lnx>
Date: Thu, 7 May 2020 20:28:40 -0400
Message-Id: <438575BA-00CA-44BF-8C4C-693DCC00FDD1@lca.pw>
References: <20200507221503.GL205881@optiplex-lnx>
 <6B423101-ACF4-49A3-AD53-ACBF87F1ABE0@lca.pw>
 <20200507233634.GA367616@optiplex-lnx>
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
To: Rafael Aquini <aquini@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com

Cgo+IE9uIE1heSA3LCAyMDIwLCBhdCA3OjM2IFBNLCBSYWZhZWwgQXF1aW5pIDxhcXVpbmlAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4gCj4gT24gVGh1LCBNYXkgMDcsIDIwMjAgYXQgMDc6MDc6MjBQTSAt
MDQwMCwgUWlhbiBDYWkgd3JvdGU6Cj4+IAo+PiAKPj4+IE9uIE1heSA3LCAyMDIwLCBhdCA2OjE1
IFBNLCBSYWZhZWwgQXF1aW5pIDxhcXVpbmlAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+PiAKPj4+IEl0
J3MgYSByZWFzb25hYmxlIGFuZCBzZWxmLWNvbnRhaW5lZCBmZWF0dXJlIHRoYXQgd2UgaGF2ZSBh
IHZhbGlkIHVzZSBmb3IuIAo+Pj4gSSBob25lc3RseSBmYWlsIHRvIHNlZSBpdCBjYXVzaW5nIHRo
YXQgYW1vdW50IG9mIGFubm95YW5jZSBhcyB5b3UgYXJlIAo+Pj4gc3VnZ2VzdGluZyBoZXJlLgo+
PiAKPj4gSXQgaXMgbm90IGEgYmlnIHRyb3VibGUgeWV0LCBidXQga2VlcGluZyBhbiBvYnNvbGV0
ZSBwYXRjaCB0aGF0IG5vdCB2ZXJ5IHN0cmFpZ2h0Zm9yd2FyZCB0byBmaWd1cmUgb3V0IHRoYXQg
aXQgd2lsbCBiZSBzdXBlcnNlZGVkIGJ5IHRoZSBwYW5pY19vbl90YWludCBwYXRjaCB3aWxsIG9u
bHkgY2F1c2UgbW9yZSBjb25mdXNpb24gdGhlIGxvbmdlciBpdCBoYXMgc3RheWVkIGluIGxpbnV4
LW5leHQuCj4+IAo+PiBUaGUgdGhpbmcgaXMgdGhhdCBldmVuIGlmIHlvdSBjYW7igJl0IGdldCB0
aGlzIHBhbmljX29uX3RhaW50ICh0aGUgc3VwZXJpb3Igc29sdXRpb24pIHBhdGNoIGFjY2VwdGVk
IGZvciBzb21lIHJlYXNvbnMsIHNvbWVvbmUgZWxzZSBjb3VsZCBzdGlsbCB3b3JrIG9uIGl0IHVu
dGlsIGl0IGdldCBtZXJnZWQuCj4+IAo+PiBUaHVzLCBJIGZhaWxlZCB0byBzZWUgYW55IHBvc3Np
YmlsaXR5IHdlIHdpbGwgZ28gYmFjayB0byB0aGUgaW5mZXJpb3Igc29sdXRpb24gKG1tLXNsdWIt
YWRkLXBhbmljX29uX2Vycm9yLXRvLXRoZS1kZWJ1Zy1mYWNpbGl0aWVzLnBhdGNoKSBieSBhbGwg
bWVhbnMuCj4+IAo+IAo+IFRoZXJlIGFyZSBwbGVudHkgb2YgZXhhbXBsZXMgb2YgdGhpbmdzIGJl
aW5nIGFkZGVkLCBjaGFuZ2VkLCBhbmQKPiByZW1vdmVkIGluIC1uZXh0LiBJT1csIGxpdmluZyBp
biBhIHRyYW5zaWVudCBzdGF0ZS4gSSB0aGluayBpdCdzIAo+IGEgcmVhc29uYWJsZSBjb21wcm9t
aXNlIHRvIGtlZXAgaXQgd2hpbGUgdGhlIG90aGVyIG9uZSBpcyBiZWluZCAKPiBpcm9uZWQgb3V0
Lgo+IAo+IFRoZSBmYWN0IHRoYXQgeW91IHByZWZlciBvbmUgc29sdXRpb24gdG8gYW5vdGhlciBk
b2Vzbid0Cj4gaW52YWxpZGF0ZSB0aGUgb25lIHlvdSBkaXNsaWtlLiAKCkFzIGZhciBJIGNhbiB0
ZWxsLCB0aGUgYmFyIG9mIHRoZSBvdGhlciBjb3JlIHN1YnN5c3RlbXMgYXJlIHF1aXRlIGhpZ2gg
ZXZlbiBmb3IgbGludXgtbmV4dC4gUGVvcGxlIGhhdmUgYmVlbiB2b2ljZWQgb3ZlciBhbmQgb3Zl
ciBhZ2FpbiB0byB1cmdlIEFuZHJldyBub3QgcGlja2luZyB1cCBwYXRjaGVzIHNvIGVhZ2VybHks
IGJ1dCBJIHdpbGwgc2F2ZSB0aGF0IGRpc2N1c3Npb24gZm9yIHRoZSBuZXh0IHRpbWUuCgpBbnl3
YXksIHRoYW5rcyBmb3Igd29ya2luZyBmb3IgdGhlIHBhbmljX29uX3RhaW50IHBhdGNoLiBJIGJl
bGlldmUgaXQgY291bGQgYmUgdXNlZnVsIGZvciBhbGwgdGVzdGluZyBhZ2VudHMgdG8gY2F0Y2gg
dGhvc2UgYmFkIHBhZ2VzIGVhcmxpZXIuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
