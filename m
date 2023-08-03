Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD2FC04FDF
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3xvNym7h6yaEiEthMchkNnyHuqiVtAhZgqqa2A32zgc=; b=uq1hwowrCvy3BC
	Lqf2LaouZp5ZeAWOueZVG4tCeg330A4icdiIdilGSERhY7EAXfINTSiQh3qrRYexNtyTcB1IeXgbm
	3lx+KYrmARRPv8cJPpzZtWBYFIZFsLuA/opF7GedFhfdqNNxEb0GKAEZ4H+uweVLNkam+dYyX8cmE
	7g8bS66bcZBQ51koR7eqRztohu9JW7xwpaLIF3fuHJrwR1PfoKdVLsVVs7+fHbNARv/YnqfTEa7q+
	Vb9t/Dd0D4nCLGodOaPHH1LVtYGP132c0QibKJYQAkfjw57ARnnowBvhxoe3Lsbmo3Sq4iOtoWRER
	U8EgYTO4Mxp+LKS04KJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZyB-00A46p-0c;
	Thu, 03 Aug 2023 15:10:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZy5-00A3zG-0A;
	Thu, 03 Aug 2023 15:10:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B01A261DF3;
	Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 142EDC433C9;
	Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691075423;
	bh=orfhoYZ+x7W/5dil2GMBX2jxw/cc0/lVW+WjnHi6yn4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=e9+0UqFR7QUmGvyWYrSJRYXSHdry8oXN4wY7ivMBfdrGKTY8TlsDzZBdNz19wEpZW
	 +I7Q82Q1JlJj9xJFxwQT1F8s+JqGgEIZgPW3OYYUkbvXFepNRLppurRqEd8+BruswS
	 CwMZLNiYGQfSyBQmQjB8hYYrJPnGOiky3pMrozZm1h6eyhOIPLamhx1I2m6f+6LTG8
	 GlToWDMqaYU2CvWz/M+Z/n8YUnIBWTDDkN5DdPPaU2Lol0bbEC3tiJ5bR54uuZCrqY
	 uc8pI/MpaHIieFY1y98/df2ynf9OWkL/ocCUwK3IfIJSXTUKKz4f59oOfIntt4rtOB
	 8oOOl6loj8iLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9DCCC595C2;
	Thu,  3 Aug 2023 15:10:22 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] RISC-V: Fix a few kexec_file_load(2) failures
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542294.19238.10753003765050685366.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 15:10:22 +0000
References: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
In-Reply-To: <cover.1690365011.git.petr.tesarik.ext@huawei.com>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, conor.dooley@microchip.com,
 lihuafei1@huawei.com, liaochang1@huawei.com, masahiroy@kernel.org,
 keescook@chromium.org, akpm@linux-foundation.org, heiko@sntech.de,
 ribalda@chromium.org, hi@alyssa.is, lizhengyu3@huawei.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, duwe@suse.de,
 roberto.sassu@huaweicloud.com, petr@tesarici.cz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_081025_155970_C8470BB3 
X-CRM114-Status: UNSURE (   9.89  )
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

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 26 Jul 2023 11:53:58 +0200 you wrote:
> From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> 
> The kexec_file_load(2) syscall does not work at least in some kernel
> builds. For details see the relevant section in this blog post:
> 
> https://sigillatum.tesarici.cz/2023-07-21-state-of-riscv64-kdump.html
> 
> [...]

Here is the summary with links:
  - [v2,1/3] riscv/kexec: handle R_RISCV_CALL_PLT relocation type
    https://git.kernel.org/riscv/c/1be0b05b3a80
  - [v2,2/3] riscv/purgatory: do not link with string.o and its dependencies
    (no matching commit)
  - [v2,3/3] riscv/kexec: load initrd high in available memory
    https://git.kernel.org/riscv/c/0ccd2e803745

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
