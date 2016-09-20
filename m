Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmILd-0000JP-PO
 for kexec@lists.infradead.org; Tue, 20 Sep 2016 10:32:22 +0000
Message-ID: <1474367516.19686.1.camel@suse.de>
Subject: Re: [PATCH v3 3/3] close_dump_bitmap: simplify logic
From: Martin Wilck <mwilck@suse.de>
Date: Tue, 20 Sep 2016 12:31:56 +0200
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E6A4CF@BPXM01GP.gisp.nec.co.jp>
References: <20160914101723.19003-3-mwilck@suse.de>
 <20160914115009.20220-1-mwilck@suse.de>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E6A4CF@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: "ptesarik@suse.cz" <ptesarik@suse.cz>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

S3VtYWdhaS1zYW4sCk9uIFR1ZSwgMjAxNi0wOS0yMCBhdCAwOTo0MyArMDAwMCwgQXRzdXNoaSBL
dW1hZ2FpIHdyb3RlOgo+wqAKPiBUaGlzIHZlcnNpb24gbG9va3MgZ29vZCwgc28gY291bGQgeW91
IGFkZCB5b3VyIFNpZ25lZC1vZmYtYnkgPwoKT0ssIEknbGwgcmVzZW5kIHRoZSB3aG9sZSB2MyBz
ZXJpZXMuCgpNYXJ0aW4KCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9rZXhlYwo=
