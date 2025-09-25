Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA2CAC5A7
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 09:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=apX1IcxXqYH7AvySJ7/QAIA2a/NM5JGfBWW8X2kwIYE=; b=u3ACo3qQWSA5ngaHiaAsQLjCRv
	Fj+OLUqd7fNTcNNrZQaHkrL2BO+w16fnd6RcF+b9frI+eS9x/Y6v9FEFRhcM/cOaKPsv+T/4LNrvb
	1eOHnTxK+blBM6BR/1gva287P3lOq88LlaWOeQfUuDsxriCpATijNpXHGAbJPjUgDjkFIIoevdKoQ
	hFVRIn3c3d8S+h9YjSqQRK9VCljzXKfl8QmKl02EjQWPMrmmZ7OmeYzxkT6Fj56c5TbKs4KGSO8YO
	fdiBBIbAwbWSScIXY9WaLkRJm5Fhg0+cVJUTQIfpXbrmDoC2RSy1Uu7c2HYmFaF1VjQ8+8/kYzNki
	8T5Df52w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iBj-00000007YSl-2n08;
	Thu, 25 Sep 2025 09:22:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1iBg-00000007YR2-2NZ0
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 09:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758792171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=apX1IcxXqYH7AvySJ7/QAIA2a/NM5JGfBWW8X2kwIYE=;
	b=XNaPn8ditX3tylmy7BkR10zx+eRCaid1X0JaX1KiKtsjdTSFmlwMSHo4FPKdbo9DvG6Pi2
	Z/Gkr87tFYhljd4c306RQvbhpkEiZ/j+JAkkMFoPxo0dwIGMPX7S6Ge3f6O9IAoarATnAh
	rSc209/W4uyIvbmIvRHSszFwaVRGuzk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-y4h-l6Y5PRi_b1-CrMVIzg-1; Thu, 25 Sep 2025 05:22:49 -0400
X-MC-Unique: y4h-l6Y5PRi_b1-CrMVIzg-1
X-Mimecast-MFC-AGG-ID: y4h-l6Y5PRi_b1-CrMVIzg_1758792168
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-57a8a75cb30so531192e87.2
        for <kexec@lists.infradead.org>; Thu, 25 Sep 2025 02:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792168; x=1759396968;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apX1IcxXqYH7AvySJ7/QAIA2a/NM5JGfBWW8X2kwIYE=;
        b=p4s+2R/ym2w3gD1riQO4+cpWkZ41FZW2Q1e6NhTgt4GamxWPE4YFhI3FPs9h0p1cf5
         v6XylpkUdZU+QtgyIhc4wVAcFO/oWwH7uq2enYLX0Uii5Tf4gx6AivYtYeqORUG4P0bV
         SDQACT1zZkUcnijXsDHMosvt6cQBMfSpjlZgQ9WHBTAuHfrzQn0hHUJik0azW3WzrB2f
         ffCnl43iDaVxdKRkeNcecF1AH4mxuVIbSUBprz5Qi81CvP7Lhejiul3Tut6CJ/5KCYCB
         Uyu/NzdwkLUTOIjMdfsK9iJV/rX4IR+MAtLHwhLlK5kNhKdCw5g8bzFT2UJeseicbSJO
         HbZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3WHHluQGEK+Ehzr7VfnjYKXFs8rfB+AoUe2CVYudpOLDY1BjHKUC3iAmyeVURIkKSvA1+Yw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyJept0+ZuM/dMgCF+eHaa0QpbeVarCnHR2MGRphIGxC8+sqji8
	AhdecYNjK8JIxkb6oOHghxZuAfi/VAnaPBhTowgUy9Fe2QzWCmbG+ygNteqYHfY1FqDrKgah9tS
	v9T8nFmWg00NZ92J+XYinyNIdwwFNJHkBhAm8HbAlpuhffJ2GZYFIgyM033aVkf/iqGJa+w1lEK
	T413YdoH/KQFG5SL3U4zereJM6KOLDs/Zk9s0z
X-Gm-Gg: ASbGnctO+PVlvlCjh5rsWm868jNZPZmGI2veIo1DDDcDXV7CJqwd+D13CKi0jCgmMqe
	nkAW+FD7RJiJDoitdFl+mzRCCispwjKWVXKt1ngMD/QUcPP08kEdihi7McS+538U6ONJX1cUAFI
	DtV8Kb4pL28XSLu503aqTLqg==
X-Received: by 2002:ac2:568a:0:b0:57a:f38a:39ad with SMTP id 2adb3069b0e04-582d0e15fdcmr784522e87.14.1758792167790;
        Thu, 25 Sep 2025 02:22:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElLVSP+jF3SnZgN+S8cIj4UqXxAJmafsQskzU/97zWFORcT+Ou7jgpjB8iDFPKo6IZ+L6cgTFXEq1cWCmtK9s=
X-Received: by 2002:ac2:568a:0:b0:57a:f38a:39ad with SMTP id
 2adb3069b0e04-582d0e15fdcmr784500e87.14.1758792167269; Thu, 25 Sep 2025
 02:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250925063241.337897-1-youling.tang@linux.dev> <20250925063241.337897-2-youling.tang@linux.dev>
