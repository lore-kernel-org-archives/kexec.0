Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ob0-x235.google.com ([2607:f8b0:4003:c01::235])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YNnFy-0004Lb-PR
 for kexec@lists.infradead.org; Tue, 17 Feb 2015 18:52:27 +0000
Received: by mail-ob0-f181.google.com with SMTP id vb8so56593682obc.12
 for <kexec@lists.infradead.org>; Tue, 17 Feb 2015 10:52:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1423730066-4587-1-git-send-email-2ameya@gmail.com>
References: <1423730066-4587-1-git-send-email-2ameya@gmail.com>
Date: Tue, 17 Feb 2015 10:52:03 -0800
Message-ID: <CAFAJAExNzO5h2=MYSEZ01z9omGyAkDG8xZvAPV=VPtfcqCrs_A@mail.gmail.com>
Subject: Re: [PATCH] i386: elf: Fix -Wunused-but-set-variable compilation
 warning
From: Ameya Palande <2ameya@gmail.com>
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
Cc: Simon Horman <horms@verge.net.au>

T24gVGh1LCBGZWIgMTIsIDIwMTUgYXQgMTI6MzQgQU0sIEFtZXlhIFBhbGFuZGUgPDJhbWV5YUBn
bWFpbC5jb20+IHdyb3RlOgo+IGtleGVjL2FyY2gvaTM4Ni9rZXhlYy1lbGYteDg2LmM6OTc6Njog
d2FybmluZzogdmFyaWFibGUKPiDigJhtb2RpZmllZF9jbWRsaW5lX2xlbuKAmSBzZXQgYnV0IG5v
dCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQo+ICAgaW50IG1vZGlmaWVkX2NtZGxp
bmVfbGVuOwo+Cj4gU2lnbmVkLW9mZi1ieTogQW1leWEgUGFsYW5kZSA8MmFtZXlhQGdtYWlsLmNv
bT4KCkFueSB1cGRhdGU/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwprZXhlYyBtYWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
