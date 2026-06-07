Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8203CD8C9F
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 20:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oir9rCALH4eHYpJVikC6mAKB9V6wqMG19r6g7e/slSE=; b=XuQTCpXPBBgR+omNNNfvhDEDrc
	XojltMmbOylBPNtyIOWB6SZJy/lqplo4Aqt4nYkj4rsUT1zSAVCOTHcv8P+7kZJRtZYyqEkh8Ok1v
	OT9x/jIPwNZBWtI0TV5r4va4/2Z2xGSEJp3Do52ctj6gswCH+i/LjJop1kSmUQHxSvU0W6R76hY+S
	k3lXxB2mSPD6wOsUrgTnyLeIjURc4nM2PjsaW4lbsH9Mlfjs5HdFceG6H7ADacfeFFuMJWhshbzzv
	lH69ulGluqlxDpd6pMfuOfSXEWM63+uKYmpcsY3P/T+A4Ya6ZbXRWE+hAePoautg1GQGOfPQu+EKK
	iqMWrUCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWKFr-00000002TiX-3w3C;
	Sun, 07 Jun 2026 20:37:59 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWKFp-00000002TiB-3Dv0
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 20:37:59 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1380104f31eso20065c88.0
        for <kexec@lists.infradead.org>; Sun, 07 Jun 2026 13:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780864677; x=1781469477; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oir9rCALH4eHYpJVikC6mAKB9V6wqMG19r6g7e/slSE=;
        b=lH+s9IPcEWYIvn15JTvDN5p0gU873vvGRVE7NLvEUUksvQ/MjclisoTQBKlv0VLtIZ
         IEztcMrenxt6nq2wBNkeiX9X89jJR8sJF7tr71vWsUIm1QFA8HNvFfHXeo8416LybMNi
         uqiNBK/w+GH3kj3pz9YQD3LCz7MWgMBxe953GpLRpZ8M/iU9dgMjzQPY+fq8hddVKfKd
         Qq+ldRvzBzkpNNweubLdJfQeM1h9cApkb3/yabJ1A72jkgtESZJkIZEZf8cxaO9UzXT4
         olpC2fiUoCASqalHPCmIcyxpEqWB9ckzfy76Tq3g8frAY3din9RpYYSRidxbXb/ysZXQ
         AuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780864677; x=1781469477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oir9rCALH4eHYpJVikC6mAKB9V6wqMG19r6g7e/slSE=;
        b=T9Q9XRyPyub2DJatfwRRDpVkN0q2oERg34WFXnWh+Q2Ogk2EhfKqkX+Rlk17zWdTdF
         yEWRfYhFrV8AM2VTq2rw9ZdRuCGGhhI7oHkvqPvVqJx1urCgQ+OsUKdnhcrAa+B0AGkP
         tDG7q9V+aiY6sF5KZQiIZ9hVqG1VkQpTSrL4OQcBmmzxszl2p2RqG3XBjbX98yilOtC7
         XAF/5+3dFxDHgXeal4QsyGhTqAiEgQJC0al+3KioqJsx6j7pgutwekMEtax2pmB1TLRh
         85W4UpBIRltO2m+rxFAwR2r6T1864kDUVuVVG8v93OApVM7HdWNB/mL24kTndGCT0TWn
         vrTg==
X-Gm-Message-State: AOJu0YyPItjGfBV4RI0007RXUAQY0YrZK++EPKUu9MDi9C0RYdqJ1cTC
	VORhQTokm9G6pcf7i8/5XB8Y6gMB0UYp+OiEHXv2VqmcK3jYlgLoa9i8HEKI2iUoQA==
