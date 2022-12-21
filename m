Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58E7C4167B
	for <kexec@archiver.kernel.org>; Wed, 21 Dec 2022 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aL3H76JrNGgXo77t5Q9yCLHSgNlS04sA2BzmlxVvvD4=; b=uHSpjoPg2WcPYs
	r7B1lfwqKBAAq9gGgDlfjx+pW5Ak5Br1GPXQZXkjnY5tke//hwbLcs57+6dgac09Kvd4rnd+l6gVv
	to412q4im90XE8d89XlKT2xyvrhxgFEPDeFWcy4VqW0Sd57f0HD86VFH8buMAbeYr4tbEtpfbETKc
	zEVxpK0zJNNavHHCuZi1xWOBsS6kMC152FBuJzKUyBo7vFcdfPyMuldiQbtutOzhNVfsLVA8p1ni5
	b8ivHS1GxJgp+bhfKg4kQJTUryVawT16EJ0z2C3EloTM/5DDzthhLy0O1/qnfQbn4G6Ofvz5Z1elk
	nRdaT8jUjNYFG/xVre/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p81Df-00GVJY-AE; Wed, 21 Dec 2022 15:41:23 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p81Bw-00GTEP-9T
	for kexec@lists.infradead.org; Wed, 21 Dec 2022 15:39:38 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 052212008C
	for <kexec@lists.infradead.org>; Wed, 21 Dec 2022 15:39:02 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 7273E940474; Wed, 21 Dec 2022 16:39:01 +0100 (CET)
Date: Wed, 21 Dec 2022 16:39:01 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.26
Message-ID: <Y6MoldRJyzh3g4P0@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_073936_547514_1A517145 
X-CRM114-Status: UNSURE (   6.83  )
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

Hi all,

I am happy to announce the release of kexec-tools 2.0.26.

This is a feature release coinciding with the release of v6.1
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.26.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.25:

ae1bd3dde601 kexec-tools 2.0.26
ffb186b83420 kexec-tools 2.0.26-rc1
b9de05184816 m68k: pass rng seed via BI_RNG_SEED
b0381b817910 workflow: update to checkout@v3
834be38cc044 LoongArch: Remove redundant cmdline parameters when using --reuse-cmdline option
84138f41efd5 LoongArch: Add purgatory framework code
615b6757dcab LoongArch: PE format image loading support
1c8bf2dc0127 LoongArch: Add kexec/kdump support
dceb1d8926e6 config: Add LoongArch architecture support in config.guess and config.sub files
6b6187f546f0 ppc64: remove rma_top limit
bc38df5e8e24 kexec-tools 2.0.25.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
