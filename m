Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF45CDB474
	for <kexec@archiver.kernel.org>; Fri, 20 Oct 2023 17:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=omjXTS4Tn4KVRlwzGaQC3jrmyA6CB78PjCnumRcmRp8=; b=q8+eRXE007FcUD
	Lg48GUQEMEPyEVTDKjuBOtQl0i3yy+enC8N/CKEkIPDhKAEy69yPZZXrxb0SpmF+iysCHt1dTBn+t
	Xy5OQTc/aqWW5CpTukx241Us1ChHp8a40tho0TgKec3tLIcAod7VTIuBaNVFkC6cFexyr1jdwyaWU
	knLtB4DP/pY3W4lSxSVo8ux10xSuH+8G0/r3J2vpsW67D4d5MRTRoLeJr+s7kOn0up4QXQz3uksq3
	yjW1yv6OnK1clvokY3+tKcsoTUaIcZ/9vyePkLEW7sZ75be9KnGk7OTnbuBWnM/78VJJsxSMZTTbA
	IQG/7Q7fEdTect5vHbeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtt3a-002kVk-0y;
	Fri, 20 Oct 2023 17:13:06 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtt3W-002kTx-0o
	for kexec@lists.infradead.org;
	Fri, 20 Oct 2023 17:13:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697821982; x=1729357982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gpUiJMwmkFwlOFmFdLdipIbLm1/5/wSUBTFzSRkhCTg=;
  b=FHhbSKs0EYkJ6tnCiiJW7BNkX5w34Lrrw4Mx38N1sarXy8oHlMLR3aRy
   NOhS2x+gm5WjJef76ojExraQOUNT/loGLdPGDrwAos3LYYEqMOU7iAmy8
   yzJ9ij9tpANtY8f5OG26+2cocR1cJXGbZ+R/Pa4CJN4bdiBKgm/7b3Sw9
   d1e2vHfm5VHbgRBd34MPQsDeq0BPRhAdhUcAFgToaf5/1TtFrm5pFQ3EQ
   fxR8LLEVohl45SxAbTF/P8cV2Uh3HOHX183K5T6R/qf0TH7YOnXkVf2+A
   L4YCyxEVHN8pBucefsBJ5yd6WZ0KjwUOMK++0F0UReVJGbWTwQV+ODPxO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385424754"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385424754"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:12:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="761114755"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="761114755"
Received: from gneiger-mobl3.amr.corp.intel.com (HELO [10.209.88.124]) ([10.209.88.124])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 10:12:56 -0700
Message-ID: <ca3c0ed7-c457-49ee-b243-c1e67a3ff0c8@linux.intel.com>
Date: Fri, 20 Oct 2023 10:12:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 01/13] x86/acpi: Extract ACPI MADT wakeup code into a
 separate file
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com>
 <20231020151242.1814-2-kirill.shutemov@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231020151242.1814-2-kirill.shutemov@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_101302_328918_B9548291 
