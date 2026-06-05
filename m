Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B392CD6E5D
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 05:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rbv0AZ2j24l1SmU6m1H5V7hzpCBteEa/IZu6sKIRnTI=; b=4Tn+GNmFhM+GmA/hxcrkoa3PZu
	3kw0VpFE87WEeamp3F4ApG/GFxDRWA3W1f2x85P9/v8ZKmWHxNXFdiKnUipfy6WpJ6Qtcomjx9qdf
	HpcyOh6YascuzOniSDJchoE3blpy1JhMigoEJ2phhmfo92WgZfKUiPTXEsxjvPd7yk4iIvP17F5tB
	PLvbv2VJaKhFHe/t5S2hpiQEoFFr/9Y4CXwkZvQBktiPfLCTHgAgXWsGZy2ewGPttHlpAAzk5ZZJ4
	DcO7FZcORbRXndSpI3vtv4z8bT1lGBlHxDwl69nAgp6cVFsBPb+nDvMFYH92O8P76vUKlpjGfWaQQ
	191FNhUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVNJo-000000007DC-0Si9;
	Fri, 05 Jun 2026 05:42:08 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVNJl-000000007Ci-39Fz
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 05:42:06 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-137ff9a7d5eso6094c88.1
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 22:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780638125; x=1781242925; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rbv0AZ2j24l1SmU6m1H5V7hzpCBteEa/IZu6sKIRnTI=;
        b=UoRqrBQdUJLqwFQnJTCu1OyDKyzfopydyT/KpyQjdw6OjAz2h+5ETnmZaCII+8Oj3c
         mfZw+1EqDVg1ugd4itpkQydwzUbEqjlQMlGs1/PJks3lEHzLYH6VI/0ehoqtYpwDIUDP
         JZKc/K2SuJXr25D6LN97o/27UAk5LlbkLm7/bphZjiSKKuXL4ExkgpFedEPiEaXz1WVR
         vWYKYPcrEXfo3X2PUBgoTg5N3FgaZGhZS2YeZTFaiPIPNgdeTzpYYXj+JFnFVLGo5qwI
         xXi/qQ7XCLpa8nJAnGDxr05wbZYDe50toxr/RkM8FEXw6B29f3+F4LxnfuRfwjz+kfDI
         aWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780638125; x=1781242925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rbv0AZ2j24l1SmU6m1H5V7hzpCBteEa/IZu6sKIRnTI=;
        b=d5Cl6BuBjutfpEn2gotoIiL0RJ3wXs6hltuSIq1NKkaUEKTo0NYuFGlziPX5BT8X27
         4f1XfZ4hXQb2HYOrvU829Yk5kdEw9RGFVF3GCZaBkZSa4jpAblAFAW538uwPU4QQCZbG
         le89zS/Dc8OUuwkgkHWagvhrrACtznNpmuDlHYQdx+8NKcA7xZr81MrOS8VMUQELTaqj
         W20bGLNKmPU4HYja9RGVrC/xnSpLQtH8EbaMi9iRitsD5m4iI/RGX2kVQyd0Tp+2+j5w
         WYf0t4/SRyY1jrt9UBfVB/NqwN3zDcsTyjTrpwc2h2+538iSUSH7CAdsnTOusC0Lu+ap
         Zmvw==
X-Gm-Message-State: AOJu0YyPi4uwQRA4OapMZYc4jNf9440G0m4MD+pyaVWY3YZgftzfUhbE
	l5QCIEBfB2S34gxQdLBRSvkkSk0FW3qbrtcNJrtlcmeY0howEQf/AuIMbOOISXvJzw==
