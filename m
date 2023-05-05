Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF943C77B7C
	for <kexec@archiver.kernel.org>; Fri,  5 May 2023 17:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Ujco5D8HGqqIRQ7rffgI6o+m3KxWhU5R6SnC2olaNk=; b=dBipd4Blp6xDfG
	1wcZ/N2bdKH1MDVTwe+e2TLU6TrROGccDluQnnMhstEQXONTwJ0/tppsx+Hh5B2l4cY8WpvXmYcBQ
	WaIi27E2SWcZBpTOFB/ft2PkUXtMaarouqzct9XmXbWmtSnpPv9E2Hg5KL5p+iZJYSr7/ZL8JnmpY
	zt3j5hL+WbdWqxIqmZ7LBasLieQbQ9K+V0Rl+t0uLoevZmoeAsjGri0qY/0IDwZtrZ+PVz9uEGLMi
	wgjUH00q4m6eNsMH78fvKq3IKwuIrrDGXGTae+qi5dsqtTKqUZGuUBk0zek1YpOirZEg3T/0CjfDS
	u9noLKQzyN1zDqlTvflA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puzbu-00BT5c-0e;
	Fri, 05 May 2023 17:52:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puzbq-00BT4i-1h
	for kexec@lists.infradead.org;
	Fri, 05 May 2023 17:52:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDC163FB4;
	Fri,  5 May 2023 17:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335C1C433D2;
	Fri,  5 May 2023 17:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683309164;
	bh=l1O/fEDp8bKQ7YzTM3V2usCCVXMJF5+ybe2bbFFtdWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTc/VaTRS80Et2t7DwgDtJ0+Rxj2HvsxpFc2ajdS6vXMHX5WSFhdDHX/o//JhWY48
	 nQ7O+qL8iPAaBsqY4n6Y/k+y+y0tZaYEu9RT0sIwCdD3sw330+3zSmGlWM2dqhcG5X
	 HjY/+37M8v2q23tbTzKqedLkvAWZcqeCvGJCqzJ4akcpTOI+ENSXIwlbHbMOAx2yXB
	 K9mdf3qAm+kVsuuiZRxmaW8Rifz3aahFd+7woHpVikA/6r5aK/q+4uuh/7frEtcy1I
	 y0O078KWJ8NfBYa+dun0Hh63kABUJ2Ucao+KJ8/QnlZrpQSHbhc37cgd4gw3ZJB5xI
	 YNQqxMItT9gHg==
Date: Fri, 5 May 2023 19:52:39 +0200
From: Simon Horman <horms@kernel.org>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, luto@amacapital.net,
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
Message-ID: <ZFVCZ1EDxQgdyocc@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-9-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-9-ross.philipson@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230505_105246_649754_3EAA1B29 
X-CRM114-Status: GOOD (  39.48  )
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

On Thu, May 04, 2023 at 02:50:17PM +0000, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch
> routine during early kernel boot. After determining what platform is
> present, various operations specific to that platform occur. This
> includes finalizing setting for the platform late launch and verifying
> that memory protections are in place.
> 
> For TXT, this code also reserves the original compressed kernel setup
> area where the APs were left looping so that this memory cannot be used.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

Hi Ross,

a few nits from my side.

