Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3592CC6FA82
	for <kexec@archiver.kernel.org>; Fri, 23 Sep 2022 13:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijunJ3TLvPn/cZLfaf6XeXec1tmHwGvBws+hPbW/s94=; b=SnXTxd5UorC4m5
	IL0YQmgnkycX63sCsO8H7J6I8vwavoYFGt6lWc9baaoLyu6axkSfqT46B95IUhYEtlfIFnHLFcXnz
	ERGDjzEdhKQQRaVN6jrypsNliWKWbpJoRo6lkSy2Nf+A498wtxhk0vs1773hsrNUVnrY4UPN4gJcH
	CcNpUxVrrYlXFeG37WMUeidHWFXD85RA5F69g1e7o//lMBeL+jdI/Eq1tfLqyyP1Dsymr0lTd5l4T
	8bREqydD28CkKyKQZ9IFrQ4kneV37DZyesYRA+q26OT/HjeRhpgEZVBCfehDOxSjXO1CTqzQN8xdM
	Wqj7A5Kn280a5MNwonbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obiP3-004ODf-LK; Fri, 23 Sep 2022 13:07:37 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obiP0-004OCK-FV
	for kexec@lists.infradead.org; Fri, 23 Sep 2022 13:07:36 +0000
Received: by mail-qt1-f170.google.com with SMTP id a20so8315951qtw.10
        for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 06:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZNyXMIvKvz26rH9+eBnc8eA2/7RfdXl9+K1RY2dFtLE=;
        b=iA0pRXDi3XIGf97dhozoTyyf14wDdhIDiNFD9zZFV1Y1jjl3tcOXSBKCwUC8BFJVD2
         J+8ItyaloS541U9/vWglHcYm+F6wXwaH/uXKHgI+IUJfN6lF147sLulCAPpwuJyGsch/
         hbHNo5jmedkOUXEs8vf3nlggjsxSUE1zJ2ytuve80jX5sHd/rGcgCzDuDAHgNzpLBJHe
         x3qVU6CqfGQ0DZM0tweS8xG0txvPy8fa+HweW1NY7krtdXN6HQ+JKLldVLeLf46p4r7O
         fIjyceRe9QUsr96A47MqK0LWqvDXK7b+WDPB9LhGZPQEReHaBtMK2d4OOSWTliKhe8sX
         7r6g==
X-Gm-Message-State: ACrzQf2zhkHwXot/1yB5AJoh3hoZdTakJJVEcWm5xL4nUTiLSAPQBt0z
	NLKGj9iRV3MXipohYYrzWvVRszbLp8hFmA==
X-Google-Smtp-Source: AMsMyM7GAWvRwMgyNGcel3rfUZcRxTpf8eHNIY0HJZkhmsNzE++ply8CduLS1jk2dVxZuatO55IPtQ==
X-Received: by 2002:a05:622a:14d0:b0:35c:c205:7d25 with SMTP id u16-20020a05622a14d000b0035cc2057d25mr6963914qtx.5.1663938451833;
        Fri, 23 Sep 2022 06:07:31 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id o67-20020a374146000000b006ced5d3f921sm5531878qka.52.2022.09.23.06.07.31
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 06:07:31 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id e81so16970503ybb.13
        for <kexec@lists.infradead.org>; Fri, 23 Sep 2022 06:07:31 -0700 (PDT)
X-Received: by 2002:a05:6902:45:b0:6ae:ce15:a08d with SMTP id
 m5-20020a056902004500b006aece15a08dmr8740635ybh.380.1663938451159; Fri, 23
 Sep 2022 06:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220923124642.3942806-1-Jason@zx2c4.com>
In-Reply-To: <20220923124642.3942806-1-Jason@zx2c4.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Sep 2022 15:07:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-KyOXg_nEa=gur-X5vjBimOM+zZ-g-xqYhAV-wBOfSA@mail.gmail.com>
Message-ID: <CAMuHMdU-KyOXg_nEa=gur-X5vjBimOM+zZ-g-xqYhAV-wBOfSA@mail.gmail.com>
Subject: Re: [PATCH kexec-tools] m68k: pass rng seed via BI_VIRT_RNG_SEED
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, 
	Simon Horman <horms@verge.net.au>, Laurent Vivier <Laurent@vivier.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_060734_535992_A1B12DA3 
X-CRM114-Status: GOOD (  29.01  )
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

Hi Jason,

