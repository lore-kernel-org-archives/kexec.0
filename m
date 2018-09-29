Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15] helo=mx1.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g6AeX-0006Xn-QS
 for kexec@lists.infradead.org; Sat, 29 Sep 2018 08:31:26 +0000
Date: Sat, 29 Sep 2018 10:30:52 +0200
From: Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v7 RESEND 4/4] kdump/vmcore: support encrypted old memory
 with SME enabled
Message-ID: <20180929083052.GA13786@zn.tnic>
References: <20180927071954.29615-1-lijiang@redhat.com>
 <20180927071954.29615-5-lijiang@redhat.com>
 <20180928083852.GA21895@zn.tnic>
 <1c27b9a9-ae93-011a-b003-a50ecc22ccc5@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c27b9a9-ae93-011a-b003-a50ecc22ccc5@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: thomas.lendacky@amd.com, jroedel@suse.de, brijesh.singh@amd.com, bhe@redhat.com, tiwai@suse.de, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, baiyaowei@cmss.chinamobile.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org, dan.j.williams@intel.com

T24gU2F0LCBTZXAgMjksIDIwMTggYXQgMDI6MjQ6NTJQTSArMDgwMCwgbGlqaWFuZyB3cm90ZToK
PiBBdCBmaXJzdCwgaSBhZGRlZCBhbiBpbnB1dCBwYXJhbWV0ZXIgZm9yIHJlYWRfZnJvbV9vbGRt
ZW0oKSBiZWNhdXNlIG9mIGVuY3J5cHRpb24oU01FKS4gQnV0Cj4gZm9yIGF2b2lkaW5nIHRvIGFs
c28gYWRkIHRoZSBzYW1lIHBhcmFtZXRlciBmb3IgY29weV9vbGRtZW1fcGFnZSgpLCBzbyBpIGFk
ZGVkIGEgbmV3IGZ1bmN0aW9uCj4gY29weV9vbGRtZW1fcGFnZV9lbmNyeXB0ZWQoKS4gTWF5YmUg
eW91IGhhZCBub3RpY2VkIHRoYXQgdGhlc2UgZnVuY3Rpb25zIHdlcmUgdmVyeSBzaW1pbGFyLgoK
SWYgeW91IGhhdmUgdHdvIHZlcnkgc2ltaWxhciBmdW5jdGlvbnMsIHlvdSBhZGQgYSAqc3RhdGlj
KiB3b3JraG9yc2UgZnVuY3Rpb246CgpzdGF0aWMgc3NpemVfdCBfX2NvcHlfb2xkbWVtX3BhZ2Uo
dW5zaWduZWQgbG9uZyBwZm4sIGNoYXIgKmJ1Ziwgc2l6ZV90IGNzaXplLCB1bnNpZ25lZCBsb25n
IG9mZnNldCwKCQkJCSAgaW50IHVzZXJidWYsIGJvb2wgZW5jcnlwdGVkKQoKYW5kIHlvdSBkZWZp
bmUgdHdvIHdyYXBwZXJzOgoKY29weV9vbGRtZW1fcGFnZSgpCmNvcHlfb2xkbWVtX3BhZ2VfZW5j
cnlwdGVkKCkKCndoaWNoIGJvdGggY2FsbCBfX2NvcHlfb2xkbWVtX3BhZ2UoKSB3aXRoIHRoZSBh
cHByb3ByaWF0ZSBwYXJhbWV0ZXJzLgoKQnV0IHlvdSBkbyAqbm90KiBkbyBhIHNlcGFyYXRlIGNv
bXBpbGF0aW9uIHVuaXQganVzdCBiZWNhdXNlLiBOb25lIG9mCnRoZSByZWFzb25zIHlvdSd2ZSBt
ZW50aW9uZWQgd2FycmFudCBoYXZpbmcgYSBzZXBhcmF0ZSBjb21waWxhdGlvbgp1bml0IHdoaWxl
IHlvdSBhbHJlYWR5IGhhdmUgKnRoZSogcGVyZmVjdCBwbGFjZSB0byBwdXQgZXZlcnl0aGluZyAt
CmFyY2gveDg2L2tlcm5lbC9jcmFzaF9kdW1wXzY0LmMKCj4gU28gc29ycnksIGhlcmUgIm9sZG1l
bSBlbmNyeXB0ZWQiIG1lYW5zIHRoZSAib2xkIG1lbW9yeSBpcyBlbmNyeXB0ZWQiLgoKSSBrbm93
IHdoYXQgaXQgbWVhbnMgLSBJJ20gdHJ5aW5nIHRvIGV4cGxhaW4gdG8geW91IHRvIHdyaXRlIGl0
IG91dAppbiBwbGFpbiBlbmdsaXNoIGFuZCBub3QgdXNlIHNvbWUgc3RyYW5nZSBjb25zdHJ1Y3Rz
IGxpa2UgIm9sZG1lbQplbmNyeXB0ZWQiLgoKQSByZWFkZXIgd291bGQgd29uZGVyOiB3aHkgaXMg
dGhpcyB0aGluZyBzZW1pLWFiYnJldmlhdGVkIGFuZCBpbgpxdW90YXRpb24gbWFya3M/IERvZXMg
dGhhdCBtZWFuIGFueXRoaW5nIHNwZWNpYWw/CgpPdXIgY29tbWVudHMgc2hvdWxkIG5vdCBiZSB3
cml0ZS1vbmx5LiBTbyBhZnRlciB5b3UndmUgd3JpdHRlbiBpdCwgdHJ5CnRvIHJlYWQgaXQgYXMg
c29tZW9uZSB3aG8gc2VlcyB0aGUgY29kZSBmb3IgdGhlIGZpcnN0IHRpbWUgYW5kIHRoaW5rCmhh
cmQgd2hldGhlciBzaGUvaGUgd2lsbCB1bmRlcnN0YW5kIGl0LgoKRG8geW91IGNhdGNoIG15IGRy
aWZ0IG5vdz8KCi0tIApSZWdhcmRzL0dydXNzLAogICAgQm9yaXMuCgpTVVNFIExpbnV4IEdtYkgs
IEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIsIEphbmUgU21pdGhhcmQsIEdyYWhhbSBOb3J0b24sIEhS
QiAyMTI4NCAoQUcgTsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
