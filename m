Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737DBC4321E
	for <kexec@archiver.kernel.org>; Wed, 30 Nov 2022 08:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hL7s1yj2GKEcQRpMgsdLa5x6bu6L+4ZdqPJEa2Imyxw=; b=Y67NC+JmKt+4Ze
	uaSow8nMK/u8w1NOLF5/lyx9UCjWkj9nALGFJ4Cv3EDdzkDXIWY6/Y/BNFkHVXPE5/Z+xXKsTHrKM
	ZGfPQO6E4EtUyyliPRDPkSzt3bJ2YSxVooecTaLlhGhA5TJoiLdb0+9QOWCDcUEnRux2X+ICDU62d
	MDhLJIH7SF/zI+GEvzaNRoXY0WyQ/Li8+cv2CwTFO1L/4NH/Sq4e8yFdMlW6/HviB6CMy77+aynaV
	yRLBjHFpo5HRwP/Q6CtHdQZixfzCKgHhtFfPbvZv0Ko/Utc71bG3IbW0HS1vRn3CshBCgQ+qq0UxM
	NkvXKDRDh6VOPB5V/r+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0I0u-00EKon-9q; Wed, 30 Nov 2022 08:00:16 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0I0n-00EKjk-6I
	for kexec@lists.infradead.org; Wed, 30 Nov 2022 08:00:11 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id E636C2000E
	for <kexec@lists.infradead.org>; Wed, 30 Nov 2022 08:00:00 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 276F29402EB; Wed, 30 Nov 2022 09:00:00 +0100 (CET)
Date: Wed, 30 Nov 2022 09:00:00 +0100
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.26 preparation
Message-ID: <Y4cNgEYQeFd8Ya9z@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.7 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_000009_498672_E129494D 
X-CRM114-Status: UNSURE (   7.65  )
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

I am planning to release kexec-tools v2.0.26 in the next two weeks
to roughly coincide with the release of the v6.1 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.26 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.25 are as follows.

Thanks to everyone who has contributed to kexec-tools!

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
