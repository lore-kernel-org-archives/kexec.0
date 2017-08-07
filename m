Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dejhl-0002sj-MT
 for kexec@lists.infradead.org; Mon, 07 Aug 2017 15:12:31 +0000
Received: by mail-oi0-x243.google.com with SMTP id v11so676310oif.1
 for <kexec@lists.infradead.org>; Mon, 07 Aug 2017 08:12:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170806164428.2273-22-mikko.rapeli@iki.fi>
References: <20170806164428.2273-1-mikko.rapeli@iki.fi>
 <20170806164428.2273-22-mikko.rapeli@iki.fi>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 7 Aug 2017 17:12:06 +0200
Message-ID: <CAK8P3a2YUbohiCDkMgKVHEmJtDv7XG21DkrVBA7eAg6+nhcidA@mail.gmail.com>
Subject: Re: [PATCH v06 21/36] uapi linux/kexec.h: use __kernel_size_t instead
 of size_t
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
To: Mikko Rapeli <mikko.rapeli@iki.fi>
Cc: Linux API <linux-api@vger.kernel.org>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>

T24gU3VuLCBBdWcgNiwgMjAxNyBhdCA2OjQ0IFBNLCBNaWtrbyBSYXBlbGkgPG1pa2tvLnJhcGVs
aUBpa2kuZmk+IHdyb3RlOgo+IEZpeGVzIHVzZXJzcGFjZSBjb21waWxhdGlvbiBlcnJvcjoKPgo+
IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhzaXplX3TigJkKPiAgIHNpemVfdCBidWZzejsK
Pgo+IFNpZ25lZC1vZmYtYnk6IE1pa2tvIFJhcGVsaSA8bWlra28ucmFwZWxpQGlraS5maT4KPiBD
Yzoga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBFcmljIEJpZWRlcm1hbiA8ZWJpZWRl
cm1AeG1pc3Npb24uY29tPgoKQWNrZWQtYnk6IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwprZXhlYyBt
YWlsaW5nIGxpc3QKa2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2tleGVjCg==
