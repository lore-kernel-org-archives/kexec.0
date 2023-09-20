Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5541CCE79CE
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hZLi8fD+dhfC5YPw+Z6MvLpMx+jqQsw0yYWS/HgvU58=; b=xJNrgpM/xOYwY4
	3tNEoj04eiotVRR1mPh9mJiPjkiVDm3zcX2gJxMfWH71rh2oqfTQJmzrZdOHU9UgjvsxJxIgX0Y9j
	g9f4T11zXqvDI8LUrudFzxtiSuxW2JP3BPMqIscSzJJBCKi24kKRCti6mAyy7rlO71ZGAsO2t6265
	KpRwlCDUj0qubGL8/GcsOlGOCdb/qtU/ESQqxivG9vq2j4KjY/V5WeSuON4+5+es9apGvx8RXbVfX
	rrI/qByQJKRbGk/KDjSMQqoeg3vGLRTTdFRV4u0diccVb0pGR6WIX3FR9GuC0VMEYUT7M9Hcvb8Vw
	tH+FyBKx5WFW3r+2nEQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qivgB-002uql-1N;
	Wed, 20 Sep 2023 11:47:39 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qivg8-002upy-2Z
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 11:47:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43FCC61A1B;
	Wed, 20 Sep 2023 11:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E85C433C8;
	Wed, 20 Sep 2023 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695210455;
	bh=jmnzUb5/CyOIQvE6gIEi8JHVyEXnZj3YNq4VgRkUm1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YamDgMIi8U8oBc23FT+Stk28K65KveXCnhS11FqQvnkmC7Xps7BHzwcqAUYF6GXfG
	 GXDzzQm9tNk+G79DjUZifbxlGhjlR6UQc0fEGnNzRzFtaYQiNZHyqDlnUsHvYNUNFq
	 QTsCoFxp8hP7pZV5Z+3djZwJwS0ZAE9v1EYqQkX3sg0PPTeizk74Lva1viaDDGehH8
	 csCLTk0FSgnbt6HBxVJTFsyG1MuHa3o2+Q+JyPmSX/Q2unJ1zLdEU1g9NyR1MWHg9M
	 jCdWI3errZQRmumDZbSslfT16DY4ashw43QXoPFuIPAW5Y6XDP8AxGocOfdzaeWTQK
	 PWpSlNS0chQzQ==
Date: Wed, 20 Sep 2023 12:47:30 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>
Subject: Re: [PATCH v1 0/2] zboot: enable kexec_load for zboot kernel images
Message-ID: <20230920114730.GE224399@kernel.org>
References: <20230914085000.17982-1-dyoung@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230914085000.17982-1-dyoung@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_044736_899839_9DCAFAFC 
X-CRM114-Status: UNSURE (   9.96  )
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

On Thu, Sep 14, 2023 at 04:49:58PM +0800, Dave Young wrote:
> The current kexec-tools only support kexec_file_load for zboot kernel
> images on arm64.
> 
> This series tweak a bit of the code so kexec_load can also load zboot
> images on both arm64 and loongarch.

Thanks, applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
