Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]
	helo=VA3EHSOBE009.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OcNqb-0001p3-Vh
	for kexec@lists.infradead.org; Fri, 23 Jul 2010 19:23:55 +0000
Subject: Re: kexec for powerpc mpc83xx processors
From: Matthew McClintock <msm@freescale.com>
In-Reply-To: <AANLkTikGM3wFFUYDLOvrG65FtsJseYwnbGRh62e95j6E@mail.gmail.com>
References: <AANLkTin0h-QftwCqLl0Yn7pi_JWlewC_VWSl01IPPwp-@mail.gmail.com>
	<1278948593.9525.3.camel@localhost>
	<20100713025819.GA23313@verge.net.au>
	<AANLkTimEjIx1lh7YJHg7-WeKZYNFYve73vl8k_C5KvAR@mail.gmail.com>
	<1279292915.4556.0.camel@localhost>
	<AANLkTikGM3wFFUYDLOvrG65FtsJseYwnbGRh62e95j6E@mail.gmail.com>
Date: Fri, 23 Jul 2010 14:25:13 -0500
Message-ID: <1279913113.22023.11.camel@localhost>
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
To: krish <radhakrishna.p@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On Fri, 2010-07-23 at 15:34 +0530, krish wrote:
> Hello Matthew,
> 
> Now, i am able to execute kexec successfully on mpc83xx platforms.
> Thanks for your support.
> 
> But, My requirement is as follows:
> The kexec always loads kernel and dtb images in to memory and starts
> the new kernel loaded. But, I want to start the same kernel every
> time.

You mean you don't want to load a new kernel you just want to reboot the
current kernel in place? I don't think that is possible nor an small
task.

> 
> I am not sure whether i can post this message to kexec-mailing list,
> If required i will add kexec-mailing list in CC. 

Generally, it's always best to post to the list as it will get you the
most responses.

> 
> I believe that the scheme i am trying had been already experimented by
> developers.
> 
> To acheive this, i have made few changes in kernel-2.6.26 version.
> But, it was stuck after jumping to start address.
> I have followed the steps used by "kexec -e" to restart kernel again.
> Appreciate your suggestions.....
> 
> I have modified the restart function and added code to allocate a
> control page and copied reboot_code_buffer, which is written in
> misc_32.S file.
> Following are the code changes made by me.

I'm not sure what version of the kernel you are working with, but as I
believe I said before you need a recent version of the kernel tree and
there is code present that might do what you are trying to do below.

For starters. You can pull Kumar's powerpc tree which should be a better
                                                         starting point:

http://git.kernel.org/?p=linux/kernel/git/galak/powerpc.git;a=summary

The default routines in this kernel should work on an 83xx if you said
the changes you made below work. But, I have not tested on the 83xx. I
think I remember someone saying it worked.

-M


