Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFAFC4708E
	for <kexec@archiver.kernel.org>; Wed,  7 Dec 2022 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=q4eoPKeHff40fBRl4Oz3P4DSS3IV+on84DjzrsnZsKo=; b=UQhdFnrwO8mYYQ
	lXbfuaxYAScJn4nAI2x/xRFqYyjkgczF4skQcfGE1UoJQ8STlltC7Jkn/QFFbyH6/NBInLcHxGw5N
	VVx7vXzdneLBaMHYeBHcJAS3sYKJFzsm9VtPWpbSQlkUL29pKHe9mKTyP8FTjlIa3LZPpJ3/2U2EP
	oIrUP7dxrxYG9QthsrqFurBmaXkXh41fqRNUgJXejxgXni4xmWXfFa/W2FZjA5jukkPUgBMEtHlWM
	PTk9nrs+hfuaCYate0OH9wQkJChMPz1h8c2+OAZ/QwUWK598ubB9dqBjnMX/WlBtqRAJl620LqQBm
	3DXTp2NUgY3gwj+l1K2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2w65-005da0-Fv; Wed, 07 Dec 2022 15:12:33 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2w61-005dWs-W2
	for kexec@lists.infradead.org; Wed, 07 Dec 2022 15:12:31 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id A297020199
	for <kexec@lists.infradead.org>; Wed,  7 Dec 2022 15:12:28 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 5AB019401DB; Wed,  7 Dec 2022 16:12:28 +0100 (CET)
Date: Wed, 7 Dec 2022 16:12:28 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.26-rc1
Message-ID: <Y5CtXNsfr4AQUSTy@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_071230_411015_6A4EC8CB 
X-CRM114-Status: UNSURE (   9.63  )
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

I am happy to announce the release of kexec-tools 2.0.26-rc1.

This is an incremental feature pre-release.

So long as no serious problems arise I intend to release kexec-tools 2.0.26
in a weeks time. Testing of 2.0.26-rc1 would be greatly appreciated.

I do not have any outstanding changes for 2.0.26 at this time.
And I would like to only accept bug fixes at this time and take
features patches once 2.0.26 has been released.

The pre-release can be downloaded from kernel.org:

	https://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.26-rc1.tar.xz
	https://kernel.org/pub/linux/utils/kernel/kexec/

I have also tagged it in git:

	https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec.


For reference the changes since v2.0.25 are:

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
