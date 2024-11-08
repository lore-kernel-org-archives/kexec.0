Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49FBD5E145
	for <kexec@archiver.kernel.org>; Fri,  8 Nov 2024 08:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=4Q3fgUe+1Hkwuy5m3k+92ccRFUzqZX9o3p+sig4Fapc=; b=aJwr7g/fkwMYRt
	0hlL+iXbxStBskvE6pFWuZhPpwlv4kDPOqVhAfa/TsC+8AtAt4cZ6bUpzuxyltT3iFibm3AXbRHZu
	fjW3eb7sI5yHlzdFFjckKkoJzLDnrpLj6T6tjkwtgGj19wITRd7UBnRHxNai4RU53nMvcmNEG60Ix
	gE9r3Q+hDWmp3hnJlu8sQB3wrGKtxs8Mi3gN7MJxV3KdI9sSVH9KNw4IeuotmzdLtkyP3ExbNvCUo
	Q8iUMKud5M/bFJYiBxdoEmA4w/Z0KH5V6jO6agKgvgYMHwaKQr1qpIudcgDuodKalSpH4IuzMOTP+
	HTd9BaYiHINWpVOnL0WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9JzW-00000009iHF-23Yd;
	Fri, 08 Nov 2024 08:05:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9JzL-00000009iFv-49yh
	for kexec@lists.infradead.org;
	Fri, 08 Nov 2024 08:05:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 60EDEA450E6
	for <kexec@lists.infradead.org>; Fri,  8 Nov 2024 08:03:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B71C4CECE
	for <kexec@lists.infradead.org>; Fri,  8 Nov 2024 08:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731053102;
	bh=R2YbGsbMY1hd3FaCpWoSl3Wb6pOH1RHNnpiBkyVQD94=;
	h=Date:From:To:Subject:From;
	b=f3yh+cmOKHpnrpBfCmHSOK+zbbc/rLnC8/G7PlV2sZUBid8qYXnBYqMt6mZP2/njo
	 ovyCyW5yKPpjdUpIXr+pJKnyPwIyLw/bE98OhffMkJD/clfhjFL1SZKHAK3kgHS6sx
	 XIdlqUCJ8ag12wV0jOzej0bGTRDORrURoEn2+SU9mlG6NcmbsfNig80x1n4GOixyBS
	 SGu+rMIWhL7FmqEdWpPrpcyz8m65K9IwcWEzY/eOdUtQ7dapCDwShZ89VociX9smXe
	 lPsO7kXMPS3aAU/Fz049q8pYTAbaCQq0dO8txA7zqC/VBykM0+AfInTk/bgna00zvX
	 Gs5W5NCgl2Elg==
Date: Fri, 8 Nov 2024 08:05:00 +0000
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools v2.0.30 preparation
Message-ID: <20241108080500.GY4507@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_000504_123361_E2434FC3 
X-CRM114-Status: UNSURE (   7.14  )
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

I am planning to release kexec-tools v2.0.30 in the next two weeks
to roughly coincide with the release of the v6.12 kernel.

I would like to ask interested parties to send any patches they would like
included in v2.0.30 within one week so they can be considered for inclusion
in an rc release.

For reference the patches queued up since v2.0.29 are as follows.

Thanks to everyone who has contributed to kexec-tools!

ec3e4dfeec22 kexec: x86: Use init_size in 32-bit case as well
fb9302eb9bc8 Fix fd leakage in uki_image_probe()
13e0a9327a42 Before adding to usablemem_rgns, check if the memory range is already included.
cd360f9f1aac arm64: Support UKI image format
0c72c4426ff5 kexec: Introduce UKI image parser
14fde160b906 kexec: Introduce implicit_initrd_fd to pass internal initrd information
ba1ad3017946 build: Update configure.ac to follow the changes
d2f42971661b util_lib/elf_info: Fix format specifiers for fprintf()
07821da7cf96 kexec: i386: Fix format specifiers for various printf() and scanf()
8767f1e1b25e kexec: i386: Fix 32-bit right shifts on 32-bit architectures
5b76649e0c23 s390: add missing limits.h header inclusion
8dd984687b79 kexec-tools 2.0.29.git


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
