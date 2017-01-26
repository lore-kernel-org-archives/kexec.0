Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cWiDw-0002Nx-El
 for kexec@lists.infradead.org; Thu, 26 Jan 2017 11:28:18 +0000
Received: by mail-pf0-f173.google.com with SMTP id e4so64987412pfg.1
 for <kexec@lists.infradead.org>; Thu, 26 Jan 2017 03:27:55 -0800 (PST)
Date: Thu, 26 Jan 2017 20:28:12 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v30 05/11] arm64: kdump: protect crash dump kernel memory
Message-ID: <20170126112811.GG23406@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
 <20170124085004.3892-4-takahiro.akashi@linaro.org>
 <5888E262.4050208@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5888E262.4050208@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

James,

I will try to revisit your comments later, but quick replies now

On Wed, Jan 25, 2017 at 05:37:38PM +0000, James Morse wrote:
> Hi Akashi,
> 
> On 24/01/17 08:49, AKASHI Takahiro wrote:
> > To protect the memory reserved for crash dump kernel once after loaded,
> > arch_kexec_protect_crashres/unprotect_crashres() are meant to deal with
> > permissions of the corresponding kernel mappings.
> > 
> > We also have to
> > - put the region in an isolated mapping, and
> > - move copying kexec's control_code_page to machine_kexec_prepare()
> > so that the region will be completely read-only after loading.
> 
> 
> > Note that the region must reside in linear mapping and have corresponding
> > page structures in order to be potentially freed by shrinking it through
> > /sys/kernel/kexec_crash_size.
> 
> Nasty! Presumably you have to build the crash region out of individual page
> mappings,

This might be an alternative, but

> so that they can be returned to the slab-allocator one page at a time,
> and still be able to set/clear the valid bits on the remaining chunk.
> (I don't see how that happens in this patch)

As far as shrinking feature is concerned, I believe, crash_shrink_memory(),
which eventually calls free_reserved_page(), will take care of all the things
to do. I can see increased number of "MemFree" in /proc/meminfo.
(Please note that the region is memblock_reserve()'d at boot time.)

> debug_pagealloc has to do this too so it can flip the valid bits one page at a
> time. You could change the debug_pagealloc_enabled() value passed in at the top
> __create_pgd_mapping() level to be a needs_per_page_mapping(addr, size) test
> that happens as we build the linear map. (This would save the 3 extra calls to
> __create_pgd_mapping() in __map_memblock())
> 
> I'm glad to see you can't resize the region if a crash kernel is loaded!
> 
> This secretly-unmapped is the sort of thing that breaks hibernate, it blindly
> assumes pfn_valid() means it can access the page if it wants to. Setting
> PG_Reserved is a quick way to trick it out of doing this, but that would leave
> the crash kernel region un-initialised after resume, while kexec_crash_image
> still has a value.

Ouch, I didn't notice this issue.

> I think the best fix for this is to forbid hibernate if kexec_crash_loaded()
> arguing these are mutually-exclusive features, and the protect crash-dump
> feature exists to prevent things like hibernate corrupting the crash region.

This restriction is really painful.
Is there any hibernation hook that will be invoked before suspending and
after resuming? If so, arch_kexec_unprotect_crashkres()/protect_crashkres()
will be able to be called.

Or if "read-only (without unmapping)" approach would be acceptable, 
those two features might be no longer mutually-exclusive.

> 
> 
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index bc96c8a7fc79..f7938fecf3ff 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -159,32 +171,20 @@ void machine_kexec(struct kimage *kimage)
> >  		kimage->control_code_page);
> >  	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
> >  		&reboot_code_buffer_phys);
> > -	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
> > -		reboot_code_buffer);
> >  	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
> >  		arm64_relocate_new_kernel);
> >  	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
> >  		__func__, __LINE__, arm64_relocate_new_kernel_size,
> >  		arm64_relocate_new_kernel_size);
> >  
> > -	/*
> > -	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
> > -	 * after the kernel is shut down.
> > -	 */
> > -	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
> > -		arm64_relocate_new_kernel_size);
> > -
> > -	/* Flush the reboot_code_buffer in preparation for its execution. */
> > -	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
> > -	flush_icache_range((uintptr_t)reboot_code_buffer,
> > -		arm64_relocate_new_kernel_size);
> 
> 
> 
> > -	/* Flush the kimage list and its buffers. */
> > -	kexec_list_flush(kimage);
> > +	if (kimage != kexec_crash_image) {
> > +		/* Flush the kimage list and its buffers. */
> > +		kexec_list_flush(kimage);
> >  
> > -	/* Flush the new image if already in place. */
> > -	if (kimage->head & IND_DONE)
> > -		kexec_segment_flush(kimage);
> > +		/* Flush the new image if already in place. */
> > +		if (kimage->head & IND_DONE)
> > +			kexec_segment_flush(kimage);
> > +	}
> 
> So for kdump we cleaned the kimage->segment[i].mem regions in
> arch_kexec_protect_crashkres(), so don't need to do it here.

Correct.

> What about the kimage->head[i] array of list entries that were cleaned by
> kexec_list_flush()? Now we don't clean that for kdump either, but we do pass it
> arm64_relocate_new_kernel() at the end of this function:
> > cpu_soft_restart(1, reboot_code_buffer_phys, kimage->head, kimage_start, 0);

Kimage->head holds a list of memory regions that are overlapped
between the primary kernel and the secondary kernel, but in kedump case,
the whole memory is isolated and the list should be empty.

That is why kexec_list_flush() is skipped here, but yes,
"kimage->head" might better be cleaned anyway.
(I believe, from the past discussions, that cache coherency is still
maintained in kdump case though.)

> Can we test the IND_DONE_BIT of kimage->head, so that we know that
> arm64_relocate_new_kernel() won't try to walk the unclean list?
> Alternatively we could call kexec_list_flush() in arch_kexec_protect_crashkres()
> too.

So call kexec_list_flush() in machine_kexec() either in kexec or kdump.

Thanks,
-Takahiro AKASHI

> 
> 
> Thanks,
> 
> James
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
