Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B4DCD98CC
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ykavwyEqXsW5ZZ5nScuS33KTE6M/HjG6kMAg60TPXhY=; b=ume0X76kVCap8cR+gxZYaSayV/
	2w3aWzu3EdheTbCHAiyL1peQ/qqnHOL4I3kqqK+g81jI4IRD9+r61VbDNpzMadDuUMUIc27FQ4kK4
	74+UbjA78/H1PJt4hCWbizoMaO82hEq+E/1Fh9qOC13tmWcXiL9kRIMMQGPRBupjIM6P9nHV9FVFG
	gXDe3+lgGMDIo0XVP+BzmDdAEfJcYlzyovzUkL6CCeXPZwXrm5chEWhUS17HMlF3SW5lMKWsWr4Xb
	dCDDpo+4+1oOFgukR3AA7JnCa2WZuVCFA3Ns5Ba+uKivlmUL8vCGQ/g+ev3FjyRQHbgSz9yLQzPWT
	5Dtanh5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXkYb-00000009uw2-2DBy;
	Thu, 11 Jun 2026 18:55:13 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXkYY-00000009uvM-3Z6w
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 18:55:12 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8ccf18ef922so2825596d6.3
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 11:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781204109; x=1781808909; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ykavwyEqXsW5ZZ5nScuS33KTE6M/HjG6kMAg60TPXhY=;
        b=FjZiVdX0NSv3ZV/DbmcEJyCo/NGtTnPGcyzOF/rzMCkse+ay3MjN3neFByzDwwG4PS
         lieDJSL7Vvxix0BnllTM1cXDYScLsDd3jeXweLEgDtRJSSHmwGdVSDY5YTwGNAnVvGSy
         XS1Asgdti05xJo6EFpIAYj0LhRfpXlrzbSisjdTes6V8x9I4GMQBkLWw2+sciNtgSGcA
         O7AVHEdhAY1rfGUDkK+Am2jlpsUxAJAkZh7v60KLr1qrqmX+OREC4GO+Jam2S/3rNlMC
         aPoCYZdKe5jQ7a4fei6QR77T1oZoqounegpcBp1z5NEPOxvRwe90oT62pYdYwutB+kPc
         PByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781204109; x=1781808909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykavwyEqXsW5ZZ5nScuS33KTE6M/HjG6kMAg60TPXhY=;
        b=kOpQOfbQlepJ0gV1NSycBHy5AuYnaUHg5NpUYYH1cgSDxt9xfn8JL68OZ0+kS1mCy4
         qT2k5pfRyAAjLMsO/f23CXZHLLMdUC+fcdQL0j0+F3Sm4V96j9Il4jLapyEG2g8cYouU
         tdhDOHXwUAgPs8t0onhgEB0miAe/9RIV55Ekeh3RaOUL//YPnI8UkMx6v2rvDNYVN3l8
         /IvTYa8oGYlxy0oWnDmhSRKT/kuKTbQRT/lv3qx825FTG7heyhNIeN9FPZNOHf72N5+3
         PblAeekkIS3o7Lw7+Ydov/xvNaFF1ILi/QghVFV5QNXDzXsYHe6Cm9QJG1/OxTvtPYcj
         J6AQ==
X-Forwarded-Encrypted: i=1; AFNElJ+thWi9rpDbYeH5Zwm1I+QUzdAwaBfJ36lat2HJKX48a8otTzKJ9SOeQIbf0ghgijk2EoMBBw==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywib6sz/FKq2EWXMcCImDH/5EX5Q8gpGXeFYZZUfOVxbTgmG/kQ
	PStiOsWibnRCrCOtZx2bhy4ZcAjhs2GRQpFlKA25LKoz32DNt1uttMnatMdP8k+H1mI=
X-Gm-Gg: Acq92OFolc56EzqVnwWHMbNJKWJjTL6cNJSB4Zsbosak5hKwMRMahrq8N0QWWtM5vru
	mBqPYqCNpnToz6bT66c56hroFlsh6npRtGsGCE/aj/R5E0ui/n2FOh6D8KTJKZCxapzlWVB0gwE
	NtcKZcH/EqEk/YqXJSMwjgA+U5+oQPAsbHQI8bjKIM76gf/WhTxev4eJknjkzri8psdmDFsRE+J
	tVNqkt6+Lkn9s7B9fCUd8ok6CmXcIQitpGeM3Lg2Q3vtthyyz6Orfhub4z2lostiA3xOlyYgNFy
	INyU5lf2YXXUEzx1PRFJhCZE1ARp1T0/eWVyM8SmVncY03rbWvOJ147KJWhLKI2x8udgVsjD6p0
	jQBQOcml3iPMpSWQQW7QuJ9X52ZrWF0WiLLrqQ79z04CBCz3iWaeKzYxkzxYVbGhuQO4KpW1bSR
	EMwmbyI2Yprl6o3drhXI0DRel/vP8ZqM7lCm58hSJTEhZKli453ogKLoPYKRtJBA==