> +/*
> + * The TXT heap is too big to map all at once with early_ioremap
> + * so it is done a table at a time.
> + */
> +static void __init *txt_early_get_heap_table(void __iomem *txt, u32 type,
> +					     u32 bytes)
> +{
> +	u64 base, size, offset = 0;
> +	void *heap;
> +	int i;
> +
> +	if (type > TXT_SINIT_TABLE_MAX)
> +		slaunch_txt_reset(txt,
> +			"Error invalid table type for early heap walk\n",
> +			SL_ERROR_HEAP_WALK);

nit: the indentation should align to the opening '('.

		slaunch_txt_reset(txt,
				  "Error invalid table type for early heap walk\n",
				  SL_ERROR_HEAP_WALK);

Likewise in a few other places in this patch.

...

> +static void __init slaunch_txt_reserve_range(u64 base, u64 size)
> +{
> +	int type;
> +
> +	type = e820__get_entry_type(base, base + size - 1);
> +	if (type == E820_TYPE_RAM) {
> +		pr_info("memblock reserve base: %llx size: %llx\n", base, size);
> +		memblock_reserve(base, size);
> +	}
> +}
> +
> +/*
> + * For Intel, certain regions of memory must be marked as reserved by putting
> + * them on the memblock reserved list if they are not already e820 reserved.
> + * This includes:
> + *  - The TXT HEAP
> + *  - The ACM area
> + *  - The TXT private register bank
> + *  - The MDR list sent to the MLE by the ACM (see TXT specification)
> + *  (Normally the above are properly reserved by firmware but if it was not
> + *  done, reserve them now)
> + *  - The AP wake block
> + *  - TPM log external to the TXT heap
> + *
> + * Also if the low PMR doesn't cover all memory < 4G, any RAM regions above
> + * the low PMR must be reservered too.

nit: s/reservered/reserved/

> + */
> +static void __init slaunch_txt_reserve(void __iomem *txt)
> +{
> +	struct txt_sinit_memory_descriptor_record *mdr;
> +	struct txt_sinit_mle_data *sinit_mle_data;
> +	u64 base, size, heap_base, heap_size;
> +	u32 mdrnum, mdroffset, mdrslen;
> +	u32 field_offset, i;
> +	void *mdrs;
> +
> +	base = TXT_PRIV_CONFIG_REGS_BASE;
> +	size = TXT_PUB_CONFIG_REGS_BASE - TXT_PRIV_CONFIG_REGS_BASE;
> +	slaunch_txt_reserve_range(base, size);
> +
> +	memcpy_fromio(&heap_base, txt + TXT_CR_HEAP_BASE, sizeof(heap_base));
> +	memcpy_fromio(&heap_size, txt + TXT_CR_HEAP_SIZE, sizeof(heap_size));
> +	slaunch_txt_reserve_range(heap_base, heap_size);
> +
> +	memcpy_fromio(&base, txt + TXT_CR_SINIT_BASE, sizeof(base));
> +	memcpy_fromio(&size, txt + TXT_CR_SINIT_SIZE, sizeof(size));
> +	slaunch_txt_reserve_range(base, size);
> +
> +	field_offset = offsetof(struct txt_sinit_mle_data,
> +				sinit_vtd_dmar_table_size);
> +	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> +						  field_offset);
> +
> +	mdrnum = sinit_mle_data->num_of_sinit_mdrs;
> +	mdroffset = sinit_mle_data->sinit_mdrs_table_offset;
> +
> +	txt_early_put_heap_table(sinit_mle_data, field_offset);
> +
> +	if (!mdrnum)
> +		goto nomdr;
> +
> +	mdrslen = mdrnum * sizeof(struct txt_sinit_memory_descriptor_record);
> +
> +	mdrs = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> +					mdroffset + mdrslen - 8);
> +
> +	mdr = mdrs + mdroffset - 8;
> +
> +	for (i = 0; i < mdrnum; i++, mdr++) {
> +		/* Spec says some entries can have length 0, ignore them */
> +		if (mdr->type > 0 && mdr->length > 0)
> +			slaunch_txt_reserve_range(mdr->address, mdr->length);
> +	}
> +
> +	txt_early_put_heap_table(mdrs, mdroffset + mdrslen - 8);
> +
> +nomdr:
> +	slaunch_txt_reserve_range(ap_wake_info.ap_wake_block,
> +				  ap_wake_info.ap_wake_block_size);
> +
> +	/*
> +	 * Earlier checks ensured that the event log was properly situated
> +	 * either inside the TXT heap or outside. This is a check to see if the
> +	 * event log needs to be reserved. If it is in the TXT heap, it is
> +	 * already reserved.
> +	 */
> +	if (evtlog_addr < heap_base || evtlog_addr > (heap_base + heap_size))
> +		slaunch_txt_reserve_range(evtlog_addr, evtlog_size);
> +
> +	for (i = 0; i < e820_table->nr_entries; i++) {
> +		base = e820_table->entries[i].addr;
> +		size = e820_table->entries[i].size;
> +		if ((base >= vtd_pmr_lo_size) && (base < 0x100000000ULL))

nit: unnecessary parentheses

> +			slaunch_txt_reserve_range(base, size);
> +		else if ((base < vtd_pmr_lo_size) &&
> +			 (base + size > vtd_pmr_lo_size))
> +			slaunch_txt_reserve_range(vtd_pmr_lo_size,
> +						  base + size - vtd_pmr_lo_size);
> +	}
> +}
> +
> +/*
> + * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
> + * It is stored in the TXT heap. Fetch it from there and make it available
> + * to the IOMMU driver.
> + */
> +static void __init slaunch_copy_dmar_table(void __iomem *txt)
> +{
> +	struct txt_sinit_mle_data *sinit_mle_data;
> +	u32 field_offset, dmar_size, dmar_offset;
> +	void *dmar;
> +
> +	memset(&txt_dmar, 0, PAGE_SIZE);
> +
> +	field_offset = offsetof(struct txt_sinit_mle_data,
> +				processor_scrtm_status);
> +	sinit_mle_data = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> +						  field_offset);
> +
> +	dmar_size = sinit_mle_data->sinit_vtd_dmar_table_size;
> +	dmar_offset = sinit_mle_data->sinit_vtd_dmar_table_offset;
> +
> +	txt_early_put_heap_table(sinit_mle_data, field_offset);
> +
> +	if (!dmar_size || !dmar_offset)
> +		slaunch_txt_reset(txt,
> +				  "Error invalid DMAR table values\n",
> +				  SL_ERROR_HEAP_INVALID_DMAR);
> +
> +	if (unlikely(dmar_size > PAGE_SIZE))
> +		slaunch_txt_reset(txt,
> +				  "Error DMAR too big to store\n",
> +				  SL_ERROR_HEAP_DMAR_SIZE);
> +
> +

