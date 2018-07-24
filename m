Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fhtXW-0004de-CS
 for kexec@lists.infradead.org; Tue, 24 Jul 2018 09:23:32 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6O9IYoh076075
 for <kexec@lists.infradead.org>; Tue, 24 Jul 2018 05:23:17 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ke0s0209t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 24 Jul 2018 05:23:17 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.ibm.com>;
 Tue, 24 Jul 2018 10:23:14 +0100
Date: Tue, 24 Jul 2018 11:23:06 +0200
From: Philipp Rudo <prudo@linux.ibm.com>
Subject: Re: [PATCH v12 03/16] s390, kexec_file: drop arch_kexec_mem_walk()
In-Reply-To: <20180724065759.19186-4-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
 <20180724065759.19186-4-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Message-Id: <20180724112306.299540b5@ThinkPad>
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

Hi AKASHI,

the patch looks good to me.

Reviewed-by: Philipp Rudo <prudo@linux.ibm.com>

Thanks
Philipp


On Tue, 24 Jul 2018 15:57:46 +0900
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
