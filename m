Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F161CC07CB1
	for <kexec@archiver.kernel.org>; Mon, 27 Nov 2023 13:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3STqhMDuVxL0KNRiR0iY5YHc5ZpsUNhPHGue6audxDk=; b=jNB9CHK2pbHfvP
	W4kVWmZirxS3+NXpPdli1NWj8XJEHBB2ze+5ZDZ8mq5riQ02CsXtiRoLCMnls2P+gOSE+UQ3oH2HA
	zCHkcFoXei5yXyOEyuqiiLupXc0E4OU/zlN/0szvOc2UzGf+D5NUH4sFBhLZRg0Nc/oZ2Xp7gZDsw
	GqCPBf3pd4pFjtBBEWOIjhxjbjocnQ2EP50R+Pykg1uoDGJZqeCS5s1vlYC08Y7FGLGxR0bgF8Xtj
	IpNbI+mU8qGN/nZPRyVYsbcW/2wzWHrF00SYJaDarqwI1slePWexBSUAiM2OoAePEK33JK6iOSywx
	qlKGKfC2gKf5Rsnt+Paw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bwz-002bXh-2g;
	Mon, 27 Nov 2023 13:47:01 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7bww-002bWd-2x
	for kexec@lists.infradead.org;
	Mon, 27 Nov 2023 13:47:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 457CBB82DAA;
	Mon, 27 Nov 2023 13:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D38C433C9;
	Mon, 27 Nov 2023 13:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701092816;
	bh=4al8ZJG9+MwFMpowk1+6TGCBahs38okY9i82bwZfpBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Am6jM6tTO4CbEccyPCBcUQ9S0xcVGPRmIbVNOzbRwquS1B6j7j9+rfo3vuMq/X7jr
	 /5yHJZQTe1VgEW+7EV2uTA23TwN4nVcQCpsOhhWrlr/nXRHJmhwVxSPNx1KPqsRxCp
	 esNhZyatbImp2B2i6QzADbFaRMj8oIVyxdbvWPAgY0m6jSu6jOu96pu/A+hcEwwEwU
	 9IDtiacowsiaSKlk7Nez42ZlWtGzKdkUKFN0dAW7Cjrn2e5i3I/V0oA4RyFuG/qTee
	 D+Rpc7HYUtGYyniP5Xx4n0qlji8YaA8vDGxT4KFPYTHNVseK7CCzye1Ei/0LqFv99F
	 jsUvOhjYl/gvA==
Date: Mon, 27 Nov 2023 13:46:53 +0000
From: Simon Horman <horms@kernel.org>
To: WANG Rui <wangrui@loongson.cn>
Cc: kexec@lists.infradead.org, Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH] LoongArch: Load vmlinux.efi to the link address
Message-ID: <20231127134653.GC3354982@kernel.org>
References: <20231124154658.114579-1-wangrui@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231124154658.114579-1-wangrui@loongson.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_054659_098092_F5113544 
X-CRM114-Status: GOOD (  10.12  )
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

On Fri, Nov 24, 2023 at 11:46:58PM +0800, WANG Rui wrote:
> Currently, kexec loads vmlinux.efi to address 0 instead of the link
> address. This causes kexec to fail to boot the new vmlinux.efi on qemu.
> 
>   pei_loongarch_load: kernel_segment: 0000000000000000
>   pei_loongarch_load: kernel_entry:   00000000015dc000
>   pei_loongarch_load: image_size:     0000000001f30000
>   pei_loongarch_load: text_offset:    0000000000200000
>   pei_loongarch_load: phys_offset:    0000000000000000
>   pei_loongarch_load: PE format:      yes
>   loongarch_load_other_segments:333: command_line: kexec console=ttyS0,115200
>   kexec_load: entry = 0x15dc000 flags = 0x1020000
>   nr_segments = 2
>   segment[0].buf   = 0x7fffef664010
>   segment[0].bufsz = 0x1de9a00
>   segment[0].mem   = (nil)
>   segment[0].memsz = 0x1f30000
>   segment[1].buf   = 0x555555e480b0
>   segment[1].bufsz = 0x200
>   segment[1].mem   = 0x1f30000
>   segment[1].memsz = 0x4000
> 
> This patch adds `text_offset` when adding kernel segment to load
> vmlinux.efi to the link address.
> 
>   pei_loongarch_load: kernel_segment: 0000000000000000
>   pei_loongarch_load: kernel_entry:   00000000015dc000
>   pei_loongarch_load: image_size:     0000000001f30000
>   pei_loongarch_load: text_offset:    0000000000200000
>   pei_loongarch_load: phys_offset:    0000000000000000
>   pei_loongarch_load: PE format:      yes
>   loongarch_load_other_segments:335: command_line: kexec console=ttyS0,115200
>   kexec_load: entry = 0x15dc000 flags = 0x1020000
>   nr_segments = 2
>   segment[0].buf   = 0x7ffff1a04010
>   segment[0].bufsz = 0x1de9a00
>   segment[0].mem   = 0x200000
>   segment[0].memsz = 0x1f30000
>   segment[1].buf   = 0x555555b28098
>   segment[1].bufsz = 0x200
>   segment[1].mem   = 0x2130000
>   segment[1].memsz = 0x4000
> 
> Signed-off-by: WANG Rui <wangrui@loongson.cn>

Thanks, applied.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
