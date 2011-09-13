Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp-out.google.com ([74.125.121.67])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R3auK-0000kk-Vg
	for kexec@lists.infradead.org; Tue, 13 Sep 2011 21:52:45 +0000
Date: Tue, 13 Sep 2011 14:52:18 -0700
From: Andrew Morton <akpm@google.com>
Subject: Re: [patch v2 2/2] s390: Add architecture code for unmapping
	crashkernel memory
Message-Id: <20110913145218.659f9e21.akpm@google.com>
In-Reply-To: <20110913132654.157278466@linux.vnet.ibm.com>
References: <20110913132635.063397500@linux.vnet.ibm.com>
	<20110913132654.157278466@linux.vnet.ibm.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, vgoyal@redhat.com

On Tue, 13 Sep 2011 15:26:37 +0200
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> 
> This patch implements the crash_map_pages() function for s390.
> KEXEC_CRASH_MEM_ALIGN is set to HPAGE_SIZE, in order to support
> kernel mappings that use large pages.
> 
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/kexec.h    |    3 +++
>  arch/s390/kernel/machine_kexec.c |   31 +++++++++++++++++++++++++++++++
>  arch/s390/kernel/setup.c         |   10 ++++++----
>  3 files changed, 40 insertions(+), 4 deletions(-)
> 
> --- a/arch/s390/include/asm/kexec.h
> +++ b/arch/s390/include/asm/kexec.h
> @@ -36,6 +36,9 @@
>  /* Allocate one page for the pdp and the second for the code */
>  #define KEXEC_CONTROL_PAGE_SIZE 4096
>  
> +/* Alignment of crashkernel memory */
> +#define KEXEC_CRASH_MEM_ALIGN HPAGE_SIZE

Why not make this unconditional, for all architectures which support
hugepages?  ie:

#ifdef HPAGE_SIZE
#define KEXEC_CRASH_MEM_ALIGN HPAGE_SIZE
#else
#define KEXEC_CRASH_MEM_ALIGN PAGE_SIZE
#endif

in include/linux/kexec.h?

IOW, what are the compromises here?

Also, does s390 support CONFIG_HUGETLB_PAGE=n?  If so, does the use of
HPAGE_SIZE still make sense?  Does it compile?


>  /* The native architecture */
>  #define KEXEC_ARCH KEXEC_ARCH_S390
>  
> --- a/arch/s390/kernel/machine_kexec.c
> +++ b/arch/s390/kernel/machine_kexec.c
> @@ -243,6 +243,37 @@ static void __machine_kdump(void *image)
>  #endif
>  
>  /*
> + * Map or unmap crashkernel memory
> + */
> +static void crash_map_pages(int enable)
> +{
> +	unsigned long size = crashk_res.end - crashk_res.start + 1;

resource_size().

> +	BUG_ON(crashk_res.start % KEXEC_CRASH_MEM_ALIGN ||
> +	       size % KEXEC_CRASH_MEM_ALIGN);
> +	if (enable)
> +		vmem_add_mapping(crashk_res.start, size);
> +	else
> +		vmem_remove_mapping(crashk_res.start, size);
> +}
>
> ...
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
