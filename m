Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F6DC4332F
	for <kexec@archiver.kernel.org>; Mon, 14 Nov 2022 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SlwyMJ0l3/USy45Z1KV8/BYoMNG+rqLVk1FvZVNLm+Q=; b=KMw2NM9dsnu3J8
	jmCZc1Zb61Jv33hEeILOZAlLxsHv4YvKNhYGAoatkOxOUNVAblXceedGgu+tp8zFq2RbzDIIAV9Xe
	I557VNE/AQ/CmE2mnFAJPeMbTOI9av9e0llYjOOGb8TeMOEktvacjxWcs/kJ8zQfNdlcT1FZy4X/G
	KoD60Bqu15FJWymO4ccU5lwHoqIHzsX6yf/KYqztOTt3XpumNAcF3s2yy8uZKz/qzCw+FrmIa51g0
	OCJ6NWTbxdUFQHUAEJawI3W7ZgJu8j1f8em/f+nJfztFiFBSTakAeB8g6D4wziKa4AIj/sYUqDmkz
	KYrqWaWhW+hO5IRY1P3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oubSk-002GDL-8k; Mon, 14 Nov 2022 15:33:30 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oubRw-002GAE-BN
	for kexec@lists.infradead.org; Mon, 14 Nov 2022 15:32:41 +0000
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 409982000E;
	Mon, 14 Nov 2022 15:32:00 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 0206E472B; Mon, 14 Nov 2022 10:31:59 -0500 (EST)
Date: Mon, 14 Nov 2022 16:31:59 +0100
From: Simon Horman <horms@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 RESEND kexec-tools] m68k: pass rng seed via BI_RNG_SEED
Message-ID: <Y3Jfb5fUnX3skm3+@vergenet.net>
References: <20221111013532.494463-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221111013532.494463-1-Jason@zx2c4.com>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_073240_555830_0EA8DF5B 
X-CRM114-Status: GOOD (  13.19  )
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

T24gRnJpLCBOb3YgMTEsIDIwMjIgYXQgMDI6MzU6MzNBTSArMDEwMCwgSmFzb24gQS4gRG9uZW5m
ZWxkIHdyb3RlOgo+IEluIG9yZGVyIHRvIHBhc3MgZnJlc2ggZW50cm9weSB0byBrZXhlYydkIGtl
cm5lbHMsIHVzZSBCSV9STkdfU0VFRAo+IGZvciBwYXNzaW5nIGEgc2VlZCwgd2l0aCB0aGUgc2Ft
ZSBzZW1hbnRpY3MgdGhhdCBrZXhlYy10b29scyBjdXJyZW50bHkKPiB1c2VzIGZvciBpMzg2J3Mg
c2V0dXBfZGF0YS4KPiAKPiBMaW5rOiBodHRwczovL2dpdC5rZXJuZWwub3JnL3RvcnZhbGRzL2Mv
ZGM2M2EwODZkYWVlOTJjNjNlMwo+IFNpZ25lZC1vZmYtYnk6IEphc29uIEEuIERvbmVuZmVsZCA8
SmFzb25AengyYzQuY29tPgo+IC0tLQo+IFNlZW1zIGxpa2UgdGhpcyB3YXMgZm9yZ290dGVuIGFi
b3V0LCBzbyByZXNlbmRpbmcuCgpIaSBKYXNvbiwKClNvcnJ5IGFib3V0IG1pc3NpbmcgdGhpcyBl
YXJsaWVyLgoKSSB3YXMgcGxhbm5pbmcgdG8gYXBwbHkgaXQganVzdCBub3csIGJ1dCBpdCBzZWVt
cyB0aGF0CnRoZSBnaXRodWIgd29ya2Zsb3cgZmxhZ2dlZCBhIHByb2JsZW06CgpJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gLi4vLi4va2V4ZWMvYXJjaC9tNjhrL2tleGVjLW02OGsuYzoxOToKLi4vLi4v
a2V4ZWMvYXJjaC9tNjhrL2Jvb3RpbmZvLmg6MjU6NDogZXJyb3I6IHVua25vd24gdHlwZSBuYW1l
IOKAmHU44oCZCiAgIDI1IHwgICAgdTggZGF0YVswXTsKICAgICAgfCAgICBefgptYWtlWzFdOiAq
KiogW01ha2VmaWxlOjEyNDoga2V4ZWMvYXJjaC9tNjhrL2tleGVjLW02OGsub10gRXJyb3IgMQpt
YWtlWzFdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgpJbiBmaWxlIGluY2x1
ZGVkIGZyb20gLi4vLi4va2V4ZWMvYXJjaC9tNjhrL2tleGVjLWVsZi1tNjhrLmM6Mjc6Ci4uLy4u
L2tleGVjL2FyY2gvbTY4ay9ib290aW5mby5oOjI1OjQ6IGVycm9yOiB1bmtub3duIHR5cGUgbmFt
ZSDigJh1OOKAmQogICAyNSB8ICAgIHU4IGRhdGFbMF07CiAgICAgIHwgICAgXn4KbWFrZVsxXTog
KioqIFtNYWtlZmlsZToxMjQ6IGtleGVjL2FyY2gvbTY4ay9rZXhlYy1lbGYtbTY4ay5vXSBFcnJv
ciAxCm1ha2U6ICoqKiBbTWFrZWZpbGU6Mjc2OiBkaXN0Y2hlY2tdIEVycm9yIDIKbWFrZVsxXTog
TGVhdmluZyBkaXJlY3RvcnkgJy9ob21lL3J1bm5lci93b3JrL2tleGVjLXRvb2xzL2tleGVjLXRv
b2xzL2tleGVjLXRvb2xzLTIuMC4yNS5naXQvX2J1aWxkL3N1YicKRXJyb3I6IFByb2Nlc3MgY29t
cGxldGVkIHdpdGggZXhpdCBjb2RlIDIuCgpSZWY6IGh0dHBzOi8vZ2l0aHViLmNvbS9ob3Jtcy9r
ZXhlYy10b29scy9hY3Rpb25zL3J1bnMvMzQ2MjgzMDY0Mi9qb2JzLzU3ODIyMzg0NDYKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcg
bGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8va2V4ZWMK
