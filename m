Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1Nx8ZQ-0000hb-IT
	for kexec@lists.infradead.org; Thu, 01 Apr 2010 00:47:41 +0000
Date: Wed, 31 Mar 2010 19:47:33 -0500
From: Jack Steiner <steiner@sgi.com>
Subject: Re: kdump/kexec on EFI-enabled x2apic platforms
Message-ID: <20100401004733.GA23806@sgi.com>
References: <20100329200104.GA23760@sgi.com>
	<20100331222449.GB8257@nlxcldnl2.cl.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100331222449.GB8257@nlxcldnl2.cl.intel.com>
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "gleb@redhat.com" <gleb@redhat.com>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>

On Wed, Mar 31, 2010 at 03:24:50PM -0700, David N. Lombard wrote:
> On Mon, Mar 29, 2010 at 01:01:04PM -0700, Jack Steiner wrote:
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
> 
> What are you using as a boot loader?  I've tested kexec with elilo 3.8 and
> got good results.  But, that was early last year, so I'll need to try it out
> with production hardware and the current firmware and sw stack.  I'll try to
> get to that this week, and let you know the results.

We use:
	elilo-3.12-0.3.6

AFAICT, the following are the problem areas:

	- nehalem platform using a BIOS that puts RSDP at a location that
	  is not scanned by acpi_find_root_pointer() looking for ACPI tables

	  	[    0.000000] ACPI: RSDP 000000007b7fe014 00024 (v02 INTEL )
		[    0.000000] ACPI: XSDT 000000007b7fe120 0005C (v01 INTEL  TIANO    00000000      01000013)
		[    0.000000] ACPI: FACP 000000007b7fc000 000F4 (v03 INTEL  TIANO    00000000 MSFT 01000013)
		...

	  Booting with EFI works because ACPI tables are pointed to by the EFI tables. However,
	  the kdump kernel does not enable EFI and the OS uses an alternate method
	  to locate the ACPI tables. The alternate method fails.

	  	NOTE: with a hacked BIOS that puts the RSDP at 0x9ec00, ACPI tables
		are correctly discovered & booting the kdump kernel is successful (except
		that some memory is missing (see next item)).


	- number of memory blocks exceeds the size supported by the E820 table. (I'm
	  still learning - memory is missing from the kdump kernel memory maps. Does
	  this affect the memory dumpped from the kernel that crashed???)


	- x2apic enabled by the BIOS & interrupt remapping enabled by the OS (this
	  may no longer be an issue but caused problems earlier)



Appreciate the help....

--- jack

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
