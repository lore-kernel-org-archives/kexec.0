Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 926F1C4345F
	for <kexec@archiver.kernel.org>; Wed, 17 Apr 2024 07:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:To:From:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=HPvdE2orwGlD2rV/vcn4bl/QTyBjytO3Zw6Mum9Hj14=; b=i2igA77UhG3Kiv
	c8Sn1qcx+/4jsM5aYxXhhQgsSGxVR6n0rdQUGJSvo0ouHWPtW5qiFRXa6pty8DaznTcYj1RoVvjAo
	EQnYcp4ZAb7rCNe45DjJTB0uEQMQQgcaUeaKDYDQ+74Rx6wjHLAdyspyU7TUOH8ibKzBFVGFB5u3U
	J8B6YjRBU4oM0bX1udQf7lGfNu+4jTIh3KfLsa1VbbJHA1WAahVe6eReutWJqbf+TfpWqDVmWFoxM
	M2/MjP71HAShSaeE6aFOa/NUplzh7onFRbedYdo0FkxBOxigjzFv0khGPYM5TzWL6uLQBW9myjSnb
	AXIUE6qIAMKHilo89rMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx04I-0000000F65J-0Rug;
	Wed, 17 Apr 2024 07:50:58 +0000
Received: from mail.geniusmake.com ([217.61.16.93])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx04E-0000000F63h-0YwZ
	for kexec@lists.infradead.org;
	Wed, 17 Apr 2024 07:50:56 +0000
Received: by mail.geniusmake.com (Postfix, from userid 1002)
	id EE08B82691; Wed, 17 Apr 2024 09:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geniusmake.com;
	s=mail; t=1713340246;
	bh=PnZc+rIY6TfTKjOaDWzpfrHUKmRuaNjVokX+KxS+akY=;
	h=Date:From:To:Subject:From;
	b=Spcq0bl4Lc5Dh2QdOlCW8iLMaLsZ2IP0JhtFKiM9oLr5QLONKFXsU5wOn90cCRA9o
	 u780VUhNRS7LMq/sxf3x1no6HR85syz/oFs9CmpAWbrtAbDlRnZjWqI822VSxFEex2
	 6+sqJr/jWtGYYH55pzrTOPL0vriplhs3KEXJbEkNTWWQaapuFFmimhuhuQI4FgFkhR
	 fyGYUgfRmm6mLisIvwphrBPdrsA+uNxOT8AxMJP1rGIrQdoHfrejeA7rrMdF7QHIGD
	 M80pHb9W4CGpRfxlSGpbe5c7BK6Av4Iwn9uyxoOOd37OpBKGrMHENOa86BIys+AIdL
	 nDKbG+gAlQazg==
Received: by mail.geniusmake.com for <kexec@lists.infradead.org>; Wed, 17 Apr 2024 07:50:43 GMT
Message-ID: <20240417084500-0.1.24.4pam.0.i0977swm0n@geniusmake.com>
Date: Wed, 17 Apr 2024 07:50:43 GMT
From: "Gordon Frogge" <gordon.frogge@geniusmake.com>
To: <kexec@lists.infradead.org>
Subject: Sunbathing cosmetics
X-Mailer: mail.geniusmake.com
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_005055_019629_458ED4C5 
X-CRM114-Status: UNSURE (   0.85  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Good morning,

We are experts in the production of tanning cosmetics in solariums.

Our products help you get a faster and longer-lasting tan, while caring for and moisturizing your skin before and after tanning.

Cosmetics contain the highest quality ingredients from the USA and Poland, thanks to which we provide the market with premium products in tubes and sachets.

We have prepared attractive terms of cooperation for you, a wide product offer at competitive prices and support materials for selected brands.

Would you like to talk about cooperation possibilities?


Best regards
Gordon Frogge

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
