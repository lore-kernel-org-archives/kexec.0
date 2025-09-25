Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0126CAC5A7
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 10:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PEhbNrxDKxLlesXWTYg/5lR5Nvg8KdBBCCu3A/Ayalc=; b=0/UefdVEkuQg8nrTmkKMMxUhcU
	WNeE77owu7OQG9xxEobQhNExAV8oAyffjJI30GGU1IzHg2SLj69FtRWwK/5V/YqE8vS0okYHcH9Su
	299P9LSl4NfOy3Gl6wh/JbV+VVuzIH67BlqKBfZVpBysrYPEPRuHPetuXukomdR0J7lGbNSQvX/C+
	yaa8MGVnD0hR9egG3WJ+us8MNMZWDMOWHGPRJC959zkelnhL6lDOtVGdp+zD32EL+2u2xKRfQPd49
	mpLKrQqcde0DdPTbL4Kx3MqiGgBsMc5MLjjuILChx9ep8xoZ+v5R4Mati25ykmvc90Zb5ZhoMaDao
	aYWFLelQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1j8f-000000082cT-3QSq;
	Thu, 25 Sep 2025 10:23:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1j8d-000000082bl-1gpg
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 10:23:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758795826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PEhbNrxDKxLlesXWTYg/5lR5Nvg8KdBBCCu3A/Ayalc=;
	b=NONffuDY32XC+zvVgSkR/2VT60TzMR5H/6eJVNoGVTDtqxpxu9unGVqoouwz/EV+taVP+W
	qgTmYKTiySt4AnNy+W/4UrIx/MQXSvx0rThaCBZoJ2gw3TUIfTMGXbDNGbBmTzWpg4jCoY
	78lgF4APqculZK2m9hSagxTPrrgKCI0=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-cJ9-Nm7TM5mer5B67vWgRg-1; Thu, 25 Sep 2025 06:23:44 -0400
X-MC-Unique: cJ9-Nm7TM5mer5B67vWgRg-1
X-Mimecast-MFC-AGG-ID: cJ9-Nm7TM5mer5B67vWgRg_1758795823
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-57dcc61bcb6so496106e87.0
        for <kexec@lists.infradead.org>; Thu, 25 Sep 2025 03:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795823; x=1759400623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEhbNrxDKxLlesXWTYg/5lR5Nvg8KdBBCCu3A/Ayalc=;
        b=HpNFP4od/YkeGawSkteONJpaaTT4fQleLNCHrMJCoKzUoznuLy5Rv3jnFPIL8EStzy
         C2lxTMSA+t7IyxEG+/CfISbHvvmW+SLwTT8x1eZOqEd4QWMwFP29l09CzgDel8AWzcfb
         +u9OiVcNbm57bnkbSGxyyoQtAuZml74wy/FhNuMEfy9OYeQFTxOOKZecQSrMx4dsaP45
         O3eaIZeVf/JJq4n+3FRFF/lScHBKwTDtYIFJDL6nMfvnnR74l+Q8DaEhkByPHtQeH6wQ
         G6HMPcWGOKxRI3U0XoFUm2qD6uO+HahGcbX44gmM7PQZuzUWgsuxk2bctnJwc61u1zeH
         AXYA==
X-Forwarded-Encrypted: i=1; AJvYcCWBO4UZdXIvoVNVB9zCnQ8FBjS6NlP43NRotU3z33Ugfoat6yjL6MGgsT2zje+7KAoNuwMlMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyqJ4f6QZzV2YZA3Qt3aeyRQ0RuJyP+vPT+SZh5/2Wh400c1uJX
	7L9jsvaKCNXYKZhZZYuaXAeRETqAnxScAKUi9WesZfzD1FgLbaCbcMUq9h+rBD9dG5A97WheR7G
	h4nj+Q97Uy6vo84ZiagP4c0vuGyDbVTrtWgJOjTObOGJLiHtS2d0xF5CxfCnXFv3XLhJM92tC9h
	RUEBHWdScM5QlyIaifOYItYfnwV/C1jbf+zdlC
X-Gm-Gg: ASbGncuzgiaVZ2HykLx3Wb+Dt6d+c0Qr8gJBKcpLDmwgNoCQ+LFlzD6HI64b87O3fob
	4KS0sghOFl4ZKRq9QapO4e2svBqqeqzbR8De2FdJEGp193fltEjQKaE2urnpeDVPrWKzNsybLq3
	bUVsUVBqZNE1/l/K/WdvCJkg==
X-Received: by 2002:ac2:4bc5:0:b0:561:9635:5af5 with SMTP id 2adb3069b0e04-582d35df03emr825094e87.48.1758795823084;
        Thu, 25 Sep 2025 03:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnnsWOPbc9vIrBF3rV7bHL/Kmr9RcA9HjHBtKTIVCeUpZAzCNaq5AI/HmnmDPTCAa88sF0QyvgY3ydGqWcVdo=
X-Received: by 2002:ac2:4bc5:0:b0:561:9635:5af5 with SMTP id
 2adb3069b0e04-582d35df03emr825085e87.48.1758795822568; Thu, 25 Sep 2025
 03:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250925063241.337897-1-youling.tang@linux.dev>
 <20250925063241.337897-2-youling.tang@linux.dev> <CALu+AoT_DMoFRWO464RSK267wkec917NaLPZ2vOwe1Kw6fvoaA@mail.gmail.com>
 <5ec31e96-7157-4300-af36-daec2cee5831@linux.dev>
In-Reply-To: <5ec31e96-7157-4300-af36-daec2cee5831@linux.dev>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 25 Sep 2025 18:23:33 +0800
X-Gm-Features: AS18NWD1SyYQlEnriFbsxErhBUuY5FqOlEo_Y4Vh3N48nYv_qbH_Sv0IjFj4d00
Message-ID: <CALu+AoQa=17vhPydQ2e+UO20CZPLMOYp2Qs+gUaZ29QyrMrZ7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] LoongArch: Refactor command line processing
To: Youling Tang <youling.tang@linux.dev>
Cc: Simon Horman <horms@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, 
	Huacai Chen <chenhuacai@kernel.org>, Youling Tang <tangyouling@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e50-d0rhelYcX0RQz1NMwmiK1eI7iUd2nCdnnekNTe4_1758795823
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_032347_538296_EF502B83 
X-CRM114-Status: GOOD (  30.70  )
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

On Thu, 25 Sept 2025 at 17:52, Youling Tang <youling.tang@linux.dev> wrote:
>
> On 9/25/25 17:22, Dave Young wrote:
>
> On Thu, 25 Sept 2025 at 14:33, Youling Tang <youling.tang@linux.dev> wrote:
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
>
> Not sure why this is needed,  I guess it is to distinguish the new
> kernel and original kernel?   As replied in another reply I would
> suggest adding an extra cmdline in scripts instead of hard coded here,
>   you need to remove the fake param each time otherwise it will make
> the cmdline longer and longer after many kexec reboot cycles.
>
>
> In arch_process_options(), the "kexec" parameter will be removed when
> reusing the current command line.
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
>
> Ditto for the mem= param and other similar cases, can this be done out
> of the kexec-tools c code? it will be more flexible.
>
>
> Currently, we will maintain passing this parameter through the command line, not
> via FDT like ARM64. In the future, we may consider whether it can be passed through
> the FDT table in efisystab (but that approach may not be friendly to ELF kernels).
>

If the kexec boot depends on the customized mem layout, ideally it
should be passed with fdt or other method.
it is reasonable to keep it for the time being.  But the "kexec" extra
cmdline should not be hard coded in my opinion.

Thanks
Dave


