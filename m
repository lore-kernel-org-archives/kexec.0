Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BBAC7EE2D
	for <kexec@archiver.kernel.org>; Wed, 24 May 2023 02:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fBDSU4dZ3W/zoTqNP047jJrFTsjBvT5NrKtDYeQ75Gg=; b=H0gmqNqvpCG8JZ
	JHY9Aqu6O68GFX1A2mSAURNtSYiv/H6EBXGhRNAaxpxmVrzX1VgBRExqdm3QGHSqp/3fESmyp+ShS
	ngYgjP4gpR8gw6yoDgdxhuOb0KMVhreOoPBhQN2MFFn+N/1DRfeFCmasXYoWnaDnxeIYyw5VMa8j1
	5SvpNccaRMGrnUC0cf2mZ1nme69cGqioSkLPGXMRx+VOW024POfg2ixmAe+9Y+o3u1RDw4wM4tZG1
	SPAyw/0fc0c54MsrMzzlLgpWv2ovXT96th0J440RiyBi9EMG4APwxJ7yL4si1xlGJfqb9vPHqEo37
	J7f+uHVwSw9Xa2NyOUXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1efB-00CApN-07;
	Wed, 24 May 2023 02:55:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1ef5-00CAoB-2o
	for kexec@lists.infradead.org;
	Wed, 24 May 2023 02:55:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 37E516381E;
	Wed, 24 May 2023 02:55:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73CDC433EF;
	Wed, 24 May 2023 02:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684896938;
	bh=9+0MxDrdOFboP1SNay+ObncG4EcjN1zooIctPXIqrY8=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=gsTZDQk54vAwJuXjiODQ2n7vWfU1T2If3+r1qu4kT6clFOCXVgWX+xvKG32/PlwfA
	 IhmpBenmRA3/r+MPkLPJMRrPoEDi9RilkQjQp0Mv48xt/UTu8zN6Jan7USgXdOtzYl
	 BcU76pmPXy/gjMbeU8Azh8eZkmNOxZk4KcReg0w3BaNM10iZ58eT8piNm34ziyeyeM
	 8QGZyWHDWMJTNcyHY5R/37e8bnLET5mB6Bf/Ym/ZECJ5snCO3mMbJaZnSOhj9CZMKc
	 GFW+mVm2kiCyA481v/M5mA9aF38q3JXoe3Zf0EuEt8+iNvUSSYDwiUHO0+O1DUKslM
	 0E5DToDQCcW1w==
Mime-Version: 1.0
Date: Wed, 24 May 2023 05:55:32 +0300
Message-Id: <CSU645AYZS0Y.WJJDVTFUNDCD@suppilovahvero>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>
Cc: <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <kanth.ghatraju@oracle.com>, <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-9-ross.philipson@oracle.com>
 <CSIZ0OTO074D.1LV8KCZM306II@suppilovahvero>
 <dbc9a961-aacf-d3ac-2227-73ff17d48e1b@oracle.com>
In-Reply-To: <dbc9a961-aacf-d3ac-2227-73ff17d48e1b@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230523_195539_998034_036A7E90 
X-CRM114-Status: GOOD (  46.04  )
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

