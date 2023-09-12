Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E75BCA0EC3
	for <kexec@archiver.kernel.org>; Tue, 12 Sep 2023 10:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=is4/aE5dzRzlgc9oBZragG1i2Evf16OTceZRkaQ9tiA=; b=mCp/itredZ8sn0
	rbsxTMRksjHuraRzVGbnrwS/rhjoeQCMgMt+Y6n1M/9MruZsJjiVTLH15ddBA49bNO13LFGouS/Jk
	Oq2EN5FgmV14G1/L5p/lgVorYvcHhNce8NGZSiBhxLm0PNIi2OJqVcgfkKDdvdlTf/VmZ+ya+ISSw
	vhQuX/xcFV7unU0zyvRcpa2isry/m7vvejRKQteI7DQeK/n/WIF3h5LE61QuT6H8qR0WH4i/tRPSw
	dIrUtx7RWIKT3V+8Kg+7QARKA2ZsuU7GhEGUsiYBVt53LqJ6tN8MWPvf+64obnqw3r915eZeY5/II
	cj8IfPgWgSWaADomOTqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg0mJ-002yip-1c;
	Tue, 12 Sep 2023 10:37:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg0mH-002yiK-1J
	for kexec@lists.infradead.org;
	Tue, 12 Sep 2023 10:37:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B1D1960244;
	Tue, 12 Sep 2023 10:37:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDECC433C8;
	Tue, 12 Sep 2023 10:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694515072;
	bh=dxP4B+yMelLzCrvZ7SL2av9sUsV6Kpduc789X1rtOVc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EPXRQ9TdnHqdeF5sFt3tTrzUsBlm6Q/olAvgVQ2rMTpPetLVuUzhQPUKSQ1so1hLG
	 v9Vc1UxTq77QYGhGTxQsi9yfa9vTh+zty9gpG9qa1da0L0j1EEWZmMFnkEUpOBxt4U
	 p2YHCVwvVxaufhJs5g/rYd/KgunZc9g8F6kXGnMnEPiL3zYvaneh/+kIk5g9krGA0+
	 lI2jHl6f1lvPHzMkR5hOIIeHfiuIg88fzcQoTCngedWKSoHfTCf/cEUCfojyASNPFt
	 /bn9KlFLocBmIK9pmIJis366CIhYuRIoEmk1qvF+DS5Q2U8AQn06PeGmnGB6kUbSXT
	 eGtLs4oOfee+w==
Mime-Version: 1.0
Date: Tue, 12 Sep 2023 13:37:47 +0300
Message-Id: <CVGVGJIQPIZ2.WN97L6BV5S97@suppilovahvero>
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>, <linux-kernel@vger.kernel.org>,
 <systemd-devel@lists.freedesktop.org>, <x86@kernel.org>,
 <kexec@lists.infradead.org>, <dhowells@redhat.com>,
 <keyrings@vger.kernel.org>, <bluca@debian.org>, <bhelgaas@google.com>,
 <tglx@linutronix.de>, <akpm@linux-foundation.org>
Subject: Re: [systemd-devel] [PATCH 0/1] x86/kexec: UKI support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Neal Gompa" <ngompa13@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230909161851.223627-1-kernel@jfarr.cc>
 <CVGFE6FRWFHR.DVG9NUQID4EA@suppilovahvero>
 <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
In-Reply-To: <CAEg-Je9GF5S+QcsspM_CzDSxzCN8h2eRp7BbctC1x7-rH8j68g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_033753_524298_08168A35 
X-CRM114-Status: GOOD (  18.61  )
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

