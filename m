Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19675E77180
	for <kexec@archiver.kernel.org>; Wed, 11 Dec 2024 23:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ryjrakl9bAirYB8Swa1Mz7aOUdVKkjHl/K2fh3pI4Ic=; b=MUMtatC75sO3ueOQkLUQnl+CUI
	aQkC4d7wcejUf21at7xMBbdQ4ChqFG+0ig0p4pOfsQ8Lgb9OEjre8pGl367qAadCIo7JH/d0dUxPD
	iSNIzHXFEPRTq92U7GkyV/35dO5bYCpEiLpoAPYMmAwNXCUqZB5QQF2kL/Sl6eBGrWg7M+ORJclJP
	gKr/uPpM775OL2xBf5EewJkCPORmV2BcrBl6Lo9DAFVolacNFMEdangeDcRV/LpqO5tol7uTE6EHV
	iakbroNKp00JYwqYl7NFGLH4WC14uA/XzQdr8QY870FaJKEbWMN2wdM5pROMM0VitQNTa0ZDGJKJF
	UbxmQ2NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLWOV-0000000GWZQ-0b2J;
	Wed, 11 Dec 2024 23:45:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLVFw-0000000GKW6-1mz2;
	Wed, 11 Dec 2024 22:32:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 820405C67EF;
	Wed, 11 Dec 2024 22:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31DDC4CED3;
	Wed, 11 Dec 2024 22:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956351;
	bh=k0MtyxDbbtsm27qvkqsKV+jrSIBDfJRGa0WHRKH9KWs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nPOtlX5TKBph2olV5g0D84w7BiGXyaTzX/kmSl/KB3xl8BPQoIcxG64kiVppaKWV6
	 UuVYIQk2nmWnJhIowxxs3i7Ezo4bFvlmC27nFpPkM/jb80vyzHBEMsDiWlhHJUBmrV
	 E4nuPLnavEZNBvgxCnxSG/erFAKypXE58/ddSXOGTSgdiPaf+RxWJKbmenqt6qmjdG
	 RpQEsDlCvg4cySX8p8aQt/+bGgUkkoqZuHIfhgpxn+qXexNXcqJewICJNI3vp9PVla
	 22tDI2SHe01OOAbfoiss8OadArWzPpX9wRC6bdennXUaIn34M8kF/jHgNGbizmzpuY
	 lZsn8ISnWGPaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEED380A965;
	Wed, 11 Dec 2024 22:32:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] of/fdt: add dt_phys arg to early_init_dt_scan and
 early_init_dt_verify
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <173395636750.1729195.6853192666319119853.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:47 +0000
References: <20241023171426.452688-1-usamaarif642@gmail.com>
In-Reply-To: <20241023171426.452688-1-usamaarif642@gmail.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-riscv@lists.infradead.org, robh@kernel.org, mark.rutland@arm.com,
 will@kernel.org, leitao@debian.org, catalin.marinas@arm.com,
 tglx@linutronix.de, chris@zankel.net, saravanak@google.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kexec@lists.infradead.org,
 loongarch@lists.linux.dev, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-openrisc@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-csky@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_143232_514575_AC832EAE 
X-CRM114-Status: GOOD (  10.69  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Rob Herring (Arm) <robh@kernel.org>:

On Wed, 23 Oct 2024 18:14:26 +0100 you wrote:
> __pa() is only intended to be used for linear map addresses and using
> it for initial_boot_params which is in fixmap for arm64 will give an
> incorrect value. Hence save the physical address when it is known at
> boot time when calling early_init_dt_scan for arm64 and use it at kexec
> time instead of converting the virtual address using __pa().
> 
> Reported-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> 
> [...]

Here is the summary with links:
  - [v2] of/fdt: add dt_phys arg to early_init_dt_scan and early_init_dt_verify
    https://git.kernel.org/riscv/c/b2473a359763

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



