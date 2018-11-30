Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSbQK-0005ZF-Ay
 for kexec@lists.infradead.org; Fri, 30 Nov 2018 05:33:11 +0000
Received: by mail-pf1-f194.google.com with SMTP id u6so2209584pfh.11
 for <kexec@lists.infradead.org>; Thu, 29 Nov 2018 21:32:57 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH 0/4] kexec/arm64: Fix issue with 'kexec load' and 'kdump' when
 --dtb option is used
Date: Fri, 30 Nov 2018 11:02:41 +0530
Message-Id: <1543555965-14399-1-git-send-email-bhsharma@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>, bhsharma@redhat.com, bhupesh.linux@gmail.com, Vicente Bergas <vicencb@gmail.com>, Simon Horman <horms@verge.net.au>

VGhpcyBwYXRjaHNldCBmaXhlcyBzb21lIGlzc3VlcyB3aGVuIHdlIGNhbGwga2V4ZWMgZm9yIGFy
bTY0IHdpdGggLS1kdGIKb3B0aW9uIChib3RoIGZvciAna2V4ZWMgbG9hZCcgYW5kICdrZHVtcCcg
dXNlIGNhc2VzKS4KCkEgY291cGxlIG9mIHRoZXNlIGlzc3VlcyB3ZXJlIHJlcG9ydGVkIGZvciAn
a2V4ZWMgbG9hZCcgdXNlIGNhc2UgYnkKVmljZW7DpyBhbmQgSSBmb3VuZCB0aGUgb3RoZXIgdHdv
IHdoaWxlIGV4cGVyaW1lbnQgd2l0aCAna2R1bXAnIHVzZQpjYXNlcy4KCkkgaGF2ZSB0ZXN0ZWQg
dGhlIHBhdGNoc2V0IG9uIG15IHF1YWxjb21tLWFtYmVyd2luZyBhbmQgaHAtbW9vbnNob3QKYXJt
NjQgYm9hcmRzLgoKQ2M6IFNpbW9uIEhvcm1hbiA8aG9ybXNAdmVyZ2UubmV0LmF1PgpDYzogQUtB
U0hJIFRha2FoaXJvIDx0YWthaGlyby5ha2FzaGlAbGluYXJvLm9yZz4KQ2M6IFZpY2VudGUgQmVy
Z2FzIDx2aWNlbmNiQGdtYWlsLmNvbT4KCkJodXBlc2ggU2hhcm1hICg0KToKICBrZXhlYy9kdC1v
cHMuYzogRml4IGNoZWNrIGFnYWluc3QgJ2ZkdF9hZGRfc3Vibm9kZScgcmV0dXJuIHZhbHVlCiAg
a2V4ZWMva2V4ZWMtYXJtNjQuYzogQWRkIGVycm9yIGhhbmRsaW5nIGNoZWNrIGFnYWluc3QgcmV0
dXJuIHZhbHVlIG9mCiAgICAnc2V0X2Jvb3RhcmdzKCknCiAga2V4ZWMvZHQtb3BzLmM6IEZpeCBh
ZGRpbmcgJy9jaG9zZW4nIG5vZGUgZm9yIGNhc2VzIHdoZXJlIGl0IGlzIG5vdAogICAgYXZhaWxh
YmxlIGluIGR0YiBwYXNzZWQgdmlhIC0tZHRiIG9wdGlvbgogIGtleGVjL2tleGVjLWFybTY0LmM6
IEFkZCBtaXNzaW5nIGVycm9yIGhhbmRsaW5nIHBhdGhzCgoga2V4ZWMvYXJjaC9hcm02NC9rZXhl
Yy1hcm02NC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysKIGtleGVjL2R0LW9wcy5j
ICAgICAgICAgICAgICAgICB8ICA3ICsrKystLS0KIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0
aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNAoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8va2V4ZWMK