In-Reply-To: <20250925063241.337897-2-youling.tang@linux.dev>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 25 Sep 2025 17:22:38 +0800
X-Gm-Features: AS18NWD-fTNYchMTH6aWHgI5QNYC91PZg0UqHqVAcaEqVGoAc-5Aoln4lYKTq5k
Message-ID: <CALu+AoT_DMoFRWO464RSK267wkec917NaLPZ2vOwe1Kw6fvoaA@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Refactor command line processing
To: Youling Tang <youling.tang@linux.dev>
Cc: Simon Horman <horms@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, 
	Huacai Chen <chenhuacai@kernel.org>, Youling Tang <tangyouling@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Khw6nZFRDGoWZAU0XMGgecRCNP7ateidcZIEiesGSUk_1758792168
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_022252_705082_CADF38FA 
X-CRM114-Status: GOOD (  28.40  )
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

On Thu, 25 Sept 2025 at 14:33, Youling Tang <youling.tang@linux.dev> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> Refactor the cmdline_add_xxx code flow, and simultaneously display
> the content of parameters such as initrd in hexadecimal format to
> improve readability.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  kexec/arch/loongarch/kexec-loongarch.c | 138 ++++++++++---------------
>  1 file changed, 55 insertions(+), 83 deletions(-)
>
> diff --git a/kexec/arch/loongarch/kexec-loongarch.c b/kexec/arch/loongarch/kexec-loongarch.c
> index 240202f..c2503de 100644
> --- a/kexec/arch/loongarch/kexec-loongarch.c
> +++ b/kexec/arch/loongarch/kexec-loongarch.c
> @@ -35,83 +35,49 @@
>  #define _O_BINARY 0
>  #endif
>
> -#define CMDLINE_PREFIX "kexec "
> -static char cmdline[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
> +/* Add the "kexec" command line parameter to command line. */
> +static void cmdline_add_loader(unsigned long *cmdline_tmplen, char *modified_cmdline)
> +{
> +       int loader_strlen;
> +
> +       loader_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "kexec ");
> +       *cmdline_tmplen += loader_strlen;
> +}

Not sure why this is needed,  I guess it is to distinguish the new
kernel and original kernel?   As replied in another reply I would
suggest adding an extra cmdline in scripts instead of hard coded here,
  you need to remove the fake param each time otherwise it will make
the cmdline longer and longer after many kexec reboot cycles.

>
> -/* Adds "initrd=start,size" parameters to command line. */
> -static int cmdline_add_initrd(char *cmdline, unsigned long addr,
> -               unsigned long size)
> +/* Add the "initrd=start,size" command line parameter to command line. */
> +static void cmdline_add_initrd(unsigned long *cmdline_tmplen, char *modified_cmdline,
> +                              unsigned long initrd_base, unsigned long initrd_size)
>  {
> -       int cmdlen, len;
> -       char str[50], *ptr;
> -
> -       ptr = str;
> -       strcpy(str, " initrd=");
> -       ptr += strlen(str);
> -       ultoa(addr, ptr);
> -       strcat(str, ",");
> -       ptr = str + strlen(str);
> -       ultoa(size, ptr);
> -       len = strlen(str);
> -       cmdlen = strlen(cmdline) + len;
> -       if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -               die("Command line overflow\n");
> -       strcat(cmdline, str);
> +       int initrd_strlen;
>
> -       return 0;
> +       initrd_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "initrd=0x%lx,0x%lx ",
> +                               initrd_base, initrd_size);
> +       *cmdline_tmplen += initrd_strlen;
>  }
>
> -/* Adds the appropriate "mem=size@start" options to command line, indicating the
> - * memory region the new kernel can use to boot into. */
> -static int cmdline_add_mem(char *cmdline, unsigned long addr,
> -               unsigned long size)
> +/*
> + * Add the "mem=size@start" command line parameter to command line, indicating the
> + * memory region the new kernel can use to boot into.
> + */
> +static void cmdline_add_mem(unsigned long *cmdline_tmplen, char *modified_cmdline,
> +                           unsigned long mem_start, unsigned long mem_sz)
>  {
> -       int cmdlen, len;
> -       char str[50], *ptr;
> -
> -       addr = addr/1024;
> -       size = size/1024;
> -       ptr = str;
> -       strcpy(str, " mem=");
> -       ptr += strlen(str);
> -       ultoa(size, ptr);
> -       strcat(str, "K@");
> -       ptr = str + strlen(str);
> -       ultoa(addr, ptr);
> -       strcat(str, "K");
> -       len = strlen(str);
> -       cmdlen = strlen(cmdline) + len;
> -       if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -               die("Command line overflow\n");
> -       strcat(cmdline, str);
> +       int mem_strlen = 0;
>
> -       return 0;
> +       mem_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "mem=0x%lx@0x%lx ",
> +                            mem_sz, mem_start);
> +       *cmdline_tmplen += mem_strlen;
>  }

Ditto for the mem= param and other similar cases, can this be done out
of the kexec-tools c code? it will be more flexible.

