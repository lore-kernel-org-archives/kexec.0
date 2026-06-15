Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F749CD98CE
	for <kexec@archiver.kernel.org>; Mon, 15 Jun 2026 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tMpN87VW6G86K/AtehrHKHoQYLtgbv5+V4AdiXXmO0=; b=TJt2nGGeYPEUKLWgSUOyri3SYK
	whevR/H4JSaDfNHrfhzOTIe4r12PNbcmqZ5Hd9XuCqlJtN8HpRBdL4jx17SCrvkhPBwlIT8uE6yNF
	QeKLIm+R1r/cBWUesBAXJONRUpBlBhpjltboC+tIyJafUBQhWdIkzY2kScPHko11YVPlSZrx0RFiu
	6Tc6AdpNS7DCqmIJOSA5B1lTkGCBDt9cEARZ0c4u8ob2RZ+kG5e+pF5Rk2LpeLCM64h4MdnBDUqZU
	ycFAkZOC3tbhThhWyeS1DQOMdKXtCznkkmui6Mbjwqn+xDzKUgxdqqktBnwoeMeCnqNhnp7SaeoHm
	TtnzVuWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZDvj-0000000EoeL-49pJ;
	Mon, 15 Jun 2026 20:29:11 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZDvg-0000000Eody-1tLR
	for kexec@lists.infradead.org;
	Mon, 15 Jun 2026 20:29:10 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-8434840cea8so2291579b3a.3
        for <kexec@lists.infradead.org>; Mon, 15 Jun 2026 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781555347; x=1782160147; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6tMpN87VW6G86K/AtehrHKHoQYLtgbv5+V4AdiXXmO0=;
        b=o6uGkpYS0gO/kda162GDQBLib+uisx2SLm9DYJDG6ObExAKtJniFWibWox1XrqPib4
         odFFjipDsdUdT/YS2vrDWpsYXm0UjoHN3oIfD64fKlfEHMp7zHgEAHOAw3I84VB5tlca
         LXA5UUlX+2qEegoDhiA5kKu/yJuwsIWX7MG1ps41eNdMxX7Cziy+EY2dP+4LyXKCR77h
         r0PHgbBXs+8bC5A1QXCnwGgjhYHKsLwoMqBdxs4AD8HlapywNz0tO54gSWmI2P90fY5T
         sznBZpPjHLyTXMKA7JZsSQEIx/MjaJbX9pm+2LKtSG7AZejtV3pUvCk3il+OWG8DDZBP
         F4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555347; x=1782160147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6tMpN87VW6G86K/AtehrHKHoQYLtgbv5+V4AdiXXmO0=;
        b=jt316WwVFZnELgKHQ4f92ayZzlqPDBuEnBDWll11c6BxPyYk6BK3IERsYaaLyxkAhG
         9HnFsGZX8qxANvBWX5TD5RG68Jzr83CN3q/5YWOoP2oVzwVYMGm9dkrXq4nwAFVsh9Xq
         SqAQ2fla46CkOPURWn6n7GvoLua4mgwdJqNlqt90Aelmzcss9J1F7nw+byYCa+dWPHMS
         MOgdw00zBRJgrdrbQYA9cFsPn/ub3APgYgisgoGT3On+OK0vkPfZ3NMWNxU0vHpzpetq
         F1MmMSp3tmxejgNxL2U6XkC1ViZc+Ht64lb9J4VHPue3Xabg6i5JvCvdnu0EWaDgtYWr
         wy6w==
X-Gm-Message-State: AOJu0Yz3VvuoZl2y9jAedlYrURT5/bdP8GU/7/limrTSlfbpMFAjxGtu
	3GLliSpT2Gwy7e9Rb8wn7C1XtJcMAxUoQvRw05m70BgOFe+qZoZOtpfqRHbLd6Eakg==
X-Gm-Gg: Acq92OEt1xHwCcxeLJmaL+nu9YAckwcfVnN6TtgbKrsj/Fm+rH5o3L5I0+tcpZdOwwG
	/S/ydORResftZBxWx7W45KRho6Mc+2XcM9aO+RYJjR5CQxlOYSmEClMljeRuo/BmPBSuJrVx9VZ
	h41LvaZ8oHIMvKBBMX9M/sINd/ZR6VfIZlO7dv5S3orYAyZoaN+mVSF5EnNlJvIVugFrwCQrmn/
	tLipubScnkdEaboWH8PCcH3CMzayH3x2moCs+XrmXdEYy42h43gXTOdBGfLAbpggsXIzkhmQhMH
	tyAmiqWCwCSoableBywktn5ZejjGFMt2xjUSTNQKijHI94Seh45T3I0qIsXZM6Dbb5Q1Tnt4BMO
	zw3ybCO2s4tDC2WCCWQ2fTV4p/TsmvPEiipSr+BG7bJqC4zdd2bjhjlFHUbAWITEJW11NW3Sc7O
	PVWXCkxDsb5aefLAPQ46SMldi5C895j9bsRxCtwWOuSawIt/NEgcjcVjaSkp46CQ==
