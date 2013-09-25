Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VOjGP-0005xE-SP
 for kexec@lists.infradead.org; Wed, 25 Sep 2013 07:11:58 +0000
Date: Wed, 25 Sep 2013 16:11:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec/ppc: Check for a uImage initrd with ELF kernel
Message-ID: <20130925071134.GI6663@verge.net.au>
References: <20130924052302.4574.87561.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130924052302.4574.87561.stgit@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Athira Rajeev <atrajeev@in.ibm.com>
Cc: kexec@lists.infradead.org, suzuki@in.ibm.com

On Tue, Sep 24, 2013 at 10:53:10AM +0530, Athira Rajeev wrote:
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
> 
> We should check if the initrd is in uImage format, when
> the kernel might be in ELF.
> 
> Signed-off-by : Suzuki K Poulose <suzuki@in.ibm.com>
> Signed-off-by : Athira Rajeev<atrajeev@in.ibm.com>

Thanks, applied.

> ---
> 
>  kexec/arch/ppc/kexec-elf-ppc.c |    2 +-
>  kexec/arch/ppc/kexec-ppc.h     |    3 +++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
> index 98cae9c..df1b521 100644
> --- a/kexec/arch/ppc/kexec-elf-ppc.c
> +++ b/kexec/arch/ppc/kexec-elf-ppc.c
> @@ -371,7 +371,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>  	blob_buf = fixup_dtb_init(info, blob_buf, &blob_size, kernel_addr, &dtb_addr);
>  
>  	if (ramdisk) {
> -		seg_buf = slurp_file(ramdisk, &seg_size);
> +		seg_buf = slurp_ramdisk_ppc(ramdisk, &seg_size);
>  		/* load the ramdisk *above* the device tree */
>  		hole_addr = add_buffer(info, seg_buf, seg_size, seg_size,
>  				0, dtb_addr + blob_size + 1,  max_addr, -1);
> diff --git a/kexec/arch/ppc/kexec-ppc.h b/kexec/arch/ppc/kexec-ppc.h
> index 68728c6..904cf48 100644
> --- a/kexec/arch/ppc/kexec-ppc.h
> +++ b/kexec/arch/ppc/kexec-ppc.h
> @@ -78,4 +78,7 @@ extern int read_memory_region_limits(int fd, unsigned long long *start,
>  #define COMMAND_LINE_SIZE	512 /* from kernel */
>  /*fs2dt*/
>  void reserve(unsigned long long where, unsigned long long length);
> +
> +/* Defined kexec-uImage-ppc.c */
> +extern char* slurp_ramdisk_ppc(const char *filename, off_t *r_size);
>  #endif /* KEXEC_PPC_H */
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
