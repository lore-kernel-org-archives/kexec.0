Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388CDC71153
	for <kexec@archiver.kernel.org>; Mon, 28 Aug 2023 08:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9Apvl+spJ07FAtCPNh7hPyKdxThvfuqweUn+VxwIHH4=; b=lot9p46xiiSIts
	OfwaSggSHhoBxiBhzCygPvhsZ2/v9OIbIYKHcdv9ivfNd0YRUYZNUNQfVd/ZnHg13fwxFM2hzIG/A
	qK5eBOWhiHyF907DQk8t08fSRXvABdaSCXSqgE1EOvRVGF4QGWEP1Aq9aHvJIxC2CmfcKhbhQguVE
	uM28+GVP91oNkGrmR8ml4RuXDzrl26nJkRNV/k79a51FrXDLyYOBc7rVDmWh/eVUk+F8hdaAjiOIM
	5Ym0jjz9z2o8MNsEdzrnnBgLzawPd4YgM6ifIi/bS1Rm/dYxQzNhfSJImztBRzcsEtU6/n3VgULtq
	2XxAEvJOKNHOgnmBEEog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaXBD-0096Hj-0p;
	Mon, 28 Aug 2023 08:00:59 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaXBA-0096HN-29
	for kexec@lists.infradead.org;
	Mon, 28 Aug 2023 08:00:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 213FC6146B
	for <kexec@lists.infradead.org>; Mon, 28 Aug 2023 08:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E605C433C7
	for <kexec@lists.infradead.org>; Mon, 28 Aug 2023 08:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693209655;
	bh=l4Sl4ERA1GrRFVfeE3lMDScVsV/u0VrsyV0C0MV2JnQ=;
	h=Date:From:To:Subject:From;
	b=uu1BABlmVRoaiV7Ion3tRxr9KEf1aMdU9PCtDsIHDCl79wL81Pk/IkXOTC2Mx6TWD
	 zW+GhnQ0WDU4+MW9eJdv7OQtm9/X2vZJhomoQ6mk6twUuI29li6/DaRHS/0FyGUqkc
	 6pfl6I5NYkaG7aXIVQ6NjEvIqVQAyRi5zeaR+sJ5PtlaicObU7b/SCGDXK6InfVKMj
	 c/MtytTFR8tu6F0w1iPrVKUj0V0c7l8Mmrzki+10vMYZEuBsPLb7sAWs/I/jXqviql
	 ICe7z56sz+J5S4ws0d0JaPp3UQFJ0upttANOx7am0mlKfLplR858JS0ttwq0xzTQQp
	 MXM8EEM479vtQ==
Date: Mon, 28 Aug 2023 10:00:51 +0200
From: Simon Horman <horms@kernel.org>
To: kexec@lists.infradead.org
Subject: [ANNOUNCE] kexec-tools 2.0.27
Message-ID: <20230828080051.GA3806727@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_010056_747427_5BD20D4C 
X-CRM114-Status: UNSURE (   8.13  )
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

I am happy to announce the release of kexec-tools 2.0.27.

This is a feature release coinciding with the release of v6.5
of the Linux Kernel.

This release can be downloaded from kernel.org:

	http://kernel.org/pub/linux/utils/kernel/kexec/kexec-tools-2.0.27.tar.xz
	http://kernel.org/pub/linux/utils/kernel/kexec/

It is also tagged it in git:

	git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

Thanks to everyone who has contributed to kexec!

Commits since v2.0.26:

17590eedff6d kexec-tools 2.0.27
777ca453ca69 kexec-tools 2.0.27-rc1
f67c4146d7b5 arm64: Hook up the ZBOOT support as vmlinuz
fc7b83bdf734 arm64: Add ZBOOT PE containing compressed image support
f41c4182b0c4 kexec/zboot: Add arch independent zboot support
1572b91da7c4 kexec: Introduce a member kernel_fd in kexec_info
714fa11590fe kexec/arm64: Simplify the code for zImage
a8de94e5f033 LoongArch: kdump: Set up kernel image segment
4203eaccfa92 kexec: __NR_kexec_file_load is set to undefined on LoongArch
63e9a012112e ppc64: Add elf-ppc64 file types/options and an arch specific flag to man page
806711fca9e9 x86: add devicetree support
29fe5067ed07 kexec: make -a the default
e63fefd4fc35 ppc64: add --reuse-cmdline parameter support
8fc55927f700 kexec-tools 2.0.26.git

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
