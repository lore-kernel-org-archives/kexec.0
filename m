Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0C0C43334
	for <kexec@archiver.kernel.org>; Sun, 26 Jun 2022 07:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KZYqaAqSmHX2pOrFPjroCNCcSgSp+4YiC1EmNh9xSE8=; b=bz3wtugLHR81hK
	4Tzo+AEHmp0JbzXOmPNzWAHr9AQwcK+/TUMbhkZlSINGpJie5cUvDqFlSXygA/Gdt86vtHJmL3Ql/
	zWYqBqf882XkxdtfzMRi7eSTPs8DLT07hKfNIimR8iR3qrun/ASlzOAf6iFRwYUAX+jdVORELcA8Q
	/5eabWO5XnxWok5pIQsr6XAqsmkx280al8+Y6datY/YaQAWjTwfsKse5pjjUnhIr3QrdZLEEBERUw
	T/kneEVeeMteMW5Jbm16tIH9MV8+LoxzlcCuBsN1Ogn51cHElxRaqWBuGFMXNavubO9gsSHQlTItD
	vXqptx5CZDh2pSmU5L6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Mcm-00AMM4-Os; Sun, 26 Jun 2022 07:24:04 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5Mcj-00AMIe-K9
	for kexec@lists.infradead.org; Sun, 26 Jun 2022 07:24:03 +0000
Received: from madeliefje.horms.nl (2a02-a44a-2918-403-201-8eff-fe22-8fea.fixed6.kpn.net [IPv6:2a02:a44a:2918:403:201:8eff:fe22:8fea])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 00641205D8;
	Sun, 26 Jun 2022 07:23:19 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 911ED3AC2; Sun, 26 Jun 2022 09:23:19 +0200 (CEST)
Date: Sun, 26 Jun 2022 09:23:19 +0200
From: Simon Horman <horms@kernel.org>
To: Hui Li <lihui@loongson.cn>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v6] kexec-tools: mips: Pass initrd parameter via cmdline
Message-ID: <YrgJZ/vcgL+WzN+X@vergenet.net>
References: <20220625024949.4274-1-lihui@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220625024949.4274-1-lihui@loongson.cn>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_002401_841258_EE738EA7 
X-CRM114-Status: GOOD (  14.51  )
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

On Sat, Jun 25, 2022 at 10:49:49AM +0800, Hui Li wrote:
> Under loongson platform, use command:
> kexec -l vmlinux... --append="root=UUID=28e1..." --initrd=...
> kexec -e
> quick restart failed like this:
> 
> ********************************************************************
> [    3.420791] VFS: Cannot open root device "UUID=6462a8a4-02fb-49..."
> [    3.431262] Please append a correct "root=" boot option; ...
> ...
> ...
> ...
> [    3.543175]   0801         4194304 sda1 554e69cc-01
> [    3.543175]
> [    3.549494]   0802        62914560 sda2 554e69cc-02
> [    3.549495]
> [    3.555818]   0803         8388608 sda3 554e69cc-03
> [    3.555819]
> [    3.562139]   0804       174553229 sda4 554e69cc-04
> [    3.562139]
> [    3.568463] 0b00         1048575 sr0
> [    3.568464]  driver: sr
> [    3.574524] Kernel panic - not syncing: VFS: Unable to mount root fs...
> [    3.582750] ---[ end Kernel panic - not syncing: VFS:...
> *******************************************************************
> 
> The kernel cannot parse the UUID, the UUID is parsed in the initrd.
> For compatibility with previous platforms, loongson platform obtain
> initrd parameter through cmdline in kernel, the kernel supports use
> cmdline to parse initrd. But under the mips architecture, kexec-tools
> pass the initrd through DTB.
> 
> Made the following modifications:
> 
> (1) in kexec/arch/mips/kexec-elf-mips.c
>     Add patch_initrd_info(), at runtime to distinguish different cpu,
>     only for loongson cpu, add initrd parameter to cmdline.
> 
> (2) in kexec/arch/mips/crashdump-mips.c
>     Because loongson uses a different page_offset, it should be modified
>     to ensure that crashdump functionality is correct and reliable.
> 
> (3) in kexec/arch/mips/crashdump-mips.h
>     Added platform-specific page_offset macro definition.
> 
> Signed-off-by: Hui Li <lihui@loongson.cn>

Thanks for addressing all my review comments.
I have applied this patch for inclusion in the next release
of kexec-tools.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