X-Gm-Gg: Acq92OHNRF0kfzFJAH5IqLSkN/Cbs2dCPe277AV+qoivlWA/gIIxLHtBVZyeZYmPScG
	m1AyzhDV6W3s5AesqIM8O1xThvAH7ginJdZn6Z9GK2CXgoNpHtjeE2tU7A6fuSbYN1UfuyF51iP
	Vua926vSb93tUOXMkKJaa8bRBGWhwlmKx/LnqSVZIacBPPvAVelTxW6VEN8RSpupI4VZaJvNTSP
	lRzjKWD81CtCOIrISAtuPDNzkav6uesr59ieI5a7Fa3zZ+py9LeaotF5tpehsxwsEiE5MYhHVE4
	5LXeKn1jzq24cLWycEi+dZ3D2Ovlp/ZowDb/rsg7+gjPiRyHvags/s6t/3otww5iIUO384PRlVo
	x0NfoQHB83e53Gjc1KhL1P+KshVmMLTKSox0GfUzAHCrjLlvqB1QKv0enoX59S/HRXCsx66PCZ8
	3JQSezGQhoQHdGKdqP/HMA8gAUqgbKPStMV45njmh4fjUJUkUzDwr4llPNx++cj2Bx868wPGk=
X-Received: by 2002:a05:7022:504:b0:134:fc89:410b with SMTP id a92af1059eb24-13807c7c2e5mr279135c88.15.1780864674937;
        Sun, 07 Jun 2026 13:37:54 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1381495bb00sm4230734c88.3.2026.06.07.13.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:37:54 -0700 (PDT)
Date: Sun, 7 Jun 2026 20:37:45 +0000
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
Subject: Re: [PATCH v6 08/12] PCI: liveupdate: Inherit ACS flags in incoming
 preserved devices
Message-ID: <aiXWmR-ettxin4LC@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-9-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260607_133757_817381_D784EA6E 
X-CRM114-Status: GOOD (  25.11  )
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

On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> Inherit Access Control Services (ACS) flags on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
> 
> Inheriting ACS flags avoids changing routing rules while memory
> transactions are in flight from preserved devices. This is also strictly
> necessary to ensure that IOMMU group assignments do not change across
> a Live Update for preserved devices, as changing ACS configurations can
> split or merge IOMMU groups.
> 
> Cache the inherited ACS controls established by the previous kernel in
> struct pci_dev so that ACS controls do not change after a reset
> (pci_restore_state() calls pci_enable_acs()).
> 
> To simplify ACS inheritance, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
>  drivers/pci/liveupdate.h       | 11 ++++++
>  drivers/pci/pci.c              |  5 +++
>  drivers/pci/pci.h              |  5 +++
>  drivers/pci/quirks.c           |  7 ++++
>  include/linux/pci_liveupdate.h |  6 +++
>  6 files changed, 102 insertions(+)
> 

[...]

>  
> +void pci_liveupdate_init_acs(struct pci_dev *dev)
> +{
> +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> +
> +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> +		return;
> +
> +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);

I might be thinking out loud here, but as an attacker, this motivates me
to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
strips ACS protections.

Should we also serialize ACS state in ser somehow to ensure we aren't 
fooled by something like this?

> +}
> +
> +int pci_liveupdate_enable_acs(struct pci_dev *dev)
> +{
> +	u16 acs_ctrl = dev->liveupdate.acs_ctrl;
> +	u16 acs_cap = dev->acs_cap;
> +
> +	/*
> +	 * Use liveupdate.was_preserved instead of liveupdate.incoming since the
> +	 * device's ACS controls should not change even after the device is
> +	 * finished participating in the Live Update.
> +	 */
> +	if (!dev->liveupdate.was_preserved)
> +		return -EINVAL;
> +
> +	/*
> +	 * The previous kernel should not have preserved any devices that
> +	 * require device-specific quirks to enable ACS, but if such a device is
> +	 * detected, log a big warning and fall back to the normal enable ACS
> +	 * path.
> +	 */

Nit: It might be worth adding a note here that this can also happen if a
new device-specific ACS quirk is introduced in the incoming kernel for a
device that was preserved by the old kernel (which didn't have the quirk).
In such cases, the two kernels are essentially non-LUO-compatible..

> +	if (pci_need_dev_specific_enable_acs(dev)) {
> +		pci_warn(dev, "Device-specific quirk required to enable ACS!\n");
> +		WARN_ON_ONCE(true);
> +		return -EINVAL;
> +	}
> +
> +	if (acs_cap)
> +		pci_write_config_word(dev, acs_cap + PCI_ACS_CTRL, acs_ctrl);
> +
> +	return 0;
> +}
> +
>  /**
>   * pci_liveupdate_is_incoming() - Check if a device is incoming-preserved
>   * @dev: The PCI device to check

[...]

Thanks,
Praan

