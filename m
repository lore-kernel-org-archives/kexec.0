Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43414CD8CA8
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 05:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ytd7iPwY/amgpO/lDKmmEiHlsDrpfROrVFTbD1YMi6c=; b=gjP/ce3GItDjzb3j4HYTtXdf/c
	FYNisUtw5UlRUQSMNSCbm31pdDwGZRHMg5twN+HpXeGK+AmB2OinmFY7Sarc0GG1CR9l4cjlC49nZ
	bXhW1GZiI7IKstlAxyy3CyNvy5fgGQSX35gYfn5lXNcBydjEKh2iRflsPV9WXuxB0JEEua/w1ku+H
	ywGHN64SXnKn0cCphx8paQn1oCLZ/IYW8ZRbUPAs/xqy211glKcCpluLSoFeSDlINkoJc186+aR0z
	gz7XYP/RGSD4ySOukyYOFW8Q62ti/jaJ2p1lFkazVFrEh+of4KpfAT/BJLg1wNlW0KxuIrnhaFs9M
	Gtj0yCNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXuEd-0000000ANBq-0o4d;
	Fri, 12 Jun 2026 05:15:15 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXuEa-0000000ANBN-07zX
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 05:15:13 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-517b1f2c668so5198661cf.2
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781241311; x=1781846111; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ytd7iPwY/amgpO/lDKmmEiHlsDrpfROrVFTbD1YMi6c=;
        b=cv+QyZ9fnB9P9jsUZKB4UW4+baPLM4dtcFwf3wFNjU9Lj1exXbphzlDEfmdGwLr9B4
         epvesnRnHWlW+X6peqL580zfOJF/+rktsndV04JSJ7fENAAdkFLoZcCefDD4JStTuC/v
         oGpXHNXIPldKq6VSxnbE8EfwE5I5EdkmEwfPYTTBByhnPPMpt+e/IQiP+bV776YaSf3i
         tJyHfQiHPujBWYZI0KlnKrIzw2/U98ubQnTQKavAkj6NKOpn93mJlKOOA1tCgfgxPY0q
         nkEqa5SwQyjlexxHyi8VLgTBybRgwPuKif85RJbmQKGtynLIYpc9KUj1kc95XK+ZouWW
         qhXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781241311; x=1781846111;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ytd7iPwY/amgpO/lDKmmEiHlsDrpfROrVFTbD1YMi6c=;
        b=kLy63H0q2qNWTxks/AfbR+AnWW+p0FuOmKXZCfavRWN+K2kJ8dRKuDsvbdj9OQVd1h
         dD6R6epd8/14xpY7Ime+4vNzmV1i0yyehz/eLnsmH/m0O1O9V+iwMfBXXtRof7QUrMJe
         Etv3/zCIws91q1IkosXf6r5ifAHtLrTSX1N/if0Fdlt4GvwguvUIOTUfKPtrh6No6vKp
         BI+gelfNtwxJKYIfNcfAYb5Uf3z5+DGeBztuKKv2zfR4WgX8QQARmxCLIMijo/yHCuMj
         3om7mW2Nj07Zq1spGsanSkafbJ0kONoxh7n/9AGKb/nPdqs3Hmro6eJdYkLZPnvw9PWY
         He5A==
X-Gm-Message-State: AOJu0Yyhq9PbTFfEHEI6/zJNnwYnRIujaePRkay2/EUapwt0y+x6F8YK
	+BeiecWEDVlmkyPfWMKXiYF46kw73lgaiiuvjo7F36FLetiTJfdI8J0di2q1SsaMshk=
X-Gm-Gg: Acq92OHi/UiFZR67Z29E4QyekHXB9h+vdXeSZTdhZXIJlrUvJ4lziJEk4TeBiAhxCBJ
	jQD52CQD7WKwqTtaj7Q7DfUzm/YzOnEnTJYsIHq5z0nC/l9fzV/NuaH7rHfFv7xNnsls0A9gz7B
	yNe2ZxUFgixBMGdaqIMPG9C7Acq+c4CacJl2HaCHZ0F5js6ftaDjQ95Fxtv6u1XYzTpIAHdtNHv
	y+wNBmR5pCKVPAfLLyCrDbVsr+vN/t1vfAPU4DckNCycdyrUcNGp9zp5saLQMitoyPWSZ5H3mIX
	LPWNLuByzrOT3ZllDpQXcw3jng5JTMM++B31fssIQ4Bj+RtJ1zk8bIgnTl4P92qWcbN71PTVtvP
	KKBM/Y1kh1PM2aJ+KlX2BBjhOv0ZfIZpF+nj7aH147tHFgnFRifaz7sQnOjGMeG4xakfdDeFxsh
	0HNAC81VG4EFU21Wwps2SD898bSHsWkSqYfiJAFIjZg8LxFW0OfxuctZTbqqS4
