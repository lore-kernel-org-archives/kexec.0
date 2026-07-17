Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A264C44515
	for <kexec@archiver.kernel.org>; Fri, 17 Jul 2026 19:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jiuq4RrEPSqzc2CjSOsVE6XMKzyT/WebTRpubajhs2o=; b=ReM1hnrcc/ZElOxHuVmuYSaWu1
	jxR/V71T93mY2JMD6zbudssmUJ7iHU9EJxXF5r5yyydZPytZktUcuCt5DpC+jV1OziHq+m50sJGLT
	Cqbs+Fce2VIjVPxK8DFJ+hsffRS5Z5ewjGdGzgtxndTbgoWL8/y6MPWc6JiLDuECrlw8tFbjpP9tZ
	iORDcim1nU6e/haLrsF1++UnVLkmjb+CB8Q5wwuWAUVMDbS28lysI7K8HcizssLDp5sGYJNODdTEm
	CRlCcp0Ri9znOHA+VM6VvAHteuNdBVlPAs8NTCy8hzNZc0QGnQyRJsf8fQ7Yz4gzhb/p7a7EuBlEV
	Tta54kDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoEw-000000038F8-1IP9;
	Fri, 17 Jul 2026 19:28:54 +0000
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkoEt-000000038Ej-3Rac
	for kexec@lists.infradead.org;
	Fri, 17 Jul 2026 19:28:52 +0000
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-9305a2121a1so454711285a.2
        for <kexec@lists.infradead.org>; Fri, 17 Jul 2026 12:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784316530; x=1784921330; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jiuq4RrEPSqzc2CjSOsVE6XMKzyT/WebTRpubajhs2o=;
        b=SREnG54KHOvfcxfMaStrTD/tnu+2G6XTlO9xgjqsAjMHKLeHMVVMPW+sxfOSvzETJf
         L3VEpIwZyYPr9bQ+rFgTIp0YxQJ2Iqaomz2DaKDvulFbKpdwWnW9PR5/MH2u86b8NyLN
         ZPoXdt59BoGIsbsrfalbry4ZcuYJnT9j/EDpzNZ0w0VAe/VrVKY9PsXW8Tqm7uzKfOoQ
         cV9DKxAzNWsKPp/mNQoy5kiV3q3gp9mZ3PprVjCJxREYB1ZbvLCUdWWJqSQ635n9r3Qw
         KLbwAKxRmf+UK0nZcfIQHsawjVgAxubEcDUTNnRYcqkiCYG85DZHWk6vybgqgCupikcl
         9o/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784316530; x=1784921330;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jiuq4RrEPSqzc2CjSOsVE6XMKzyT/WebTRpubajhs2o=;
        b=j4/LdKeOx8EpC1Z+NB4eXyuWrBZ4ujKsxNFfFVi6l2INiB7bPS5/LuICNCO/YpLxMn
         jRYCaCs8O6AgitjviP382HAENUDcwTSXRKLtFXHxuf64LzLmnmzSc0t5SWfa9T4vsnOw
         jnalYm1Z8msZLX1dVFNlt9FuAk1Lejhz7bxpozXskjo115uKeV22Yul+U+XKHGS8W36+
         Q0q8nYWuiKRY1vJMDWNWXEhujyIYawAoJEuDtlkZOqvL71ufhQUqcF5nMTEu6xT1nfH6
         YjXix3x1GJaNtD7/tIYBuJzNFB+pkRaEAspSDUHtQS7EvDmC6t3I3xW8H4u6RpMj22mM
         cQYg==
X-Gm-Message-State: AOJu0YxGCM9iLPRSHqFeSvoQK1WZRjJnbAxN9l1iIF+E9XIgAOGmtllD
	1CQdEnpl0mEO/1O4oLtR2I7ambaBE4QlymxxZ55IiaMSNgXJpwC4vtX+oG+PSF/iK0Ye60BNXWB
	6qzLB
X-Gm-Gg: AfdE7cndj/IR18QOpMH87fPFtDuLswpxGVlEsgsDTU6BRYJL41S/QLdK5VaH1an5iAR
	PTVG5adjIYh5yOI+9Z/FzeHduN+ob9WtYysZKBzF+2gAeEGEoRmX5TtvydGbkuoNTZXOsGkabxT
	HKR22CRzOTCB+bPZH9B0tsmJZgalpjHRvcS0qzFrPN7y3C64f6PtllidZaeRuLK710t9wDXPjvD
	pHVA9zGsfelcQfpDpLVm4MtBRBcaWQYPP7IpW45kdNLaiEH3F9wxDc8gOFOzgN9QpO0jhNVsRMk
	UH4DUmqhYeIUm2Ch88ejVy+hE9AWDDpsHe3G/Iej9goDAltuv5yJJCLgqC3OZXPwudQT5YdK5Gv
	ksrfuQQ6ZdCAWxKqQbPnTJyvoYhj5Q12FDxWo21+BDi1lo5C1mnZXHydgarhbdKn8yOPZPzgS5C
	3cBObjF1wLfjjA2Gbd0Kmk3PM95VmnLT9gTA2dhgs=
