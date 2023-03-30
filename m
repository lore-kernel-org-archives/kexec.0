Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3927AC6FD1D
	for <kexec@archiver.kernel.org>; Thu, 30 Mar 2023 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VH1b0BxftrZzgKw8qKCgCkTDViWWXK4ebIqHBJRXwp8=; b=FpeS27pOnj3rU0
	rxfRrSODdnydMezPJXoPm2Gw3SjAMAROMRujvoms42DClpGcxP4ji3wLr3JxXsib3WgL3ygf5VMNh
	2k2vf0De2swQz+NLYqGypwJudd6sS/4ih9LFwN07x3yrRmM+tJdB/Ay3xIUw8+ZOyHT0SsXXt9QN7
	HnTy3LPvvF+xPTlZEEeAdgbMtLlXvoZM4C5E0frYGne/RcbFCNxaCNZZLtcljB+6oAY/4cp8caFYG
	6YZpljUuhpjWiUa3faw7tiB+CJSabkipL0+hgLtUFb2Md2Rd590NeiTbj96mDe8r54voB3UjAwoEi
	4okdnGriy/+0magA77xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phu00-004COE-2c;
	Thu, 30 Mar 2023 15:15:36 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phtzs-004CMD-2l
	for kexec@lists.infradead.org;
	Thu, 30 Mar 2023 15:15:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 84ECCB828BE;
	Thu, 30 Mar 2023 15:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12418C433EF;
	Thu, 30 Mar 2023 15:15:24 +0000 (UTC)
Date: Thu, 30 Mar 2023 11:15:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
 Philipp Rudo <prudo@redhat.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>, Simon
 Horman <horms@kernel.org>, "x86@kernel.org" <x86@kernel.org>, Borislav
 Petkov <bp@alien8.de>
Subject: Re: [PATCH v5 2/2] x86/purgatory: Add linker script
Message-ID: <20230330111523.4b98c8ce@gandalf.local.home>
In-Reply-To: <20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
References: <20230321-kexec_clang16-v5-0-5563bf7c4173@chromium.org>
	<20230321-kexec_clang16-v5-2-5563bf7c4173@chromium.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_081529_177301_35F3D1C0 
X-CRM114-Status: GOOD (  23.88  )
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


Hmm, this patch may need some more eyes. At least from the x86 maintainers.

-- Steve


On Thu, 30 Mar 2023 11:44:48 +0200
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Make sure that the .text section is not divided in multiple overlapping
> sections. This is not supported by kexec_file.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  arch/x86/purgatory/.gitignore        |  2 ++
>  arch/x86/purgatory/Makefile          | 20 +++++++++----
>  arch/x86/purgatory/kexec-purgatory.S |  2 +-
>  arch/x86/purgatory/purgatory.lds.S   | 57 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 74 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/purgatory/.gitignore b/arch/x86/purgatory/.gitignore
> index d2be1500671d..1fe71fe5945d 100644
> --- a/arch/x86/purgatory/.gitignore
> +++ b/arch/x86/purgatory/.gitignore
> @@ -1 +1,3 @@
>  purgatory.chk
> +purgatory.lds
> +purgatory
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index 17f09dc26381..4dc96d409bec 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -16,10 +16,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>  
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
> -PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> -LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
> -LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
> -targets += purgatory.ro purgatory.chk
> +PURGATORY_LDFLAGS := -nostdlib -z nodefaultlib
> +LDFLAGS_purgatory := -r $(PURGATORY_LDFLAGS) -T
> +LDFLAGS_purgatory.chk := -e purgatory_start $(PURGATORY_LDFLAGS)
> +
> +targets += purgatory.lds purgatory.ro purgatory.chk
>  
>  # Sanitizer, etc. runtimes are unavailable and cannot be linked here.
>  GCOV_PROFILE	:= n
> @@ -72,10 +73,17 @@ CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
>  AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
>  AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
>  
> -$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> +OBJCOPYFLAGS_purgatory.ro := -O elf64-x86-64
> +OBJCOPYFLAGS_purgatory.ro += --remove-section='*debug*'
> +OBJCOPYFLAGS_purgatory.ro += --remove-section='.comment'
> +OBJCOPYFLAGS_purgatory.ro += --remove-section='.note.*'
> +$(obj)/purgatory.ro: $(obj)/purgatory FORCE
> +		$(call if_changed,objcopy)
> +
> +$(obj)/purgatory.chk: $(obj)/purgatory FORCE
>  		$(call if_changed,ld)
>  
> -$(obj)/purgatory.chk: $(obj)/purgatory.ro FORCE
> +$(obj)/purgatory: $(obj)/purgatory.lds $(PURGATORY_OBJS) FORCE
>  		$(call if_changed,ld)
>  
>  $(obj)/kexec-purgatory.o: $(obj)/purgatory.ro $(obj)/purgatory.chk
> diff --git a/arch/x86/purgatory/kexec-purgatory.S b/arch/x86/purgatory/kexec-purgatory.S
> index 8530fe93b718..54b0d0b4dc42 100644
> --- a/arch/x86/purgatory/kexec-purgatory.S
> +++ b/arch/x86/purgatory/kexec-purgatory.S
> @@ -5,7 +5,7 @@
>  	.align	8
>  kexec_purgatory:
>  	.globl	kexec_purgatory
> -	.incbin	"arch/x86/purgatory/purgatory.ro"
> +	.incbin	"arch/x86/purgatory/purgatory"
>  .Lkexec_purgatory_end:
>  
>  	.align	8
> diff --git a/arch/x86/purgatory/purgatory.lds.S b/arch/x86/purgatory/purgatory.lds.S
> new file mode 100644
> index 000000000000..610da88aafa0
> --- /dev/null
> +++ b/arch/x86/purgatory/purgatory.lds.S
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm-generic/vmlinux.lds.h>
> +
> +OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
> +
> +#undef i386
> +
> +#include <asm/cache.h>
> +#include <asm/page_types.h>
> +
> +ENTRY(purgatory_start)
> +
> +SECTIONS
> +{
> +	. = 0;
> +	.head.text : {
> +		_head = . ;
> +		HEAD_TEXT
> +		_ehead = . ;
> +	}
> +	.rodata : {
> +		_rodata = . ;
> +		*(.rodata)	 /* read-only data */
> +		*(.rodata.*)
> +		_erodata = . ;
> +	}
> +	.text :	{
> +		_text = .; 	/* Text */
> +		*(.text)
> +		*(.text.*)
> +		*(.noinstr.text)
> +		_etext = . ;
> +	}
> +	.data :	{
> +		_data = . ;
> +		*(.data)
> +		*(.data.*)
> +		*(.bss.efistub)
> +		_edata = . ;
> +	}
> +	. = ALIGN(L1_CACHE_BYTES);
> +	.bss : {
> +		_bss = . ;
> +		*(.bss)
> +		*(.bss.*)
> +		*(COMMON)
> +		. = ALIGN(8);	/* For convenience during zeroing */
> +		_ebss = .;
> +	}
> +
> +	/* Sections to be discarded */
> +	/DISCARD/ : {
> +		*(.eh_frame)
> +		*(*__ksymtab*)
> +		*(___kcrctab*)
> +	}
> +}
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
