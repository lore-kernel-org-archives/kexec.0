Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYbuf-00082G-NN
 for kexec@lists.infradead.org; Sun, 16 Dec 2018 19:17:19 +0000
Received: by mail-pf1-f194.google.com with SMTP id z9so5258071pfi.2
 for <kexec@lists.infradead.org>; Sun, 16 Dec 2018 11:17:06 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 0/4] kexec/arm64: Fix issue with 'kexec load' and 'kdump'
 when --dtb option is used
Date: Mon, 17 Dec 2018 00:46:51 +0530
Message-Id: <1544987815-19527-1-git-send-email-bhsharma@redhat.com>
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
Cc: takahiro.akashi@linaro.org, bhsharma@redhat.com, bhupesh.linux@gmail.com, vicencb@gmail.com, horms@verge.net.au

Q2hhbmdlcyBzaW5jZSB2MjoKLS0tLS0tLS0tLS0tLS0tLS0KIC0gRHJvcHBlZCA0LzQgZnJvbSB2
MiBhcyBJIG5vdGljZWQgdGhhdCB3ZSBwYXNzIHdyb25nIG5vZGUgbmFtZSB0byBmZHQKICAgaGVs
cGVyIGZ1bmN0aW9ucyBpbiAna2V4ZWMvZHQtb3BzLmMnCgpUaGlzIHBhdGNoc2V0IGZpeGVzIHNv
bWUgaXNzdWVzIHdoZW4gd2UgY2FsbCBrZXhlYyBmb3IgYXJtNjQgd2l0aCAtLWR0YgpvcHRpb24g
KGJvdGggZm9yICdrZXhlYyBsb2FkJyBhbmQgJ2tkdW1wJyB1c2UgY2FzZXMpLgoKQSBjb3VwbGUg
b2YgdGhlc2UgaXNzdWVzIHdlcmUgcmVwb3J0ZWQgZm9yICdrZXhlYyBsb2FkJyB1c2UgY2FzZSBi
eQpWaWNlbsOnIGFuZCBJIGZvdW5kIHRoZSBvdGhlciB0d28gd2hpbGUgZXhwZXJpbWVudCB3aXRo
ICdrZHVtcCcgdXNlCmNhc2VzLgoKSSBoYXZlIHRlc3RlZCB0aGUgcGF0Y2hzZXQgb24gbXkgcXVh
bGNvbW0tYW1iZXJ3aW5nIGFuZCBocC1tb29uc2hvdAphcm02NCBib2FyZHMuCgpDYzogU2ltb24g
SG9ybWFuIDxob3Jtc0B2ZXJnZS5uZXQuYXU+CkNjOiBBS0FTSEkgVGFrYWhpcm8gPHRha2FoaXJv
LmFrYXNoaUBsaW5hcm8ub3JnPgpDYzogVmljZW50ZSBCZXJnYXMgPHZpY2VuY2JAZ21haWwuY29t
PgoKQmh1cGVzaCBTaGFybWEgKDQpOgogIGtleGVjL2R0LW9wcy5jOiBGaXggY2hlY2sgYWdhaW5z
dCAnZmR0X2FkZF9zdWJub2RlJyByZXR1cm4gdmFsdWUKICBrZXhlYy9rZXhlYy1hcm02NC5jOiBB
ZGQgZXJyb3IgaGFuZGxpbmcgY2hlY2sgYWdhaW5zdCByZXR1cm4gdmFsdWUgb2YKICAgICdzZXRf
Ym9vdGFyZ3MoKScKICBrZXhlYy9kdC1vcHMuYzogRml4IGFkZGluZyAnL2Nob3Nlbicgbm9kZSBm
b3IgY2FzZXMgd2hlcmUgaXQgaXMgbm90CiAgICBhdmFpbGFibGUgaW4gZHRiIHBhc3NlZCB2aWEg
LS1kdGIgb3B0aW9uCiAga2V4ZWMvZHQtb3BzLmM6IEZpeCAnL2Nob3Nlbicgdi9zICdjaG9zZW4n
IG5vZGUgYmVpbmcgcGFzc2VkIHRvIGZkdAogICAgaGVscGVyIGZ1bmN0aW9ucwoKIGtleGVjL2Fy
Y2gvYXJtNjQva2V4ZWMtYXJtNjQuYyB8ICA1ICsrKysrCiBrZXhlYy9kdC1vcHMuYyAgICAgICAg
ICAgICAgICAgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIDIgZmls
ZXMgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCi0tIAoyLjcuNAoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1h
aWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
