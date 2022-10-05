Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354EFC433FE
	for <kexec@archiver.kernel.org>; Wed,  5 Oct 2022 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4dkwnqw+sa9LGDdX7FoIASgh27eXi4lnler+mbZv+z8=; b=tNedKASKlykuIQ
	uVHylBB0/Y0waKzVfqUzhVhCTl/tnZqATmZuWUkSnGexYglqxL2mwgBPxwVQssyfrp6Z94V1OgS7p
	sVB76Vjz9w9bBgZX3nM1+W5QaQbmX/vII9hUhRlGA4Kuuza3oJ7/Scu2EnjkgodM25Ict1d8jWpAv
	swSmjfF9WXa63M2YmoOxC9mcHcF0Gi1madRZW/YqNWhXXtq+cEj0Ecldewvuq9pgArcPYeaqL8Fz8
	PprGVtKHoHAZSZX5En1tOu0+dmVFQ7H9enpojeqong7bNJWwtGFvxp1p5kbFNNJF2nE3L3SWSGEmI
	p1ZDNks9EBlyI4i0Q9KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6Bj-00Epfi-DV; Wed, 05 Oct 2022 15:19:59 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og6BY-00EpbV-8q
	for kexec@lists.infradead.org; Wed, 05 Oct 2022 15:19:54 +0000
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 5518B2008D;
	Wed,  5 Oct 2022 15:19:12 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id DC69442D3; Wed,  5 Oct 2022 16:19:11 +0100 (IST)
Date: Wed, 5 Oct 2022 16:19:11 +0100
From: Simon Horman <horms@kernel.org>
To: Youling Tang <tangyouling@loongson.cn>
Cc: horms@kernel.org, kexec@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH 0/5] Add LoongArch port support
Message-ID: <Yz2gb5cuoTnX6XhJ@vergenet.net>
References: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1664332106-4845-1-git-send-email-tangyouling@loongson.cn>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221005_081948_578371_DFA3BD34 
X-CRM114-Status: GOOD (  10.30  )
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

On Wed, Sep 28, 2022 at 10:28:21AM +0800, Youling Tang wrote:
> This patch series to support kexec/kdump (only 64bit).
> 
> Note: Kernel kexec/kdump support patch see link [1]:
> Link [1]: https://lore.kernel.org/loongarch/711d53ae-197f-3c55-d09d-2f40e6886ad1@loongson.cn/T/#t

Thanks,

in principle this looks good to me.
But I am wondering if you could provide a patch to .github/workflows/build.yml

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
