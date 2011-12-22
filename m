Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Rdiza-0005bB-Ro
 for kexec@lists.infradead.org; Thu, 22 Dec 2011 13:47:32 +0000
Date: Thu, 22 Dec 2011 08:47:22 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH] crash: s390x: Auto-detect the correct	MAX_PHYSMEM_BITS
 used in vmcore being analyzed
Message-ID: <0fcc2238-1a56-4ce1-a3bd-648ad7a47202@zmail15.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1324560400.2720.36.camel@br98xy6r>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, Crash-utility <crash-utility@redhat.com>, kexec@lists.infradead.org, V Strivatsa <vatsa@linux.vnet.ibm.com>, Ananth Narayan <ananth@in.ibm.com>



----- Original Message -----
> Hello Dave and Mahesh,
> 
> We also tried to solve the problem and came up with an alternative
> solution.
> 
> The function s390x_max_physmem_bits() solves the following equation:
> 
> array_len == NR_MEM_SECTIONS / SECTIONS_PER_ROOT
>           
>                  2^(MAX_PYSMEM_BITS - SECTION_SIZE_BITS)
>                  ---------------------------------------
>           ==                    PAGE_SIZE
>                         -------------------------
>                         sizeof(struct mem_section)
> 
> This leads to the following:
> 
> MAX_PYSMEM_BITS  == SECTION_SIZE_BITS + log2(array_len) +
> log2(PAGE_SIZE)
>                          - log2(sizeof(struct mem_section));
> 
> I tested the patch with 42 and 46 bits and for both it seems to work.
> I will leave now for vacation and will return January the 9th 2012.
> 
> I leave it to you which solution to take.

No -- I leave to you guys to decide.  I appreciate the simplicity of
your solution, but Mahesh's patch is easier to understand.

So please decide before you go home -- I was hoping to get a release
out today!
 
> Merry Christmas!
> 
> Michael
> 
> PS: I think this patch also fixes a bug in verify_ptn()...
>     BTOP vs. PTOB :-)

Hey, you're right!

Dave

> ---
>  kernel.c |    2 +-
>  memory.c |    2 +-
>  s390x.c  |   17 ++++++++++++++++-
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> --- a/kernel.c
> +++ b/kernel.c
> @@ -275,7 +275,7 @@ kernel_init()
>          MEMBER_OFFSET_INIT(prio_array_nr_active, "prio_array",
>          "nr_active");
>  	STRUCT_SIZE_INIT(runqueue, rqstruct);
>  	STRUCT_SIZE_INIT(prio_array, "prio_array");
> -
> +	STRUCT_SIZE_INIT(mem_section, "mem_section");
>  	MEMBER_OFFSET_INIT(rq_cfs, "rq", "cfs");
>  
>         /*
> --- a/memory.c
> +++ b/memory.c
> @@ -13601,7 +13601,7 @@ verify_pfn(ulong pfn)
>  	for (i = machdep->max_physmem_bits; i < machdep->bits; i++)
>  		mask |= ((physaddr_t)1 << i);
>  		
> -	if (mask & BTOP(pfn))
> +	if (mask & PTOB(pfn))
>  		return FALSE;
>  
>  	return TRUE;
> --- a/s390x.c
> +++ b/s390x.c
> @@ -17,6 +17,7 @@
>   */
>  #ifdef S390X
>  #include <elf.h>
> +#include <math.h>
>  #include "defs.h"
>  #include "netdump.h"
>  
> @@ -283,6 +284,19 @@ static void s390x_process_elf_notes(void
>  }
>  
>  /*
> + * The older s390x kernels use _MAX_PHYSMEM_BITS as 42 and the
> + * newer kernels use 46 bits. This function calculates the bits
> + * via a generic function.
> + */
> +static int s390x_max_physmem_bits(void)
> +{
> +	unsigned long array_len = get_array_length("mem_section", NULL, 0);
> +
> +	return _SECTION_SIZE_BITS + log2(array_len) + 12 /* log2(PAGE_SIZE)
> */
> +		- log2(SIZE(mem_section));
> +}
> +
> +/*
>   *  Do all necessary machine-specific setup here.  This is called
>   several
>   *  times during initialization.
>   */
> @@ -350,13 +364,14 @@ s390x_init(int when)
>  		if (!machdep->hz)
>  			machdep->hz = HZ;
>  		machdep->section_size_bits = _SECTION_SIZE_BITS;
> -		machdep->max_physmem_bits = _MAX_PHYSMEM_BITS;
> +		machdep->max_physmem_bits = s390x_max_physmem_bits();
>  		s390x_offsets_init();
>  		break;
>  
>  	case POST_INIT:
>  		break;
>  	}
> +	fprintf(stderr, "XXX %d\n", machdep->max_physmem_bits);
>  }
>  
>  /*
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
