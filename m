Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D15FCCFA13
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 21:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=; b=hREXakAmbeYRbQEdUc/ikjWhN/
	0cJTnZUBnK7JhxLFfQGUznyQ3vWHYzh2x6DlzZ8kr1P6bOS2GCV+aAWcvPFr+BMh2yj6yhPfpfXD3
	3q6BfSdL8794H60TwsqOOV15Q02pD7/7sNrHFvhTJprPYpOMX9Y5VYVkGqXml8Rg1HYoXpHRWiu+2
	tHEN+AWIH+ENV7ECQzOHybTY5CsZYazW5MTE0ShYaaVHHbZBHcDH0x3r1F+U16LLue2PW2LbMhnvA
	rz19HHiaah4lgDQJcQZsT08WCtDxaMfQXagtbRb02DFCFJpbd8T9t1dfQQc5quAVyqkqOOr07yiF6
	k4W38UDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYjz-00000005y4B-3WUS;
	Thu, 30 Apr 2026 21:16:11 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYjx-00000005y3O-1bcg
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 21:16:10 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2b0afa0210bso7471865ad.2
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 14:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583768; x=1778188568; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=;
        b=eV59FV6KeZ2X2ccx/e6rqQZKcp8wxoMbVKnhvOinjspmabj1oQgZi+zY9LrBeNOl6U
         DdFwpjGZqRB1L7oGdI8MNelZwyBwuvLgVXs71R9b2gFOGTh1YBwAk4couVXCk3+mMvqw
         YblDnDJ1cN+F622BMSSjvDmV9vJMKuaja8a+51OR5JEtS3l4WRlbRRhkc38F+7FuzEF1
         YpMjlhz6LgGS8gH95H0+jAB1nWDu3McCiH68s95VzY45DqmVbHHPBQzh/mOQoM4baAJD
         KGTqcwA1Xv3l72b4cZTpH7y08ddQQDvD7Z+XkFUpsqjIYiVj89pwyJFDZTZXHwXauUka
         CF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583768; x=1778188568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKjNRn2md89MeJaRqxCLA5wY9NhKNsbLMVT1tb1aOVs=;
        b=WpeYTnv32YDHvSV0MVsM9ylv2OFBzO5RPlE7qMVfTzhkx7U17Yr1YVaVvAdF8SsBkY
         mgZ34r0NUfCcXc3ja/MVqNCWUyRNw3ctBMThBxdYKpGZR5injw5t22yVVqkoLHrGh+7e
         B6+niLHEEnJLvTMwy5JURq74bfyLlNTHHmk98xMdSQKvei+8fE9CcMqExnuEeFj6zXRg
         O7U1HIrJR6QbESqgQELai0p1UkQXhigU8ibWv+D+30BmY1dTHvD7Y03lP9x2Th64E5Ex
         QV3oB+4YT7LFnH2R90UTK+aVPPiKtmbbICNfnHvMOydTR2WBY6oH+gkclJf2HRwVxfNq
         Lr1w==
X-Forwarded-Encrypted: i=1; AFNElJ+QdPdUkv8PenZio2p6k2MPRLTUvnJolMRUgq+qISRD76hzzquadgOwHfl+1lh44XTRst3J4Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Ywyl6haC7TlcfkOhMUKzQvZ0kmAbBDWmnm1NaSyqsCQcCILGE7N
	htEytYFoHz+Yy+97gDldxeFP2pZO4wMvqRHuOsOlZqN8yEWy8zriSPdT3sSp1HpD4rmWLB3T7vK
	DKeP/AE/d
X-Gm-Gg: AeBDieuumR4XVVpqsM9JgwcX3CC502997xEOQvByuNVDMZkpqjNR2ISn3frllbpkzgM
	QqPRn/EsfDEQlLaaGNfBSF0+zH4j58PKgDxAeyXurUGk+8haGuvt8Q6OaiVEKq5ia8ZU2ts/Apx
	hAbM3eVWlWaGx9yGJR2PtAKyaMjSiXsYMYd8vUPq8NF/Ke7FGTLY/iNa/gF3WNXJGiJZYKi9Q54
	eyDpzXnGHr2Ksoet0tV7LCyIPceNzka8MfK3Xx16x2M5hjSnRWbWq7gNVDlGaml15oI3w8hpE3h
	zuK7t34JLKYCzdF18FUJPijYJcRpgfratwDxf4k31GZhVZUy5bImlWHCZvIGjRokJKFyZvIBY47
	3Rfy5kumFhCdS/b6PdITfwIdVG+2sGuJPyN+TAy+sqzZPMRWKO37ejF/DhgOZtFClGETARdtDBL
	EwAnbjuzBnyMfkpeOfos2TuljkRZpDG1Gl+QHmWBWkS1znPr/qb/gy7cHQfvVGAnEB+VA8gAgby
	M/4Yg==
X-Received: by 2002:a17:903:22c8:b0:2b9:9086:da9c with SMTP id d9443c01a7336-2b9a234e736mr49645755ad.17.1777583767972;
        Thu, 30 Apr 2026 14:16:07 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae67196sm5018815ad.79.2026.04.30.14.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:16:07 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:16:03 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afPGkxjCdPCL8MLG@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
 <afDvVhkp8tQpsVlt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDvVhkp8tQpsVlt@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_141609_425534_E69608BF 
X-CRM114-Status: GOOD (  28.88  )
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

On 2026-04-28 05:35 PM, Samiullah Khawaja wrote:
> On Tue, Apr 28, 2026 at 05:24:53PM +0000, Samiullah Khawaja wrote:
> > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > Add APIs to allow drivers to notify the PCI core of which devices are
> > > being preserved across a Live Update for the next kernel, i.e.
> > > "outgoing" devices.
> > > 
> > > Drivers must notify the PCI core when devices are preserved so that the
> > > PCI core can update its FLB data (struct pci_ser) and track the list of
> > > outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> > > device must be preserved across Live Update. pci_liveupdate_unpreserve()
> > > reverses this (cancels the preservation of the device).
> > > 
> > > This tracking ensures the PCI core is fully aware of which devices may
> > > need special handling during shutdown and kexec, and so that it can be
> > > handed off to the next kernel.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > > drivers/pci/liveupdate.c    | 101 ++++++++++++++++++++++++++++++++++++
> > > include/linux/kho/abi/pci.h |   7 +--
> > > include/linux/pci.h         |  26 ++++++++++
> > > 3 files changed, 131 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > > index 5c0e92588c00..5b4c8d9e462c 100644
> > > --- a/include/linux/kho/abi/pci.h
> > > +++ b/include/linux/kho/abi/pci.h
> > > @@ -23,19 +23,20 @@
> > > * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> > > */
> > > 
> > > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
> > > 
> > > /**
> > > * struct pci_dev_ser - Serialized state about a single PCI device.
> > > *
> > > * @domain: The device's PCI domain number (segment).
> > > * @bdf: The device's PCI bus, device, and function number.
> > > - * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > + * @refcount: Reference count used by the PCI core to keep track of whether it
> > > + *            is done using a device's struct pci_dev_ser.
> 
> nit: I was wondering why is this named refcount and why it is needed. It
> seems you are using it to track the preservation dependency between
> parent devices and leaf. Maybe add a comment to clarify that.

Ack, I will clarify that more in the kerneldoc in v5, thanks.

