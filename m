Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1N2myr-0000sw-IN
	for kexec@lists.infradead.org; Tue, 27 Oct 2009 14:25:06 +0000
Date: Tue, 27 Oct 2009 10:24:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Kdump issue with percpu_alloc=lpage (Was:Re: crash_notes posted to
	kexec-tools)
Message-ID: <20091027142419.GB10513@redhat.com>
References: <4AE5CF6F.40706@ccur.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE5CF6F.40706@ccur.com>
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
To: John Blackwood <john.blackwood@ccur.com>, Tejun Heo <tj@kernel.org>
Cc: kexec@lists.infradead.org

On Mon, Oct 26, 2009 at 11:33:51AM -0500, John Blackwood wrote:
> >
> > Hi Vivek and Dave,
> >
> > While doing some testing with crash, I noticed that on newer (2.6.31.x)
> > NUMA x86_64 kernels, the physical address output by the
> >
> >   /sys/devices/system/cpu/cpu1/crash_notes
> >
> > sysfs file is not correct on NUMA architecture systems.
> >

Hi John,

I am not very sure about how new per cpu allocator options will affect
our ability to determine physical address for the memory allocations
we requested for. I am CCing Tejun Heo. He might have answers here.

Tejun,

In kdump, we allocate per cpu area using alloc_percpu() and later
export the physical address of the area allocated to user space through
sysfs. (/sys/devices/system/cpu/cpuN/crash_notes). kexec-tools user space
utility makes use of this physical address to store in some ELF headers
which in turn are used by the second kernel booted after crash.

We assume that address returned by per_cpu_ptr() is unity mapped and
use __pa() to convert that address to physical address.

addr = __pa(per_cpu_ptr(crash_notes, cpunum));

Is that not a valid assumption with percpu_alloc=lpage or percpu_alloc=4k
options? If not, what's the right way to get the physical address in
such situations?

Thanks
Vivek

>
> Hi Vivek,
>
> Sorry for the interruption, but I just wanted to mention
> that I decided not to post this issue to the crash mailing list,
> but instead to the kexec-tools mailing list.
>
> The post to the kexec-tools mailing list is below.
> Thank you.
> ------------------------------------- -------------------------------------
>
> Hello,
>
> When attempting to generate a crash file on a on newer (2.6.31.x) NUMA
> x86_64 kernel, the kdump kernel was unable to initialize the /proc/vmcore
> file due to a bad physical address specified in the elf header for a
> per-cpu crash notes area.
>
> It turns out that the physical address that kexec reads from the output
> of the:
>
>   /sys/devices/system/cpu/cpu1/crash_notes
>
> sysfs file is not correct for NUMA x86_64 architecture systems, and this
> physical address is used in the elfheader that the kdump kernel attempts
> to use to initialize /proc/vmcore.
>
> I believe that this has to do with the new percpu_alloc=lpage and
> percpu_alloc=4k per-cpu setups that are now used.
>
> In those cases, the __pa(per_cpu_ptr(crash_notes, cpunum)) does not
> return the correct physical address value.
>
> I did a rough stab at getting the correct physical address for the
> 'lpage' case (which I believe tends to be the default method used),
> but I was unable to figure out how to get the correct physical address
> for the '4k' page case.
>
> For what ever it's worth, here's a patch of my attempt at the lpage version;
> it might or might not be useful.
>
> ( This patch really assumes only x86 or x86_64 builds, since
> the asm/percpu.h header file is only for x86 arch. )
>
> Thank you.
>
>
> diff -rup a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> --- a/arch/x86/include/asm/percpu.h	2009-10-26 09:33:37.000000000 -0500
> +++ b/arch/x86/include/asm/percpu.h	2009-10-26 09:33:53.000000000 -0500
> @@ -165,6 +165,15 @@ static inline void *pcpu_lpage_remapped(
>  }
>  #endif
>
> +#if defined(CONFIG_NEED_MULTIPLE_NODES) && defined(CONFIG_X86_64)
> +unsigned long long pcpul_get_paddr(int cpunum, void *item);
> +#else
> +static inline unsigned long long pcpul_get_paddr(int cpunum, void *item)
> +{
> +	return (unsigned long long)NULL;
> +}
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>
>  #ifdef CONFIG_SMP
> diff -rup a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
> --- a/arch/x86/kernel/setup_percpu.c	2009-10-26 09:33:37.000000000 -0500
> +++ b/arch/x86/kernel/setup_percpu.c	2009-10-26 09:33:53.000000000 -0500
> @@ -314,6 +314,35 @@ void *pcpu_lpage_remapped(void *kaddr)
>
>  	return NULL;
>  }
> +
> +#ifdef CONFIG_X86_64
> +/*
> + * Return the physical address of the percpu data item for the
> + * specified cpu.
> + *
> + * Returns a physical address or NULL if pcpul_map is not being used.
> + * Currently only called by show_crash_notes().
> + */
> +unsigned long long pcpul_get_paddr(int cpunum, void *item)
> +{
> +	struct pcpul_ent *pmp;
> +	void *vaddr, *offset;
> +	unsigned long long paddr = (unsigned long long)NULL;
> +
> +	if (!pcpul_map)
> +		return paddr;
> +	for (pmp = pcpul_map; pmp->ptr; pmp++) {
> +		if ((int)pmp->cpu != cpunum)
> +			continue;
> +		offset = per_cpu_ptr(item, cpunum) - __per_cpu_offset[cpunum];
> +		vaddr = pmp->ptr + (long unsigned int)offset;
> +		paddr = __pa(vaddr);
> +		return paddr;
> +	}
> +	return paddr;
> +}
> +#endif
> +
>  #else
>  static ssize_t __init setup_pcpu_lpage(size_t static_size, bool chosen)
>  {
> diff -rup a/drivers/base/cpu.c b/drivers/base/cpu.c
> --- a/drivers/base/cpu.c	2009-10-26 09:33:37.000000000 -0500
> +++ b/drivers/base/cpu.c	2009-10-26 09:33:53.000000000 -0500
> @@ -97,6 +97,12 @@ static ssize_t show_crash_notes(struct s
>  	 * boot up and this data does not change there after. Hence this
>  	 * operation should be safe. No locking required.
>  	 */
> +	addr = pcpul_get_paddr(cpunum, crash_notes);
> +	if (addr) {
> +		rc = sprintf(buf, "%Lx\n", addr);
> +		return rc;
> +	}
> +
>  	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
>  	rc = sprintf(buf, "%Lx\n", addr);
>  	return rc;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
