Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEFCCCFA13
	for <kexec@archiver.kernel.org>; Thu, 30 Apr 2026 20:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jkf0FFUPX2DRAnC583F6L6pCpn6Z3D9oHd6oyEqtOrY=; b=FuqBzJZFWFZw+o88VJq7umI2q+
	ThIOYjt30HmpvzmmiQ4RauLffEEnajzB2WoBfUhMQaDOd9abd3b4gCSVilJt4zKuGI5LSSlEGOg52
	ipVqE7wvwC2ANrWLlNQO74KqvdQAolG2Is8g0I0+uvFR3rAGdbOAp6aTUubnPSyIjEAnUjd8suP4B
	VnH5q8+M0fG5Fj4sP8dSTGTvOS11TvNhBkv10l923a3ABlciyOh5l0gpBuR88TQfuNQBB+QuYgkJR
	Dk4f/Tbe4mRZhNJivPeSeOSH7+NSsFt39CqHPSnJS5rKmiMN/3xfhYer0xzQ/mMJdG5v2daWjxF6Y
	Oln0i7JQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYHi-00000005wDk-2Uhp;
	Thu, 30 Apr 2026 20:46:58 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIYHg-00000005wDN-11YV
	for kexec@lists.infradead.org;
	Thu, 30 Apr 2026 20:46:57 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-82f8b60e485so647104b3a.0
        for <kexec@lists.infradead.org>; Thu, 30 Apr 2026 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777582015; x=1778186815; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jkf0FFUPX2DRAnC583F6L6pCpn6Z3D9oHd6oyEqtOrY=;
        b=EUBVgkXgP5n3j1gXFhRbS8RRPB6abpe7QDLIp3YjeHT9vSpWOActmLfP+DaR3wOPHR
         RMoKS8BXVgGZkWeCYd473QEmzNPKomY03yaHZh09bsnw0022RlmNrca888oGHgDTFyMp
         WMuj5e4tj3BOewvRfocz/zoYAHBCs8rBxvVwuoHK3t9CUXordoSFwRS+kUsgbvOqrYkh
         gh2prygjendMOKxV1MGeRyHp0Vrs7R8xFvB9wLvEwIi0CfIZOoK8zqrGg3fbNl7rfry5
         7mKVlKdr0xyhEBP7eCF9wdsJqNrMjZNTJTLI/DLGNYARqr2XwaXpyOYJ+e2aFDtOsjdi
         p5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582015; x=1778186815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jkf0FFUPX2DRAnC583F6L6pCpn6Z3D9oHd6oyEqtOrY=;
        b=jAtsIdwXiF08EebbbmTOWmMKK8AFEl8bIm4JHHRrNwIx61TfOo30J/C3ty4L10boMp
         3jLYZgtlearc88ebyA+3SQ3Ch14PUMLZ9XENlbnpwoKT1nA2etuS1WUnD4uCoC3/FUNV
         Plp0IU0lxXo8SKGgAt/q9RjE5VimchQcxvl15fAX6ZmROI60XVsTJfw2K5yutVCnX3pZ
         /rSI7T5wDrYm2k6yei/LZ5X7Zgu5gygrxJxXoSry0Ak9rqKLGRFzYQIqlhg3DduAbtHj
         7BF95CmUyFqDrFcm1M2RLyuFarEiMqWcTjrn4HsjmvBJtmilKaPp3KzUnHIAE1L/LxcV
         Y0fQ==
X-Forwarded-Encrypted: i=1; AFNElJ/O+T+ofdsOWwTEv6KAgQakOpHWG8n0Fz7uMwsmLu0FME8QLPYwCf/rmFHr03Pb7AAzuGbEmA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9RmNS+f/e5YPGHsXhO+1iS1YIZaqH3atuuksbWJ23MXgL4qO+
	CA5wk8g8d6LfeB6gV9qdp4iFRGOyxsSYsLrZTXCuE8if4ulbz/VMMjEM8dzQh6eAUg==
