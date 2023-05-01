Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3385C77B7F
	for <kexec@archiver.kernel.org>; Mon,  1 May 2023 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=oVNFqRlrV6fDQk/GSgMalOmxLuP4zEHqSzDgq/ZRBh8=; b=QuciPPnsPsr2qjSxUEy2CjomVT
	c9W47aZduYCX1WIv7Ljzjy8U7j0A0+uzKv5DItyIKv+wlBh8hEVEs6OPxYH4Se+GUZt0C+CKK5+Lg
	yin/ZC6WxeRxfKZXCz9NpVH+CkBG/lyOIoj2OTi2/DUSAH3quh++m8R5J3qfUIsJ/iWdqaHnhYe2y
	UvtnTabuRR1GpE0TVooMGJX4gjh+lpTsLc59HFRyN1NbGARdXMT6e2DomXQIYA8PQRahA2ltPSqGc
	kjcuzp97gHAZo7W/HEL0kXXWxW57gZxcBuTLWOPFp+T/cxvWAmKI1nU4aLjFY04rJXx4OJwoHz+ca
	dLx9m/Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptStO-00G1ck-2b;
	Mon, 01 May 2023 12:44:34 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptStM-00G1ay-0D
	for kexec@lists.infradead.org;
	Mon, 01 May 2023 12:44:33 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b60365f53so2933681b3a.0
        for <kexec@lists.infradead.org>; Mon, 01 May 2023 05:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682945067; x=1685537067;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+/m/Q8rJDfBtNlvA5MoeSZihLHMU+hMCap0lrbB/rs=;
        b=cwwHyIgX4KWvvBvY8nSBkLAFNRsKMYzp6WW1Di0i93YYJQgPlYiPsZZCu6Q8jvx894
         ycO1ma38TjwwxCTgtSZueTlcY4Th+uxr3S4GZBnOqQEH/2pBTsxgbr9pWx/8L3JZczbj
         MnpoznAqXqI5UK+Sm37GsXne1PqltuZm1m4Xu8tVG+/im46OIrq2m1j0tSR/GAxO8Bh4
         VdlXDlQkolJTQQTRdSXDTZdb4WP2mQUEn80kYCVF+/O11w7FZ444LzumBUmo4iRb4nVZ
         uU5vUU+SbF4ykTZ8FxZUOcJJPtSPqDIpmNPWpIGo5upiSDMbV64yvLxaou3JoJtoNA5f
         aYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682945067; x=1685537067;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+/m/Q8rJDfBtNlvA5MoeSZihLHMU+hMCap0lrbB/rs=;
        b=TPwTv9DZdoi0X88FvuD0IP2VirDDgiJtND5RkgBwDIiP3qRvmcwOM8EfgrHKYWsaoW
         3vgy4+IDUdcI1L6oPYjWpSNPjU0PmeJgUB9RTFslRT7fxolsD2xArKCpq+2rAulW1HG3
         mvjcCLgoFzg+QP/pLPqzoYZPrWIgC9cxhNL1pqX7Upcu1akw/n7Dhpf2cyaKENc4A6e9
         uQ7+mMTRS6ijQCWn1jM7zcCd7vLFWi/JHqj1qxXFqHf+ia8RjsYW8mlKtG347x6K3hHy
         U5eZzlZh1ol6lRWZhVl+YQ/FB0jfvASIg9sxd/a7Zq3DTF2gIqIman+airJBCs0LNqJw
         u/Pw==
X-Gm-Message-State: AC+VfDy0ZNAVdQGUd3UgcBy6p89tHB+o9otUb8CN7ucRmFZW1HM5qkhV
	YpSFqHW/XLf4KYiRHIEeGFhirg==
X-Google-Smtp-Source: ACHHUZ7UwoeVcV7NcPNRh+PYPFK4S9ad6FQ4bVggkB4CDQoyhbAx7EDtp4SCD00iu4lmGkebBwMNsA==
X-Received: by 2002:a05:6a20:6f03:b0:f8:b39b:b24e with SMTP id gt3-20020a056a206f0300b000f8b39bb24emr14578405pzb.11.1682945067231;
        Mon, 01 May 2023 05:44:27 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v17-20020a62c311000000b005a8bf239f5csm19690294pfg.193.2023.05.01.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 05:44:26 -0700 (PDT)
Date: Mon, 01 May 2023 05:44:26 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 05:44:09 PDT (-0700)
Subject: Re: [PATCH v6 4/4] risc/purgatory: Add linker script
In-Reply-To: <20230321-kexec_clang16-v6-4-a2255e81ab45@chromium.org>
CC: ebiederm@xmission.com, prudo@linux.vnet.ibm.com, dyoung@redhat.com,
  akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
  dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, nathan@kernel.org, trix@redhat.com,
  mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, bhe@redhat.com, prudo@redhat.com,
  kexec@lists.infradead.org, linux-kernel@vger.kernel.org, zwisler@google.com, rostedt@goodmis.org,
  horms@kernel.org, ndesaulniers@google.com, llvm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
  linux-riscv@lists.infradead.org, ribalda@chromium.org, stable@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: ribalda@chromium.org
Message-ID: <mhng-6809e805-0a92-401b-af74-fef93eeda1ae@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_054432_102415_B5FFD66A 
X-CRM114-Status: GOOD (  16.75  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, 01 May 2023 05:38:22 PDT (-0700), ribalda@chromium.org wrote:
> If PGO is enabled, the purgatory ends up with multiple .text sections.
> This is not supported by kexec and crashes the system.
>
> Cc: stable@vger.kernel.org
> Fixes: 930457057abe ("kernel/kexec_file.c: split up __kexec_load_puragory")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  arch/riscv/purgatory/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/riscv/purgatory/Makefile b/arch/riscv/purgatory/Makefile
> index 5730797a6b40..cf3a44121a90 100644
> --- a/arch/riscv/purgatory/Makefile
> +++ b/arch/riscv/purgatory/Makefile
> @@ -35,6 +35,11 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>  CFLAGS_string.o := -D__DISABLE_EXPORTS
>  CFLAGS_ctype.o := -D__DISABLE_EXPORTS
>
> +# When profile optimization is enabled, llvm emits two different overlapping
> +# text sections, which is not supported by kexec. Remove profile optimization
> +# flags.
> +KBUILD_CFLAGS := $(filter-out -fprofile-sample-use=% -fprofile-use=%,$(KBUILD_CFLAGS))
> +
>  # When linking purgatory.ro with -r unresolved symbols are not checked,
>  # also link a purgatory.chk binary without -r to check for unresolved symbols.
>  PURGATORY_LDFLAGS := -e purgatory_start -z nodefaultlib

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
