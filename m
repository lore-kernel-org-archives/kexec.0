Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357E4C52D7B
	for <kexec@archiver.kernel.org>; Tue, 13 Aug 2024 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b4RyuJbYOOtxe7RSIqxJkKpq7dl+Zk3+teggJc/Pszw=; b=BWTElc/9cAwu55
	fgcJ+ZCNas+134+th9zTlkEFferAQ5sYXiWIS2JxOqvq+gROI/Welgmk8bb3c1ltVA7lszpnliOcG
	13drlYTbTCvgMaRFOgCxrgg8tYoY4DJt0dNvw5sFZJv8s0l+G4LSwZHSFWXrZQGa2jncfHwBLqXuW
	ectI4jgnAuYFotweSGRSlQCqm77JLgunbsBqjDKqNvDVh9Dum+lKdmIXYtKeerXbtlRI9kYjuOG8w
	fw0+XcckA0ibXb1Rtt40RcsjcGg0ZOZ3TxbGBoyEgmQGXPqhxkypt9R1/JUa2nQpHiKvzEwqlBgR6
	C/zebxnm/RVOEFTbxmiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdqGY-00000003bzz-3SXy;
	Tue, 13 Aug 2024 12:04:42 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdqGV-00000003bxf-1mCS;
	Tue, 13 Aug 2024 12:04:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 20BD3CE0FC9;
	Tue, 13 Aug 2024 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67DCC4AF0B;
	Tue, 13 Aug 2024 12:04:33 +0000 (UTC)
Date: Tue, 13 Aug 2024 13:04:31 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Baoquan He <bhe@redhat.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	vgoyal@redhat.com, dyoung@redhat.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, chenjiahao16@huawei.com,
	akpm@linux-foundation.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH -next] crash: Fix riscv64 crash memory reserve dead loop
Message-ID: <ZrtLz8VHzZIULbOT@arm.com>
References: <20240802090105.3871929-1-ruanjinjie@huawei.com>
 <ZqywtegyIS/YXOVv@MiWiFi-R3L-srv>
 <ZrJ1JkyDVpRRB_9e@arm.com>
 <ZrJ60vopeGDXFZyK@arm.com>
 <20240813104006.520bf42d@mordecai.tesarici.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240813104006.520bf42d@mordecai.tesarici.cz>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_050439_677537_C2108ACB 
