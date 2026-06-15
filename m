Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB43CD98DE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1hI+H0ca4Dm+4Rh5RqmuKXgYDTibOfqOeSOBb1qqYIE=; b=Kdq8JCHzcfQS6Ik1Q7JiTglpyA
	qxSr1oPhcsxcu81NUJPjTT+GMcDIIHfykoLaBblO+dK0RbIv96+W2itgtcCw8DLdjplxDzXm4QN04
	C/hI9DPyZNeLDfM1LoA2jcmjmEJcjUWfnruIzklmu+mF7tj+JhDM14IsuXQr5aOJu0qqYD+rUpzz2
	B2WoW+0M/aXgVuVt2v0IRkmql/0ZNf0sKIT/WPb7OLfX7m1K/wZAnXz9uDH3Hxh7grl3/68z0QOZc
	cqWBiL3j5mDgscWuf9xkAYQ8jQY3T3pxXU+OwekCWsxb2sdE5MEWdFdbdsgfSgSjjsbjoMek1YnfC
	e3uR7SZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZFhB-0000000EtUb-0Gc7;
	Mon, 15 Jun 2026 22:22:17 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZFh8-0000000EtU6-2xUH
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 22:22:16 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-842288702fbso1827049b3a.1
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781562132; x=1782166932; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hI+H0ca4Dm+4Rh5RqmuKXgYDTibOfqOeSOBb1qqYIE=;
        b=LdAh7OCeO5CNlQ2vpOoL8x1NnxJbW4tx1lzVxoyaBrClX3lwLg3/Qxtoi4jPRU+iMe
         /znp058Du4uKhiIUVHevkqUxr9agqRTcxAt1/+kP+ji/kl3U7ia2wj5ufxZVg3f5JXbr
         5qGvglraXA1mS8awP4ewttOnpkMcA+qwbOd6eW0HMu9H8ZKlWuO220HtYDTis90dex6E
         1TcjYuRBS2GIAqCbyoLmF2mt0lxyyFntV6kyWBU2ghyPz9wZUGBE7tWfLiSZKFKO0C9W
         HhfEIfkSXGV4TmUe1Z9IBbPpC4x7gcZ4+mMK7Y6z6QzV+7RZI/JpwnD9/7iQe0zY15O+
         3SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781562132; x=1782166932;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hI+H0ca4Dm+4Rh5RqmuKXgYDTibOfqOeSOBb1qqYIE=;
        b=qys3W3/eEmjqxUhDrckZbeNkif+12TUcu4GVoQWaIi82PmZ7MJa94zuQIwtbLwB7vi
         IsyqpUupvRQWJkwy8z7araoCSoK0Fur17rikKe5LT88tSkorX0JKMUB1Io/xFCmHb3GS
         lsaBqy18l0yk97Pqz7x89vSuVIKOZHVnpukdSXHJ2aON1X9ODzTp9Sst73Pi0+IjdLwe
         9HLp4OTAfLYQUpMj6Qy1Y7Je60yEOmVroQ8Yy2psPBmDNAixSXMC2EbJwtuA1CntBez+
         0QxYoFgUpt8LUhJ3fsb0cf3/Y7dYFiu+DDF7m3eLCFTgMFKTdvu60W6ZzQ5KxFT758Bt
         0XJQ==
X-Gm-Message-State: AOJu0Yw0UiCGbsJMo1n0XCYeo1PxlS+t6lLeMxjq9tTH57N7hyo7K2Q3
	dK1YFT0R8sQR9PEIbKLTBsfNYzG3VZODGD6etHBpf8anUr0hKyv7hs9bHMBz2oV5TA==
X-Gm-Gg: Acq92OHpVLAAtc4h3mDerXhwzXWw0srqXF7V4cnZ2VjyKJCbK8VlshcgL0RAiH9bkVb
	Q6UfyeJsgzsJdZwiXyQhV7bBqm906GsZCd/dMllgGJBG7dWaQxyQQlHlXT4FO0vw5ZdG8slxz5F
	NBSf3AwzpzfMinY4pU4Rr3ixfjr7EpFj555UtjDrjY0i407A7dpVoIJTzUOqgmOGj+s4vmaw2iC
	hk5+6gX8+lJ4/jq7Tz0vDrOOEnCTzGQETqBg0aJ+5+3Lr5mdp2BwjlhlnW/+SoDJnHeut5hWLHV
	ypuWaLqopCPDBo9RJ/Q5Mm49IyA9FWzWLqjELCmgcJz0Hgh9TadHiS8lWzRRJvt+q1Sm8NmsELL
	4B1ZlhjZsleYiU7wsm93kOCdb/1WRZSi/9/j3/XBSdNCkOW8iltQV2tVf1YsV9QVIjsIgNYmVO1
	7mG/SFZtHWsYymCbtGfHbz3qaqHX+qjRVwBShBRNj1R9JIjHbRtb4Kw28S22ennQ==
