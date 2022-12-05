Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550B9C47089
	for <kexec@archiver.kernel.org>; Mon,  5 Dec 2022 22:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Mt6t3/Kb7b7zJC1DrKGOsrqmp/VMWfr/EeBY40f3Pc=; b=mrDSEjIvLv+cfU
	kvvDBXt5J+uqWbtLDLqMGJeOKuHponjMOfeMSbLfRMtVeXH0v8C1ptGSRZM2zBAczV9QgFYZVprz0
	kw2QgE8RIIC26EvKzmYUiR/DRgXT0balktZtW0rRWUDRTruLS9HHQIfEzIJFaI5Jn2YR7guaf5JMi
	YScI1rGNZyai4zO0PsBA0QVqNO30nDUWDxOOI42PU7WmyTVkjt/fdJfYQuzrUfDPZHi3rkRy1j4ix
	vcf8F3RsZayf4ifP7xGLM2ev3SoN+d6ZSl5eHOv4BIHpJzVINN3eIjPLV/QFRNthvScsh9suseIj0
	0Y93RzuIGGW0mjpxO8ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2K8M-00BOld-A1; Mon, 05 Dec 2022 22:40:22 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2K8I-00BOhj-Su; Mon, 05 Dec 2022 22:40:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AB5BAB8159E;
	Mon,  5 Dec 2022 22:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 628D0C433D7;
	Mon,  5 Dec 2022 22:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670280015;
	bh=GJt2tQnd1Xeds2lIE0ThsvUpUJvK+iSYvNujEq1ftUg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ULBvvhhRvzK9LCZR4X9G0JzAec6adclarvUv/8MLd/rjJzfztFmatqkSoyCgJRuGL
	 SIi2UK/GRQW9t8WokcK0Wbd/p6AR/cWPn6gAJ/y/7DH3i/mgoJrCHkjRFzYxmKmB/w
	 urjm3vyEWuL0YxU22XjqgwZ8BQwiq1LLYpB0BAj8JCNtD+BFmfnv0vxsBtBH3k1HIz
	 f827gvGp4Ryr9gJcPyQCW1UTXJKG8feJj92SF3hbOXoKgJqyhKEVUa7oI7DaSEKDPS
	 UZrryZGmvAdqq1qEpKzICkzKLZHie3ShizgtkK5hXETBgPIi2e3XdkbiekmcQtO78A
	 pH653pZlFQXyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47B59C395E5;
	Mon,  5 Dec 2022 22:40:15 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] RISC-V: kexec: Fix memory leak of fdt buffer
From: patchwork-bot+linux-riscv@kernel.org
Message-Id:  <167028001528.27830.840137402099225328.git-patchwork-notify@kernel.org>
Date: Mon, 05 Dec 2022 22:40:15 +0000
References: <20221104095658.141222-1-lihuafei1@huawei.com>
In-Reply-To: <20221104095658.141222-1-lihuafei1@huawei.com>
To: Li Huafei <lihuafei1@huawei.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, lizhengyu3@huawei.com,
 liaochang1@huawei.com, u.kleine-koenig@pengutronix.de, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_144019_087739_C6C908FA 
X-CRM114-Status: UNSURE (   8.45  )
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

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 4 Nov 2022 17:56:57 +0800 you wrote:
> This is reported by kmemleak detector:
> 
> unreferenced object 0xff60000082864000 (size 9588):
>   comm "kexec", pid 146, jiffies 4294900634 (age 64.788s)
>   hex dump (first 32 bytes):
>     d0 0d fe ed 00 00 12 ed 00 00 00 48 00 00 11 40  ...........H...@
>     00 00 00 28 00 00 00 11 00 00 00 02 00 00 00 00  ...(............
>   backtrace:
>     [<00000000f95b17c4>] kmemleak_alloc+0x34/0x3e
>     [<00000000b9ec8e3e>] kmalloc_order+0x9c/0xc4
>     [<00000000a95cf02e>] kmalloc_order_trace+0x34/0xb6
>     [<00000000f01e68b4>] __kmalloc+0x5c2/0x62a
>     [<000000002bd497b2>] kvmalloc_node+0x66/0xd6
>     [<00000000906542fa>] of_kexec_alloc_and_setup_fdt+0xa6/0x6ea
>     [<00000000e1166bde>] elf_kexec_load+0x206/0x4ec
>     [<0000000036548e09>] kexec_image_load_default+0x40/0x4c
>     [<0000000079fbe1b4>] sys_kexec_file_load+0x1c4/0x322
>     [<0000000040c62c03>] ret_from_syscall+0x0/0x2
> 
> [...]

Here is the summary with links:
  - [1/2] RISC-V: kexec: Fix memory leak of fdt buffer
    https://git.kernel.org/riscv/c/96df59b1ae23
  - [2/2] RISC-V: kexec: Fix memory leak of elf header buffer
    https://git.kernel.org/riscv/c/cbc32023ddbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
