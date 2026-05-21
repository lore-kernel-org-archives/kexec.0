Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2D2CD5BAC
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 18:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To
	:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHTbJEuXZdHx6N6WJcPrdnqUBqgjkQoTRJUUIZxSOGk=; b=1Y+DrhrBZWR9W4ghIwhtSVqizp
	0KG4GNIW45CG/KOYFVQn++gmlZNCdokt0THMJ5MZuFGKDqI2/DIYFdkF7J/gVv0oy/6Lf4pAAY9/8
	uKAtm8yhxJhTcGcgf+op8VgGapFXq1ANJlO8g343iH9N5Olkrl5PQfzbpiqOz7l5aN+ltBW/d03h6
	rIIiJzUXtboyilWTvziMabj2iLxo3sqRXLHP/crv0FgeqAabzs1GAoBwATBA2+inJXmd8Wcb5FcR1
	x850z2ZyYdcgKJ/BSrvUfql2V/muzBIzTswS2/mZ8+8NtoLSUMfDh8hvnnd5vmxJr1YnmgZhHzWlT
	qUqSavhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ8Hr-00000008oCh-1PKW;
	Thu, 21 May 2026 18:38:27 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ8Hn-00000008oBs-1TXM
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 18:38:24 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-512f09ecc67so46115961cf.3
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 11:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779388702; x=1779993502; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHTbJEuXZdHx6N6WJcPrdnqUBqgjkQoTRJUUIZxSOGk=;
        b=Y5n1UelPOTQVPV2zDDJt7sEsBcDkVFIi34LozeMcNCiWMMlioql/pfu9JmwgUpgSPO
         K52uUbdyUkDXdnmC0JTHV0/Vs16GpQOHhtLOTcD62xz96Is4mIesMAJronb7USQInKbS
         SfOS1uJKA12lvt5smHbLE4lL0XSZj26rQBgeeKnquOr64E/CZThisdfl1ZoPSp3YZeMM
         +DMbgnB0+Z12edh82lZPfeY22Ct4l9GT0dsdwmhhorhCmpwHHqDV27rnZR/81CTxS+kw
         CImcIL/I8r5mo2HSIDNoK58PAegly6mtiI7BGLMqE6MU8p7UJV56QVwXfekG9b6oeir+
         rVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779388702; x=1779993502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHTbJEuXZdHx6N6WJcPrdnqUBqgjkQoTRJUUIZxSOGk=;
        b=n08k8ZubPQEJOz2gknMmzjywFgXTymorh7xMcpXS2kCXtCWDhTyWurjtFrEzODT7aQ
         EYV3tFAj7EpHjMyfp2/Im+BWwjqJL70E/WjFL6K0sicS3PhwV76MUjAmBka5TKqlVaQg
         M1j3bq26NsB/eYQCzf3J6Kzqa8+qeZwItDT0KiQi1WgTMYHObimIW4g1O16Dwsr9qsT0
         SHArTWBHuY1R1v7oVGEjTNhrIM4XzvVO2pbNUjFOUyhtuSLPZqplKLoqhdUEwM34nWxL
         RHXwro+RK9WMFs9xf3MKShUT8zMraJ/wI6J1ZgHSR2dfVuo96Ui4qDSUIuCrlYBTbw+7
         23RQ==
X-Forwarded-Encrypted: i=1; AFNElJ8EoP1XTAzZzJ7lnCq32bbr2ZT8kyR1P2jIwVi/C4Zg563SlcevSw7Tm34eqQO0HWLtNZCMug==@lists.infradead.org
X-Gm-Message-State: AOJu0YzKFQVbO3+xf9WYaymAjGhONI9+6/0tC8KujQ4ccQonqmxBARGz
	JY1X9jU08+ipc68rf/wcuEKJCcXl4ydJ3BuvKomH0PgpTUeePQHY+1gq+pO0ch9zNQ0=