X-CRM114-Status: GOOD (  38.10  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 10/20/2023 8:12 AM, Kirill A. Shutemov wrote:
> In order to prepare for the expansion of support for the ACPI MADT
> wakeup method, move the relevant code into a separate file.
> 
> Introduce a new configuration option to clearly indicate dependencies
> without the use of ifdefs.
> 
> There have been no functional changes.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  arch/x86/Kconfig                   |  7 +++
>  arch/x86/include/asm/acpi.h        |  5 ++
>  arch/x86/kernel/acpi/Makefile      | 11 ++--
>  arch/x86/kernel/acpi/boot.c        | 86 +-----------------------------
>  arch/x86/kernel/acpi/madt_wakeup.c | 81 ++++++++++++++++++++++++++++
>  5 files changed, 100 insertions(+), 90 deletions(-)
>  create mode 100644 arch/x86/kernel/acpi/madt_wakeup.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 799102f4d909..9957a73bb386 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1108,6 +1108,13 @@ config X86_LOCAL_APIC
>  	depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
>  	select IRQ_DOMAIN_HIERARCHY
>  
> +config X86_ACPI_MADT_WAKEUP
> +	def_bool y
> +	depends on X86_64
> +	depends on ACPI
> +	depends on SMP
> +	depends on X86_LOCAL_APIC
> +
>  config X86_IO_APIC
>  	def_bool y
>  	depends on X86_LOCAL_APIC || X86_UP_IOAPIC
> diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> index c8a7fc23f63c..b536b5a6a57b 100644
> --- a/arch/x86/include/asm/acpi.h
> +++ b/arch/x86/include/asm/acpi.h
> @@ -73,6 +73,11 @@ static inline bool acpi_skip_set_wakeup_address(void)
>  
>  #define acpi_skip_set_wakeup_address acpi_skip_set_wakeup_address
>  
> +union acpi_subtable_headers;
> +
> +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +			      const unsigned long end);
> +
>  /*
>   * Check if the CPU can handle C2 and deeper
>   */
> diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
> index fc17b3f136fe..8c7329c88a75 100644
> --- a/arch/x86/kernel/acpi/Makefile
> +++ b/arch/x86/kernel/acpi/Makefile
> @@ -1,11 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_ACPI)		+= boot.o
> -obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
> -obj-$(CONFIG_ACPI_APEI)		+= apei.o
> -obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
> +obj-$(CONFIG_ACPI)			+= boot.o
> +obj-$(CONFIG_ACPI_SLEEP)		+= sleep.o wakeup_$(BITS).o
> +obj-$(CONFIG_ACPI_APEI)			+= apei.o
> +obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> +obj-$(CONFIG_X86_ACPI_MADT_WAKEUP)	+= madt_wakeup.o
>  
>  ifneq ($(CONFIG_ACPI_PROCESSOR),)
> -obj-y				+= cstate.o
> +obj-y					+= cstate.o
>  endif
>  
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 2a0ea38955df..111bd226ad99 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -66,13 +66,6 @@ static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>  static bool acpi_support_online_capable;
>  #endif
>  
> -#ifdef CONFIG_X86_64
> -/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> -static u64 acpi_mp_wake_mailbox_paddr;
> -/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> -static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> -#endif
> -
>  #ifdef CONFIG_X86_IO_APIC
>  /*
>   * Locks related to IOAPIC hotplug
> @@ -357,60 +350,6 @@ acpi_parse_lapic_nmi(union acpi_subtable_headers * header, const unsigned long e
>  
>  	return 0;
>  }
> -
> -#ifdef CONFIG_X86_64
> -static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> -{
> -	/*
> -	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> -	 *
> -	 * Wakeup of secondary CPUs is fully serialized in the core code.
> -	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
> -	 */
> -	if (!acpi_mp_wake_mailbox) {
> -		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> -						sizeof(*acpi_mp_wake_mailbox),
> -						MEMREMAP_WB);
> -	}
> -
> -	/*
> -	 * Mailbox memory is shared between the firmware and OS. Firmware will
> -	 * listen on mailbox command address, and once it receives the wakeup
> -	 * command, the CPU associated with the given apicid will be booted.
> -	 *
> -	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
> -	 * firmware before the wakeup command is visible.  smp_store_release()
> -	 * ensures ordering and visibility.
> -	 */
> -	acpi_mp_wake_mailbox->apic_id	    = apicid;
> -	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
> -	smp_store_release(&acpi_mp_wake_mailbox->command,
> -			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> -
> -	/*
> -	 * Wait for the CPU to wake up.
> -	 *
> -	 * The CPU being woken up is essentially in a spin loop waiting to be
> -	 * woken up. It should not take long for it wake up and acknowledge by
> -	 * zeroing out ->command.
> -	 *
> -	 * ACPI specification doesn't provide any guidance on how long kernel
> -	 * has to wait for a wake up acknowledgement. It also doesn't provide
> -	 * a way to cancel a wake up request if it takes too long.
> -	 *
> -	 * In TDX environment, the VMM has control over how long it takes to
> -	 * wake up secondary. It can postpone scheduling secondary vCPU
> -	 * indefinitely. Giving up on wake up request and reporting error opens
> -	 * possible attack vector for VMM: it can wake up a secondary CPU when
> -	 * kernel doesn't expect it. Wait until positive result of the wake up
> -	 * request.
> -	 */
> -	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> -		cpu_relax();
> -
> -	return 0;
> -}
> -#endif /* CONFIG_X86_64 */
>  #endif /* CONFIG_X86_LOCAL_APIC */
>  
>  #ifdef CONFIG_X86_IO_APIC
> @@ -1160,29 +1099,6 @@ static int __init acpi_parse_madt_lapic_entries(void)
>  	}
>  	return 0;
>  }
> -
> -#ifdef CONFIG_X86_64
> -static int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> -				     const unsigned long end)
> -{
> -	struct acpi_madt_multiproc_wakeup *mp_wake;
> -
> -	if (!IS_ENABLED(CONFIG_SMP))
> -		return -ENODEV;
> -
> -	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> -	if (BAD_MADT_ENTRY(mp_wake, end))
> -		return -EINVAL;
> -
> -	acpi_table_print_madt_entry(&header->common);
> -
> -	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> -
> -	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> -
> -	return 0;
> -}
> -#endif				/* CONFIG_X86_64 */
>  #endif				/* CONFIG_X86_LOCAL_APIC */
>  
>  #ifdef	CONFIG_X86_IO_APIC
> @@ -1379,7 +1295,7 @@ static void __init acpi_process_madt(void)
>  				smp_found_config = 1;
>  			}
>  
> -#ifdef CONFIG_X86_64
> +#ifdef CONFIG_X86_ACPI_MADT_WAKEUP
>  			/*
>  			 * Parse MADT MP Wake entry.
>  			 */
> diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
> new file mode 100644
> index 000000000000..58cdfc0b6c0a
> --- /dev/null
> +++ b/arch/x86/kernel/acpi/madt_wakeup.c
> @@ -0,0 +1,81 @@
> +#include <linux/acpi.h>
> +#include <linux/io.h>
> +#include <asm/apic.h>
> +#include <asm/barrier.h>
> +#include <asm/processor.h>
> +
> +/* Physical address of the Multiprocessor Wakeup Structure mailbox */
> +static u64 acpi_mp_wake_mailbox_paddr;
> +
> +/* Virtual address of the Multiprocessor Wakeup Structure mailbox */
> +static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
> +
> +static int acpi_wakeup_cpu(int apicid, unsigned long start_ip)
> +{
> +	/*
> +	 * Remap mailbox memory only for the first call to acpi_wakeup_cpu().
> +	 *
> +	 * Wakeup of secondary CPUs is fully serialized in the core code.
> +	 * No need to protect acpi_mp_wake_mailbox from concurrent accesses.
> +	 */
> +	if (!acpi_mp_wake_mailbox) {
> +		acpi_mp_wake_mailbox = memremap(acpi_mp_wake_mailbox_paddr,
> +						sizeof(*acpi_mp_wake_mailbox),
> +						MEMREMAP_WB);
> +	}
> +
> +	/*
> +	 * Mailbox memory is shared between the firmware and OS. Firmware will
> +	 * listen on mailbox command address, and once it receives the wakeup
> +	 * command, the CPU associated with the given apicid will be booted.
> +	 *
> +	 * The value of 'apic_id' and 'wakeup_vector' must be visible to the
> +	 * firmware before the wakeup command is visible.  smp_store_release()
> +	 * ensures ordering and visibility.
> +	 */
> +	acpi_mp_wake_mailbox->apic_id	    = apicid;
> +	acpi_mp_wake_mailbox->wakeup_vector = start_ip;
> +	smp_store_release(&acpi_mp_wake_mailbox->command,
> +			  ACPI_MP_WAKE_COMMAND_WAKEUP);
> +
> +	/*
> +	 * Wait for the CPU to wake up.
> +	 *
> +	 * The CPU being woken up is essentially in a spin loop waiting to be
> +	 * woken up. It should not take long for it wake up and acknowledge by
> +	 * zeroing out ->command.
> +	 *
> +	 * ACPI specification doesn't provide any guidance on how long kernel
> +	 * has to wait for a wake up acknowledgement. It also doesn't provide
> +	 * a way to cancel a wake up request if it takes too long.
> +	 *
> +	 * In TDX environment, the VMM has control over how long it takes to
> +	 * wake up secondary. It can postpone scheduling secondary vCPU
> +	 * indefinitely. Giving up on wake up request and reporting error opens
> +	 * possible attack vector for VMM: it can wake up a secondary CPU when
> +	 * kernel doesn't expect it. Wait until positive result of the wake up
> +	 * request.
> +	 */
> +	while (READ_ONCE(acpi_mp_wake_mailbox->command))
> +		cpu_relax();
> +
> +	return 0;
> +}
> +
> +int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +			      const unsigned long end)
> +{
> +	struct acpi_madt_multiproc_wakeup *mp_wake;
> +
> +	mp_wake = (struct acpi_madt_multiproc_wakeup *)header;
> +	if (BAD_MADT_ENTRY(mp_wake, end))
> +		return -EINVAL;
> +
> +	acpi_table_print_madt_entry(&header->common);
> +
> +	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
> +
> +	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +
> +	return 0;
> +}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
