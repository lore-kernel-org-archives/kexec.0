Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D4AC43334
	for <kexec@archiver.kernel.org>; Thu, 14 Jul 2022 14:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WDOSPSlkz40DXHlbnF5IMHBGNs4o7QKzeZpL3tRXT8M=; b=h8U221k1muazBu
	0VqezpbyYqteDBmNOqXpLkeDTBO/9Sq+8w9nzPbIMaUPgayfbjw2pODSaEGH7fSYEjIYIScm6Vz3H
	iXDL5lgTkH6fwmYuGCAN3BP2pFqIPQLhyb/m2nhPbN651zF7gQghlmzvxTjcG77wIY7nkH04AHaKX
	ptPwNCcgNGmxPZwWXTAjrejRADsbD4H1YRwHYQdxRK0CcSilpDRcOE1PnrrpJ82BW+xEEj+AX5NFi
	lzdk2LTMHbWZG1NI1yZAH2Q3t6b/HTiuGzVw4l592Oa+dycIFS+3bKll6IFJFAHSkJPi6UDe781T6
	VqYOWQlOYp4m0aUkV/8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzvg-00FEyb-4W; Thu, 14 Jul 2022 14:35:00 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBzvd-00FEuC-Cg
	for kexec@lists.infradead.org; Thu, 14 Jul 2022 14:34:58 +0000
Received: from momiji.horms.nl (86-93-216-223.fixed.kpn.net [86.93.216.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 73A4A20087
	for <kexec@lists.infradead.org>; Thu, 14 Jul 2022 14:34:49 +0000 (UTC)
Received: by momiji.horms.nl (Postfix, from userid 7100)
	id 79E0A94014D; Thu, 14 Jul 2022 16:34:48 +0200 (CEST)
Date: Thu, 14 Jul 2022 16:34:48 +0200
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.25 preparation
Message-ID: <YtApiPU4R4sXbq8/@vergenet.net>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_073457_616020_EDD91D48 
X-CRM114-Status: UNSURE (   7.00  )
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

I am planning to release kexec-tools v2.0.25 in the next two weeks
to roughly coincide with the release of the v5.19 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.25 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.24 are as follows.

Thanks to everyone who has contributed to kexec-tools!

db26ac7f6a9c kexec-tools: mips: Pass initrd parameter via cmdline
1b87ea9ccaf0 arm64/crashdump-arm64: increase CRASH_MAX_MEMORY_RANGES to 32k
2ddfaf31fa83 kexec-tools 2.0.23.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
