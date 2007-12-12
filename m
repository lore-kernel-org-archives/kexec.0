Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J2FqJ-00013L-R5
	for kexec@lists.infradead.org; Wed, 12 Dec 2007 00:53:02 +0000
Date: Tue, 11 Dec 2007 19:52:02 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071212005202.GA19016@hmsreliant.think-freely.org>
References: <20071211034349.GA3635@localhost.localdomain>
	<m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<20071211182254.GB10999@hmsreliant.think-freely.org>
	<m1ejdtysqd.fsf@ebiederm.dsl.xmission.com>
	<20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
	<475F2860.2080203@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <475F2860.2080203@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ben Woodard <woodard@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Dec 11, 2007 at 04:16:32PM -0800, Ben Woodard wrote:
> We may need to go back and do some additional work on this. It doesn't 
> seem to be quite as cut and dried as we initially thought.
> 
> This quirk doesn't appear to work on virtually the same motherboard with 
> the barcelona processors in it. It also may be sensitive to the firmware 
> version.  More extensive testing on a larger number of pre-production is 
> not showing it to be as effective as it appeared to be initially on the 
> testbed.
> 
> I'm doing some retesting to figure out what exact situations and 
> collection of patches were able to make it work before.
> 
Ben, please lets be clear about this.  You say this patch doesn't help on a new
system.  Even thought its almost the exact same system, its not the same system.
Does this patch work consistently on the system you initially reported the
problem on?  I've done enough work on this at this point that I'm invested in
not abandoning this fix.  If this solves the problem on dual core system, but
not quad core, I'd much rather move forward with this fix and address your quad
core problem as a separate issue.

Neil

