Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81143C43334
	for <kexec@archiver.kernel.org>; Tue, 19 Jul 2022 12:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uOXMghdH5omLuee8jVTXDjdyjgvhBeKQteLeIXwIk+c=; b=IPN/aWdfCAfDvp
	mE+Xu6VUwkMqISwkPdAMDR48EvkAS1kGM/9CMPiVmJYU/D+saJP4Aqq9C2k7T4OkKgAtw5X7dqWqI
	GbM2k+9E4odcWP2w/O6fcOUjGzt8qoMh7GfPwP2Z6dQVHF+B5Lk9O+MLAPYuXoth+9K6eO8J2csvh
	3Q84nI1zN2d5qtSSqr8Hj1i6TeOnt85yR2RHBBOa5ZrjN3S8MmAtouey+rESLC4vHiOOIpby/oBn+
	8jk8+aOOMQFrx34UJb94hnB3fEMeEzLglM4wPcKhWYq4AoHs++asHT5BZDVSWxZ0Ezzpi0xZ8cDD8
	VdipZk/Nxs/MnJxKu94g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmWq-008lCm-D5; Tue, 19 Jul 2022 12:40:44 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDmWn-008lC0-1a
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 12:40:42 +0000
Received: from momiji.horms.nl (2a02-a46e-7b6b-703-d63d-7eff-fe99-ac9d.fixed6.kpn.net [IPv6:2a02:a46e:7b6b:703:d63d:7eff:fe99:ac9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 92A2F20087
	for <kexec@lists.infradead.org>; Tue, 19 Jul 2022 12:40:09 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 26A05940218; Tue, 19 Jul 2022 14:40:09 +0200 (CEST)
Date: Tue, 19 Jul 2022 14:40:08 +0200
From: Simon Horman <horms@verge.net.au>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.25-rc1
Message-ID: <YtamKFJOeyYxE7xE@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_054041_245685_68DF86B7 
X-CRM114-Status: UNSURE (   9.69  )
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

I am happy to announce the release of kexec-tools 2.0.25-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.25
in a weeks time. Testing of 2.0.25-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.25 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.25 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.25-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.24 are:

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
