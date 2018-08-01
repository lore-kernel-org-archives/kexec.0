Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fkmWO-0002n3-27
 for kexec@lists.infradead.org; Wed, 01 Aug 2018 08:30:17 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w718ThNS012489
 for <kexec@lists.infradead.org>; Wed, 1 Aug 2018 04:30:03 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kk8s3sgxb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 01 Aug 2018 04:30:03 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Wed, 1 Aug 2018 09:30:00 +0100
Date: Wed, 1 Aug 2018 10:29:51 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v13 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
In-Reply-To: <20180801075820.3753-4-takahiro.akashi@linaro.org>
References: <20180801075820.3753-1-takahiro.akashi@linaro.org>
 <20180801075820.3753-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Message-Id: <20180801102951.527cfc57@ThinkPad>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, bhsharma@redhat.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, schwidefsky@de.ibm.com, james.morse@arm.com, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com

Hey Akashi,

I kept thinking about this patch and remembered why I didn't made the change
you are suggesting now.

The problem is when you only check for kbuf->mem you are excluding address 0,
which might be a valid address to load the kernel to. On s390 this is actually
done when the kernel is not loaded via a boot loader. For kexec_file however,
we cut off the first few kB of the image and jump directly to 'startup'. So
checking for !0 does not cause a problem here.

Anyway, the long term safer solution would be something like

#define KEXEC_BUF_MEM_UNKNOWN (-1UL)

for architectures to tell common code to search a fitting mem hole.

Back then I didn't do the change because I had the other workaround, which
didn't require a common code change. But when you are touching the code now it
is worth thinking about it.

Just wanted to let you know
Philipp


On Wed,  1 Aug 2018 16:58:07 +0900
AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> Since s390 already knows where to locate buffers, calling
> arch_kexec_mem_walk() has no sense. So we can just drop it as kbuf->mem
> indicates this while all other architectures sets it to 0 initially.
> 
> This change is a preparatory work for the next patch, where all the
> variant memory walks, either on system resource or memblock, will be
> put in one common place so that it will satisfy all the architectures'
> need.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> ---
>  arch/s390/kernel/machine_kexec_file.c | 10 ----------
>  kernel/kexec_file.c                   |  4 ++++
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
> index f413f57f8d20..32023b4f9dc0 100644
> --- a/arch/s390/kernel/machine_kexec_file.c
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -134,16 +134,6 @@ int kexec_file_add_initrd(struct kimage *image, struct s390_load_data *data,
>  	return ret;
>  }
>  
> -/*
> - * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> - * and provide kbuf->mem by hand.
> - */
> -int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> -			int (*func)(struct resource *, void *))
> -{
> -	return 1;
> -}
> -
>  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>  				     Elf_Shdr *section,
>  				     const Elf_Shdr *relsec,
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 63c7ce1c0c3e..bf39df5e5bb9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -534,6 +534,10 @@ int kexec_locate_mem_hole(struct kexec_buf *kbuf)
>  {
>  	int ret;
>  
> +	/* Arch knows where to place */
> +	if (kbuf->mem)
> +		return 0;
> +
>  	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
>  
>  	return ret == 1 ? 0 : -EADDRNOTAVAIL;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
