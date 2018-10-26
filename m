Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x129.google.com ([2607:f8b0:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gG1uo-0005Af-Hb
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 13:12:40 +0000
Received: by mail-it1-x129.google.com with SMTP id l191-v6so1454091ita.4
 for <kexec@lists.infradead.org>; Fri, 26 Oct 2018 06:12:27 -0700 (PDT)
MIME-Version: 1.0
From: Vicente Bergas <vicencb@gmail.com>
Date: Fri, 26 Oct 2018 15:12:14 +0200
Message-ID: <CAAMcf8BU+ifd5JEC11maz=uxR+iU4myP_J3Oyy6MfWUo2AqTwA@mail.gmail.com>
Subject: [BUG] Set device tree bootargs failed when DTB does not contain a
 chosen node.
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
To: horms@verge.net.au, kexec@lists.infradead.org

SGVsbG8sCndoZW4gZXhlY3V0aW5nCiAga2V4ZWMgLWQgLS1kdGIgZHRiX3dpdGhvdXRfY2hvc2Vu
X25vZGUuZHRiIC0tYXBwZW5kICdjbWRsaW5lJyAtLWxvYWQgSW1hZ2UKaXQgcmVwb3J0cwogIGR0
Yl9zZXRfcHJvcGVydHk6IGZkdF9hZGRfc3Vibm9kZSBmYWlsZWQ6IDx2YWxpZCBvZmZzZXQvbGVu
Z3RoPgogIGtleGVjOiBTZXQgZGV2aWNlIHRyZWUgYm9vdGFyZ3MgZmFpbGVkLgoKSXQgaGFzIGJl
ZW4gdGVzdGVkIG9uIHRoZSBhcm02NCBhcmNoaXRlY3R1cmUgd2l0aCB2ZXJzaW9uIHYyLjAuMTcg
YW5kCnYyLjAuMTgtcmMxCgpSZWdhcmRzLAogIFZpY2Vuw6cuCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2tleGVjCg==
