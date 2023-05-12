Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A9FC7EE23
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jxNkmsXISU3YSxZ1r1EVZnrRPTz5oAGEYkMry6sGjn4=; b=0+ZiVFOEjUCWNc
	5bpryujKZn+EsHJvCl88dXNL4NNYo+0Ll39kwL67YPcWCsjaq9RVsA1yJpVqDNeKp99HJn/+BrRY9
	oNJ7W3qaW3V+THh/IPNEvLmYHzDKzvLMoubvG8xatTW6+zYAuvTGCGOyMkTlvoZ7QPFjo38l+EjUR
	EI4L/kO3A5cw0hOcN5FoFfwlM5sHfCHVD+0x+B2NONMKJOp/mONOTapudJR3CNf9nC1at/KX9yCIs
	JmkX3P9gUcBB0+WxEWkYtAymoucxmYhvFZuA/JXsTHA+4omyPFDxhfJNW9qIdp4SNitlAqpliIlaz
	HwVm03AaIka3Nx3b4XeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUwF-00CPER-2Z;
	Fri, 12 May 2023 15:44:11 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxUwB-00CPAa-2q
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 15:44:10 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1683906241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTa5g+pxhC6EjhK4uNcZKNdGUeakcPfkaE7Sp7t1J14=;
	b=UaD8yoj2U9lr8h5H0rsMBsGYlyNn2hxAb941Mp3TFiNn4oZChtd05Xt6nJk8TlbOurDzTN
	jrAuHIBnB9J9bFDYdYtRHCd4yIT31SUVWFzFUgheDKOUilAglOUDCbs2MDpTEPZu2O/c5e
	L+wqK55Tje6TjpAQd8Za5E7tRjsXoaF41wKIjkmCt1ZRtr/t2reIN1HK0Y4C4WVoegpm5i
	JoJC0DrQ+FONd8+MIjvBDaQOsCNZpto7t8GoARW3Cox6eijL4aEd0En7ax+lE4OOJ/9cUh
	tsPpzuqxVshaHg2qDwn6VH/mboWoOHnAy98soXWmm/7uzNEB52VTAmouOdTVzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1683906241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lTa5g+pxhC6EjhK4uNcZKNdGUeakcPfkaE7Sp7t1J14=;
	b=EOKuudnx/6QNvHJfaDUG8EOeYSN7duIrAZ/X1CRE8aCeryg1rVmoUnOcaaOLbimGKkJA64
	82SKWrbbMUlGACDg==
To: Ross Philipson <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
 kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc: ross.philipson@oracle.com, dpsmith@apertussolutions.com,
 mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 luto@amacapital.net, nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
 trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
In-Reply-To: <20230504145023.835096-9-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-9-ross.philipson@oracle.com>
Date: Fri, 12 May 2023 17:44:00 +0200
Message-ID: <87jzxdblmn.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_084408_227105_6115273D 
X-CRM114-Status: GOOD (  23.34  )
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

On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch

Can you please make functions visible in changelogs by appending (),
i.e. setup_arch() ?

See https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
for further hints.

> +static u32 sl_flags;
> +static struct sl_ap_wake_info ap_wake_info;
> +static u64 evtlog_addr;
> +static u32 evtlog_size;
> +static u64 vtd_pmr_lo_size;

Is any of this modifyable after boot? If not then this wants to be
annotated with __ro_after_init.

> +/* This should be plenty of room */
> +static u8 txt_dmar[PAGE_SIZE] __aligned(16);
> +
> +u32 slaunch_get_flags(void)
> +{
> +	return sl_flags;
> +}
> +EXPORT_SYMBOL(slaunch_get_flags);

What needs this export? If there is a reason then please EXPORT_SYMBOL_GPL()

> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
> +{
> +	return &ap_wake_info;
> +}

If you return a pointer, then there is not much of point for encapsulating.

> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)

Some explanation on public visible functions would be really useful.

> +{
> +	/* The DMAR is only stashed and provided via TXT on Intel systems */

-ENOPARSE.

> +	if (memcmp(txt_dmar, "DMAR", 4))
> +		return dmar;
> +
> +	return (struct acpi_table_header *)(&txt_dmar[0]);

s/&txt_dmar[0]/txt_dmar/ No?

> +}

> +void __noreturn slaunch_txt_reset(void __iomem *txt,
> +				  const char *msg, u64 error)

Please avoid these line breaks. We lifted the 80 character limit quite
some time ago.

> +
> +	/* Iterate over heap tables looking for table of "type" */
> +	for (i = 0; i < type; i++) {
> +		base += offset;
> +		heap = early_memremap(base, sizeof(u64));
> +		if (!heap)
> +			slaunch_txt_reset(txt,
> +				"Error early_memremap of heap for heap walk\n",
> +				SL_ERROR_HEAP_MAP);

This is horrible to read.

		if (!heap) {
			slaunch_txt_reset(txt, "Error early_memremap of heap for heap walk\n",
                        		  SL_ERROR_HEAP_MAP);
                }

See documentation about bracket rules.

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

txt_dmar is statically allocated so it's already zero, no?

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

Wait. You have established above that SMX is available and the boot has
set the SLAUNCH flag.

So if that ioremap() fails then there is an issue with the fixmaps.

How is returning here sensible? The system will just die later on in the
worst case with some undecodable issue.

Thanks,

        tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