X-Received: by 2002:a05:6214:4113:b0:8cc:ece4:f88a with SMTP id 6a1803df08f44-8d1d8246c51mr65020766d6.2.1781204109520;
        Thu, 11 Jun 2026 11:55:09 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302211f20sm1590026d6.21.2026.06.11.11.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:55:09 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:55:08 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
Message-ID: <air8jVtmUahab9hd@plex>
References: <20260605121040.1177072-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605121040.1177072-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_115510_939501_5DD0649D 
X-CRM114-Status: GOOD (  44.13  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 06-05 14:10, Michal Clapinski wrote:
> Up to this point to preserve late shutdown logs in memory, users had to
> predefine a memory region using ramoops. This commit changes this by
> preserving a buffer using kexec-handover.
> 
> pstore_kho supports preserving only 1 dmesg buffer.
> It gets replaced with the new buffer on every kexec, so the user has to
> copy the file out of pstore after every kexec.
> There is no erase() support.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
> v2:
> - Added a comment explaining the benefits of pstore_kho.
> - Created include/linux/kho/abi/pstore.h.
> - Got rid of the KHO subtree.
> - Made sure never to free incoming kho data.
>   This way the module can be safely reloaded.
> - Sashiko complained that I trust the data coming from the old kernel.
>   I ignored it. LMK if I shouldn't trust the old kernel.
> ---
>  fs/pstore/Kconfig              |  10 ++
>  fs/pstore/Makefile             |   2 +
>  fs/pstore/pstore_kho.c         | 230 +++++++++++++++++++++++++++++++++
>  include/linux/kho/abi/pstore.h |  27 ++++
>  4 files changed, 269 insertions(+)
>  create mode 100644 fs/pstore/pstore_kho.c
>  create mode 100644 include/linux/kho/abi/pstore.h
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 3acc38600cd1..455790fec955 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -81,6 +81,16 @@ config PSTORE_RAM
>  
>  	  For more information, see Documentation/admin-guide/ramoops.rst.
>  
> +config PSTORE_KHO
> +	tristate "Preserve logs over kexec"
> +	depends on PSTORE
> +	depends on KEXEC_HANDOVER
> +	help
> +	  A pstore backend for preserving dmesg over KHO (kexec handover).
> +	  It does not require any additional cmdline params to work.
> +
> +	  It supports preservation of only 1 dmesg file.
> +
>  config PSTORE_ZONE
>  	tristate
>  	depends on PSTORE
> diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
> index c270467aeece..518cd408bf8e 100644
> --- a/fs/pstore/Makefile
> +++ b/fs/pstore/Makefile
> @@ -13,6 +13,8 @@ pstore-$(CONFIG_PSTORE_PMSG)	+= pmsg.o
>  ramoops-objs += ram.o ram_core.o
>  obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
>  
> +obj-$(CONFIG_PSTORE_KHO)	+= pstore_kho.o
> +
>  pstore_zone-objs += zone.o
>  obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
>  
> diff --git a/fs/pstore/pstore_kho.c b/fs/pstore/pstore_kho.c
> new file mode 100644
> index 000000000000..6d4187d91642
> --- /dev/null
> +++ b/fs/pstore/pstore_kho.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KHO (Kexec Handover) backend for pstore.
No need to spelll it out.
> + *
> + * KHO-based pstore provides a mechanism to hand over pstore data (specifically
> + * dmesg logs) from one kernel to another across a kexec reboot using the
> + * Kexec Handover (KHO) framework.
> + *
> + * Key advantages of KHO-based pstore include:
> + * - No hardcoded memmap: Unlike ramoops, it does not require reserving a static
> + *   memory region in the bootloader or device tree. Memory is allocated
> + *   dynamically and handed over to the next kernel.
> + * - Firmware independence: It does not rely on platform firmware support (like
> + *   ACPI ERST or UEFI variable storage) to preserve logs across reboots.
> + * - High throughput: It avoids the performance bottlenecks of serial consoles,
> + *   not being limited by console baud rates.
> + * - Complete log preservation: It preserves all dmesg logs, including those
> + *   generated late in the reboot cycle after filesystems have been unmounted,
> + *   up to the point of the kexec jump.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kho/abi/pstore.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/module.h>
> +#include <linux/pstore.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +/*
> + * The in and out buffers are separate and they need not be the same size.
> + * Therefore, this is not part of ABI.
> + */
> +#define RECORD_MAX_SIZE		(1 << CONFIG_LOG_BUF_SHIFT)

This does not sound right. I think, we should enforce size through 
ABI. Or make it flexible so 

> +
> +struct pstore_kho_context {
> +	struct pstore_info pstore;
> +	bool read_done;
> +};
> +
> +static struct pstore_ser *kho_ser_in;
> +static struct pstore_ser *kho_ser_out;
> +
> +static int pstore_kho_open(struct pstore_info *psi)
> +{
> +	struct pstore_kho_context *cxt = psi->data;
> +
> +	cxt->read_done = false;
> +	return 0;
> +}
> +
> +static ssize_t pstore_kho_read(struct pstore_record *record)
> +{
> +	struct pstore_kho_context *cxt = record->psi->data;
> +	struct pstore_kho_record *kho_data_in;
> +
> +	if (cxt->read_done || !kho_ser_in)
> +		return 0;
> +
> +	cxt->read_done = true;
> +	kho_data_in = &kho_ser_in->record;
> +
> +	record->buf = kmemdup(kho_data_in->buf, kho_data_in->size, GFP_KERNEL);
> +	if (!record->buf)
> +		return -ENOMEM;
> +
> +	record->type = PSTORE_TYPE_DMESG;
> +	record->id = 0;
> +	record->size = kho_data_in->size;
> +	record->time.tv_sec = kho_data_in->time_sec;
> +	record->time.tv_nsec = kho_data_in->time_nsec;
> +	record->count = kho_data_in->count;
> +	record->reason = kho_data_in->reason;
> +	record->part = kho_data_in->part;
> +	record->compressed = kho_data_in->compressed;
> +
> +	return record->size;
> +}
> +
> +static int pstore_kho_write(struct pstore_record *record)
> +{
> +	struct pstore_kho_record *kho_data_out = &kho_ser_out->record;
> +
> +	if (record->type != PSTORE_TYPE_DMESG)
> +		return -EINVAL;
> +
> +	if (kho_data_out->size != 0) {
> +		pr_err("pstore kho already contains a record\n");
> +		return -ENOSPC;
> +	}
> +
> +	if (record->size > RECORD_MAX_SIZE) {
> +		pr_err("dmesg record too big, record size: %lu, available space: %d\n",
> +		       record->size, RECORD_MAX_SIZE);
> +		return -ENOSPC;
> +	}
> +
> +	memcpy(kho_data_out->buf, record->buf, record->size);
> +	kho_data_out->size = record->size;
> +	kho_data_out->time_sec = record->time.tv_sec;
> +	kho_data_out->time_nsec = record->time.tv_nsec;
> +	kho_data_out->count = record->count;
> +	kho_data_out->reason = record->reason;
> +	kho_data_out->part = record->part;
> +	kho_data_out->compressed = record->compressed;
> +
> +	return 0;
> +}
> +
> +static struct pstore_kho_context pstore_kho_cxt = {
> +	.pstore = {
> +		.owner		= THIS_MODULE,
> +		.name		= "kho",
> +		.bufsize	= RECORD_MAX_SIZE,

Let's make this ABI for simplicity.

> +		.flags		= PSTORE_FLAGS_DMESG,
> +		.max_reason	= KMSG_DUMP_SHUTDOWN,

In all other places, the default is KMSG_DUMP_OOPS, and it is increased 
or decreased based on user-provided parameters. Should we not do the 
same here?

> +		.open		= pstore_kho_open,
> +		.read		= pstore_kho_read,
> +		.write		= pstore_kho_write,
> +	},
> +};
> +
> +static void __init kho_setup_incoming(void)
> +{
> +	phys_addr_t kho_ser_phys;
> +	int err;
> +
> +	err = kho_retrieve_subtree(KHO_PSTORE_FDT_NAME, &kho_ser_phys);
> +	if (err) {
> +		if (err != -ENOENT)
> +			pr_err("failed to retrieve KHO data %s: %d\n",
> +			       KHO_PSTORE_FDT_NAME, err);
> +		return;
> +	}
> +
> +	kho_ser_in = phys_to_virt(kho_ser_phys);
> +
> +	if (kho_ser_in->version != KHO_PSTORE_VERSION) {
> +		pr_err("unsupported KHO pstore version: %d\n", kho_ser_in->version);
> +		kho_ser_in = NULL;
> +		return;
> +	}
> +
> +	pr_info("successfully restored preserved data\n");
> +}
> +
> +static int __init kho_setup_outgoing(void)
> +{
> +	int err;
> +	size_t total_size = sizeof(struct pstore_ser) + RECORD_MAX_SIZE;

Please use the reverse-christmas-tree order for variable declarations.

> +
> +	kho_ser_out = kho_alloc_preserve(total_size);

RECORD_MAX_SIZE is not part of the ABI, yet it is statically configured 
during kho_setup_outgoing(). We need to either make it dynamic, setting 
up preserved pages as we go based on the amount of used memory (i.e use 
something like KHO linked-blocks), or make this part of the ABI.

> +	if (IS_ERR(kho_ser_out)) {
> +		pr_err("failed to allocate pstore kho ser anchor\n");
> +		return PTR_ERR(kho_ser_out);
> +	}
> +	memset(kho_ser_out, 0, total_size);
> +	kho_ser_out->version = KHO_PSTORE_VERSION;
> +
> +	err = kho_add_subtree(KHO_PSTORE_FDT_NAME, kho_ser_out);
> +	if (err) {
> +		pr_err("failed to add KHO data\n");
> +		goto err_free_ser;
> +	}
> +
> +	return 0;
> +
> +err_free_ser:
> +	kho_unpreserve_free(kho_ser_out);
> +	return err;
> +}
> +
> +static int __init pstore_kho_init(void)
> +{
> +	int err;
> +	struct pstore_kho_context *cxt = &pstore_kho_cxt;

RCT order please.

> +
> +	if (!kho_is_enabled()) {
> +		pr_info("KHO is disabled, pstore_kho cannot start\n");
> +		return -ENODEV;
> +	}
> +
> +	kho_setup_incoming();
> +	err = kho_setup_outgoing();
> +	if (err) {
> +		pr_err("failed to setup outgoing KHO\n");
> +		return err;

Although the outgoing failed, can we still retrieve incoming messages?

> +	}
> +
> +	cxt->pstore.data = cxt;
> +	cxt->pstore.buf = kmalloc(cxt->pstore.bufsize, GFP_KERNEL);
> +	if (!cxt->pstore.buf) {
> +		err = -ENOMEM;
> +		goto err_free_outgoing;
> +	}
> +
> +	err = pstore_register(&cxt->pstore);
> +	if (err) {
> +		pr_err("failed to register with pstore\n");
> +		goto err_free_pstore_buf;
> +	}
> +
> +	return 0;
> +
> +err_free_pstore_buf:
> +	kfree(cxt->pstore.buf);
> +
> +err_free_outgoing:
> +	kho_remove_subtree(kho_ser_out);
> +	kho_unpreserve_free(kho_ser_out);
> +
> +	return err;
> +}
> +module_init(pstore_kho_init);
> +
> +static void __exit pstore_kho_exit(void)
> +{
> +	pstore_unregister(&pstore_kho_cxt.pstore);
> +	kfree(pstore_kho_cxt.pstore.buf);
> +
> +	kho_remove_subtree(kho_ser_out);
> +	kho_unpreserve_free(kho_ser_out);
> +}
> +module_exit(pstore_kho_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Pstore backend for dmesg preservation over kexec");
> diff --git a/include/linux/kho/abi/pstore.h b/include/linux/kho/abi/pstore.h
> new file mode 100644
> index 000000000000..743ec64d67fc
> --- /dev/null
> +++ b/include/linux/kho/abi/pstore.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_KHO_ABI_PSTORE_H
> +#define _LINUX_KHO_ABI_PSTORE_H
> +
> +#include <linux/types.h>

Please use the header comment in other ABI files as a template for what 
should be stated here. Please also include it in the documentation, 
consistent with all other ABI headers.

> +
> +#define KHO_PSTORE_FDT_NAME	"pstore-kho"
> +#define KHO_PSTORE_VERSION	1
> +
> +struct pstore_kho_record {

I would prefer: pstore_record_ser

> +	s64			size;
> +	s64			time_sec;
> +	u32			time_nsec;
> +	s32			count;
> +	u32			reason;
> +	u32			part;
> +	u32			compressed;
> +	char			buf[];
> +};
> +
> +struct pstore_ser {
> +	u32			version;
> +	struct pstore_kho_record record;
> +};
> +
> +#endif /* _LINUX_KHO_ABI_PSTORE_H */
> -- 
> 2.54.0.1032.g2f8565e1d1-goog
> 

