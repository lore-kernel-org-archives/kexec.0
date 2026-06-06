Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EACCD8C90
	for <kexec@archiver.kernel.org>; Sat,  6 Jun 2026 11:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F1UvGUn3KRDrygvBE4DSDRKEnm/sK5Y67p5+Nbu/YEQ=; b=Ibv6X9m5/O1jRZhZYtKJzxqQpr
	TNmUZD/zOfwjRyQ1r3O+Lz2R4xjbTOAsbqZrPDfwAE4qJ297REsUbYvUVKet8UcGbxwGhenIftAMf
	qt9rYrzdie1y56DKEvHS4tgH/gggkTYTchuvWAw8mXifKIsRY6du1yGrmYbLzdoj0A5uS79dkoKIh
	NTil1gcO8yQ/1UcxHJU0CapWJzh1/UUBI5EqbrCmqVttY9jpS0Rceoq3TavQAMThR7hsymN5og020
	uf9+/LXvtW1uTvI0pOn14+CgJI7UZsuXa42zvg/n6B0FfQKQTzp0BfnO/UzCZZ75+vVMyuA72OCHx
	b/uWK+Vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVovK-00000001ZTv-3aJd;
	Sat, 06 Jun 2026 11:10:42 +0000
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVovI-00000001ZTa-29rZ
	for kexec@lists.infradead.org;
	Sat, 06 Jun 2026 11:10:41 +0000
Received: by mail-dl1-x1229.google.com with SMTP id a92af1059eb24-133362c30cfso19661c88.0
        for <kexec@lists.infradead.org>; Sat, 06 Jun 2026 04:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780744239; x=1781349039; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F1UvGUn3KRDrygvBE4DSDRKEnm/sK5Y67p5+Nbu/YEQ=;
        b=fHXJBzMI1EPXIucyiQ3D48yLtYNOWGOeu9yM8ObE300iBugKns5ISGjcnA2B0DxH0A
         ce8fAEX+n8MarF6zkgH4HorkDRF3n929qU8nHzon27ohlMGa4bMSfU1SIiarPay4DRsI
         DZx9fvdaDfXrKhUSMOVFX9cpGvGxroSX/gCI3CU7qXHdTT5yvcK0pBV7DE2V6S1XuKUj
         2+xA64/CtBwzeVREah7V60LVlAnVQpWZPSN4FezRZsN9Zxmd/I6rfGI7UIH95QVdBIxd
         LRfc2JC/bTXkT3FLbIS26xkzlv66CHXDmkjT0RkKnqNpV4IjmsLJwn4JQvPKjLrlKC3d
         tx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780744239; x=1781349039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1UvGUn3KRDrygvBE4DSDRKEnm/sK5Y67p5+Nbu/YEQ=;
        b=D+ZZahkTo86yb7kGujS4ego087adyyy/0Z40IH8R6CsmoWjSoTuWLagRDQ9qOsXzyX
         KtkDUpV3un58ZM8b0eqbFuvQ0QUyVJQUZFiJ33sv9lOlAxk3bqkFPpC9/omiqBKhdx63
         dU0h+/otaUyifYzVu4yWqYeFHn0P5uM4vD19636EEKYtB0+f8ojJqVKtlLL19tjV4pEw
         OYqXmNm6EHhsP7c9NoqkgjKbvv2QqXUF3KW4ulGP+9qy6DIHv9gG0rjUPnzpVoJoPXFj
         ENGK8Knu/o3fhpT1GQ0IflK1w6HwWqehX7LgFlyvd1tjt/e3Io6t18+TRm85pNwnji7O
         jx9Q==
X-Gm-Message-State: AOJu0YxABbZzhYWzMqp0MYxy7Xvqn2lI8qidS902PqWDmQXDzZ//Q9DJ
	1s+/pOeEecBKJ1QP743TkHKULHarTKg1OwE7Tp791QzgQ2W5kp5xCgfrG1NgTM1FDg==
X-Gm-Gg: Acq92OFkauA3pLAHMmKoyeeA/7jsKAOHXVhdIWPEKW9GmY5pFbbVYtcMxkcyqtpA9Uy
	faakc1irHxGMkcIMKJThKLOE0+i/fkchOk9hmL81k+HmBQHwfCg5Ni9WbOtbxaZMd6pwmXkW2y+
	IDfVuzVP7FKPDtdB0/9LdScLSubxW0F+J/Zkty3Lk6uBDyFmiGuO4F2KGM8ALyxQQY6Lea9P38L
	gVmmIx9rYsGVwnKgS6S1MeokpqjhHylgomqk4IhR1gynmfvOTX5aOPGcuIix23Ka28OE1QxFVVU
	LSuMRfv1BjJ4R8CpSSpTDFozVCqJ6Dz930UwHfIKcVdP9Sq03UBkdHls2ZRxdbBDb9O70hS2H+g
	Ka7kaRRjd7nVvLtqQGhmAA/WaQSqn397uma3NMkg/KwetnCv0VXFfrW2088db3B7M/Xu/UoOeuS
	Cu0QVQ+d6u4TWKqA2VYKNHNtCXMkNn6GfMbhp6FOhS3WVWV4eSKfQNA7xebaZx+U4L2rYMhF88+
	C8pUgkCBA==
