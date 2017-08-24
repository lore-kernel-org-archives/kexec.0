Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dko6D-0004B4-TB
 for kexec@lists.infradead.org; Thu, 24 Aug 2017 09:06:51 +0000
Received: by mail-it0-x232.google.com with SMTP id a73so127649itd.1
 for <kexec@lists.infradead.org>; Thu, 24 Aug 2017 02:06:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170824081811.19299-4-takahiro.akashi@linaro.org>
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-4-takahiro.akashi@linaro.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 24 Aug 2017 10:06:28 +0100
Message-ID: <CAKv+Gu_UfeDf13RPUejVqz0y=QjSCGhPn6fTTCyLWHY=iu-4BA@mail.gmail.com>
Subject: Re: [PATCH 03/14] resource: add walk_system_ram_res_rev()
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Baoquan He <bhe@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

On 24 August 2017 at 09:18, AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> This function, being a variant of walk_system_ram_res() introduced in
> commit 8c86e70acead ("resource: provide new functions to walk through
> resources"), walks through a list of all the resources of System RAM
> in reversed order, i.e., from higher to lower.
>
> It will be used in kexec_file implementation on arm64.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  include/linux/ioport.h |  3 +++
>  kernel/resource.c      | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 6230064d7f95..9a212266299f 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -271,6 +271,9 @@ extern int
>  walk_system_ram_res(u64 start, u64 end, void *arg,
>                     int (*func)(u64, u64, void *));
>  extern int
> +walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +                       int (*func)(u64, u64, void *));
> +extern int
>  walk_iomem_res_desc(unsigned long desc, unsigned long flags, u64 start, u64 end,
>                     void *arg, int (*func)(u64, u64, void *));
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 9b5f04404152..1d6d734c75ac 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -23,6 +23,7 @@
>  #include <linux/pfn.h>
>  #include <linux/mm.h>
>  #include <linux/resource_ext.h>
> +#include <linux/vmalloc.h>
>  #include <asm/io.h>
>
>
> @@ -469,6 +470,53 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>         return ret;
>  }
>
> +int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
> +                               int (*func)(u64, u64, void *))
> +{
> +       struct resource res, *rams;
> +       u64 orig_end;
> +       int count, i;
> +       int ret = -1;
> +
> +       count = 16; /* initial */
> +again:
> +       /* create a list */
> +       rams = vmalloc(sizeof(struct resource) * count);
> +       if (!rams)
> +               return ret;
> +
> +       res.start = start;
> +       res.end = end;
> +       res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +       orig_end = res.end;
> +       i = 0;
> +       while ((res.start < res.end) &&
> +               (!find_next_iomem_res(&res, IORES_DESC_NONE, true))) {
> +               if (i >= count) {
> +                       /* unlikely but */
> +                       vfree(rams);
> +                       count += 16;

If the count is likely to be < 16, why are we using vmalloc() here?

> +                       goto again;
> +               }
> +
> +               rams[i].start = res.start;
> +               rams[i++].end = res.end;
> +
> +               res.start = res.end + 1;
> +               res.end = orig_end;
> +       }
> +
> +       /* go reverse */
> +       for (i--; i >= 0; i--) {
> +               ret = (*func)(rams[i].start, rams[i].end, arg);
> +               if (ret)
> +                       break;
> +       }
> +
> +       vfree(rams);
> +       return ret;
> +}
> +
>  #if !defined(CONFIG_ARCH_HAS_WALK_MEMORY)
>
>  /*
> --
> 2.14.1
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
