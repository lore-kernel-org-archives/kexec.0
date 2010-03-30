Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NwfiX-0005Pu-4l
	for kexec@lists.infradead.org; Tue, 30 Mar 2010 17:59:13 +0000
Date: Tue, 30 Mar 2010 12:59:04 -0500
From: Jack Steiner <steiner@sgi.com>
Subject: Re: kdump/kexec on EFI-enabled x2apic platforms
Message-ID: <20100330175904.GA26220@sgi.com>
References: <20100329200104.GA23760@sgi.com> <m1zl1qydxq.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1zl1qydxq.fsf@fess.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: mingo@elte.hu, kexec@lists.infradead.org, tglx@linutronix.de, gleb@redhat.com, suresh.b.siddha@intel.com

On Mon, Mar 29, 2010 at 03:13:05PM -0700, Eric W. Biederman wrote:
> Jack Steiner <steiner@sgi.com> writes:
> 

Thnaks for the quick reply. I am still digging thru the issues but am making
good progress.

See comments below.


> > All -
> >
> > I just started debugging kdump/kexec on our UV platform and
> > have run into some problems. I suspect others have encountered these
> > same or similar problems. Any help would be appreciated.
> >
> >
> >
> > Our platform uses EFI boot. It is Nehalem based & has a large number of cpus.
> > The BIOS enables x2apic mode and the kernel runs with interrupt remapping enabled.
> > Note that some apicids have more than 8 bits - x2apic mode is required.
> >
> >
> > I am able to successfully kexec the dump kernel but run into several problems.
> >
> > 	- because the initial kernel boots using EFI, BIOS does not build the legacy
> > 	  tables that are required to locate the RSDP using the legacy method in
> > 	  acpi_find_root_pointer(). (When booting with EFI, acpi_find_root_pointer() is
> > 	  not used. The ACPI tables are found from pointers in EFI tables.)
> 
> Ouch.  EFI tables are a major pain to use because they are not 32/64 clean.  Thus
> making them unreasonably difficult to work with.
> 
> I believe the boot loader should be passing in the location of acpi tables instead
> of expecting the kernel to wade through EFI tables.

I made a temporary fix to the BIOS to build the legacy table used by
acpi_find_root_pointer() to locate the ACPI tables. I tested this on a system simulator &
it seems to work. ACPI tables are discovered and parsed correctly - at least for the
current BIOS & hardware configuration. I'll try this on real hardware later but
don't expect any problems.


> 
> > 	- it appears that kdump/kexec intentionally boots the kdump kernel
> > 	  in a mode does does enable efi mode. (Am I correct here???)
> > 	  This avoids the issues with EFI virtual mode. However, the result
> > 	  is that ACPI tables are not found. From the dump kernel:
> >
> > 	  	ACPI Error: A valid RSDP was not found (20090903/tbxfroot-222)
> 
> My personal opinion is that EFI virtual mode is a mistake.  We should not have
> any interactions with the EFI bios of sufficient frequency that we need an
> efficient virtual mapping.

Agree. The EFI virtual mode support was poorly architected as far as kdump/kexec is
concerned. We had a lot of problem on IA64, too.


> 
> 
> > 	- Because ACPI tables are not found, the dump kernel does not transition
> > 	  into x2apic mode. The hardware, however, is still in x2apic mode from the
> > 	  initial kernel. 
> 
> Hmm.  That is a bug of many flavors.  We should have transitions back into 
> i8259 legacy mode, before calling kdump.  Then regardless of what happen
> before we ran if the hardware is x2apic capable we should force the hardware
> into the mode we want it, not just assume x2apic mode is off by default.

It is not possible to transition back into non-x2apic mode. The initial transition
INTO x2apic mode is done by the BIOS - not the OS. X2apic mode is required because
apic ids are greater than 8 bits. Fortunately, now that we discover ACPI tables, the
OS is handling x2apic mode correctly.


With the above changes, I can now successfully boot to single user mode (simulator)
in the dump kernel. I may still have a few issues with lack-of EFI support but I think
I can work thru them. I did not see any problems on the simulator but might
hit them on hardware.


The only issue that still needs to be resolved (that I know of) is the memmap. The
E820 table in the boot_param block only supports 128 entries. Additional entries
are passed in the EFI memmap but this is missing w/o enabling EFI.

I suspect there are other problems waiting to be discovered but at least I'm making
progress.

Thanks for the help.

--- jack

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