X-Received: by 2002:a05:6a00:2d01:b0:842:380a:1ee8 with SMTP id d2e1a72fcca58-8451530e10amr465722b3a.17.1781555346795;
        Mon, 15 Jun 2026 13:29:06 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm12817496b3a.38.2026.06.15.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 13:29:06 -0700 (PDT)
Date: Mon, 15 Jun 2026 20:29:03 +0000
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
Subject: Re: [PATCH v6 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <ajBgj_aSuzMZG47e@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-4-dmatlack@google.com>
 <178144432039.1257322.9644414453415904478.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178144432039.1257322.9644414453415904478.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260615_132908_500084_BEFF288D 
X-CRM114-Status: GOOD (  38.37  )
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

On 2026-06-14 01:38 PM, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:24:01 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 10c9b65aa242..e68ae5c172d4 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -330,7 +330,7 @@ config VGA_ARB_MAX_GPUS
> >  
> >  config PCI_LIVEUPDATE
> >  	bool "PCI Live Update Support"
> > -	depends on PCI && LIVEUPDATE
> > +	depends on PCI && LIVEUPDATE && 64BIT
> 
> Please move this to the first patch, fewer changes between patches, and 
> also KHO does not support anything but 64-bit mode.

I think it is preferred to introduce changes when they are needed. This
is the exact patch that requires 64BIT so it makes sense to add the
dependency within this patch no?

> 
> >
> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> > index 065d5af822f7..96c43b84532c 100644
> > --- a/drivers/pci/liveupdate.c
> > +++ b/drivers/pci/liveupdate.c
> > @@ -128,13 +157,49 @@ static void pci_flb_unpreserve(struct liveupdate_flb_op_args *args)
> > [ ... skip 31 lines ... ]
> > +
> > +err_xa_destroy:
> > +	xa_destroy(&incoming->xa);
> > +	kfree(incoming);
> > +err_restore_free:
> > +	kho_restore_free(ser);
> 
> This is the pattern we have been enforcing in other places in LUO. If 
> the first retrieval fails, return the same error thereafter.
> 
> > @@ -270,6 +335,91 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(pci_liveupdate_unpreserve);
> >  
> > +static struct pci_flb_incoming *pci_liveupdate_flb_get_incoming(void)
> > +{
> > +	struct pci_flb_incoming *incoming = NULL;
> > +	int ret;
> 
> Maybe make the error return static, and avoid another search through compatible 
> FLBs if it failed before?

Good idea, will do.

> 
> 1. Add "saved_err;"; if it is set, return it right away.
> 2. Change all errors to use goto save_err;, and at the end of the 
> function, assign ret to saved_err;
> 
> > [ ... skip 15 lines ... ]
> > +	 * This could mean that no PCI FLB data was passed by the previous
> > +	 * kernel, but it could also mean the previous kernel used a different
> > +	 * compatibility string (i.e. a different ABI).
> > +	 */
> > +	if (ret == -ENOENT) {
> > +		pr_info_once("No incoming FLB matched %s\n", pci_liveupdate_flb.compatible);
> 
> I would assume this is very normal, e.g., no devices were preserved but 
> memfd+hugetlb was preserved. Maybe use pr_debug_once().

The problem is described in the comment above. The PCI core cannot
distinguish between:

 1. There was not PCI FLB preserved. and
 2. There was PCI FLB preserved, but it was not compatible.

I agree we should not log anything for (1) but (2) definitely requires
at least some kind of logging so that's why I went with info-level here
and not debug.

> 
> > +		return NULL;
> > +	}
> > +
> > +	/*
> > +	 * There is incoming FLB data that matches pci_liveupdate_flb.compatible
> > +	 * but it cannot be retrieved.
> > +	 */
> > +	if (ret) {
> > +		WARN_ONCE(ret, "Failed to retrieve incoming FLB data\n");
> 
> No need to print backtrace, please just print a warning:
> pr_warn_once("Failed to retrieve incoming FLB data: %pe\n", ERR_PTR(ret));

SGTM

> 
> > [ ... skip 34 lines ... ]
> > +	 * through pci_liveupdate_finish(). This can happen if PCI core probes
> > +	 * the same device multiple times, e.g. due to hotplug.
> > +	 */
> > +	if (!dev_ser->refcount) {
> > +		pci_liveupdate_flb_put_incoming();
> > +		return;
> 
> Pleaes use 'goto put_incoming'

SGTM.

> 
> > +	}
> > +
> > +	pci_info(dev, "Device was preserved by previous kernel across Live Update\n");
> > +	dev->liveupdate.incoming = dev_ser;
> > +
> > +	/*
> > +	 * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
> > +	 * that dev->liveupdate.incoming does not get freed while it is in use.
> > +	 */
> 
> How would that work? If finish is not called FLB stays around until the 
> next reboot.

True... I think if the PCI core trusts drivers to call
pci_liveupdate_finish() then we don't need to hold onto the incoming
reference here.

> 
> -- 
> Pasha Tatashin <pasha.tatashin@soleen.com>