X-Received: by 2002:a05:622a:60c:b0:517:6b31:8058 with SMTP id d75a77b69052e-517fe50614bmr16606071cf.40.1781241310554;
        Thu, 11 Jun 2026 22:15:10 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7e8900sm12732291cf.23.2026.06.11.22.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 22:15:10 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the
 PCI core
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
 David Rientjes <rientjes@google.com>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
 Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>, 
 Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pranjal Shrivastava <praan@google.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Vipin Sharma <vipinsh@google.com>, 
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260522202410.3104264-2-dmatlack@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
Date: Fri, 12 Jun 2026 05:15:02 +0000
Message-Id: <178124130274.908199.14827357870284807134.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=EzD98ff1aItiQM04E7u7INRRf8aew7gIPA1oAqmmEbk=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqK5Xc6OMuwmCG+aG2z1N7L1TcMXvQcxKu7DUJX
 +1rPXHL7kiJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCaiuV3AAKCRC7dyhM23N6
 3sl4D/49rTQw3AtcTrHTcVdJeLsKzlzrERbSSrQdqByRDKt/VZ3tYXxZ42pX6dtH57jB2TwPimJ
 fosBa4kw60OkjlCXDe0327bTsC/RBIpO8fpRg1nrQ4mdgxcxCA9WDOPf7nJKIGccIBHIyBSvzMH
 F1ist4SEhl3S9htSG08rn/5MOMDrQMbyPYpiMXJkCX8jmEnu+IhogD/W9GVaoN48kPyeW1BSYys
 rlDCm4C1C+TpXxkc9eQoTDokqxutzb6n9L+BmuGFXMZzLRT+Cvyy2XYoSMZ7h/ca1urQmGkcYQI
 C94Kxe+cqfGA4hE2Id/Dtrfj2Cv5PJVKahykKX4kp5vdFS8qGiWiexcvY5qrgFRIkuR467BP+WH
 IjdCg6yY0k1YvqmZTee/96z3eDX+BL7agDjBDpQJ6P92fVdayoI0kDL71lX9FhtUoobW0gUipjR
 UEi/3DifS9I2vz9+U7MN2RA4kPvyOQjqLtNmo9v4FSBa/YkCLnoyRA0LlRsIjF9d9WdtKu8M1ad
 CMeu4L4tloS40kHaM4VoOCDpVOxau7uk165pKvOGsyGdRN5wGMShHp0btN7htAjYMh9jz2E1mw7
 uMP27uJMOKTo6YqcPACF1qa4YPc+FVG+bLp/Qp6ddOr+7jiJvg9s9XVb469tJ1qe/BZiKMpm5tf
 9wtlEwOJSVNY0UA==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_221512_099684_9392B62D 
X-CRM114-Status: GOOD (  20.41  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd16..6c618830cf61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20530,6 +20530,16 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
> +PCI LIVE UPDATE
> +M:	David Matlack <dmatlack@google.com>

Please add Pratyush, Mike, and myself so we are notified directly of 
incoming patches, the same as with other areas where the liveupdate/ 
tree is specified.

>
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 000000000000..737e7b9366db
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (c) 2026, Google LLC.
> + * David Matlack <dmatlack@google.com>
> + */
> +
> +/**
> + * DOC: PCI Live Update
> + *
> + * The PCI subsystem participates in the Live Update process to enable drivers
> + * to preserve their PCI devices across kexec.
> + *
> + * File-Lifecycle-Bound (FLB) Data
> + * ===============================

...

> + *
> + * PCI device preservation across Live Update is built on top of the Live Update
> + * Orchestrator's (LUO) support for file preservation across kexec. Drivers

I prefer to just use acronyms FLB, and LUO, but have links to the actual 
documentations about them.

So, something like this:

  * :ref:`FLB <flb>` Data
  * =====================
  *
  * PCI device preservation across Live Update is built on top of the
  * :ref:`LUO <luo>` support for file preservation across kexec. Drivers

And also add _luo and _flb to Documentation/core-api/liveupdate.rst

.. _luo:

 ========================
 Live Update Orchestrator
 ========================

.. _flb:

 LUO File Lifecycle Bound Global Data
 ====================================

> [ ... skip 17 lines ... ]
> + *
> + *  * ``pci_liveupdate_register_flb(driver_file_handler)``
> + *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> + */
> +
> +#define pr_fmt(fmt) "PCI: liveupdate: " fmt

Nit, may be:

> +
> +#include <linux/io.h>
> +#include <linux/kexec_handover.h>
> +#include <linux/kho/abi/pci.h>
> +#include <linux/liveupdate.h>
> +#include <linux/mutex.h>
> +#include <linux/mm.h>

Please sort alphabetically.

> [ ... skip 12 lines ... ]
> +	 * future to increase the chances that there is enough room to preserve
> +	 * devices that are not yet present on the system (e.g. VFs, hot-plugged
> +	 * devices).
> +	 */
> +	for_each_pci_dev(dev)
> +		max_nr_devices++;

I think, we want to use kho_block [1] (it is in liveupdate/next branch) 
to allow number of supported devices to be dynamic.

To support this, we would redefine the ABI and tracking structures like 
so:

/* include/linux/kho/abi/pci.h */
struct pci_ser {
	u64 devices;      /* Phys address of the first block header of kho_block_set */
	u64 nr_devices;   /* Total count of active preserved devices */
} __packed;

/* drivers/pci/liveupdate.c */
struct pci_flb_outgoing {
	struct pci_ser *ser;            /* Points to the FDT/KHO-allocated ABI struct */
	struct kho_block_set block_set;  /* Controls the active blocks on the fly */
};

In  __pci_liveupdate_preserve_device() , we would search for 
and reuse any inactive  pci_dev_ser  slot first, and only call 
kho_block_set_grow() to expand if no inactive slots are available.

In pci_liveupdate_unpreserve_device(), we would simply 
mark the  pci_dev_ser as inactive.

>
> diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> new file mode 100644
> index 000000000000..8ec98beefcb4
> --- /dev/null
> +++ b/include/linux/pci_liveupdate.h
> @@ -0,0 +1,30 @@
> [ ... skip 24 lines ... ]
> +static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
> +{
> +}
> +#endif
> +
> +#endif /* LINUX_PCI_LIVEUPDATE_H */

[1] https://lore.kernel.org/all/20260603154402.468928-1-pasha.tatashin@soleen.com/

Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply

Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply 

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