T24gVHVlIFNlcCAxMiwgMjAyMyBhdCAyOjIwIEFNIEVFU1QsIE5lYWwgR29tcGEgd3JvdGU6ID4g
T24gTW9uLCBTZXAgMTEsIDIwMjMgYXQgNzoxNeKAr1BNIEphcmtrbyBTYWtraW5lbiA8amFya2tv
QGtlcm5lbC5vcmc+IHdyb3RlOgo+ID4gT24gU2F0IFNlcCA5LCAyMDIzIGF0IDc6MTggUE0gRUVT
VCwgSmFuIEhlbmRyaWsgRmFyciB3cm90ZToKPiA+ID4gSGVsbG8sCj4gPiA+Cj4gPiA+IHRoaXMg
cGF0Y2ggaW1wbGVtZW50cyBVS0kgc3VwcG9ydCBmb3Iga2V4ZWNfZmlsZV9sb2FkLiBJdCB3aWxs
IHJlcXVpcmUgc3VwcG9ydAo+ID4gPiBpbiB0aGUga2V4ZWMtdG9vbHMgdXNlcnNwYWNlIHV0aWxp
dHkuIEZvciB0ZXN0aW5nIHB1cnBvc2VzIHRoZSBmb2xsb3dpbmcgY2FuIGJlIHVzZWQ6Cj4gPiA+
IGh0dHBzOi8vZ2l0aHViLmNvbS9DeWRveC9rZXhlYy10ZXN0Lwo+ID4gPgo+ID4gPiBUaGVyZSBo
YXMgYmVlbiBkaXNjdXNzaW9uIG9uIHRoaXMgdG9waWMgaW4gYW4gaXNzdWUgb24gR2l0SHViIHRo
YXQgaXMgbGlua2VkIGJlbG93Cj4gPiA+IGZvciByZWZlcmVuY2UuCj4gPiA+Cj4gPiA+Cj4gPiA+
IFNvbWUgbGlua3M6Cj4gPiA+IC0gUmVsYXRlZCBkaXNjdXNzaW9uOiBodHRwczovL2dpdGh1Yi5j
b20vc3lzdGVtZC9zeXN0ZW1kL2lzc3Vlcy8yODUzOAo+ID4gPiAtIERvY3VtZW50YXRpb24gb2Yg
VUtJczogaHR0cHM6Ly91YXBpLWdyb3VwLm9yZy9zcGVjaWZpY2F0aW9ucy9zcGVjcy91bmlmaWVk
X2tlcm5lbF9pbWFnZS8KPiA+ID4KPiA+ID4gSmFuIEhlbmRyaWsgRmFyciAoMSk6Cj4gPiA+ICAg
eDg2L2tleGVjOiBVS0kgc3VwcG9ydAo+ID4gPgo+ID4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20v
a2V4ZWMtdWtpLmggICAgICAgfCAgIDcgKysKPiA+ID4gIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Bh
cnNlX3BlZmlsZS5oICAgIHwgIDMyICsrKysrKysKPiA+ID4gIGFyY2gveDg2L2tlcm5lbC9NYWtl
ZmlsZSAgICAgICAgICAgICAgIHwgICAyICsKPiA+ID4gIGFyY2gveDg2L2tlcm5lbC9rZXhlYy11
a2kuYyAgICAgICAgICAgIHwgMTEzICsrKysrKysrKysrKysrKysrKysrKysrKysKPiA+ID4gIGFy
Y2gveDg2L2tlcm5lbC9tYWNoaW5lX2tleGVjXzY0LmMgICAgIHwgICAyICsKPiA+ID4gIGFyY2gv
eDg2L2tlcm5lbC9wYXJzZV9wZWZpbGUuYyAgICAgICAgIHwgMTEwICsrKysrKysrKysrKysrKysr
KysrKysrKwo+ID4gPiAgY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy9tc2NvZGVfcGFyc2VyLmMgfCAg
IDIgKy0KPiA+ID4gIGNyeXB0by9hc3ltbWV0cmljX2tleXMvdmVyaWZ5X3BlZmlsZS5jIHwgMTEw
ICsrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAgY3J5cHRvL2FzeW1tZXRyaWNfa2V5cy92
ZXJpZnlfcGVmaWxlLmggfCAgMTYgLS0tLQo+ID4gPiAgOSBmaWxlcyBjaGFuZ2VkLCAyNzggaW5z
ZXJ0aW9ucygrKSwgMTE2IGRlbGV0aW9ucygtKQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFy
Y2gveDg2L2luY2x1ZGUvYXNtL2tleGVjLXVraS5oCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
YXJjaC94ODYvaW5jbHVkZS9hc20vcGFyc2VfcGVmaWxlLmgKPiA+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL3g4Ni9rZXJuZWwva2V4ZWMtdWtpLmMKPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBhcmNoL3g4Ni9rZXJuZWwvcGFyc2VfcGVmaWxlLmMKPiA+ID4KPiA+ID4gLS0KPiA+ID4gMi40
MC4xCj4gPgo+ID4gV2hhdCB0aGUgaGVjayBpcyBVS0k/Cj4KPiBVbmlmaWVkIEtlcm5lbCBJbWFn
ZXMuIE1vcmUgZGV0YWlscyBhdmFpbGFibGUgaGVyZToKPiBodHRwczovL3VhcGktZ3JvdXAub3Jn
L3NwZWNpZmljYXRpb25zL3NwZWNzL3VuaWZpZWRfa2VybmVsX2ltYWdlLwo+Cj4gSXQncyBhIHdh
eSBvZiBjcmVhdGluZyBpbml0cmFtZnMtc3R5bGUgaW1hZ2VzIGFzIGZ1bGx5IGdlbmVyaWMsCj4g
cmVwcm9kdWNpYmxlIGltYWdlcyB0aGF0IGNhbiBiZSBidWlsdCBzZXJ2ZXItc2lkZS4KCllvdSBj
YW4gYnVpbGQgdG9kYXkgYSBrZXJuZWwgd2l0aCB0aGVzZSBjb21waWxlZCBpbjoKCjEuIEVGSSBz
dHViCjIuIGluaXRlcmFtZnMKMy4gY21kbGluZQoKV2h5IGFub3RoZXIgd2F5IChhbmQgbGFiZWwg
J1VLSScpIGZvciBhIHByZS1leGlzdGluZyBmZWF0dXJlPwoKQlIsIEphcmtrbwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18Ka2V4ZWMgbWFpbGluZyBsaXN0
CmtleGVjQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9rZXhlYwo=
