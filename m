Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHfhk-0007NE-Ed
 for kexec@lists.infradead.org; Tue, 08 Oct 2019 02:58:30 +0000
Date: Tue, 8 Oct 2019 10:58:22 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] x86/kdump: Fix 'kmem -s' reported an invalid
 freepointer when SME was active
Message-ID: <20191008025822.GM31919@MiWiFi-R3L-srv>
References: <20191007070844.15935-1-lijiang@redhat.com>
 <20191007093338.GA4710@dhcp-128-65.nay.redhat.com>
 <e179c616-f427-769f-aa5b-058c63040015@redhat.com>
 <87bluseaz2.fsf@x220.int.ebiederm.org>
 <20191008024447.GL31919@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191008024447.GL31919@MiWiFi-R3L-srv>
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
To: lijiang <lijiang@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>
Cc: jgross@suse.com, Thomas.Lendacky@amd.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

On 10/08/19 at 10:44am, Baoquan He wrote:
> On 10/07/19 at 12:12pm, Eric W. Biederman wrote:
> > This has only been boot tested but I think this is about what we need.
> > 
> > I feel like I haven't found and deleted all of the backup region code.
> > 
> > I think it is important to have the reservation code in reseve_real_mode
> > as the logic is fundamentally intertwined.
> > 
> > Eric
> > 
> > 
> > From: "Eric W. Biederman" <ebiederm@xmission.com>
> > Date: Mon, 7 Oct 2019 11:57:24 -0500
> > Subject: [PATCH] x86/kexec: Always reserve the low 1MiB
> > 
> > When the crashkernel kernel command line option is specified always
> > reserve the low 1MiB.    That way it does not need to be included
> > in crash dumps or used for anything execept the processor trampolines
> > that must live in the low 1MiB.
> > 
> > The current handling of copying the low 1MiB runs into problems when
> > SME is active.  So just simplify everything and make it unnecessary
> > to do anything with the low 1MiB.
> > 
> > This comes at a cost of 640KiB.  But when crash kernels need 32MiB or
> > more to run this isn't much more, and it makes everything much more
> > reliable.
> > 
> > Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> > ---
> >  arch/x86/include/asm/kexec.h   |  4 ----
> >  arch/x86/kernel/crash.c        | 19 -------------------
> >  arch/x86/purgatory/purgatory.c | 15 ---------------
> >  arch/x86/realmode/init.c       | 10 ++++++++++
> >  4 files changed, 10 insertions(+), 38 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
> > index 5e7d6b46de97..e36307ac324d 100644
> > --- a/arch/x86/include/asm/kexec.h
> > +++ b/arch/x86/include/asm/kexec.h
> > @@ -66,10 +66,6 @@ struct kimage;
> >  # define KEXEC_ARCH KEXEC_ARCH_X86_64
> >  #endif
> >  
> > -/* Memory to backup during crash kdump */
> > -#define KEXEC_BACKUP_SRC_START	(0UL)
> > -#define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
> > -
> >  /*
> >   * This function is responsible for capturing register states if coming
> >   * via panic otherwise just fix up the ss and sp if coming via kernel
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index eb651fbde92a..dc4773d2f4a6 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -409,31 +409,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
> >  	return ret;
> >  }
> >  
> > -static int determine_backup_region(struct resource *res, void *arg)
> > -{
> > -	struct kimage *image = arg;
> > -
> > -	image->arch.backup_src_start = res->start;
> > -	image->arch.backup_src_sz = resource_size(res);
> > -
> > -	/* Expecting only one range for backup region */
> > -	return 1;
> > -}
> > -
> >  int crash_load_segments(struct kimage *image)
> >  {
> >  	int ret;
> >  	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
> >  				  .buf_max = ULONG_MAX, .top_down = false };
> >  
> > -	/*
> > -	 * Determine and load a segment for backup area. First 640K RAM
> > -	 * region is backup source
> > -	 */
> > -
> > -	ret = walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
> > -				image, determine_backup_region);
> > -
> >  	/* Zero or postive return values are ok */
> >  	if (ret < 0)
> >  		return ret;
> > diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
> > index 3b95410ff0f8..448de04703ba 100644
> > --- a/arch/x86/purgatory/purgatory.c
> > +++ b/arch/x86/purgatory/purgatory.c
> > @@ -22,20 +22,6 @@ u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(.kexec-purgatory);
> >  
> >  struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] __section(.kexec-purgatory);
> >  
> > -/*
> > - * On x86, second kernel requries first 640K of memory to boot. Copy
> > - * first 640K to a backup region in reserved memory range so that second
> > - * kernel can use first 640K.
> > - */
> > -static int copy_backup_region(void)
> > -{
> > -	if (purgatory_backup_dest) {
> > -		memcpy((void *)purgatory_backup_dest,
> > -		       (void *)purgatory_backup_src, purgatory_backup_sz);
> > -	}
> > -	return 0;
> > -}
> > -
> >  static int verify_sha256_digest(void)
> >  {
> >  	struct kexec_sha_region *ptr, *end;
> > @@ -66,7 +52,6 @@ void purgatory(void)
> >  		for (;;)
> >  			;
> >  	}
> > -	copy_backup_region();
> >  }
> >  
> >  /*
> > diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> > index 7dce39c8c034..76c680ad23a1 100644
> > --- a/arch/x86/realmode/init.c
> > +++ b/arch/x86/realmode/init.c
> > @@ -34,6 +34,16 @@ void __init reserve_real_mode(void)
> >  
> >  	memblock_reserve(mem, size);
> >  	set_real_mode_mem(mem);
> > +
> > +#ifdef CONFIG_KEXEC_CORE
> > +	/* When crashkernel is specified only use the low 1MiB for the
> > +	 * real mode trampolines.
> > +	 */
> > +	if (strstr(boot_command_line, "crashkernel=")) {
> > +		memblock_reserve(0, 1<<20);
> > +		pr_info("Reserving low 1MiB of memory for crashkernel\n");
> > +	}
> 
> Reserving low 1M looks good to me. The memblock reserved pages won't
> enter into buddy allocator, unless they are freed explicitly with
> memblock_free() later.
> > +#endif /* CONFIG_KEXEC_CORE */
> 
> I doubt this patch can work in kdump kernel booting. Because the low 1MB
> is not passed to kdump kernel as system RAM, please check below code.
> 
> /* Prepare memory map for crash dump kernel */
> int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
> {
> ......
> 
>         /* Add first 640K segment */                                                                                                              
>         ei.addr = image->arch.backup_src_start;
>         ei.size = image->arch.backup_src_sz;
>         ei.type = E820_TYPE_RAM;
>         add_e820_entry(params, &ei);
> 
> ......
> }

The current code will dig out one block of 640K from crashkernel region,
we call it the backup region, then copy its low 640K to this backup region.
the low 640K will be added to kdump kernel as system RAM, and the backup
region will be mapped to the [0,640K] of the vmcore elf file of the 1st
kernel. So we can memblock reserve low 1MB, and add it to kdump kernel
as system RAM in crash_setup_memmap_entries(), then clean up all the
other backup related old code, just based on Eric's patch.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