X-Received: by 2002:a05:6a00:3e20:b0:82c:7767:5bb2 with SMTP id d2e1a72fcca58-8434ce428cemr17610087b3a.21.1781562131898;
        Mon, 15 Jun 2026 15:22:11 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434acca7ecsm11283741b3a.13.2026.06.15.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 15:22:11 -0700 (PDT)
Date: Mon, 15 Jun 2026 22:22:08 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <ajB7EA4tAKqj5XV0@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178124130274.908199.14827357870284807134.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_152214_758231_84E7CE9E 
X-CRM114-Status: GOOD (  27.85  )
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

On 2026-06-12 05:15 AM, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:

> > + * PCI device preservation across Live Update is built on top of the Live Update
> > + * Orchestrator's (LUO) support for file preservation across kexec. Drivers
> 
> I prefer to just use acronyms FLB, and LUO, but have links to the actual 
> documentations about them.
> 
> So, something like this:
> 
>   * :ref:`FLB <flb>` Data
>   * =====================
>   *
>   * PCI device preservation across Live Update is built on top of the
>   * :ref:`LUO <luo>` support for file preservation across kexec. Drivers
> 
> And also add _luo and _flb to Documentation/core-api/liveupdate.rst
> 
> .. _luo:
> 
>  ========================
>  Live Update Orchestrator
>  ========================
> 
> .. _flb:

Will do.

I guess I will need to add another patch to add the link references to
liveupdate.rst?

> 
>  LUO File Lifecycle Bound Global Data
>  ====================================
> 
> > [ ... skip 17 lines ... ]
> > + *
> > + *  * ``pci_liveupdate_register_flb(driver_file_handler)``
> > + *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> > + */
> > +
> > +#define pr_fmt(fmt) "PCI: liveupdate: " fmt
> 
> Nit, may be:

Did you have a suggestion here that got lost?

> 
> > +
> > +#include <linux/io.h>
> > +#include <linux/kexec_handover.h>
> > +#include <linux/kho/abi/pci.h>
> > +#include <linux/liveupdate.h>
> > +#include <linux/mutex.h>
> > +#include <linux/mm.h>
> 
> Please sort alphabetically.

Will do.

> 
> > [ ... skip 12 lines ... ]
> > +	 * future to increase the chances that there is enough room to preserve
> > +	 * devices that are not yet present on the system (e.g. VFs, hot-plugged
> > +	 * devices).
> > +	 */
> > +	for_each_pci_dev(dev)
> > +		max_nr_devices++;
> 
> I think, we want to use kho_block [1] (it is in liveupdate/next branch) 
> to allow number of supported devices to be dynamic.
> 
> To support this, we would redefine the ABI and tracking structures like 
> so:
> 
> /* include/linux/kho/abi/pci.h */
> struct pci_ser {
> 	u64 devices;      /* Phys address of the first block header of kho_block_set */
> 	u64 nr_devices;   /* Total count of active preserved devices */
> } __packed;
> 
> /* drivers/pci/liveupdate.c */
> struct pci_flb_outgoing {
> 	struct pci_ser *ser;            /* Points to the FDT/KHO-allocated ABI struct */
> 	struct kho_block_set block_set;  /* Controls the active blocks on the fly */
> };
> 
> In  __pci_liveupdate_preserve_device() , we would search for 
> and reuse any inactive  pci_dev_ser  slot first, and only call 
> kho_block_set_grow() to expand if no inactive slots are available.
> 
> In pci_liveupdate_unpreserve_device(), we would simply 
> mark the  pci_dev_ser as inactive.

Makes sense at a high level. I'll work on switching kho_block for v7 and
get back to you if I hit any issues.

> 
> >
> > diff --git a/include/linux/pci_liveupdate.h b/include/linux/pci_liveupdate.h
> > new file mode 100644
> > index 000000000000..8ec98beefcb4
> > --- /dev/null
> > +++ b/include/linux/pci_liveupdate.h
> > @@ -0,0 +1,30 @@
> > [ ... skip 24 lines ... ]
> > +static inline void pci_liveupdate_unregister_flb(struct liveupdate_file_handler *fh)
> > +{
> > +}
> > +#endif
> > +
> > +#endif /* LINUX_PCI_LIVEUPDATE_H */
> 
> [1] https://lore.kernel.org/all/20260603154402.468928-1-pasha.tatashin@soleen.com/
> 
> Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
> Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply
> 
> Preserving: In  __pci_liveupdate_preserve_device() , we would search for 
> Unpreserving: In  pci_liveupdate_unpreserve_device(), we would simply 
> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>