nit: one blank line is enough

> +	dmar = txt_early_get_heap_table(txt, TXT_SINIT_MLE_DATA_TABLE,
> +					dmar_offset + dmar_size - 8);
> +	if (!dmar)
> +		slaunch_txt_reset(txt,
> +				  "Error early_ioremap of DMAR\n",
> +				  SL_ERROR_HEAP_DMAR_MAP);
> +
> +	memcpy(&txt_dmar[0], dmar + dmar_offset - 8, dmar_size);
> +
> +	txt_early_put_heap_table(dmar, dmar_offset + dmar_size - 8);
> +}

...

> +/*
> + * Intel TXT specific late stub setup and validation.
> + */
> +void __init slaunch_setup_txt(void)
> +{
> +	u64 one = TXT_REGVALUE_ONE, val;
> +	void __iomem *txt;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SMX))
> +		return;
> +
> +	/*
> +	 * If booted through secure launch entry point, the loadflags
> +	 * option will be set.
> +	 */
> +	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
> +		return;
> +
> +	/*
> +	 * See if SENTER was done by reading the status register in the
> +	 * public space. If the public register space cannot be read, TXT may
> +	 * be disabled.
> +	 */
> +	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> +	if (!txt)
> +		return;
> +
> +	memcpy_fromio(&val, txt + TXT_CR_STS, sizeof(val));
> +	early_iounmap(txt, TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> +
> +	/* SENTER should have been done */
> +	if (!(val & TXT_SENTER_DONE_STS))
> +		panic("Error TXT.STS SENTER_DONE not set\n");
> +
> +	/* SEXIT should have been cleared */
> +	if (val & TXT_SEXIT_DONE_STS)
> +		panic("Error TXT.STS SEXIT_DONE set\n");
> +
> +	/* Now we want to use the private register space */
> +	txt = early_ioremap(TXT_PRIV_CONFIG_REGS_BASE,
> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> +	if (!txt) {
> +		/* This is really bad, no where to go from here */
> +		panic("Error early_ioremap of TXT priv registers\n");
> +	}
> +
> +	/*
> +	 * Try to read the Intel VID from the TXT private registers to see if
> +	 * TXT measured launch happened properly and the private space is
> +	 * available.
> +	 */
> +	memcpy_fromio(&val, txt + TXT_CR_DIDVID, sizeof(val));
> +	if ((val & 0xffff) != 0x8086) {
> +		/*
> +		 * Can't do a proper TXT reset since it appears something is
> +		 * wrong even though SENTER happened and it should be in SMX
> +		 * mode.
> +		 */
> +		panic("Invalid TXT vendor ID, not in SMX mode\n");
> +	}
> +
> +	/* Set flags so subsequent code knows the status of the launch */
> +	sl_flags |= (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT);

nit: spaces around '|'

...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
