Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42F5C00140
	for <kexec@archiver.kernel.org>; Sun, 31 Jul 2022 06:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lHDkxB9dpnQc6lJDiCAvqEe1doNQaBVORbu5JMLC2OM=; b=YVJsbXNPB5GsJ4
	47I7uiqDdtN+BFzwSCmzWLPWcdKzCWEt5q1Hu7MPWMr90pEMu+hBqvYCBS+X1qk9VqtSzcGTy1LCx
	t2evir4msVRcSfOvyrHn44jOJ8ZypJHm5OpzrkU1oYLvGAStB/tD0P8kEC3J78z9+G36vhSsqOLQF
	Vu15lUTBHu/mDQdUCwStHtkIhsC++PvQ+sMdfdttOuiC3jWsloMndG2Pd2oXbkYI8ay5UZOud6yeJ
	Kj/D34FWAD69iHuhn2VMDvqfD7EkECUddn3OJezNPzJ9/97fTnZMopap5vJs2jGa9+pp/VfWN4ObK
	UQWGRK+shIWcQjZwD7tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oI2lj-009402-H7; Sun, 31 Jul 2022 06:49:43 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oI2lg-0093ug-KU
	for kexec@lists.infradead.org; Sun, 31 Jul 2022 06:49:42 +0000
Received: from madeliefje.horms.nl (unknown [31.124.144.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id F2FE720007
	for <kexec@lists.infradead.org>; Sun, 31 Jul 2022 06:48:59 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 83FD53B50; Sun, 31 Jul 2022 07:48:59 +0100 (BST)
Date: Sun, 31 Jul 2022 07:48:59 +0100
From: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.25
Message-ID: <YuYl22cyGldQQc5m@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220730_234940_863994_FBAA44D6 
X-CRM114-Status: UNSURE (   7.19  )
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

I am happy to announce the release of kexec-tools 2.0.25.

This is a feature release coinciding with the release of v5.19
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.25.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.24:

0fded956184b kexec-tools 2.0.25
bfab31851465 kexec-tools 2.0.25-rc1
c3950959f428 kexec-tools: Remove duplicate ultoa() definitions and redefine it
6cd3e94813f7 i386: pass rng seed via setup_data
db26ac7f6a9c kexec-tools: mips: Pass initrd parameter via cmdline
1b87ea9ccaf0 arm64/crashdump-arm64: increase CRASH_MAX_MEMORY_RANGES to 32k
2ddfaf31fa83 kexec-tools 2.0.23.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