X-Received: by 2002:a05:7022:38f:b0:133:12e0:aab7 with SMTP id a92af1059eb24-13807c6a877mr251422c88.11.1780744238685;
        Sat, 06 Jun 2026 04:10:38 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13803eb106esm4391089c88.5.2026.06.06.04.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:10:38 -0700 (PDT)
Date: Sat, 6 Jun 2026 11:10:29 +0000
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
Subject: Re: [PATCH v6 05/12] PCI: liveupdate: Keep bus numbers constant
 during Live Update
Message-ID: <aiQAJRINEKiwCmVm@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-6-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-6-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260606_041040_613055_E0F121AE 
X-CRM114-Status: GOOD (  28.64  )
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

On Fri, May 22, 2026 at 08:24:03PM +0000, David Matlack wrote:
> During a Live Update, preserved devices must be allowed to continue
> performing memory transactions so the kernel cannot change the fabric
> topology, including bus numbers, since that would require disabling
> and flushing any memory transactions first.
> 
> To keep bus numbers constant, always inherit the secondary and
> subordinate bus numbers assigned to bridges during scanning, instead of
> assigning new ones, if any PCI devices are being preserved. Note that
> the kernel inherits bus numbers even on bridges without any downstream
> endpoints that were preserved. This avoids accidentally assigning a
> bridge a new window that overlaps with a preserved device that is
> downstream of a different bridge.
> 
> If a bridge is scanned with a broken topology or has no bus numbers
> set during a Live Update, refuse to assign it new bus numbers and refuse
> to enumerate devices below it until the Live Update is finished. This is
> a safety measure to prevent topology conflicts.
> 
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since inheriting bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  6 +-
>  drivers/pci/Kconfig                           |  2 +-
>  drivers/pci/liveupdate.c                      | 83 ++++++++++++++++++-
>  drivers/pci/liveupdate.h                      | 14 ++++
>  drivers/pci/probe.c                           | 17 +++-
>  include/linux/pci_liveupdate.h                |  4 +
>  6 files changed, 119 insertions(+), 7 deletions(-)
> 

[...]

> +		incoming = pci_liveupdate_flb_get_incoming();
> +		if (!incoming) {
> +			dev->liveupdate.inherit_buses = false;
> +			goto out;
> +		}
> +
> +		/*
> +		 * It is safe to sample incoming->ser->nr_devices and then
> +		 * drop the rwsem since nr_devices will only decrease. Thus the
> +		 * only "race" is that the current scan will be overly
> +		 * conservative and force bus inheritance.
> +		 */
> +		dev->liveupdate.inherit_buses = incoming->ser->nr_devices;

Nit: inherit_buses is a bool, while compiler will handle it correctly,
maybe we could:

dev->liveupdate.inherit_buses = !!incoming->ser->nr_devices 

OR

dev->liveupdate.inherit_buses = (incoming->ser->nr_devices > 0)

for readability?

> +		pci_liveupdate_flb_put_incoming();
> +	}
> +
> +out:
> +	return dev->liveupdate.inherit_buses;
> +}
> +
 
[...]

>  		/*
> @@ -1497,8 +1501,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  		 * do in the second pass.
>  		 */
>  		if (!pass) {
> -			if (pcibios_assign_all_busses() || broken)
> -
> +			if (assign_new_buses || broken)
>  				/*
>  				 * Temporarily disable forwarding of the
>  				 * configuration cycles on all bridges in
> @@ -1512,6 +1515,11 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  			goto out;
>  		}
>  
> +		if (liveupdate) {
> +			pci_err(dev, "Cannot reconfigure bridge during Live Update, skipping\n");
> +			goto out;
> +		}

Quite helpful! Thanks :)

> +
>  		/* Clear errors */
>  		pci_write_config_word(dev, PCI_STATUS, 0xffff);
>  
> @@ -1572,6 +1580,7 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
>  
>  	pm_runtime_put(&dev->dev);
> +	pci_liveupdate_scan_bridge_end(dev, pass);
>  
>  	return max;
>  }

With the minor nit above,
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