>
> -/* Adds the "elfcorehdr=size@start" command line parameter to command line. */
> -static int cmdline_add_elfcorehdr(char *cmdline, unsigned long addr,
> -                       unsigned long size)
> +/* Add the "elfcorehdr=size@start" command line parameter to command line. */
> +static void cmdline_add_elfcorehdr(unsigned long *cmdline_tmplen, char *modified_cmdline,
> +                                  unsigned long elfcorehdr_start, unsigned long elfcorehdr_sz)
>  {
> -       int cmdlen, len;
> -       char str[50], *ptr;
> -
> -       addr = addr/1024;
> -       size = size/1024;
> -       ptr = str;
> -       strcpy(str, " elfcorehdr=");
> -       ptr += strlen(str);
> -       ultoa(size, ptr);
> -       strcat(str, "K@");
> -       ptr = str + strlen(str);
> -       ultoa(addr, ptr);
> -       strcat(str, "K");
> -       len = strlen(str);
> -       cmdlen = strlen(cmdline) + len;
> -       if (cmdlen > (COMMAND_LINE_SIZE - 1))
> -               die("Command line overflow\n");
> -       strcat(cmdline, str);
> +       int elfcorehdr_strlen = 0;
>
> -       return 0;
> +       elfcorehdr_strlen = sprintf(modified_cmdline + (*cmdline_tmplen), "elfcorehdr=0x%lx@0x%lx ",
> +                                   elfcorehdr_sz, elfcorehdr_start);
> +       *cmdline_tmplen += elfcorehdr_strlen;
>  }
>
>  /* Return a sorted list of memory ranges. */
> @@ -329,18 +295,17 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
>         unsigned long initrd_min, hole_max;
>         char *initrd_buf = NULL;
>         unsigned long pagesize = getpagesize();
> +       unsigned long cmdline_tmplen = 0;
> +       char *cmdline = NULL;
>         int i;
>
> -       if (arch_options.command_line) {
> -               if (strlen(arch_options.command_line) >
> -                   sizeof(cmdline) - 1) {
> -                       fprintf(stderr,
> -                               "Kernel command line too long for kernel!\n");
> -                       return EFAILED;
> -               }
> +       cmdline = calloc(1, COMMAND_LINE_SIZE);
> +       if (!cmdline)
> +               return EFAILED;
>
> -               strncat(cmdline, arch_options.command_line, sizeof(cmdline) - 1);
> -       }
> +       /* Ensure it's null terminated */
> +       cmdline_add_loader(&cmdline_tmplen, cmdline);
> +       cmdline[COMMAND_LINE_SIZE - 1] = '\0';
>
>         /* Put the other segments after the image. */
>
> @@ -360,21 +325,29 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
>                                                 pagesize), hole_max, -1);
>                 dbgprintf("initrd_base: %lx, initrd_size: %lx\n", initrd_base, initrd_size);
>
> -               cmdline_add_initrd(cmdline, initrd_base, initrd_size);
> +               cmdline_add_initrd(&cmdline_tmplen, cmdline, initrd_base, initrd_size);
>         }
>
>         if (info->kexec_flags & KEXEC_ON_CRASH) {
> -               cmdline_add_elfcorehdr(cmdline, elfcorehdr_mem.start,
> -                               elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
> +               cmdline_add_elfcorehdr(&cmdline_tmplen, cmdline, elfcorehdr_mem.start,
> +                                      elfcorehdr_mem.end - elfcorehdr_mem.start + 1);
>
>                 for(i = 0;i < usablemem_rgns.size; i++) {
> -                       cmdline_add_mem(cmdline, crash_reserved_mem[i].start,
> -                       crash_reserved_mem[i].end -
> -                       crash_reserved_mem[i].start + 1);
> +                       cmdline_add_mem(&cmdline_tmplen, cmdline, crash_reserved_mem[i].start,
> +                                       crash_reserved_mem[i].end - crash_reserved_mem[i].start + 1);
> +               }
> +       }
> +
> +       if (arch_options.command_line) {
> +               if (strlen(arch_options.command_line) + cmdline_tmplen > COMMAND_LINE_SIZE) {
> +                       fprintf(stderr, "Kernel command line too long for kernel!\n");
> +                       free(cmdline);
> +                       return EFAILED;
>                 }
> +               memcpy(cmdline + cmdline_tmplen, arch_options.command_line,
> +                      strlen(arch_options.command_line));
>         }
>
> -       cmdline[sizeof(cmdline) - 1] = '\0';
>         add_buffer(info, cmdline, sizeof(cmdline), sizeof(cmdline),
>                 sizeof(void *), _ALIGN_UP(hole_min, getpagesize()),
>                 hole_max, 1);
> @@ -382,7 +355,6 @@ int loongarch_load_other_segments(struct kexec_info *info, unsigned long hole_mi
>         dbgprintf("%s:%d: command_line: %s\n", __func__, __LINE__, cmdline);
>
>         return 0;
> -
>  }
>
>  int arch_compat_trampoline(struct kexec_info *UNUSED(info))
> --
> 2.48.1
>
>


