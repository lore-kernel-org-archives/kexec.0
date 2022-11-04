Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBFCC4332F
	for <kexec@archiver.kernel.org>; Fri,  4 Nov 2022 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ydqnAg6GamH1w4shEKLQHh64qN/wY8qrwvEkTNLEfwQ=; b=c1rjMKjm63Fj0y
	MgbyctxIDMhvMKM+I21P+Pa0wyAbaCl02/MypVBy+CyJ51XiKxgK4NWN34B2n196GD44KLiI0uKXv
	J7rjoNbGJRGjfrMXmOTs2v3nWc5Am6bOA+Jy2S8kSIZWsTlzHxci6wqczIHIyVqWDFwgcClWnn+n9
	pFjR1tkA3o8A9lAd2qcPHTyksL7y8af9B+N6A2y4ZkB5ZqMGva+ZYL+uH1aHskThDFtXuAMEk2e+F
	Yl5ok4+Cb21/K52srbJv1g1NI8JnX2RT/mDcRYiW4Ihd1iOJoLxIvrTDL41xLKD7Q7GjDAQTY/7l+
	CzPQo0/mmWeaL0WhSLpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqwB0-003WWP-8Q; Fri, 04 Nov 2022 12:52:02 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqwAx-003WV6-EC; Fri, 04 Nov 2022 12:52:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1AB2AB82D81;
	Fri,  4 Nov 2022 12:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F81C433D6;
	Fri,  4 Nov 2022 12:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667566316;
	bh=OgwptLaMSJduv4WFFZr/fdf7IeYyN0+CLHXPY8BR89M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcjC4Zn3fk1QaFtYPuuVpH277ylYcZM/ksmvLMrdhLjmCFK6BdfjeLgk177jCymrp
	 VwDG/xUhzByTL0Eh+CgVXzIl/sTzBvMPM1HJzI/AGqKtVg23CB3XuwFr0lcJ1xMC8k
	 k9EDW1VNYvjt11CTOE8P2SoOy/pcacfzh3WEyC0e+RVOmwGm53pP9QQImYXbgIFLKK
	 kNTRnxh3Jgi6U/oBwK74BjWt585tVVp+i/Wnk1e+8aXuk3Fm488FeL/wWE62o2alh9
	 f4uU/3R5n76v4owamOW7T4rjSbG1sMlHeFxITzF8jvMOuTY3DWQuQ/Vbpxc9aMcXuY
	 vRu0gR5yH8fqA==
Date: Fri, 4 Nov 2022 12:51:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	lizhengyu3@huawei.com, liaochang1@huawei.com,
	u.kleine-koenig@pengutronix.de, rdunlap@infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH 2/2] RISC-V: kexec: Fix memory leak of elf header buffer
Message-ID: <Y2UK51+2WrT9zjdx@spud>
References: <20221104095658.141222-1-lihuafei1@huawei.com>
 <20221104095658.141222-2-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104095658.141222-2-lihuafei1@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221104_055159_629812_3F012F34 
X-CRM114-Status: UNSURE (   5.88  )
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

Again, echos arm64's cleanup.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