X-Gm-Gg: Acq92OHBpN83UZP74xnEF+dCE+G8KC7kX9YxXJwc2bIZGVN3c+zMDRMVfOmSpb9SuF4
	ngTsNv1mc1cxUASxIUtgWy8+kyYOLLTr3HaW0z9y6Rc2hy8iqVfhM21SKELHyKiFnzpI9Tsov9+
	9e9M6q/1FxXlNyWgGHV/ZoriN7o9b5ohpDymtVrebVv1kMFy6R182qEZ2Zsv6CJU5huZDA+x+1C
	8pbVS0cMDVXGWSD29se+AKjWe3j+iDn7QZoo4ApjOavr52ra63iISTMNRcAwnNKpxh0ct4x/iD9
	uVM4FV6nQQb9sgusRCCcyDUVfQEgJ9Rp2tnfykz9N/Mteyj1uxfQfSyyY7IjjbuWfNiQOMqOevE
	61+nocjr4b1bcM8/Rt+Btei7VIyI/Fg53FshG2MhgCnGdO/MkM9rkf5lJDIs7FPo7JTuRd5nrAk
	SuNP40yhZf9tMwH1toeV8Jz5VkpsUso2J49V+2+8rjOXqDBsgCJsP5Zd/QFm3aNrDrrbg2Ys4=
X-Received: by 2002:a05:7022:107:b0:136:d02a:67ee with SMTP id a92af1059eb24-13807cf45e2mr63052c88.24.1780638123822;
        Thu, 04 Jun 2026 22:42:03 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074deaab1asm6539103eec.17.2026.06.04.22.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 22:42:03 -0700 (PDT)
Date: Fri, 5 Jun 2026 05:41:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aiJhoq_Yj6-1Hl5r@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-2-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_224205_797863_8DB3AD39 
X-CRM114-Status: GOOD (  24.62  )
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

On Fri, May 22, 2026 at 08:23:59PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
> 
> Preserving PCI devices across Live Update is built on top of the Live
> Update Orchestrator's (LUO) support for file preservation. Drivers are
> expected to expose a file to userspace to represent a single PCI device
> and support preservation of that file. This is intended primarily to
> support preservation of PCI devices bound to VFIO drivers.
> 
> This commit enables drivers to register their liveupdate_file_handler
> with the PCI core so that the PCI core can do its own tracking and
> enforcement of which devices are preserved.
> 
>   pci_liveupdate_register_flb(driver_file_handler);
>   pci_liveupdate_unregister_flb(driver_file_handler);
> 
> When the first file (with a handler registered with the PCI core) is
> preserved, the PCI core will be notified to allocate its tracking struct
> (pci_ser). When the last file is unpreserved (i.e. preservation
> cancelled) the PCI core will be notified to free struct pci_ser.
> 
> This struct is preserved across a Live Update using KHO and can be
> fetched by the PCI core during early boot (e.g. during device
> enumeration) so that it knows which devices were preserved.
> 
> Note: This commit only allocates struct pci_ser and preserves it across
> Live Update. A subsequent commit will add an API for drivers to tell the
> PCI core exactly which devices are being preserved.
> 
> Note: There is no reason to check for kho_is_enabled() since it can be
> assumed to return true. If KHO was not enabled then Live Update would
> not be enabled and these routines would never run.
> 

[...]

> +/**
> + * struct pci_dev_ser - Serialized state about a single PCI device.
> + *
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @padding: Padding to naturally align struct pci_dev_ser.
> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 padding;
> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @max_nr_devices: The length of the devices[] flexible array.
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Flexible array of pci_dev_ser structs for each device.
> + */
> +struct pci_ser {
> +	u32 max_nr_devices;
> +	u32 nr_devices;
> +	struct pci_dev_ser devices[];
> +} __packed;
> +
> +/* Ensure all elements of devices[] are naturally aligned. */
> +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);

Minor Nit: Shall we consider using specific bitwidth types here?
I'm wondering if down the line another u32 field is added to 
struct pci_dev_ser.. in that case on a 32-bit machine 12 % 4 == 0 but on
a 64-bit machine 12 % 8 != 0..

[...]

With the nit:

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

