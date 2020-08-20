Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8mXT-0001IH-ER
 for kexec@lists.infradead.org; Thu, 20 Aug 2020 15:31:40 +0000
Date: Thu, 20 Aug 2020 17:31:31 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] MIPS: Fix compile warnnings in kexec-elf-mips.c
Message-ID: <20200820153131.GC23571@vergenet.net>
References: <1597296712-28069-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1597296712-28069-1-git-send-email-tangyouling@loongson.cn>
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
To: Youling Tang <tangyouling@loongson.cn>
Cc: kexec@lists.infradead.org

T24gVGh1LCBBdWcgMTMsIDIwMjAgYXQgMDE6MzE6NTJQTSArMDgwMCwgWW91bGluZyBUYW5nIHdy
b3RlOgo+IEZpeCB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOgo+IAo+IGtleGVjL2FyY2gvbWlwcy9r
ZXhlYy1lbGYtbWlwcy5jOjE2MTo0MTogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAzIG9mCj4g
4oCYZHRiX3NldF9pbml0cmTigJkgbWFrZXMgaW50ZWdlciBmcm9tIHBvaW50ZXIgd2l0aG91dCBh
IGNhc3QKPiBkdGJfc2V0X2luaXRyZCgmZHRiX2J1ZiwgJmR0Yl9sZW5ndGgsIGluaXRyZF9idWYs
IGluaXRyZF9idWYgKyBpbml0cmRfc2l6ZSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGtleGVjL2FyY2gvbWlwcy9r
ZXhlYy1lbGYtbWlwcy5jOjMzOjA6Cj4ga2V4ZWMvYXJjaC9taXBzLy4uLy4uL2R0LW9wcy5oOjY6
NTogbm90ZTogZXhwZWN0ZWQg4oCYb2ZmX3TigJkgYnV0IGFyZ3VtZW50IGlzCj4gb2YgdHlwZSDi
gJhjaGFyICrigJkKPiBpbnQgZHRiX3NldF9pbml0cmQoY2hhciAqKmR0Yiwgb2ZmX3QgKmR0Yl9z
aXplLCBvZmZfdCBzdGFydCwgb2ZmX3QgZW5kKTsKPiAgICAgIF4KPiAKPiBrZXhlYy9hcmNoL21p
cHMva2V4ZWMtZWxmLW1pcHMuYzoxNjE6NTM6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQgNCBv
Zgo+IOKAmGR0Yl9zZXRfaW5pdHJk4oCZIG1ha2VzIGludGVnZXIgZnJvbSBwb2ludGVyIHdpdGhv
dXQgYSBjYXN0Cj4gZHRiX3NldF9pbml0cmQoJmR0Yl9idWYsICZkdGJfbGVuZ3RoLCBpbml0cmRf
YnVmLCBpbml0cmRfYnVmICsgaW5pdHJkX3NpemUpOwo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBr
ZXhlYy9hcmNoL21pcHMva2V4ZWMtZWxmLW1pcHMuYzozMzowOgo+IGtleGVjL2FyY2gvbWlwcy8u
Li8uLi9kdC1vcHMuaDo2OjU6IG5vdGU6IGV4cGVjdGVkIOKAmG9mZl904oCZIGJ1dCBhcmd1bWVu
dCBpcwo+IG9mIHR5cGUg4oCYY2hhciAq4oCZCj4gaW50IGR0Yl9zZXRfaW5pdHJkKGNoYXIgKipk
dGIsIG9mZl90ICpkdGJfc2l6ZSwgb2ZmX3Qgc3RhcnQsIG9mZl90IGVuZCk7Cj4gICAgICBeCj4g
Cj4gU2lnbmVkLW9mZi1ieTogWW91bGluZyBUYW5nIDx0YW5neW91bGluZ0Bsb29uZ3Nvbi5jbj4K
ClRoYW5rcywgYXBwbGllZC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
