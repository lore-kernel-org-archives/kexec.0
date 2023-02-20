Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EFFC636CC
	for <kexec@archiver.kernel.org>; Mon, 20 Feb 2023 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8LfOed937fNL6HldiBhVjcB/aSWh115LbOzj8ZrHFHw=; b=hFifTI5Q4fCQqC
	Kd85/Gm/hCwPId/qSs3MGzoIRu3vLL6M8G6jXKNUR1Z6X9s9gDJCOTAfc1MQ+zyRBCEa0/xm5cTmc
	jIZGlu7cRuiDasAYeaJOqJ+1nMaS8xPGQLqwvonJXCGABuR5HjmX1msDwBp4U74NxvpCBiznF0St0
	YTJgcj/QGmGw6X63/K/vRY8xO8BuWWYh/u8YZpvFyi06MO7ZEpdMh5ZTgN5g4X5BrlNQuNEmSEzmr
	hTiAXdCyioNJmyHMwXyemeypiAOhK5XHNTA5kzwBxDOwtt4l/VYJ7iOgmGec9xwVFGuY1zWJK3Zlt
	1LQ4Od1Kcmn7x6jafYIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU8G7-004gBZ-La; Mon, 20 Feb 2023 15:39:19 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pU7gQ-004NnJ-BG
	for kexec@lists.infradead.org; Mon, 20 Feb 2023 15:02:28 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 63E0E20090;
	Mon, 20 Feb 2023 15:01:48 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 5FE67940242; Mon, 20 Feb 2023 16:01:45 +0100 (CET)
Date: Mon, 20 Feb 2023 16:01:45 +0100
From: Simon Horman <horms@kernel.org>
To: Julian Winkler <julian.winkler1@web.de>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH] x86: add devicetree support
Message-ID: <Y/OLWRZ4nHiNimgL@vergenet.net>
References: <20230219101813.903377-1-julian.winkler1@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230219101813.903377-1-julian.winkler1@web.de>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230220_070226_658353_586F6BE1 
X-CRM114-Status: GOOD (  10.05  )
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

T24gU3VuLCBGZWIgMTksIDIwMjMgYXQgMTE6MTg6MTNBTSArMDEwMCwgSnVsaWFuIFdpbmtsZXIg
d3JvdGU6Cj4gU2luY2UgbGludXgga2VybmVsIGhhcyBkcm9wcGVkIHN1cHBvcnQgZm9yIHNpbXBs
ZSBmaXJtd2FyZSBpbnRlcmZhY2UKPiAoU0ZJKSwgdGhlIG9ubHkgd2F5IG9mIGJvb3QgbmV3ZXIg
dmVyc2lvbnMgb24gaW50ZWwgTUlEIHBsYXRmb3JtIGlzCj4gdXNpbmcgZGV2aWNldHJlZQoKVGhh
bmtzIEp1bGlhbiwKCmluIGdlbmVyYWwgdGhpcyBwYXRjaCBsb29rcyBmaW5lIHRvIG1lLgoKQ291
bGQgSSBhc2sgeW91IHRvIHBvc3QgYSB2MiB0aGF0OgoKMS4gSXMgcmViYXNlZCBvbiBtYWluIC0g
dGhlcmUgd2FzIHNvbWUgZnV6eiBpbiBrZXhlYy1iekltYWdlLmMgd2hlbgogICBhcHBseWluZyB0
aGlzIHBhdGNoIGxvY2FsbHkuCgoyLiBJbmNsdWRlIGEgU2lnbmVkLW9mZi1ieSBsaW5lLgoKICAg
U2VlICJTaWduIHlvdXIgd29yayAtIHRoZSBEZXZlbG9wZXLigJlzIENlcnRpZmljYXRlIG9mIE9y
aWdpbiIgaW4KICAgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC92Ni4yL3Byb2Nlc3Mv
c3VibWl0dGluZy1wYXRjaGVzLmh0bWwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmtleGVjIG1haWxpbmcgbGlzdAprZXhlY0BsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8va2V4ZWMK