X-CRM114-Status: GOOD (  21.30  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

SGkgUGV0ciwKCk9uIFR1ZSwgQXVnIDEzLCAyMDI0IGF0IDEwOjQwOjA2QU0gKzAyMDAsIFBldHIg
VGVzYcWZw61rIHdyb3RlOgo+IE9uIFR1ZSwgNiBBdWcgMjAyNCAyMDozNDo0MiArMDEwMAo+IENh
dGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+IHdyb3RlOgo+ID4gSSBoYXZl
bid0IHRyaWVkIGJ1dCBpdCdzIHBvc3NpYmxlIHRoYXQgdGhpcyBwYXRjaCBhbHNvIGJyZWFrcyB0
aG9zZQo+ID4gYXJtNjQgcGxhdGZvcm1zIHdpdGggYWxsIFJBTSBhYm92ZSA0R0Igd2hlbiBDUkFT
SF9BRERSX0xPV19NQVggaXMKPiA+IG1lbWJsb2NrX2VuZF9vZl9EUkFNKCkuIEhlcmUgYWxsIG1l
bW9yeSB3b3VsZCBiZSBsb3cgYW5kIGluIHRoZSBhYnNlbmNlCj4gPiBvZiBubyBmYWxsYmFjaywg
aXQgZmFpbHMgdG8gYWxsb2NhdGUuCj4gCj4gSSdtIGFmcmFpZCB5b3UndmUganVzdCBvcGVuZWQg
YSBQYW5kb3JhIGJveC4uLiA7LSkKCk5vdCB0aGF0IGJhZCA7KSBidXQsIHllYWgsIHRoaXMgcGF0
Y2ggd2FzIGRyb3BwZWQgaW4gZmF2b3VyIG9mIHRoaXM6CgpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9yLzIwMjQwODEyMDYyMDE3LjI2NzQ0NDEtMS1ydWFuamluamllQGh1YXdlaS5jb20vCgo+IEFu
b3RoZXIgKHVucmVsYXRlZCkgcGF0Y2ggc2VyaWVzIG1hZGUgdXMgYXdhcmUgb2YgYSBwbGF0Zm9y
bXMgd2hlcmUgUkFNCj4gc3RhcnRzIGF0IDMyRywgYnV0IElJVUMgdGhlIGhvc3QgYnJpZGdlIG1h
cHMgMzJHLTMzRyB0byBidXMgYWRkcmVzc2VzCj4gMC0xRywgYW5kIHRoZXJlIGlzIGEgZGV2aWNl
IG9uIHRoYXQgYnVzIHdoaWNoIGNhbiBwcm9kdWNlIG9ubHkgMzAtYml0Cj4gYWRkcmVzc2VzLgo+
IAo+IE5vdywgd2hhdCB3YXMgdGhlIGlkZWEgYmVoaW5kIGFsbG9jYXRpbmcgc29tZSBjcmFzaCBt
ZW1vcnkgImxvdyI/Cj4gUmlnaHQsIGl0IHNob3VsZCBhbGxvdyB0aGUgY3Jhc2gga2VybmVsIHRv
IGFjY2VzcyBkZXZpY2VzIHdpdGgKPiBhZGRyZXNzaW5nIGNvbnN0cmFpbnRzLiBTbywgb24gdGhl
IGFib3ZlLW1lbnRpb25lZCBwbGF0Zm9ybSwgYWxsb2NhdGluZwo+ICJsb3ciIHdvdWxkIGluIGZh
Y3QgbWVhbiBhbGxvY2F0aW5nIGJldHdlZW4gMzJHIGFuZCAzM0cgKGluIGhvc3QgYWRkcmVzcwo+
IGRvbWFpbikuCgpJbmRlZWQuIElmIHRoYXQncyBub3QgYXZhaWxhYmxlLCB0aGUgY3Jhc2gga2Vy
bmVsIHdvbid0IGJlIGFibGUgdG8gYm9vdAoodW5sZXNzIHRoZSBjb3JyZXNwb25kaW5nIGRldmlj
ZSBpcyByZW1vdmVkIGZyb20gRFQgb3IgQUNQSSB0YWJsZXMpLgoKPiBTaG91bGQgd2UgcmV0aGlu
ayB0aGUgd2hvbGUgY29uY2VwdCBvZiBoaWdoL2xvdz8KClllYWgsIGl0IHdvdWxkIGJlIGdvb2Qg
dG8gcmV2aXNpdCB0aG9zZSBhdCBzb21lIHBvaW50LiBGb3IgdGhlIHRpbWUKYmVpbmcsICdsb3cn
IGluIHRoaXMgY29udGV4dCBvbiBhcm02NCBtZWFucyBaT05FX0RNQSBtZW1vcnksIGJhc2ljYWxs
eQp0aGUgY29tbW9uIGRlbm9taW5hdG9yIGFkZHJlc3MgcmFuZ2UgdGhhdCBzdXBwb3J0cyBhbGwg
ZGV2aWNlcyBvbiBhbgpTb0MuIEZvciBvdGhlcnMgbGlrZSB4ODZfMzIsIHRoaXMgbWVhbnMgdGhl
IG1lbW9yeSB0aGF0IHRoZSBrZXJuZWwgY2FuCmFjdHVhbGx5IG1hcCAobm90IG5lY2Vzc2FyaWx5
IGRldmljZS9ETUEgcmVsYXRlZCkuCgpTbywgaXQncyBub3QgYWx3YXlzIGFib3V0IHRoZSBETUEg
Y2FwYWJpbGl0aWVzIGJ1dCBhbHNvIHdoYXQgdGhlIGNyYXNoCmtlcm5lbCBjYW4gbWFwIChzbyBz
b21ld2hhdCBkaWZmZXJlbnQgZnJvbSB0aGUgem9uZSBhbGxvY2F0b3IgY2FzZSB3ZSd2ZQpiZWVu
IGRpc2N1c3NpbmcgaW4gb3RoZXIgdGhyZWFkcykuCgotLSAKQ2F0YWxpbgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0Cmtl
eGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9rZXhlYwo=
