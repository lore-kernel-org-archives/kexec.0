Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1411671771.6001.208.camel@smoke>
Subject: Re: [PATCH 6/7] arm64/kexec: Add core kexec support
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 25 Sep 2014 12:02:51 -0700
In-Reply-To: <20140925182810.GB6303@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140925182810.GB6303@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

Hi Vivek,

On Thu, 2014-09-25 at 14:28 -0400, Vivek Goyal wrote:
> On Thu, Sep 25, 2014 at 12:23:27AM +0000, Geoff Levand wrote:
> [..]
> > +void machine_kexec(struct kimage *image)
> > +{
> > +	phys_addr_t reboot_code_buffer_phys;
> > +	void *reboot_code_buffer;
> > +
> > +	BUG_ON(num_online_cpus() > 1);
> > +
> > +	kexec_kimage_head = image->head;
> > +
> > +	reboot_code_buffer_phys = page_to_phys(image->control_code_page);
> > +	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
> > +
> > +	/*
> > +	 * Copy relocate_new_kernel to the reboot_code_buffer for use
> > +	 * after the kernel is shut down.
> > +	 */
> > +
> > +	memcpy(reboot_code_buffer, relocate_new_kernel,
> > +		relocate_new_kernel_size);
> > +
> > +	/* Flush the reboot_code_buffer in preparation for its execution. */
> > +
> > +	__flush_dcache_area(reboot_code_buffer, relocate_new_kernel_size);
> > +
> > +	/* Flush the kimage list. */
> > +
> > +	kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
> > +
> > +	pr_info("Bye!\n");
> > +
> > +	/* Disable all DAIF exceptions. */
> > +	
> > +	asm volatile ("msr daifset, #0xf" : : : "memory");
> > +
> > +	soft_restart(reboot_code_buffer_phys);
> 
> So what is soft_restart() functionality in arm64?

soft_restart() basically turns off the MMU and data caches, then jumps
to the address passed to it, reboot_code_buffer_phys here.
 
> Looks like it switches to identity mapped page tables and that seems
> to be the reason that you are not preparing identity mapped page
> tables in kexec code. I am wondering I how do you make sure that once
> kexec is swapping pages (putting new kernel's pages to its destination)
> at that time these identity page will not be overwritten?
> 
> I am assuming that you are jumping to purgatory with paging enabled
> and whole of the memory identity mapped.

The identity map is just used to turn off the MMU.  soft_restart() is in
that identity mapping, and once it shuts off the MMU it jumps to the
physical address of relocate_kernel, which uses physical addressing to
do the copy.

> I am also curious to know what are different entry points arm64
> kernel image supports and which one are you using by default.

The arm64 kernel as a single entry, the start of the image.  See
Documentation/arm64/booting.txt.

-Geoff



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
