Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41DBC4345F
	for <kexec@archiver.kernel.org>; Wed, 24 Apr 2024 18:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kvo6Wc4UantQV+2xEvODb7BUPa0wiQIMiiPD7nVo+Qg=; b=k2Y0Y9pgWo5wEM
	Y9eCuyokXl5ER2lqECObxeMdBfmHmVtNfDwpug99cM6R3LiVPN4YzXtKlpbdDkuRaV+5iMPpVd0Wr
	qKm5Hhd9T8se+5jvT74tkpbJBPtchNcryxInRqWlcBSDuadifXvOx4StKDUe65ve2d3uvcY9KWKjf
	ojxP/qiPeLj0Kkh+sK0Ls1LZvj2Fml0dxlRUsJs+8E6y96gE7wZ/3G568aKYj9pM2Lnl9G0kAee1h
	YmMXqR/IdhyePFb2x+1epV0D8sWbo0jFLKL1/pnRzLyCZuSvBxlFpbpvqCyb1cs7uUW0J+rX1qOu3
	pMH26ZIgquCfqihVbpxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzhKv-00000005MY7-0e1M;
	Wed, 24 Apr 2024 18:27:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzhKr-00000005MT8-3w9m
	for kexec@lists.infradead.org;
	Wed, 24 Apr 2024 18:27:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 344A261A7E;
	Wed, 24 Apr 2024 18:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29049C2BD11;
	Wed, 24 Apr 2024 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713983221;
	bh=abPWopN//NmQWtu+Y5v3ubjHMIaG4BQbX/z10WFr8TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BPh9VQPUhow8VDzz2IDIgbDmdiO42O/vPbw96koB2+PvfRyf6roPDkl42O8oVDNN/
	 /1ANIU1PGVR/XeIMqARTcqin+FAClXOJLMTrb1ojFhzbo2+l3bNruCS0J9dGOHWU4M
	 T8pq9vFS/JHT/snVnmZb1a1wBlXgUMC0yY8j6raHYJzYyEkXqC04fCf5J4LkIsTID+
	 Xlsb4x0kdLF+A1IjCw14ZFvOlT+gtTmTQa4ZoEejcJx7pklgw3g1ZVxew5COqUtYSy
	 nMrbKwZx8SkBmTSm7RD4aQhrQUpzvmjOaJClOktaNp5rvsP73pn53v7/7MIbkyI070
	 VcCSD7/i6TL0g==
Date: Wed, 24 Apr 2024 11:26:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC PATCH 2/9] x86/purgatory: Simplify stack handling
Message-ID: <20240424182659.GA2126602@dev-arch.thelio-3990X>
References: <20240424155309.1719454-11-ardb+git@google.com>
 <20240424155309.1719454-13-ardb+git@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240424155309.1719454-13-ardb+git@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_112714_036952_17470790 
X-CRM114-Status: GOOD (  16.60  )
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

On Wed, Apr 24, 2024 at 05:53:12PM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The x86 purgatory, which does little more than verify a SHA-256 hash of
> the loaded segments, currently uses three different stacks:
> - one in .bss that is used to call the purgatory C code
> - one in .rodata that is only used to switch to an updated code segment
>   descriptor in the GDT
> - one in .data, which allows it to be prepopulated from the kexec loader
>   in theory, but this is not actually being taken advantage of.
> 
> Simplify this, by dropping the latter two stacks, as well as the loader
> logic that programs RSP.
> 
> Both the stacks in .bss and .data are 4k aligned, but 16 byte alignment
> is more than sufficient.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/include/asm/kexec.h      |  1 -
>  arch/x86/kernel/kexec-bzimage64.c |  8 --------
>  arch/x86/purgatory/entry64.S      |  8 --------
>  arch/x86/purgatory/setup-x86_64.S |  2 +-
>  arch/x86/purgatory/stack.S        | 18 ------------------

This needs a small fix up to build.

  make[6]: *** No rule to make target 'arch/x86/purgatory/stack.o', needed by 'arch/x86/purgatory/purgatory.ro'.

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index acc09799af2a..2b6b2fb033d6 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
 
-purgatory-y := purgatory.o stack.o setup-x86_$(BITS).o sha256.o entry64.o string.o
+purgatory-y := purgatory.o setup-x86_$(BITS).o sha256.o entry64.o string.o
 
 targets += $(purgatory-y)
 PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