> -ben
> 
> 
> 
> Neil Horman wrote:
> > Recently a kdump bug was discovered in which a system would hang inside
> > calibrate_delay during the booting of the kdump kernel.  This was caused by the
> > fact that the jiffies counter was not being incremented during timer
> > calibration.  The root cause of this problem was found to be a bios
> > misconfiguration of the hypertransport bus.  On system affected by this hang,
> > the bios had assigned APIC ids which used extended apic bits (more than the
> > nominal 4 bit ids's), but failed to configure bit 17 of the hypertransport
> > transaction config register, which indicated that the mask for the destination
> > field of interrupt packets accross the ht bus (see section 3.3.9 of
> > http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26094.PDF).
> > If a crash occurs on a cpu with an APIC id that extends beyond 4 bits, it will
> > not recieve interrupts during the kdump kernel boot, and this hang will be the
> > result.  The fix is to add this patch, whcih add an early pci quirk check, to
> > forcibly enable this bit in the httcfg register.  This enables all cpus on a
> > system to receive interrupts, and allows kdump kernel bootup to procede
> > normally.
> > 
> > Regards
> > Neil
> > 
> > 
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > 
> > 
> >  early-quirks.c |   90 +++++++++++++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 69 insertions(+), 21 deletions(-)
> > 
> > 
> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > index 88bb83e..c0d0c69 100644
> > --- a/arch/x86/kernel/early-quirks.c
> > +++ b/arch/x86/kernel/early-quirks.c
> > @@ -21,8 +21,36 @@
> >  #include <asm/gart.h>
> >  #endif
> >  
> > -static void __init via_bugs(void)
> > +static void __init fix_hypertransport_config(int num, int slot, int func)
> >  {
> > +	u32 htcfg;
> > +	/*
> > +	 *we found a hypertransport bus
> > +	 *make sure that are broadcasting
> > +	 *interrupts to all cpus on the ht bus
> > +	 *if we're using extended apic ids
> > +	 */
> > +	htcfg = read_pci_config(num, slot, func, 0x68);
> > +	if (htcfg & (1 << 18)) {	
> > +		printk(KERN_INFO "Detected use of extended apic ids on hypertransport bus\n");
> > +		if ((htcfg & (1 << 17)) == 0) {
> > +			printk(KERN_INFO "Enabling hypertransport extended apic interrupt broadcast\n");
> > +			printk(KERN_INFO "Note this is a bios bug, please contact your hw vendor\n");
> > +			htcfg |= (1 << 17);
> > +			write_pci_config(num, slot, func, 0x68, htcfg);
> > +		}
> > +	}
> > +
> > +	
> > +}
> > +
> > +static void __init via_bugs(int  num, int slot, int func)
> > +{
> > +	static int fix_applied = 0;
> > +
> > +	if (fix_applied++)
> > +		return;
> > +
> >  #ifdef CONFIG_GART_IOMMU
> >  	if ((end_pfn > MAX_DMA32_PFN ||  force_iommu) &&
> >  	    !gart_iommu_aperture_allowed) {
> > @@ -44,8 +72,13 @@ static int __init nvidia_hpet_check(struct acpi_table_header *header)
> >  #endif /* CONFIG_X86_IO_APIC */
> >  #endif /* CONFIG_ACPI */
> >  
> > -static void __init nvidia_bugs(void)
> > +static void __init nvidia_bugs(int num, int slot, int func)
> >  {
> > +	static int fix_applied = 0;
> > +
> > +	if (fix_applied++)
> > +		return;
> > +
> >  #ifdef CONFIG_ACPI
> >  #ifdef CONFIG_X86_IO_APIC
> >  	/*
> > @@ -72,8 +105,13 @@ static void __init nvidia_bugs(void)
> >  
> >  }
> >  
> > -static void __init ati_bugs(void)
> > +static void __init ati_bugs(int num, int slot, int func)
> >  {
> > +	static int fix_applied = 0;
> > +
> > +	if (fix_applied++)
> > +		return;
> > +
> >  #ifdef CONFIG_X86_IO_APIC
> >  	if (timer_over_8254 == 1) {
> >  		timer_over_8254 = 0;
> > @@ -84,14 +122,18 @@ static void __init ati_bugs(void)
> >  }
> >  
> >  struct chipset {
> > -	u16 vendor;
> > -	void (*f)(void);
> > +	u32 vendor;
> > +	u32 device;
> > +	u32 class;
> > +	u32 class_mask;
> > +	void (*f)(int num, int slot, int func);
> >  };
> >  
> >  static struct chipset early_qrk[] __initdata = {
> > -	{ PCI_VENDOR_ID_NVIDIA, nvidia_bugs },
> > -	{ PCI_VENDOR_ID_VIA, via_bugs },
> > -	{ PCI_VENDOR_ID_ATI, ati_bugs },
> > +	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, nvidia_bugs },
> > +	{ PCI_VENDOR_ID_VIA, PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, via_bugs },
> > +	{ PCI_VENDOR_ID_ATI, PCI_ANY_ID, PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, ati_bugs },
> > +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB, PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, fix_hypertransport_config },
> >  	{}
> >  };
> >  
> > @@ -106,27 +148,33 @@ void __init early_quirks(void)
> >  	for (num = 0; num < 32; num++) {
> >  		for (slot = 0; slot < 32; slot++) {
> >  			for (func = 0; func < 8; func++) {
> > -				u32 class;
> > -				u32 vendor;
> > +				u16 class;
> > +				u16 vendor;
> > +				u16 device;
> >  				u8 type;
> >  				int i;
> > -				class = read_pci_config(num,slot,func,
> > +
> > +				class = read_pci_config_16(num,slot,func,
> >  							PCI_CLASS_REVISION);
> > -				if (class == 0xffffffff)
> > +				if (class == 0xffff)
> >  					break;
> >  
> > -				if ((class >> 16) != PCI_CLASS_BRIDGE_PCI)
> > -					continue;
> > -
> > -				vendor = read_pci_config(num, slot, func,
> > +				vendor = read_pci_config_16(num, slot, func,
> >  							 PCI_VENDOR_ID);
> > -				vendor &= 0xffff;
> >  
> > -				for (i = 0; early_qrk[i].f; i++)
> > -					if (early_qrk[i].vendor == vendor) {
> > -						early_qrk[i].f();
> > -						return;
> > +				device = read_pci_config_16(num, slot, func,
> > +							PCI_DEVICE_ID);
> > +
> > +				for(i=0;early_qrk[i].f != NULL;i++) {
> > +					if (((early_qrk[i].vendor == PCI_ANY_ID) ||
> > +					    (early_qrk[i].vendor == vendor)) &&
> > +					   ((early_qrk[i].device == PCI_ANY_ID) ||
> > +					    (early_qrk[i].device == device)) &&
> > +					   (!((early_qrk[i].class ^ class) & 
> > +					     early_qrk[i].class_mask))) {
> > +						early_qrk[i].f(num, slot, func);
> >  					}
> > +				}
> >  
> >  				type = read_pci_config_byte(num, slot, func,
> >  							    PCI_HEADER_TYPE);
> 
> 
> -- 
> -ben
> -=-
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
