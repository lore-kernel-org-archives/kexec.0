Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67882C55162
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRIfx4TLYAlH3SnTech17HhGQG575fDtx9lFhxWcvsI=; b=zu+77+/2lgX95GpjX1lVBLbofz
	LWTskFLEiSMMpgn2oit822rEPhDFtoIuO3RfNVItfmyd1gMoykt91gfnuCQrv2Y4v+Chhc5S+ZLHS
	Vhuv317KR4g3MQbH9cKSwMKGKiSG4UmLKfDb1O5/kDf2T0JZhyF5+M7xHbLsia+BauU+/P/m+2z6Y
	R7ZgUkZ4m+cvG1M4s49o85Z/PwUC2rtq707bBPSgXpdRL4h9FjvJb8LCyZdw5k32GA8fYTSJfSNrV
	FJpYPi0OREFH7vW6Gg+v3XMzsRiElf3CSm7d4HYaugeBiQeqxgoFf9aL4XnnvT1bZ90KUi1P3MaYw
	u5HEl1Ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpMGe-00000009tQ1-45Vk;
	Thu, 30 Jul 2026 08:37:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpMGd-00000009tP7-3Rlf
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 08:37:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 467A7600AB;
	Thu, 30 Jul 2026 08:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E261F000E9;
	Thu, 30 Jul 2026 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785400647;
	bh=sRIfx4TLYAlH3SnTech17HhGQG575fDtx9lFhxWcvsI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=D9fSv0/LZSgIAShREquHiHX7Tx0CMoIBR485y3u10lT5SwyeT94zW9pgp758qvX2a
	 ZyngkQgu8D4pH/ruXOpdNGIceARJBuWPDQsgnOCULA8qiMX+kdsuIAQbqM633A/4ur
	 pzcjS+tcc4RXal+FkUBAME+iGlC3XJn8f0kKNKMxxlLKpfedUBlxV4KCUJduzra6tP
	 3PuKxZBTYYVugIMDa0nWHEMCk0Kp+Nj+vNJ+Wz3cL0VrupySYGl7BMd0d6WCc2R9AW
	 Epmbvf7XWhIqkQTRdB4f56/0Q+88wFyPnhIs0CQdh4ZKhr7ip3Sq/QGWvFD+ux7s7w
	 DKd+wAwYTCB0g==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 18/22] kho: extend scratch
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Alexander Graf <graf@amazon.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
 Jork Loeser <jloeser@linux.microsoft.com>, kexec@lists.infradead.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260729145610.2827231-19-pratyush@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
 <20260729145610.2827231-19-pratyush@kernel.org>
Date: Thu, 30 Jul 2026 11:37:14 +0300
Message-Id: <178540063445.2151126.14089645580528118019.b4-review@b4>
X-Mailer: b4 0.16-dev
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> +static void __init kho_extend_scratch(void)
> +{
> +	const struct kho_radix_walk_cb kho_cb = {
> +		.leaf = kho_ext_walk_leaf,
> +		.node = kho_ext_walk_node,
> +	};
> +	const struct kho_radix_walk_cb ext_cb = {
> +		.leaf = kho_ext_mark_scratch,
> +	};
> +	struct kho_radix_tree radix;
> +	phys_addr_t prev_end = 0;
> +	int err = 0;
> +
> +	err = kho_radix_init_tree(&radix, NULL);
> +	if (err)
> +		goto print;
> +
> +	/* Walk the KHO radix tree to find busy blocks. */
> +	err = kho_radix_walk_tree(&kho_in.radix_tree, &kho_cb, &radix);

sashiko: Will this trigger a lockdep recursive locking warning?

I think it will.

-- 
Sincerely yours,
Mike.