X-Gm-Gg: Acq92OHvbJc41x6c6oTPSERLxZbKk4EfVRvUd22WKLFIgYTdQ4rBMOwAGxZeK0MsslJ
	q/1rvdMEcGXvFq4rBiINR8Ltz/bOEKzZ3dP1fmCrmm8LzccXXO/krfW01+6UBzUfb0kt09Ht7+2
	kVb7JYzt86tfkIrbCA2/R+geawsQ7HR4kie9UJsSufu+wBfOtXPSXnJhBoSKWQK5yQzkrK9rYh9
	ZfOw1fr4N2+2DPXBH46frr2wmbOG20K2rcSQbY2r/ej36q/XEJfgz7IqYmkaibhq0009CAamp2B
	Swg+vZ1aK/jIksJe+iJztptyMorTajBPSUg+OF6ClGmhHVJQQPM2BXXlyoWwvhPPp4whvrmwS/k
	GqoYoFxK8nmbTI/14gBx1zBjcsQMUYP587u6oXxZmPnCG3eulBDAC9NtJ2BYZ5vRfu1DF7F3894
	ccgzRyh+a7FW3Wf3k635wlyoPpkDCatk4ZpvZW92TBzZCehgv8G8U=
X-Received: by 2002:a05:622a:207:b0:50f:b904:457 with SMTP id d75a77b69052e-516d4316d1fmr7975701cf.25.1779388701888;
        Thu, 21 May 2026 11:38:21 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781b383csm12094556d6.27.2026.05.21.11.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 11:38:21 -0700 (PDT)
Date: Thu, 21 May 2026 18:38:20 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Michal Clapinski <mclapinski@google.com>
Subject: Re: [PATCH] pstore: add a KHO backend
Message-ID: <ag9LehR5HdX14M9s@plex>
References: <20260520174332.921186-1-mclapinski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520174332.921186-1-mclapinski@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_113823_406102_D84288C4 
X-CRM114-Status: GOOD (  24.40  )
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

On 05-20 19:43, Michal Clapinski wrote:
> Up to this point to preserve late shutdown logs in memory, users had to
> predefine a memory region using ramoops. This commit changes this by
> preserving a buffer using kexec-handover.
> 
> For now it supports preserving only 1 dmesg buffer.

"only" sounds like a limitation, but I do not think it is. If userspace 
is configured properly after every boot, it can back up the dmesg from 
the previous kernel instance if needed.

> It gets replaced with the new buffer on every kexec, so the user has to
> copy the file out of pstore after every kexec.
> There is no erase() support.
> 
> Signed-off-by: Michal Clapinski <mclapinski@google.com>
> ---
>  fs/pstore/Kconfig      |   9 ++
>  fs/pstore/Makefile     |   2 +
>  fs/pstore/pstore_kho.c | 267 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 fs/pstore/pstore_kho.c
> 
> diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> index 3acc38600cd1..70853799e211 100644
> --- a/fs/pstore/Kconfig
> +++ b/fs/pstore/Kconfig
> @@ -81,6 +81,15 @@ config PSTORE_RAM
>  
>  	  For more information, see Documentation/admin-guide/ramoops.rst.
>  
> +config PSTORE_KHO
> +	tristate "Preserve logs over kexec"
> +	depends on PSTORE
> +	depends on KEXEC_HANDOVER
> +	help
> +	  A pstore backend for preserving dmesg over KHO (kexec handover).
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
> index 000000000000..3bc679273c8d
> --- /dev/null
> +++ b/fs/pstore/pstore_kho.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * KHO (Kexec Handover) backend for pstore
> + */

We need a proper Doc comment here explaining the benefits of using a 
KHO-based pstore. It has some very significant advantages, such as 
removing the need to manage a hardcoded memmap or rely on firmware 
support. Also, you can mention that pstore also provides the ability to 
preserve every single dmesg even after filesystem unmounts, without 
being limited by the console baud rate.

> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/libfdt.h>
> +#include <linux/module.h>
> +#include <linux/pstore.h>
> +#include <linux/slab.h>
> +#include <linux/unaligned.h>
> +
> +#define KHO_PSTORE_FDT_NAME	"pstore-kho"
> +#define KHO_PSTORE_COMPAT	"pstore-kho-v1"
> +#define KHO_PSTORE_DATA		"pstore_kho_record"
> +
> +static const size_t record_max_size = 1 << CONFIG_LOG_BUF_SHIFT;

The above should be added to include/linux/kho/abi/pstore.h

Also, there is no need to add an FDT subtree; it is much cleaner to add 
a sub-blob and use a C-struct directly. Let's add something like struct 
pstore_ser to the pstore ABI header to act as an anchor for everything 
this code references.

Additionally, what happens if CONFIG_LOG_BUF_SHIFT changes between two 
kexec'd kernels? Will this still work? If not, then the buffer size 
needs to be explicitly defined as part of the ABI.

[...]

Pleae review 
https://sashiko.dev/#/patchset/20260520174332.921186-1-mclapinski%40google.com 
review comments.

Pasha