On Fri May 12, 2023 at 6:58 PM EEST, Ross Philipson wrote:
> On 5/10/23 19:02, Jarkko Sakkinen wrote:
> > On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
> >> The routine slaunch_setup is called out of the x86 specific setup_arch
> >> routine during early kernel boot. After determining what platform is
> >> present, various operations specific to that platform occur. This
> >> includes finalizing setting for the platform late launch and verifying
> >> that memory protections are in place.
> >>
> >> For TXT, this code also reserves the original compressed kernel setup
> >> area where the APs were left looping so that this memory cannot be used.
> >>
> >> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> >> ---
> >>   arch/x86/kernel/Makefile   |   1 +
> >>   arch/x86/kernel/setup.c    |   3 +
> >>   arch/x86/kernel/slaunch.c  | 497 +++++++++++++++++++++++++++++++++++++++++++++
> >>   drivers/iommu/intel/dmar.c |   4 +
> >>   4 files changed, 505 insertions(+)
> >>   create mode 100644 arch/x86/kernel/slaunch.c
> >>
> >> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> >> index dd61752..3d2a33e 100644
> >> --- a/arch/x86/kernel/Makefile
> >> +++ b/arch/x86/kernel/Makefile
> >> @@ -72,6 +72,7 @@ obj-$(CONFIG_X86_32)		+= tls.o
> >>   obj-$(CONFIG_IA32_EMULATION)	+= tls.o
> >>   obj-y				+= step.o
> >>   obj-$(CONFIG_INTEL_TXT)		+= tboot.o
> >> +obj-$(CONFIG_SECURE_LAUNCH)	+= slaunch.o
> >>   obj-$(CONFIG_ISA_DMA_API)	+= i8237.o
> >>   obj-y				+= stacktrace.o
> >>   obj-y				+= cpu/
> >> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> >> index 16babff..592c09e 100644
> >> --- a/arch/x86/kernel/setup.c
> >> +++ b/arch/x86/kernel/setup.c
> >> @@ -21,6 +21,7 @@
> >>   #include <linux/root_dev.h>
> >>   #include <linux/hugetlb.h>
> >>   #include <linux/tboot.h>
> >> +#include <linux/slaunch.h>
> > 
> > Only because of pure curiosity: what made you choose this location in
> > the middle for the new include? :-)
>
> Only because Secure Launch is like TBOOT. No other real reason.
>
> > 
> >>   #include <linux/usb/xhci-dbgp.h>
> >>   #include <linux/static_call.h>
> >>   #include <linux/swiotlb.h>
> >> @@ -1063,6 +1064,8 @@ void __init setup_arch(char **cmdline_p)
> >>   	early_gart_iommu_check();
> >>   #endif
> >>   
> >> +	slaunch_setup_txt();
> >> +
> >>   	/*
> >>   	 * partially used pages are not usable - thus
> >>   	 * we are rounding upwards:
> >> diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
> >> new file mode 100644
> >> index 0000000..7dba088
> >> --- /dev/null
> >> +++ b/arch/x86/kernel/slaunch.c
> >> @@ -0,0 +1,497 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Secure Launch late validation/setup and finalization support.
> >> + *
> >> + * Copyright (c) 2022, Oracle and/or its affiliates.
> >> + */
> >> +
> >> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >> +
> >> +#include <linux/linkage.h>
> >> +#include <linux/mm.h>
> >> +#include <linux/io.h>
> >> +#include <linux/uaccess.h>
> >> +#include <linux/security.h>
> >> +#include <linux/memblock.h>
> >> +#include <asm/segment.h>
> >> +#include <asm/sections.h>
> >> +#include <asm/tlbflush.h>
> >> +#include <asm/e820/api.h>
> >> +#include <asm/setup.h>
> >> +#include <linux/slr_table.h>
> >> +#include <linux/slaunch.h>
> >> +
> >> +static u32 sl_flags;
> >> +static struct sl_ap_wake_info ap_wake_info;
> >> +static u64 evtlog_addr;
> >> +static u32 evtlog_size;
> >> +static u64 vtd_pmr_lo_size;
> >> +
> >> +/* This should be plenty of room */
> >> +static u8 txt_dmar[PAGE_SIZE] __aligned(16);
> >> +
> >> +u32 slaunch_get_flags(void)
> >> +{
> >> +	return sl_flags;
> >> +}
> >> +EXPORT_SYMBOL(slaunch_get_flags);
> >> +
> >> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
> >> +{
> >> +	return &ap_wake_info;
> >> +}
> >> +
> >> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
> >> +{
> >> +	/* The DMAR is only stashed and provided via TXT on Intel systems */
> >> +	if (memcmp(txt_dmar, "DMAR", 4))
> >> +		return dmar;
> >> +
> >> +	return (struct acpi_table_header *)(&txt_dmar[0]);
> >> +}
> >> +
> >> +void __noreturn slaunch_txt_reset(void __iomem *txt,
> >> +				  const char *msg, u64 error)
> >> +{
> >> +	u64 one = 1, val;
> >> +
> >> +	pr_err("%s", msg);
> >> +
> >> +	/*
> >> +	 * This performs a TXT reset with a sticky error code. The reads of
> >> +	 * TXT_CR_E2STS act as barriers.
> >> +	 */
> >> +	memcpy_toio(txt + TXT_CR_ERRORCODE, &error, sizeof(error));
> >> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
> >> +	memcpy_toio(txt + TXT_CR_CMD_NO_SECRETS, &one, sizeof(one));
> >> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
> >> +	memcpy_toio(txt + TXT_CR_CMD_UNLOCK_MEM_CONFIG, &one, sizeof(one));
> >> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
> >> +	memcpy_toio(txt + TXT_CR_CMD_RESET, &one, sizeof(one));
> >> +
> >> +	for ( ; ; )
> >> +		asm volatile ("hlt");
> >> +
> >> +	unreachable();
> >> +}
> >> +
> >> +/*
> >> + * The TXT heap is too big to map all at once with early_ioremap
> >> + * so it is done a table at a time.
> >> + */
> >> +static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
> >> +					     u32 bytes)
> >> +{
> >> +	u64 base, size, offset = 0;
> >> +	void *heap;
> >> +	int i;
> >> +
> >> +	if (type > TXT_SINIT_TABLE_MAX)
> >> +		slaunch_txt_reset(txt,
> >> +			"Error invalid table type for early heap walk\n",
> >> +			SL_ERROR_HEAP_WALK);
> > 
> > Align with 'txt'.
>
> Ack
>
> > 
> >> +
> >> +	memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
> >> +	memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
> >> +
> >> +	/* Iterate over heap tables looking for table of "type" */
> >> +	for (i = 0; i < type; i++) {
> >> +		base += offset;
> >> +		heap = early_memremap(base, sizeof(u64));
> >> +		if (!heap)
> >> +			slaunch_txt_reset(txt,
> >> +				"Error early_memremap of heap for heap walk\n",
> >> +				SL_ERROR_HEAP_MAP);
> >> +
> >> +		offset = *((u64 *)heap);
> >> +
> >> +		/*
> >> +		 * After the first iteration, any offset of zero is invalid and
> >> +		 * implies the TXT heap is corrupted.
> >> +		 */
> >> +		if (!offset)
> >> +			slaunch_txt_reset(txt,
> >> +				"Error invalid 0 offset in heap walk\n",
> >> +				SL_ERROR_HEAP_ZERO_OFFSET);
> >> +
> >> +		early_memunmap(heap, sizeof(u64));
> >> +	}
> >> +
> >> +	/* Skip the size field at the head of each table */
> >> +	base += sizeof(u64);
> >> +	heap = early_memremap(base, bytes);
> >> +	if (!heap)
> >> +		slaunch_txt_reset(txt,
> >> +				  "Error early_memremap of heap section\n",
> >> +				  SL_ERROR_HEAP_MAP);
> >> +
> >> +	return heap;
> >> +}
> >> +
> >> +static void __init txt_early_put_heap_table(void *addr, unsigned long size)
> >> +{
> >> +	early_memunmap(addr, size);
> >> +}
> >> +
> >> +/*
> >> + * TXT uses a special set of VTd registers to protect all of memory from DMA
> >> + * until the IOMMU can be programmed to protect memory. There is the low
> >> + * memory PMR that can protect all memory up to 4G. The high memory PRM can
> >> + * be setup to protect all memory beyond 4Gb. Validate that these values cover
> >> + * what is expected.
> >> + */
> >> +static void __init slaunch_verify_pmrs(void __iomem *txt)
> >> +{
> >> +	struct txt_os_sinit_data *os_sinit_data;
> >> +	u32 field_offset, err = 0;
> >> +	const char *errmsg = "";
> >> +	unsigned long last_pfn;
> >> +
> >> +	field_offset = offsetof(struct txt_os_sinit_data, lcp_po_base);
> >> +	os_sinit_data = txt_early_get_heap_table(txt, TXT_OS_SINIT_DATA_TABLE,
> >> +						 field_offset);
> >> +
> >> +	/* Save a copy */
> >> +	vtd_pmr_lo_size = os_sinit_data->vtd_pmr_lo_size;
> >> +
> >> +	last_pfn = e820__end_of_ram_pfn();
> >> +
> >> +	/*
> >> +	 * First make sure the hi PMR covers all memory above 4G. In the
> >> +	 * unlikely case where there is < 4G on the system, the hi PMR will
> >> +	 * not be set.
> >> +	 */
> >> +	if (os_sinit_data->vtd_pmr_hi_base != 0x0ULL) {
> >> +		if (os_sinit_data->vtd_pmr_hi_base != 0x100000000ULL) {
> >> +			err = SL_ERROR_HI_PMR_BASE;
> >> +			errmsg =  "Error hi PMR base\n";
> >> +			goto out;
> >> +		}
> >> +
> >> +		if (PFN_PHYS(last_pfn) > os_sinit_data->vtd_pmr_hi_base +
> >> +		    os_sinit_data->vtd_pmr_hi_size) {
> >> +			err = SL_ERROR_HI_PMR_SIZE;
> >> +			errmsg = "Error hi PMR size\n";
> >> +			goto out;
> >> +		}
> >> +	}
> >> +
> >> +	/*
> >> +	 * Lo PMR base should always be 0. This was already checked in
> >> +	 * early stub.
> >> +	 */
> >> +
> >> +	/*
> >> +	 * Check that if the kernel was loaded below 4G, that it is protected
> >> +	 * by the lo PMR. Note this is the decompressed kernel. The ACM would
> >> +	 * have ensured the compressed kernel (the MLE image) was protected.
> >> +	 */
> >> +	if ((__pa_symbol(_end) < 0x100000000ULL) &&
> >> +	    (__pa_symbol(_end) > os_sinit_data->vtd_pmr_lo_size)) {
> >> +		err = SL_ERROR_LO_PMR_MLE;
> >> +		errmsg = "Error lo PMR does not cover MLE kernel\n";
> >> +	}
> >> +
> >> +	/*
> >> +	 * Other regions of interest like boot param, AP wake block, cmdline
> >> +	 * already checked for PMR coverage in the early stub code.
> >> +	 */
> >> +
> >> +out:
> >> +	txt_early_put_heap_table(os_sinit_data, field_offset);
> >> +
> >> +	if (err)
> >> +		slaunch_txt_reset(txt, errmsg, err);
> >> +}
> >> +
> >> +static void __init slaunch_txt_reserve_range(u64 base, u64 size)
> >> +{
> >> +	int type;
> >> +
> >> +	type = e820__get_entry_type(base, base + size - 1);
> >> +	if (type == E820_TYPE_RAM) {
> >> +		pr_info("memblock reserve base: %llx size: %llx\n", base, size);
> >> +		memblock_reserve(base, size);
> >> +	}
> >> +}
> >> +
> >> +/*
> >> + * For Intel, certain regions of memory must be marked as reserved by putting
> >> + * them on the memblock reserved list if they are not already e820 reserved.
> >> + * This includes:
> >> + *  - The TXT HEAP
> >> + *  - The ACM area
> >> + *  - The TXT private register bank
> >> + *  - The MDR list sent to the MLE by the ACM (see TXT specification)
> >> + *  (Normally the above are properly reserved by firmware but if it was not
> >> + *  done, reserve them now)
> >> + *  - The AP wake block
> >> + *  - TPM log external to the TXT heap
> >> + *
> >> + * Also if the low PMR doesn't cover all memory < 4G, any RAM regions above
> >> + * the low PMR must be reservered too.
> >> + */
> >> +static void __init slaunch_txt_reserve(void __iomem *txt)
> >> +{
> >> +	struct txt_sinit_memory_descriptor_record *mdr;
> >> +	struct txt_sinit_mle_data *sinit_mle_data;
> >> +	u64 base, size, heap_base, heap_size;
> >> +	u32 mdrnum, mdroffset, mdrslen;
> >> +	u32 field_offset, i;
> >> +	void *mdrs;
> >> +
> >> +	base = TXT_PRIV_CONFIG_REGS_BASE;
> >> +	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
> >> +	slaunch_txt_reserve_range(base, size);
> >> +
> >> +	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
> >> +	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
> >> +	slaunch_txt_reserve_range(heap_base, heap_size);
> >> +
> >> +	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
> >> +	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
> >> +	slaunch_txt_reserve_range(base, size);
> >> +
> >> +	field_offset = offsetof(struct txt_sinit_mle_data,
> >> +				sinit_vtd_dmar_table_size);
> >> +	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> >> +						  field_offset);
> >> +
> >> +	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
> >> +	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
> >> +
> >> +	txt_early_put_heap_table(sinit_mle_data, field_offset);
> >> +
> >> +	if (!mdrnum)
> >> +		goto nomdr;
> >> +
> >> +	mdrslen = mdrnum * sizeof(struct txt_sinit_memory_descriptor_record);
> >> +
> >> +	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> >> +					mdroffset + mdrslen - 8);
> >> +
> >> +	mdr = mdrs + mdroffset - 8;
> >> +
> >> +	for (i = 0; i < mdrnum; i++, mdr++) {
> >> +		/* Spec says some entries can have length 0, ignore them */
> >> +		if (mdr->type > 0 && mdr->length > 0)
> >> +			slaunch_txt_reserve_range(mdr->address, mdr->length);
> >> +	}
> >> +
> >> +	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
> >> +
> >> +nomdr:
> >> +	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
> >> +				  ap_wake_info.ap_wake_block_size);
> >> +
> >> +	/*
> >> +	 * Earlier checks ensured that the event log was properly situated
> >> +	 * either inside the TXT heap or outside. This is a check to see if the
> >> +	 * event log needs to be reserved. If it is in the TXT heap, it is
> >> +	 * already reserved.
> >> +	 */
> >> +	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
> >> +		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
> >> +
> >> +	for (i = 0; i < e820_table->nr_entries; i++) {
> >> +		base = e820_table->entries[i].addr;
> >> +		size = e820_table->entries[i].size;
> >> +		if ((base >= vtd_pmr_lo_size) && (base < 0x100000000ULL))
> >> +			slaunch_txt_reserve_range(base, size);
> >> +		else if ((base < vtd_pmr_lo_size) &&
> >> +			 (base + size > vtd_pmr_lo_size))
> >> +			slaunch_txt_reserve_range(vtd_pmr_lo_size,
> >> +						  base + size - vtd_pmr_lo_size);
> >> +	}
> >> +}
> >> +
> >> +/*
> >> + * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
> >> + * It is stored in the TXT heap. Fetch it from there and make it available
> >> + * to the IOMMU driver.
> >> + */
> >> +static void __init slaunch_copy_dmar_table(void __iomem *txt)
> >> +{
> >> +	struct txt_sinit_mle_data *sinit_mle_data;
> >> +	u32 field_offset, dmar_size, dmar_offset;
> >> +	void *dmar;
> >> +
> >> +	memset(&txt_dmar, 0, PAGE_SIZE);
> >> +
> >> +	field_offset = offsetof(struct txt_sinit_mle_data,
> >> +				processor_scrtm_status);
> >> +	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> >> +						  field_offset);
> >> +
> >> +	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
> >> +	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
> >> +
> >> +	txt_early_put_heap_table(sinit_mle_data, field_offset);
> >> +
> >> +	if (!dmar_size || !dmar_offset)
> >> +		slaunch_txt_reset(txt,
> >> +				  "Error invalid DMAR table values\n",
> >> +				  SL_ERROR_HEAP_INVALID_DMAR);
> >> +
> >> +	if (unlikely(dmar_size > PAGE_SIZE))
> >> +		slaunch_txt_reset(txt,
> >> +				  "Error DMAR too big to store\n",
> >> +				  SL_ERROR_HEAP_DMAR_SIZE);
> >> +
> >> +
> >> +	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> >> +					dmar_offset + dmar_size - 8);
> >> +	if (!dmar)
> >> +		slaunch_txt_reset(txt,
> >> +				  "Error early_ioremap of DMAR\n",
> >> +				  SL_ERROR_HEAP_DMAR_MAP);
> >> +
> >> +	memcpy(&txt_dmar[0], dmar + dmar_offset - 8, dmar_size);
> >> +
> >> +	txt_early_put_heap_table(dmar, dmar_offset + dmar_size - 8);
> >> +}
> >> +
> >> +/*
> >> + * The location of the safe AP wake code block is stored in the TXT heap.
> >> + * Fetch needed values here in the early init code for later use in SMP
> >> + * startup.
> >> + *
> >> + * Also get the TPM event log values are in the SLRT and have to be fetched.
> >> + * They will be put on the memblock reserve list later.
> >> + */
> >> +static void __init slaunch_fetch_values(void __iomem *txt)
> >> +{
> >> +	struct txt_os_mle_data *os_mle_data;
> >> +	struct slr_entry_log_info *log_info;
> >> +	struct slr_table *slrt;
> >> +	u8 *jmp_offset;
> >> +	u32 size;
> >> +
> >> +	os_mle_data = txt_early_get_heap_table(txt, TXT_OS_MLE_DATA_TABLE,
> >> +					       sizeof(*os_mle_data));
> >> +
> >> +	ap_wake_info.ap_wake_block = os_mle_data->ap_wake_block;
> >> +	ap_wake_info.ap_wake_block_size = os_mle_data->ap_wake_block_size;
> >> +
> >> +	jmp_offset = os_mle_data->mle_scratch + SL_SCRATCH_AP_JMP_OFFSET;
> >> +	ap_wake_info.ap_jmp_offset = *((u32 *)jmp_offset);
> >> +
> >> +	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, sizeof(*slrt));
> >> +	if (!slrt)
> >> +		slaunch_txt_reset(txt,
> >> +			"Error early_memremap of SLRT failed\n",
> >> +			SL_ERROR_SLRT_MAP);
> >> +
> >> +	size = slrt->size;
> >> +	early_memunmap(slrt, sizeof(*slrt));
> >> +
> >> +	slrt = (struct slr_table *)early_memremap(os_mle_data->slrt, size);
> >> +	if (!slrt)
> >> +		slaunch_txt_reset(txt,
> >> +			"Error early_memremap of SLRT failed\n",
> >> +			SL_ERROR_SLRT_MAP);
> >> +
> >> +	log_info = (struct slr_entry_log_info *)
> >> +		slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
> >> +
> >> +	if (!log_info)
> >> +		slaunch_txt_reset(txt,
> >> +				  "SLRT missing logging info entry\n",
> >> +				  SL_ERROR_SLRT_MISSING_ENTRY);
> >> +
> >> +	evtlog_addr = log_info->addr;
> >> +	evtlog_size = log_info->size;
> >> +
> >> +	early_memunmap(slrt, size);
> >> +
> >> +	txt_early_put_heap_table(os_mle_data, sizeof(*os_mle_data));
> >> +}
> >> +
> >> +/*
> >> + * Intel TXT specific late stub setup and validation.
> >> + */
> >> +void __init slaunch_setup_txt(void)
> >> +{
> >> +	u64 one = TXT_REGVALUE_ONE, val;
> >> +	void __iomem *txt;
> >> +
> >> +	if (!boot_cpu_has(X86_FEATURE_SMX))
> >> +		return;
> >> +
> >> +	/*
> >> +	 * If booted through secure launch entry point, the loadflags
> >> +	 * option will be set.
> >> +	 */
> >> +	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
> >> +		return;
> >> +
> >> +	/*
> >> +	 * See if SENTER was done by reading the status register in the
> >> +	 * public space. If the public register space cannot be read, TXT may
> >> +	 * be disabled.
> >> +	 */
> >> +	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
> >> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> >> +	if (!txt)
> >> +		return;
> >> +
> >> +	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
> >> +	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> >> +
> >> +	/* SENTER should have been done */
> >> +	if (!(val & TXT_SENTER_DONE_STS))
> >> +		panic("Error TXT.STS SENTER_DONE not set\n");
> >> +
> >> +	/* SEXIT should have been cleared */
> >> +	if (val & TXT_SEXIT_DONE_STS)
> >> +		panic("Error TXT.STS SEXIT_DONE set\n");
> >> +
> >> +	/* Now we want to use the private register space */
> >> +	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
> >> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> >> +	if (!txt) {
> >> +		/* This is really bad, no where to go from here */
> >> +		panic("Error early_ioremap of TXT priv registers\n");
> >> +	}
> >> +
> >> +	/*
> >> +	 * Try to read the Intel VID from the TXT private registers to see if
> >> +	 * TXT measured launch happened properly and the private space is
> >> +	 * available.
> >> +	 */
> >> +	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(val));
> >> +	if ((val & 0xffff) != 0x8086) {
> >> +		/*
> >> +		 * Can't do a proper TXT reset since it appears something is
> >> +		 * wrong even though SENTER happened and it should be in SMX
> >> +		 * mode.
> >> +		 */
> >> +		panic("Invalid TXT vendor ID, not in SMX mode\n");
> >> +	}
> >> +
> >> +	/* Set flags so subsequent code knows the status of the launch */
> >> +	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT);
> >> +
> >> +	/*
> >> +	 * Reading the proper DIDVID from the private register space means we
> >> +	 * are in SMX mode and private registers are open for read/write.
> >> +	 */
> >> +
> >> +	/* On Intel, have to handle TPM localities via TXT */
> >> +	memcpy_toio(txt + TXT_CR_CMD_SECRETS, &one, sizeof(one));
> >> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
> >> +	memcpy_toio(txt + TXT_CR_CMD_OPEN_LOCALITY1, &one, sizeof(one));
> >> +	memcpy_fromio(&val, txt + TXT_CR_E2STS, sizeof(val));
> >> +
> >> +	slaunch_fetch_values(txt);
> >> +
> >> +	slaunch_verify_pmrs(txt);
> >> +
> >> +	slaunch_txt_reserve(txt);
> >> +
> >> +	slaunch_copy_dmar_table(txt);
> >> +
> >> +	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> >> +
> >> +	pr_info("Intel TXT setup complete\n");
> >> +}
> >> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> >> index a3414af..5d1ac8d 100644
> >> --- a/drivers/iommu/intel/dmar.c
> >> +++ b/drivers/iommu/intel/dmar.c
> >> @@ -28,6 +28,7 @@
> >>   #include <linux/iommu.h>
> >>   #include <linux/numa.h>
> >>   #include <linux/limits.h>
> >> +#include <linux/slaunch.h>
> >>   #include <asm/irq_remapping.h>
> >>   
> >>   #include "iommu.h"
> >> @@ -660,6 +661,9 @@ static inline int dmar_walk_dmar_table(struct acpi_table_dmar *dmar,
> >>   	 */
> >>   	dmar_tbl = tboot_get_dmar_table(dmar_tbl);
> >>   
> >> +	/* If Secure Launch is active, it has similar logic */
> >> +	dmar_tbl = slaunch_get_dmar_table(dmar_tbl);
> >> +
> >>   	dmar = (struct acpi_table_dmar *)dmar_tbl;
> >>   	if (!dmar)
> >>   		return -ENODEV;
> >> -- 
> >> 1.8.3.1
> > 
> > Is it possible to test TXT in QEMU? Never done it so that's why I'm
> > asking.
>
> I would be if emulation of the GETSEC leaf functions were added to QEMU. 
> AFAIK there is no public implementation of this at present.

That's a shame. I have one NUC7 which I use sometimes to test SGX
patches but I don't think it scales to TXT (have to check).

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
