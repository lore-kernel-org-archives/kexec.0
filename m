Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NwNDI-0008Ax-0C
	for kexec@lists.infradead.org; Mon, 29 Mar 2010 22:13:44 +0000
Subject: Re: kdump/kexec on EFI-enabled x2apic platforms
References: <20100329200104.GA23760@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 29 Mar 2010 15:13:05 -0700
In-Reply-To: <20100329200104.GA23760@sgi.com> (Jack Steiner's message of "Mon\,
	29 Mar 2010 15\:01\:04 -0500")
Message-ID: <m1zl1qydxq.fsf@fess.ebiederm.org>
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
To: Jack Steiner <steiner@sgi.com>
Cc: mingo@elte.hu, kexec@lists.infradead.org, tglx@linutronix.de, gleb@redhat.com, suresh.b.siddha@intel.com

Jack Steiner <steiner@sgi.com> writes:

> All -
>
> I just started debugging kdump/kexec on our UV platform and
> have run into some problems. I suspect others have encountered these
> same or similar problems. Any help would be appreciated.
>
>
>
> Our platform uses EFI boot. It is Nehalem based & has a large number of cpus.
> The BIOS enables x2apic mode and the kernel runs with interrupt remapping enabled.
> Note that some apicids have more than 8 bits - x2apic mode is required.
>
>
> I am able to successfully kexec the dump kernel but run into several problems.
>
> 	- because the initial kernel boots using EFI, BIOS does not build the legacy
> 	  tables that are required to locate the RSDP using the legacy method in
> 	  acpi_find_root_pointer(). (When booting with EFI, acpi_find_root_pointer() is
> 	  not used. The ACPI tables are found from pointers in EFI tables.)

Ouch.  EFI tables are a major pain to use because they are not 32/64 clean.  Thus
making them unreasonably difficult to work with.

I believe the boot loader should be passing in the location of acpi tables instead
of expecting the kernel to wade through EFI tables.

> 	- it appears that kdump/kexec intentionally boots the kdump kernel
> 	  in a mode does does enable efi mode. (Am I correct here???)
> 	  This avoids the issues with EFI virtual mode. However, the result
> 	  is that ACPI tables are not found. From the dump kernel:
>
> 	  	ACPI Error: A valid RSDP was not found (20090903/tbxfroot-222)

My personal opinion is that EFI virtual mode is a mistake.  We should not have
any interactions with the EFI bios of sufficient frequency that we need an
efficient virtual mapping.


> 	- Because ACPI tables are not found, the dump kernel does not transition
> 	  into x2apic mode. The hardware, however, is still in x2apic mode from the
> 	  initial kernel. 

Hmm.  That is a bug of many flavors.  We should have transitions back into 
i8259 legacy mode, before calling kdump.  Then regardless of what happen
before we ran if the hardware is x2apic capable we should force the hardware
into the mode we want it, not just assume x2apic mode is off by default.

>	  Later in the boot of the dump kernel, read_apic_id()
> 	  tried to read memory-mapped apic registers instead of the MSRs that are
> 	  used in x2apic mode. This is not allowed & the dump kernel panics with:
>
> 		[    0.000000]  [<ffffffff81b52195>] early_idt_handler+0x55/0x68
> 		[    0.000000]  [<ffffffff8101f393>] ? native_apic_mem_read+0x3/0x10
> 		[    0.000000]  [<ffffffff8101a3c6>] ? read_apic_id+0x16/0x30
> 		[    0.000000]  [<ffffffff81b5f857>] init_apic_mappings+0xe7/0x137
> 		[    0.000000]  [<ffffffff81b559fd>] setup_arch+0x900/0xc33
> 		[    0.000000]  [<ffffffff81b52bae>] start_kernel+0x6f/0x4a1
>
>
>
> I checked an Intel Nehalem whitebox using the Intel BIOS. The dump kernel does not
> find the RDSP but the initial kernel does not enable x2apic mode either (possibly
> because of an old BIOS - not sure).  As a result, the dump kernel does not hit
> the panic shown above. The kdump kernel successfully boots w/o having discovered
> ACPI tables.
>
>
> How should I proceed?
> 	- should I be running the dump kernel with EFI mode enabled?

We can not interact with the BIOS/EFI in kdump in general so finding a way
to make it work without interacting with the BIOS seems to be a proper path.

> 	- should I be fixing the issues with x2apic mode in a non-EFI dump kernel?

Definitely.

> 	- or should BIOS be building the tables necessary to support both EFI & non-EFI boot.

That too.  Unless it is impossible it is good to be able to avoid EFI nonsense.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
