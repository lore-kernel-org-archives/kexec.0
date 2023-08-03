Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807F7C001DB
	for <kexec@archiver.kernel.org>; Thu,  3 Aug 2023 15:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tiQ0vst1bLzQ9Y5Khp01htGocwOSHKzuhwTqNmkbuY0=; b=l5wkJb6/ReWjad
	euBms1pg6I5xjahnDGmF/AuWnnzUWZVucRNsH9GzU+gVlzhJfLS6kg4hkyIBqtk2xagyMVKv8P/4x
	elTSQjfoVWUqm+EmpWK/+MyeMMEnJsl8yYoCN/CYpjKDN+3ItRPB5eR/vTtxwywIfgvCudBTsVlsm
	5ELDKrNiXv+lmt+ZTwLsQUjcY+IXKGhPC6brGW3Qdx6Qq1qFnfkRSNOl+Vv3DVPr1DaSvXrWey1XV
	CDLaVSEEac2LW1tSOqyHeO6n3f0IhIQ6Yswp1oe9/qRDsPVQPDMSwnc93ZKUyBIRPbQ+gQVRDVuCT
	foWPzBSSgl6G4UCfsHew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZy9-00A44W-0k;
	Thu, 03 Aug 2023 15:10:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZy5-00A3zV-0V;
	Thu, 03 Aug 2023 15:10:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3293F61DF6;
	Thu,  3 Aug 2023 15:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 226B5C433CA;
	Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691075423;
	bh=tZJ7tXVDkdspZw9aq8GHx3NudtBiKp17JwhiNPFjWqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vE+IQSLw+4DWc8DAqB9eWzLVYCnRl49lI14R1eMMNF3ZE/PFk05i+2io8QpOkdVY3
	 Sd7UkDfcVeLZ6v3ym2r86oqnUC+htOED3yhAZbFnqy1FQdFy+w7/+Yp1SgpkdDN9N0
	 il9Eh2yPQgJKxWqdDwRHf7bY/rTI7CDRdco+bs4PNpCsfGB2rh6z0m9LV6Q1+v6vZt
	 gSMK1uaWurqRh7TmcRplXhEQ20RLbch25mwLX7k/rIQKAQinRbZO5VNc1NNjyUedyI
	 gsEWgl9YuZbrKJalAlXvO3qyKc7cCC4JrUPhye+URlYBsV4+TAagOiojQ8mCoWXyo6
	 Gr5GbX7dvGo3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A960C595D1;
	Thu,  3 Aug 2023 15:10:23 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [RESEND PATCH -fixes 1/2] riscv: Export va_kernel_pa_offset in
 vmcoreinfo
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <169107542303.19238.12982353248491606719.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 15:10:23 +0000
References: <20230724100917.309061-1-suagrfillet@gmail.com>
In-Reply-To: <20230724100917.309061-1-suagrfillet@gmail.com>
To: Song Shuai <suagrfillet@gmail.com>
Cc: linux-riscv@lists.infradead.org, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, xianting.tian@linux.alibaba.com,
 anup@brainfault.org, robh@kernel.org, ajones@ventanamicro.com,
 alexghiti@rivosinc.com, conor.dooley@microchip.com,
 kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_081025_265909_2880ACDC 
X-CRM114-Status: UNSURE (   9.00  )
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

On Mon, 24 Jul 2023 18:09:16 +0800 you wrote:
> Since RISC-V Linux v6.4, the commit 3335068f8721 ("riscv: Use
> PUD/P4D/PGD pages for the linear mapping") changes phys_ram_base
> from the physical start of the kernel to the actual start of the DRAM.
> 
> The Crash-utility's VTOP() still uses phys_ram_base and kernel_map.virt_addr
> to translate kernel virtual address, that failed the Crash with Linux v6.4 [1].
> 
> [...]

Here is the summary with links:
  - [RESEND,-fixes,1/2] riscv: Export va_kernel_pa_offset in vmcoreinfo
    https://git.kernel.org/riscv/c/fbe7d19d2b7f
  - [RESEND,-fixes,2/2] Documentation: kdump: Add va_kernel_pa_offset for RISCV64
    https://git.kernel.org/riscv/c/640c503d7dbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
