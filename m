Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RE7WE-00075g-MT
	for kexec@lists.infradead.org; Wed, 12 Oct 2011 22:43:23 +0000
Date: Thu, 13 Oct 2011 07:42:46 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] sh: Take into account the base of System RAM in
	virt_to_phys()
Message-ID: <20111012224238.GE16825@verge.net.au>
References: <1317603918-30762-1-git-send-email-horms@verge.net.au>
	<CANqRtoT1ik9x+s10K6dBy34pDv5+up9dCweVF5MOctWeB=gxAw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANqRtoT1ik9x+s10K6dBy34pDv5+up9dCweVF5MOctWeB=gxAw@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, kexec@lists.infradead.org, linux-sh@vger.kernel.org

T24gV2VkLCBPY3QgMTIsIDIwMTEgYXQgMDU6MjQ6MjNQTSArMDkwMCwgTWFnbnVzIERhbW0gd3Jv
dGU6Cj4gT24gTW9uLCBPY3QgMywgMjAxMSBhdCAxMDowNSBBTSwgU2ltb24gSG9ybWFuIDxob3Jt
c0B2ZXJnZS5uZXQuYXU+IHdyb3RlOgo+ID4gUHJldmlvdXNseSB2aXJ0X3RvX3BoeXMoKSBhc3N1
bWVkIHRoYXQgcGh5c2ljYWwgbWVtb3J5IGFsd2F5cyBzdGFydGVkCj4gPiBhdCBhZGRyZXNzIDAu
IFRoaXMgaXMgbm90IGFsd2F5cyB0aGUgY2FzZS4KPiA+Cj4gPiBUZXN0ZWQgb24gYW4gc2g3NzU3
bGNyICgzMmJpdCBzeXN0ZW0pIHdob3NlIG9ubHkgU3lzdGVtIFJBTSByZWdpb24gaXMKPiA+IDQw
MDAwMDAwLTRlZmZmZmZmIGFuZCBhbiBlY292ZWMyNCAoMjliaXQgc3lzdGVtKS4KPiA+Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBTaW1vbiBIb3JtYW4gPGhvcm1zQHZlcmdlLm5ldC5hdT4KPiA+Cj4gPiAt
LS0KPiA+IMKga2V4ZWMvYXJjaC9zaC9rZXhlYy1zaC5jIHwgwqAgNDUgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystCj4gPiDCoDEgZmlsZXMgY2hhbmdlZCwgNDQg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPiA+Cj4gPiB2Mgo+ID4gKiBPbmx5IHVzZSB0
aGUgYmFzZSBvZiBTeXN0ZW0gUkFNIGFzIGFuIG9mZnNldCBpbnRvIHBoeXNpY2FsIG1lbW9yeQo+
ID4gwqBpZiAzMmJpdCBhZGRyZXNzaW5nIGlzIGluIHVzZS4KPiAKPiBUaGlzIHZlcnNpb24gbG9v
a3MgbXVjaCBiZXR0ZXIsIHRoYW5rcyEKCkkgdGhvdWdodCBzbyB0b28uIEJ1dCBhZnRlciBwdXNo
aW5nIGl0IEkgcmVhbGlzZWQgdGhlIHBhcnNpbmcgbG9naWMgaW4KaXNfMzJiaXQoKSBpcyBmbGF3
ZWQuIEkgd2lsbCBzZW5kIGFuIHVwZGF0ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