X-Gm-Gg: AeBDiesvwHYKJk2WNrPqkA0HpRzqeGlHDr3bA4C7I41phLZhtQuipodA70N4NPfPS7g
	ms+XPyFTH7MyDbW5UCCDCpXGJdfItyqFTtdIYhhiHywJ3uXzPcWR0EBx9ZoEPmsN/oFBkWlF/A9
	c2zEk18+BtkYWUcRi2E10MBnAd6p6+Rbz5qqSP6Uwv60K7MM0zrPGldmu7kjpdwzEEpduCGc5sP
	XtQN7tLcEOnmQSWy44OMqN5BDob20TFp1A/0S8D6X/EGz49e1U73jBX6GJgt/TQZySOaJntwM52
	6cJ1mqf7HMIaEw3+0kGQHjV9AXZhPv5gL+ahW1VPMiJRsxnxFjC5w2Z0fyrRlflVfsU6W6OnrMk
	q7lCXmv4IOZrVdrz0zej/GNS/xf0de4S0aLTjL182iiJ0m83QQnUVd3nxZRfDhMpoL9v2zMuvNw
	cb9B7vaV3OAqXWSkzMYlOIzGYlDYav3tHUWgsVp3amn7/kWkwcd2/O+Ulyeg2zchsgwZ0/2mC3i
	5G4Vw==
X-Received: by 2002:a05:6a00:2384:b0:834:dfb5:6e73 with SMTP id d2e1a72fcca58-834fe061295mr5131011b3a.5.1777582014798;
        Thu, 30 Apr 2026 13:46:54 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515ad8eb6sm491387b3a.37.2026.04.30.13.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 13:46:54 -0700 (PDT)
Date: Thu, 30 Apr 2026 20:46:50 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
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
Subject: Re: [PATCH v4 08/11] PCI: liveupdate: Require preserved devices are
 in immutable singleton IOMMU groups
Message-ID: <afO_ulcut4GNgEpy@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-9-dmatlack@google.com>
 <CALzav=dGpHEnEjyp8qc50iZrGeKJ47vjLvwtvkLCyNzOMJhozw@mail.gmail.com>
 <20260423225253.GA3444440@nvidia.com>
 <CALzav=fraXLgGs-XMc-=whMPhMbS99twFskGtV5Eo=UQ9mU5Fg@mail.gmail.com>
 <aeqpJ7BeBtzoPIx4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aeqpJ7BeBtzoPIx4@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260430_134656_311286_1799238A 
X-CRM114-Status: GOOD (  34.00  )
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

On 2026-04-23 11:27 PM, Samiullah Khawaja wrote:
> On Thu, Apr 23, 2026 at 04:09:01PM -0700, David Matlack wrote:
> > On Thu, Apr 23, 2026 at 3:53 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > 
> > > On Thu, Apr 23, 2026 at 03:10:55PM -0700, David Matlack wrote:
> > > > On Thu, Apr 23, 2026 at 2:23 PM David Matlack <dmatlack@google.com> wrote:
> > > > >
> > > > > Restrict support for preserving PCI devices across Live Update to
> > > > > devices in immutable singleton IOMMU groups. A device's group is
> > > > > considered immutable if all bridges upstream from the device up to the
> > > > > root port have the required ACS features enabled.
> > > > >
> > > > > Since ACS flags are inherited across a Live Update for preserved devices
> > > > > and all the way up to the root port, the preserved device should be in a
> > > > > singleton IOMMU group after kexec in the new kernel.
> > > > >
> > > > > This change should still permit all the current use-cases for PCI device
> > > > > preservation across Live Update, since it is intended to be used in
> > > > > Cloud enviroments which should have the required ACS features enabled
> > > > > for virtualization purposes.
> > > > >
> > > > > If a device is part of a multi-device IOMMU group, preserving it will
> > > > > now fail with an error. This restriction may be lifted in the future if
> > > > > support for preserving multi-device groups is desired.
> > > > >
> > > > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > >
> > > > Jason, do you think requiring singleton iommu groups is still
> > > > necessary/useful now that this series preserves ACS flags on preserved
> > > > devices and upstream bridges?
> > > 
> > > I have forgotten why we introduced that? There are alot of funky
> > > things about iommu groups that might be important upon restoration..
> > 
> > You had originally suggested it in this thread:
> > 
> >  https://lore.kernel.org/kvm/20260301192236.GQ5933@nvidia.com/
> > 
> > > Like if you preserve one group member but not the other what do you ?
> > 
> > Yeah I imagine there could be some tricky cases there...
> > 
> > I wonder if PCI core is the right layer to enforce this. Maybe this
> > fits better into Sami's IOMMU core series since that is where all
> > those tricky cases will be (I imagine?).
> 
> +1
> 
> Also I think this should probably be checked by iommufd and invoked
> through vfio cdev. Basically when vfio cdev calls into iommufd to
> preserve IOMMU specific aspects of device (PASID table etc), iommufd can
> check this and return error.

Ok I will drop this patch from v5. The IOMMU core can check for it if it
makes life simpler, but I can't think of anything in the PCI core that
cares about this check.