On Fri, Sep 23, 2022 at 2:47 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> In order to pass fresh entropy to kexec'd kernels, use BI_VIRT_RNG_SEED
> for passing a seed, with the same semantics that kexec-tools currently
> uses for i386's setup_data.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for your patch!

> --- a/kexec/arch/m68k/bootinfo.c
> +++ b/kexec/arch/m68k/bootinfo.c
> @@ -135,40 +135,45 @@ void bootinfo_print(void)
>                 size = bi->size;
>                 switch (tag) {
>                 case BI_MACHTYPE:
>                         printf("BI_MACHTYPE: 0x%08x\n", bi->machtype);
>                         break;
>
>                 case BI_MEMCHUNK:
>                         printf("BI_MEMCHUNK: 0x%08x bytes at 0x%08x\n",
>                                bi->mem_info.size, bi->mem_info.addr);
>                         break;
>
>                 case BI_RAMDISK:
>                         printf("BI_RAMDISK: 0x%08x bytes at 0x%08x\n",
>                                bi->mem_info.size, bi->mem_info.addr);
>                         break;

Hmm, lots of context.

>
>                 case BI_COMMAND_LINE:
>                         printf("BI_COMMAND_LINE: %s\n", bi->string);
>                         break;
>
> +               case BI_VIRT_RNG_SEED:

This won't work as expected: BI_VIRT_* tags are only valid if the
machine type is MACH_VIRT.

Worse, this will trigger for other platform-specific tags using the same value:

    arch/m68k/include/uapi/asm/bootinfo-amiga.h:#define
BI_AMIGA_CHIPSET    0x8006  /* native chipset present (__be32) */
    arch/m68k/include/uapi/asm/bootinfo-mac.h:#define BI_MAC_SCCBASE
             0x8006  /* Mac SCC base address */
    arch/m68k/include/uapi/asm/bootinfo-virt.h:#define
BI_VIRT_RNG_SEED     0x8006

> +                       /* These are secret, so never print them to the console */
> +                       printf("BI_VIRT_RNG_SEED: 0x%08x bytes\n", be16_to_cpu(bi->bytes.len));
> +                       break;
> +
>                 default:
>                         printf("BI tag 0x%04x size %u\n", tag, size);
>                         break;
>                 }
>                 bi = bi_next(bi, size);
>         }
>  }

>  }
>
> +void bootinfo_add_rng_seed(void)
> +{
> +       struct bi_rec *bi;
> +       enum { RNG_SEED_LEN = 32 };
> +
> +       /* Remove existing rng seed records */
> +       bi_remove(BI_VIRT_RNG_SEED);
> +
> +       /* Add new rng seed record */
> +       bi = bi_add(BI_VIRT_RNG_SEED, sizeof(bi->bytes) + RNG_SEED_LEN);

Likewise, this will destroy existing BI_AMIGA_CHIPSET and BI_MAC_SCCBASE
tags, breaking Amiga and Mac.

> +       if (getrandom(bi->bytes.data, RNG_SEED_LEN, GRND_NONBLOCK) != RNG_SEED_LEN) {
> +               bi_remove(BI_VIRT_RNG_SEED);
> +               return;
> +       }
> +       bi->bytes.len = cpu_to_be16(RNG_SEED_LEN);
> +}
> +
>

As random seeds can now be generic, I think it makes sense to introduce
a machine-independent BI_RND_SEED.
In hindsight, we should have done this from the beginning...

> --- a/kexec/arch/m68k/bootinfo.h
> +++ b/kexec/arch/m68k/bootinfo.h
> @@ -1,43 +1,49 @@
>  #include <asm/bootinfo.h>
> +#include <asm/bootinfo-virt.h>
>
>  #define DEFAULT_BOOTINFO_FILE  "/proc/bootinfo"
>  #define MAX_BOOTINFO_SIZE      1536
>
>
>      /*
>       *  Convenience overlay of several struct bi_record variants
>       */
>
>  struct bi_rec {
>         __be16 tag;
>         __be16 size;
>         union {
>                 __be32 data[0];
>                 /* shorthands for the types we use */
>                 __be32 machtype;
>                 struct {
>                         __be32 addr;
>                         __be32 size;
>                 } mem_info;
>                 char string[0];
> +               struct {
> +                       __be16 len;
> +                       u8 data[0];
> +               } bytes;

I'd rather call this rng_seed, to avoid confusion between "data"
and "bytes",

>         };
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
