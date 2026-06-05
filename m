Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972D3CD6E5D
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 06:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+JACYJJsZuvAWWpivo6XAMCeidn10mj5aCjcUHoRua0=; b=lkhFK+nKSp8fX1vh39u8qeCfZc
	cRkfbtU2fhntxaLvTi6nZAzJ4g0xM94nxyXOXANnr/jI/am5aL5s0eI61UyY73uQ9TOOW586mgr+t
	LpDhyJA7jQLQmYtSx2zkPTBKPa5rkY4NSmlJgFAQpAQheW0JcQ8UMVEBU8/Tuc0nmuW6dUxxBAvbV
	AreN4Ga71Lp0o+CrThUPSHf5DDWitvZvk6p8sJiv9ykz7Z7idgDzso4H8cxTngQEjElKtVTjO3PUo
	259RRXc8Xls7GH1woMd21CYG1kFeeZUz19qOeyrTNLOtTfHLEBzH3UokLQk+JGrgMnRW80ATc9kYc
	/5MWkUOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVNmI-000000008jR-0AO2;
	Fri, 05 Jun 2026 06:11:34 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVNmE-000000008iy-312K
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 06:11:31 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-133362c30cfso9158c88.0
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 23:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780639890; x=1781244690; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JACYJJsZuvAWWpivo6XAMCeidn10mj5aCjcUHoRua0=;
        b=chK1/OhHvI5VExur8EEa4u57bYpdPujSiI/a9VrYZiiGQwesqqCOGHAyAtv0HI7U1H
         1hZe3oWc6ZD67Hzno0A8ze5DGO4Z7dRVN/ZEHEmcRYahAuIAXfojuPJrNnAf9u8WZkQ8
         TwE2NjNYeMvoM4Ly6m1HVMrcRisRUKYnzf0AbY3GgLKm9dcTBUMxcjFGCnWHLMAWKcHm
         l1w7qAlXEDd54W3Qk3/IaxSdrc/dU8O+6mgnOMvyV+x+BhIhBtzQzGDONxoPcsICxs33
         7Cs/AxpMCE0jArD5kgBOd5taFmDz211fpk+CdL21dIawI6AkvK8guezPOWA3mxk2lvDn
         A5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780639890; x=1781244690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JACYJJsZuvAWWpivo6XAMCeidn10mj5aCjcUHoRua0=;
        b=eexJvjoo610S+Sool06XB1VkziH2jhsFkkpfgAEVQxHOmVyYnmLR+e2vrQm45HnL5T
         roXgj/ftTyYE7+LZPtQjLF6IR8sfBmohStWtI2J0HtdBiAyd5d9MaaXPr2/xSlQ8ZQNy
         NUqQ7GfQ+7FI6A+KKgIrAior4+YqYfzqHl18X4AeVMy+WLDriu/tiNTQj5klCsyFdHSC
         SWWGeNQ9vevvmB6FPr+9W3ATaLwTvk3CYiSe4hV+3L/xg/aYcqCXBbT7x8A5/vJvh8fU
         JN5ESYIYs5lirYu7tY8JHr38Nk8b0jbzqz2VIcz84SOOqTjq8eailIk0Cy8JwkqrkWTN
         cWpA==
X-Gm-Message-State: AOJu0Yz7aZViJ7LexLwWmLbyTNStfJDuJNskitkQc9FpHup7q9nLRrRQ
	5RuZnzpeMe3SPgGYndkCe+pN3i9OlcZm++BWAqM8D6FzMbs2HSWa0p7aEO4DIGBFdw==
X-Gm-Gg: Acq92OEAIUai0/fUFviXFJnXdStPWjTWJsrafOSRVETDx8f95OsvOSAPLaos5klg8g+
	sbavI3Bscgguksb2NC8BSzRLLookMzN9CjgM7Wvd44Z3dCgzeuypOa/AMNnlIMvAZWU8Z9ezkv5
	Ufv2TNU1IC7OHHFH2bYfrR2PyLfcd+cZ/NBn9OFTVNUiHvfCXZO4rBAbRvQ04ZQUwLkTWbpYdW1
	lnzI3x7ppOiAlyy707+QytX1bn7Fc3Qo3sjwSQ2UAw5L1JxHtWJEOLlxyIqGGl5hzVr3nAEISb3
	kT23uqw2Hj7tB55d8lrEuHTK6dgNrM1wM6bhGDQ+wMNvj5EiuwJGPWHdnbXOW8Ayjy/53bP2ji/
	QocmN7lYKVNEzi0TJb0y18NWiI4LDKP8fkKIGGXUvy2nC4kfFjWfSGd6cnLkA+18zpEo0XSyhsX
	U6/pZYwq8cidrbsMl68qti+XsZahKnK7WsWviZkPzTrKarLcj+v9UtOw3Wm2q9homQoKUk23M=
X-Received: by 2002:a05:7022:6289:b0:134:a710:ca44 with SMTP id a92af1059eb24-13807ccb5f0mr74668c88.18.1780639888034;
        Thu, 04 Jun 2026 23:11:28 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074d9fde90sm10632107eec.0.2026.06.04.23.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:11:27 -0700 (PDT)
Date: Fri, 5 Jun 2026 06:11:18 +0000
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
Subject: Re: [PATCH v6 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <aiJohr2dD6Jf8m3r@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522202410.3104264-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_231130_782186_13684742 
X-CRM114-Status: GOOD (  18.36  )
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

On Fri, May 22, 2026 at 08:24:00PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so that it can be
> handed off to the next kernel.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>

[...]

>  
>  /**
>   * struct pci_dev_ser - Serialized state about a single PCI device.
>   *
>   * @domain: The device's PCI domain number (segment).
>   * @bdf: The device's PCI bus, device, and function number.
> - * @padding: Padding to naturally align struct pci_dev_ser.
> + * @refcount: Reference count used by the PCI core to keep track of whether it
> + *            is done using a device's struct pci_dev_ser. The value of the
> + *            refcount is equal to 1 when the struct pci_dev_ser is in use, and
> + *            0 otherwise.

Note to fellow reviewers: This may seem like a bool instead of refcount,
but this is changed in Patch 6. 

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan

