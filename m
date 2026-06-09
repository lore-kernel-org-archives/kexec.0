Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFF1CD8CB9
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01u/8EAi6NGn4gFgEAFXoW9+VQRDowjxcP1j39dvRbk=; b=sg5YNDoVPWBasIpe4rWmhk/HQW
	YcXpVzOqSthJ1g1frE6mt+/rhSRlJGE9QnvW9mk44mGaQZY2zf0mVkKDBMKWA7ZqEQaK6dx7V4GNK
	YKNZrCFXj+l5hYz8WNyURcLEdsRcSy8BHxRcUeD5mybEGQeOaMIrwtmhkrcoj6+S3uwNt8RxfOFDr
	iBKxb04qMDSCQdXddGzR5ilptbPSGXzmkTi8wz1YcGLCKtAzmXsgT1z5Rhk21rqWkSiiaNYa+jZdI
	G/t2+C3K1mWJZUINZxMN6cOqpdfyuzhw5zp9pKysYzyncyS3/TRrkiLW87hQiTJW+77PATqb463/F
	7DSvlPfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX07s-000000067Q2-3nqr;
	Tue, 09 Jun 2026 17:20:35 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX07l-000000067PU-320f
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 17:20:26 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2bf22c18ad3so553725ad.0
        for <kexec@lists.infradead.org>; Tue, 09 Jun 2026 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781025625; x=1781630425; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01u/8EAi6NGn4gFgEAFXoW9+VQRDowjxcP1j39dvRbk=;
        b=nhj5bOVK8w786vNOfbDYzSXCdfPS+HsE2PDafU1hKQFEknCHs8UiQKD9q5Q/5S0XTb
         B+nnz7fu8mKPQSnWsAH0Iti3pmW5XMF+hRnexSDYxjMf+lHBsByMWL3P/mk7nByi7GQz
         f0oD4QxmlVVm9IFWz5sRtbtH/1NcmauPgaA+eClSgccyb1bnkH7kvF64N0smkjb8mYLp
         NR+jCT7MTg57Frcz8OgDaNPg6tuBFkpclPrtLcHko50o8DJYUV6em/aY94Z035jXn94n
         nll+p0Lhv5MLwo4+esjdmQ7R8QedEDE4XW64CdqqI8UXZZdnw+GorPSjuzn5/fX1RScc
         13mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025625; x=1781630425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01u/8EAi6NGn4gFgEAFXoW9+VQRDowjxcP1j39dvRbk=;
        b=Lswd9KIeD1ulbkuEIBr03VAlKT7WOtBvqQPdKuvsP5KbAhDg6QennF3A6lKHvAb06w
         9FE+noFPHqlYtWxaogN1y0TAkMP0OnpPed4efopkYekKUajgbmquu7+DlbXh1I3W5qc9
         OU57cNMcBJysZf+OH0z5ubUBOtfaV5V0gKfWpnTnpCdD82cBsuaXZ5JvmIwBV3QBfO+W
         /rd/g+ZoBRWpKibaki2JOP4jCMBvMkOjhdJZHS26JIAqMDK+o0TZDX3DWOpgFE/ydyGC
         b1UFFYhL7liXSHHYcOMwFG1WI01CLh/hItZhpwFgzoDC+U1LVn82Vg0loc40ushvF/Bd
         S1CA==
X-Gm-Message-State: AOJu0Yw/DCKkUbwoE1VTpK0fHear7lJ/x5Fpi+gaJU0D9M/fvUJFp1hj
	tSDi50P0FZ9NE0RVg01lJubpr10P85XPTQ+++IPiXd5zQRojjTeeC1Lm8aTYg5wtjg==
X-Gm-Gg: Acq92OHqBf4fNSDOqxhpdA2UrObW1W5DzzR5ym8o/Yl3oceYVZijmKH2I8Ah2NWVpR2
	z0+jQnstGipYJkIgWderjkYZpD5O6Py7jWeEaMxSII8Hcdsf3JViO3xPZIPHDy4MdfW8pLQAg/Q
	Nor7XwXPKk7PRDNj57Kz5rBIIg1MF5Ymn93+AdEwvuOZhkODlkuJop8U2UIetG5L3B3zCorBT4g
	jQNcYYcv4XTr6Kl4s5R7o6azJfp0OHQMNw2lqHugHtWdyiUO+/e58C7NOcu4T2GsbmlCHUI463B
	86a7ulHTWNhC+FLdfiuQBnARUba5T+/YVVo0AKaJjQL53auyMN07WDOFCKzAy7nPlcasSUfyAt9
	4ISnpvJr723bqIOEe98ftNQuLI1+oFSLLZGyICy/fgmJ5VB/+nRMOJI+cem0a/K/SgjU7yz9Idt
	eqj30a0VQiix0Z180tFSqvKtla+e4Q4WU31oWh+b794SP6usDSumXaf/urpmzCOlHmb/cvv45wj
	7YHN2US4Q==
X-Received: by 2002:a17:902:e744:b0:2bd:907:2ce5 with SMTP id d9443c01a7336-2c1eafbcbdamr9084545ad.7.1781025624007;
        Tue, 09 Jun 2026 10:20:24 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf827e6sm25059778a91.1.2026.06.09.10.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:20:23 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:20:14 +0000
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
Message-ID: <aihLTgs1Y49OXQaV@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
 <aic6mdiZ0qUJpFca@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aic6mdiZ0qUJpFca@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_102025_773790_87F53A08 
X-CRM114-Status: GOOD (  28.70  )
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

On Mon, Jun 08, 2026 at 09:56:41PM +0000, David Matlack wrote:
> On 2026-06-07 08:37 PM, Pranjal Shrivastava wrote:
> > On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > > Inherit Access Control Services (ACS) flags on all incoming preserved
> > > devices (endpoints and upstream bridges) during a Live Update.
> > > 
> > > Inheriting ACS flags avoids changing routing rules while memory
> > > transactions are in flight from preserved devices. This is also strictly
> > > necessary to ensure that IOMMU group assignments do not change across
> > > a Live Update for preserved devices, as changing ACS configurations can
> > > split or merge IOMMU groups.
> > > 
> > > Cache the inherited ACS controls established by the previous kernel in
> > > struct pci_dev so that ACS controls do not change after a reset
> > > (pci_restore_state() calls pci_enable_acs()).
> > > 
> > > To simplify ACS inheritance, reject preserving any devices that require
> > > quirks to enable ACS as those quirks would also have to take Live Update
> > > into account.
> > > 
> > > Signed-off-by: David Matlack <dmatlack@google.com>
> > > ---
> > >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> > >  drivers/pci/liveupdate.h       | 11 ++++++
> > >  drivers/pci/pci.c              |  5 +++
> > >  drivers/pci/pci.h              |  5 +++
> > >  drivers/pci/quirks.c           |  7 ++++
> > >  include/linux/pci_liveupdate.h |  6 +++
> > >  6 files changed, 102 insertions(+)
> > > 
> > 
> > [...]
> > 
> > >  
> > > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > > +{
> > > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > > +
> > > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > > +		return;
> > > +
> > > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> > 
> > I might be thinking out loud here, but as an attacker, this motivates me
> > to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> > a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> > strips ACS protections.
> > 
> > Should we also serialize ACS state in ser somehow to ensure we aren't 
> > fooled by something like this?
> 
> What does "EP FW" mean?

I was referring to the Endpoint Firmware (basically any SW running on
a downstream device)

> 
> Does such an attacker even need Live Update to attack the system? It
> seems like such an attacker could route TLPs in whatever malicious way
> they want regardless of Live Update.
> 

I agree that compromised PCIe devices are a menace anyway. But I was
talking about the potential window opened up by Live Update here,
suppose we have Device A & B assigned to 2 different VMs (implying they
are in separate IOMMU groups because the switch set ACS_RR = 1).

Now, the attacker has an opportunity with Liveupdate, since the devices
are already assigned, if *somehow* it flips a bit like ACS_RR, the
incoming kernel might see both the devices in the same IOMMU group.
Who detects this case and what happens if this happens if the devices
are kept assigned to these VMs?

Thanks,
Praan