> 
>   1 Index: arch/powerpc/kernel/misc_32.S
>   2
> ===================================================================
>   3 RCS
> file: /tn100/cvs/LINUX/linux-2.6.26/arch/powerpc/kernel/misc_32.S,v
>   4 retrieving revision 1.1
>   5 diff -u -r1.1 misc_32.S
>   6 --- arch/powerpc/kernel/misc_32.S   4 Sep 2008 11:05:10 -0000
> 1.1
>   7 +++ arch/powerpc/kernel/misc_32.S   23 Jul 2010 09:39:04 -0000
>   8 @@ -868,6 +868,7 @@
>   9  _GLOBAL(__main)
>  10     blr
>  11 
>  12  #ifdef CONFIG_KEXEC
>  13     /*
>  14      * Must be relocatable PIC code callable as a C function.
>  15 @@ -961,6 +962,13 @@
>  16      */
>  17     isync
>  18     sync
>  19  
>  20     /* jump to the entry point, usually the setup routine */
>  21     mtlr    r5 
>  22 @@ -974,3 +982,170 @@
>  23  relocate_new_kernel_size:
>  24     .long relocate_new_kernel_end - relocate_new_kernel
>  25  #endif
>  26 +
>  27 +#define RK_KERNELBASE   0x0 /* KERNELBASE */
>  28 +    .global rk_restart
>  29 +rk_restart:    
>  30 +    li r8,0
>  31 +    ori r8,r8,MSR_RI|MSR_ME
>  32 +    mtspr SPRN_SRR1,r8
>  33 +    addi r8,r4,1f-rk_restart
>  34 +    mtspr SPRN_SRR0,r8
>  35 +    sync
>  36 +    rfi
>  37 +
>  38 +    /* Set environment variables to start kernel */
>  39 +1:  lis r4,RK_KERNELBASE@h
>  40 +    ori r4,r4,RK_KERNELBASE@l
>  41 +    li r5,0x01
>  42 +    li r6,0
>  43 +
>  44 +    isync
>  45 +    mtlr r4
>  46 +    sync
>  47 +    isync
>  48 +    blrl
>  49 +
>  50 +rk_restart_end:
>  51 +    .global rk_restart_size
>  52 +rk_restart_size:
>  53 +   .long rk_restart_end - rk_restart 
> 
>  
>   1 Index: arch/powerpc/platforms/83xx/mpc837x_rdb.c
>   2
> ===================================================================
>   3 RCS
> file: /tn100/cvs/LINUX/linux-2.6.26/arch/powerpc/platforms/83xx/mpc837x_rdb.c,v
>   4 retrieving revision 1.1
>   5 diff -u -r1.1 mpc837x_rdb.c
>   6 --- arch/powerpc/platforms/83xx/mpc837x_rdb.c   4 Sep 2008
> 11:05:13 -0000   1.1
>   7 +++ arch/powerpc/platforms/83xx/mpc837x_rdb.c   23 Jul 2010
> 09:38:51 -0000
>   8 @@ -17,6 +17,7 @@
>   9  #include <asm/time.h>
>  10  #include <asm/ipic.h>
>  11  #include <asm/udbg.h>
>  12 +#include <asm/cacheflush.h>
>  13 
>  14  #include "mpc83xx.h"
>  15 
>  16 @@ -82,10 +83,70 @@
>  17  {
>  18     unsigned long root = of_get_flat_dt_root();
>  19 
>  20     return of_flat_dt_is_compatible(root, "fsl,mpc8377rdb") ||
>  21            of_flat_dt_is_compatible(root, "fsl,mpc8378rdb") ||
>  22            of_flat_dt_is_compatible(root, "fsl,mpc8379rdb");
>  23  }
>  24 +
>  25 +typedef NORET_TYPE void ( * rk_restart_t)(phys_addr_t dtb_paddr,
> phys_addr_t rb_code_paddr)ATTRIB_NORET;
>  26 +void tj_restart(char *cmd)
>  27 +{
>  28 +    extern const u8 rk_restart[];
>  29 +    extern const u32 rk_restart_size;
>  30 +    rk_restart_t rkr;
>  31 +    struct page *rb_code_page;
>  32 +    u32 rb_code_vaddr;
>  33 +    phys_addr_t rb_code_paddr;
>  34 +    unsigned long flags;
>  35 +    extern struct boot_param_header *initial_boot_params;
>  36 +    phys_addr_t dtb_paddr;
>  37 +
>  38 +    local_irq_save(flags);
>  39+
>  40 +
>  41 +    /* Get physical address of DTB */
>  42 +    dtb_paddr = virt_to_phys((void *)initial_boot_params);
>  43 +    printk("DTB paddr: %08x\n", dtb_paddr);
>  44 +
>  45 +    /* Allocate a page for reboot code */
>  46 +    rb_code_page = alloc_pages(GFP_KERNEL, get_order(4096));
>  47 +    if (rb_code_page == NULL) {
>  48 +        printk("Failed to alloc page for reboot code\n");
>  49 +        printk("Going for processor restart\n");
>  50 +        mpc83xx_restart(cmd);
>  51 +    }
>  52 +    rb_code_vaddr = (u32)page_address(rb_code_page);
>  53 +    rb_code_paddr = virt_to_phys((void *)rb_code_vaddr);
>  54 +    printk("rb_code_page: %08x, rb_code_vaddr: %08x,
> rb_code_paddr: %08x\n", (u32)rb_code_page, rb_code_vaddr,
> rb_code_paddr);
>  55 +    memcpy((void *)rb_code_vaddr, rk_restart, rk_restart_size);
>  56 +    flush_icache_range(rb_code_vaddr, rb_code_vaddr
> +rk_restart_size);
>  57 +    rkr = (rk_restart_t)rb_code_vaddr;
>  58 +
>  59 +    printk("Restarting OS ...\n");
>  60 +    (*rkr)(dtb_paddr, rb_code_paddr);
>  61 +    printk("This message should not print..\n");
>  62 +    while (1);
>  63 +}
>  64 +
>  65 
>  66  define_machine(mpc837x_rdb) {
>  67     .name           = "MPC837x RDB",
>  68 @@ -93,7 +154,8 @@
>  69     .setup_arch     = mpc837x_rdb_setup_arch,
>  70     .init_IRQ       = mpc837x_rdb_init_IRQ,
>  71     .get_irq        = ipic_get_irq,
>  72 -   .restart        = mpc83xx_restart,
>  73 +// .restart        = mpc83xx_restart,
>  74 +   .restart        = tj_restart,
>  75     .time_init      = mpc83xx_time_init,
>  76     .calibrate_decr     = generic_calibrate_decr,
>  77     .progress       = udbg_progress,
> 
> 
> 
> ============================== 
> 
> On Fri, Jul 16, 2010 at 8:38 PM, Matthew McClintock
> <msm@freescale.com> wrote:
>         On Fri, 2010-07-16 at 11:42 +0530, krish wrote:
>         > Thanks for the announcement of new release.
>         >
>         > I have successfully compiled for mpc83xx, but execution was
>         failed
>         > with following message
>         > "Symbol: mem_size found cannot set".
>         >
>         > The root cause behind it was that pul_stack and mem_size
>         symbols are
>         > not defined in purgatory/arch/ppc/purgatory-ppc.c file.
>         > Correct me if i am wrong.
>         >
>         > As i am new to git, I am going through the git user manual
>         to sync
>         > with the latest sources and if possible to provide code
>         changes in
>         > patch-format..
>         
>         
>         My patches to the list recently should address those issues.
>         
>         -M
>         
>         
> 




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