X-Received: by 2002:a05:620a:4014:b0:930:b7f3:6c6a with SMTP id af79cd13be357-930b7f36ef3mr332805385a.66.1784316530109;
        Fri, 17 Jul 2026 12:28:50 -0700 (PDT)
Received: from [127.0.1.1] ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b5304a99sm231909285a.20.2026.07.17.12.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 12:28:49 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 01/12] PCI: liveupdate: Set up FLB handler for the
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
In-Reply-To: <20260710212616.1351130-2-dmatlack@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-2-dmatlack@google.com>
Date: Fri, 17 Jul 2026 19:28:44 +0000
Message-Id: <178431652443.189683.17611165218179620081.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2399;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=WaZbN29Yb7QirGLZ6z5SCIc8GS0Y/8CnVePacwfjgX4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBqWoJwXimoKQnR5L+cGvO5hfmCHnc7/6Y+V/lnr
 /tiYHeaRyWJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCalqCcAAKCRC7dyhM23N6
 3mp/D/9E7WlpCbODIzubvEP77KqJASqif+QIFU1RjVar0csfnfO/87C1moo0vCfIbC5Wp4vev5R
 Weg8hCZ2vLXDJz3lZXkA4+MsTgUcAAUyQQEjh6Qz8ByxS+sRPt3KLMkTEMLvpv/RizG0xuuOxQF
 1MhV3yaBpkv3AqJR2aNw5bVIXcWGqdcGm4dwrzJQd1+mhwmw2ysi1ar4aCa91WcVxiPR5258FjR
 L6P9gv/F6g1QxuiohNcx/CYF+1WBiVYD5ElowzhhrrkWAlpbEyNU2WuMtDxB4Mk0UNqfL5d/HjP
 yvC16iyfwmfYtymywIPSxd+6EO5awcN1kN8GBHAgvqYdjGl/++zbvsYOhHeK0VSWNJ4r8ab03Yz
 saoGD2xsKkdhxtABu4cG0lWbRyKgCMc2jyvt4vYFCisgxPbIEVHpOE3ZdL5O9w0f6p9wglb0bd8
 o8lDkvrrVGsHSDlOgeiZel+Pah/XGVOb89wPQ5PnIhdyocdX/blr6+4xbeExmuVdcik4GWX3RC/
 OVRyYBeSlTJ+dIQxC/gyYJ6o7wcY28JEIbr/6z7yE0M2mJ7ZmuGjBoeX8sYSTxiFjR6Z0tfA9x/
 0Br6X1vRHcwO1p/zpTdETR3bzl5yaXnL/fAKnCWt7OlQVnA6hyKsV7ro9T3/H8PswPl2AIfElFc
 2EkAQsTiIeXe94g==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260717_122851_910745_27201754 
X-CRM114-Status: GOOD (  17.17  )
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

On Fri, 10 Jul 2026 21:26:04 +0000, David Matlack <dmatlack@google.com> wrote:
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> new file mode 100644
> index 000000000000..899758883dd5
> --- /dev/null
> +++ b/drivers/pci/liveupdate.c
> @@ -0,0 +1,155 @@
> [ ... skip 50 lines ... ]
> +#include <linux/slab.h>
> +
> +/**
> + * struct pci_flb_outgoing - Outgoing PCI FLB object
> + * @ser: Pointer to the preserved struct pci_ser.
> + * @block_set: The KHO block set holding the outgoing devices.

AFAIK, these should be aligned after column:
@ser:       Pointer to ...
@block_set: The KHO block ...

> [ ... skip 26 lines ... ]
> +	ser->devices = 0;
> +
> +	outgoing->ser = ser;
> +	kho_block_set_init(&outgoing->block_set, sizeof(struct pci_dev_ser));
> +
> +	args->obj = outgoing;

Nit:
You could re-write the above:

args->obj = no_free_ptr(outgoing);

And declare outgoing like this:
struct pci_flb_outgoing *outgoing __free(kfree) = kzalloc_obj(*outgoing);

Also, remove kfree(outgoing) call.

>
> diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> new file mode 100644
> index 000000000000..de549016807a
> --- /dev/null
> +++ b/include/linux/kho/abi/pci.h
> @@ -0,0 +1,58 @@
> [ ... skip 30 lines ... ]
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @refcount: Reference count used by the PCI core to keep track of whether it
> + *            is done using a device's struct pci_dev_ser. The value of the
> + *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> + *            0 otherwise.

I believe descriptions must be aligned.

> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 refcount;
> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Physical address of the first KHO block containing pci_dev_ser.

I believe descriptions must be aligned.

Nit: Please order the included headers alphabetically.

Nit: Please order the included headers alphabetically.

-- 
Pasha Tatashin <pasha.tatashin@soleen.com>

