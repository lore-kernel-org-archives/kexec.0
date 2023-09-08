Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678EBEEB56E
	for <kexec@archiver.kernel.org>; Fri,  8 Sep 2023 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dysftZV/vaPSa0MokonV74GjDWC6V3Hmx5fe70wo+KM=; b=vgHyymtf16jZQX
	nwjiz25f34cuFhCu7E4OlyO9/vh33GIRjIK4cxRhHG4IveJ+JAgzZhDpoN1bmjARvL5fsl6nTgQZ+
	qORStkeXpIxYeX9XDI0f6omowYUOVi/r8ah2ka9dXBfykE6+VcSKrw5w/nxS6CtSnCaTOzpDCWXJ0
	8jRAHGl9mW4oeKTB6/pSPX9t2rcwX4BAKCsnq5ybAEo3fTENgKMPFySxpvx7yByU6LLcycd71dvZ6
	PKpYuly/Oh0YxWQSBAi66Bizo3Tt/EDLYNL0ijtQwZuIs+okr2lJGxjaIegbnf5pm4ghnTL1yIhrb
	8bI2Bhqx7+8c9PBYrOgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qekS9-00Eecu-1G;
	Fri, 08 Sep 2023 22:59:53 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qekS6-00Eeab-2Z
	for kexec@lists.infradead.org;
	Fri, 08 Sep 2023 22:59:52 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf55a81eeaso19894605ad.0
        for <kexec@lists.infradead.org>; Fri, 08 Sep 2023 15:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694213982; x=1694818782; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETim7bqC4c0aI+Gj1+8OKYYdNlAwl+LsLJgDB3GOPU0=;
        b=oacUoP1cw8ZLmWjc0AwRiZVr+CzVVC1NO+OZ7Q7Kxg8G22ag34roCN9A8+JSL83mRc
         rIuNcfO0KkZT/1IXbQJfWUdTLt8ho5ameZGU8tUohJX8a2ZfEzDYLp9rTsVdwf0+RPEC
         JhUFzLpZPlD02+cRMaDoIf69ilwSvy3VKP3Z7aV2LsGopL1Z2ZS9DD6tnx69qtgcMU4p
         19XrryRXhq3rx6NLmyRmYp8YljHga5xKIqLaWu5M0qirmjBfOOO7FGbvWkL2wtr4pEoc
         mEnqkOzCDPr8ahDKy284aJOVtgNen+P8hVEXGVrnU+7VF1/tj94rozJywGPoJIHxPJwa
         mS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694213982; x=1694818782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ETim7bqC4c0aI+Gj1+8OKYYdNlAwl+LsLJgDB3GOPU0=;
        b=izhe6bhDOTvUBP4zJr/Fpa52io216WS5nQ6TwvxZ1Dzt0HzDtYqCotHx2WNqHVbBq7
         EMvX5IiTHdW/sCmy5gl9eq+L1znoRNOthE8JffK8+fn8YyYsJqyN3vgV+Bwx2lsH0Mas
         ZxFjYyr8jSCE6+TEpfJ4cXSp8wrx6Yvt0lNuNMD1vUXhHJNFKVrQVB0OpZI85mAy/2ww
         VgAL3GeaqUNPVYWUN063R0e0U8UZjEG0f92nbyQMsJnCr3OhhgF7JgMNIsKrW8bREjg7
         bWZTm407F7fo/5bupS28DWpCfAFjkxhjKsYUd/SIe+cLahUW5DHEfLaSzom8Y448issf
         XSTw==
X-Gm-Message-State: AOJu0Yxyip4zLJ6yhFCQfTNZTH/ss0+TXGTWDlzxkIfp/PijJqOU1IVy
	VUbDhtYm7I44UYB+ydUakcktPg==
X-Google-Smtp-Source: AGHT+IHrseoLZKz9f+X23SUo9lh+9srjRT/B0C9SNO5Kl8Ketugg/YTE6oE1r1EnvshvFys7O6MlqQ==
X-Received: by 2002:a17:902:834c:b0:1c0:a417:ccb2 with SMTP id z12-20020a170902834c00b001c0a417ccb2mr3011165pln.35.1694213982229;
        Fri, 08 Sep 2023 15:59:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:d39f:a985:2060:eedd])
        by smtp.gmail.com with ESMTPSA id y12-20020a1709027c8c00b001ba066c589dsm2060747pll.137.2023.09.08.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 15:59:41 -0700 (PDT)
Date: Fri, 8 Sep 2023 15:59:36 -0700
From: Nick Desaulniers <ndesaulniers@google.com>
To: Song Liu <song@kernel.org>
Cc: linux-kernel@vger.kernel.org, songliubraving@fb.com,
	Ricardo Ribalda <ribalda@chromium.org>, kexec@lists.infradead.org,
	x86@kernel.org, samitolvanen@google.com, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/purgatory: Remove LTO flags
Message-ID: <ZPunWKU/TlrN9xiH@google.com>
References: <20230908225353.984169-1-song@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230908225353.984169-1-song@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_155950_834421_2F4CF0FC 
X-CRM114-Status: GOOD (  18.59  )
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

On Fri, Sep 08, 2023 at 03:53:53PM -0700, Song Liu wrote:
> With LTO enabled, ld.lld generates multiple .text sections for
> purgatory.ro:
> 
> $ readelf -S purgatory.ro  | grep " .text"
>   [ 1] .text             PROGBITS         0000000000000000  00000040
>   [ 7] .text.purgatory   PROGBITS         0000000000000000  000020e0
>   [ 9] .text.warn        PROGBITS         0000000000000000  000021c0
>   [13] .text.sha256_upda PROGBITS         0000000000000000  000022f0
>   [15] .text.sha224_upda PROGBITS         0000000000000000  00002be0
>   [17] .text.sha256_fina PROGBITS         0000000000000000  00002bf0
>   [19] .text.sha224_fina PROGBITS         0000000000000000  00002cc0
> 
> This cause WARNING from kexec_purgatory_setup_sechdrs():
> 
> WARNING: CPU: 26 PID: 110894 at kernel/kexec_file.c:919
> kexec_load_purgatory+0x37f/0x390
> 
> Fix this by disabling LTO for purgatory.
> 
> Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
> Cc: Ricardo Ribalda <ribalda@chromium.org>
> Cc: kexec@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: x86@kernel.org
> Signed-off-by: Song Liu <song@kernel.org>
> 
> ---
> AFAICT, x86 is the only arch that supports LTO and purgatory.
> ---
>  arch/x86/purgatory/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index c2a29be35c01..9c0bff4992ea 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -19,6 +19,10 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS -D__NO_FORTIFY
>  # optimization flags.
>  KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
>  
> +# When LTO is enabled, llvm emits many text sections, which is not supported
> +# by kexec. Remove -flto=* flags.
> +KBUILD_CFLAGS := $(filter-out -flto=%,$(KBUILD_CFLAGS))

Thanks for the patch!

Please prefer something akin to:
commit 6e20f18579c5 ("efi/libstub: disable LTO")

Please also CC Sami and llvm@lists.linux.dev for v2.

Pretty sure we use a linker script to rejoin .text.* elsewhere in the
kernel, but it doesn't look like x86 purgatory has one.

> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
>  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib
> -- 
> 2.34.1
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
