Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231D7CD8C9F
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fmn+PdTc6vMvIeP/V6J1RAe1SscwIO8ISTB8QBGG6KU=; b=xI9UlC6gM/nuvzX2E7ZLqyArt/
	9TSTsLN42HT/bXRMWKFT5b70Qd3/Nvn/gF53zQdvYzMvZY4y6l4+O2A8dqJ9sJ+yTukjWiIKf0R5q
	7bKioRjelNqV7adLMpgpPqx7n5BVnEkVXn4s2zxMJWDZF7xFNCh09B+T/JZwuea+lfeeb3jlPbHvn
	B0OEW7xaf2kIxN4o6yiSdsSc9PVkdv+0xTNQPgLzFXQFaI4eHdDSebkKG/ygF7o5iE1I+ibPh7r7a
	8GAW9VuGqEmeQu8H5mnnOyhXG1F01vJggyQdiTAi5Ae6PIXQKw+KysjT69+3z5S7F97tdWv0zSFi4
	Ld4aSp1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWXY6-00000003MTS-3ou0;
	Mon, 08 Jun 2026 10:49:42 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWXY4-00000003MT0-10g8
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 10:49:41 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2bf2911f93cso293775ad.1
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780915779; x=1781520579; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fmn+PdTc6vMvIeP/V6J1RAe1SscwIO8ISTB8QBGG6KU=;
        b=t4CUzyrqRmwRMQ6g5JQF2HapdmLXooYtmcPaKMsjpquBrqnTDDzzePtWJAen5s/oiZ
         A9EkHXtZ2+bzAVlxGgTr2GJIxkW5A0qhX/C6Necn/TFCGWBY0ZpbPVBVBayzGgWKCSxt
         SgOuex0eI5EDI5/NWYA/1lhx2CTTs3nMc8g4Cmjt8WsRwCo88EECNG61PL6U61/0lpVP
         AJXf6LXnoJ879zEGAXz+93dG1rn7e8ms/iPN87Sr6ylILpmBCcUIIIris7G8coht2tqo
         Ordjz99xxGWUu1Mv0F3XkApKcqiWrRfySOfZeOFj18jbBmhRpwmxu8t4OG13iz/kK5Q0
         k72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915779; x=1781520579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmn+PdTc6vMvIeP/V6J1RAe1SscwIO8ISTB8QBGG6KU=;
        b=qROU72m0r07q60wwaQ+2MiuGWWvJ6RS4o9+tNtHScv9+TanP4i1beeMDP1EVzfdNvZ
         5SAMB8GZJM0pRTi+qw5VAAOwA3LMPTwKi3mh1dmWlljaiCZmR9kFS1IvQdFS2Xnq9uzD
         as7VApJJLA76X9ljyxC9J4ZSqUVATSOaQKuUvDMjsoBioWV2FVHLKkwUlpZenFBbL6iL
         vuQDcPFTkWqasWT06ifVArHxQ/4Gr1r2Aa9mRBCaMBlbtKG2l5E+//1FbkWK1QNknGj3
         XA3ZRrIo5PtT5FrY2Ixpeoz9FJGJ9t4m4/iau4uBVq2AMYDa2NJTdiAXitvczY5bkhLP
         MZBg==
X-Gm-Message-State: AOJu0YzCMPKDzrzBIFzFTk5MXgoUoK20eUGvbMO6s3e7RLJPqtW0YBYW
	6rHSnKelRSjh5GoMGv63Af/GFTVYsBjDpru9jr8wLhrjd+Cyv9S7rc/TeXddeQqCow==
X-Gm-Gg: Acq92OH/5PjyMPX44s2z4/jzjojCBi3d6fEBBXXqBzN0fOoA4CRNr1qQkQXLTM/9mXq
	6CwerIVyFX+Tx969wSwynRgYKmWw80dBfFsDE7xrlhVU8QnVJnJmjdNbJzWu8hgJ45IRXJekmb5
	4h+tIwozbayxKe9TAP8540tcG1KSVw4lKmItAoB7+rgSrMr4cchrNzCgP7R+3IMrCv0lgRjLjh3
	cBRDUvTOmx4oVcmLzwP53k/q6QS/jFe5GNGzxGJcbj+q22w83UdpGFpM6o0vQZF9VR3xo5gm8J0
	S+rsIHx0Ivfc4AEwX++/YcLMclg/g6dcGFQoZ/AM9U59upwXFH5S1Dq7+IkH7JM+gBJdxAAyOcu
	p8hbBy/siC/AEPQparzF096N7Mhzls0ztJ2RHqREGf/lUz5OhFkwZHowhB1caLZXy66lV542ysu
	H01OQwGhSxcDoP3d+7ZEyPLFAOY45Bq8tBSyWUq3N3O/I1N+vDAgfWxLEN9mpPjGpClYqaTEY=
X-Received: by 2002:a17:903:1986:b0:2c1:ee6e:4e50 with SMTP id d9443c01a7336-2c1ee6e51d9mr4607285ad.33.1780915778977;
        Mon, 08 Jun 2026 03:49:38 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649c302sm173906215ad.73.2026.06.08.03.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:49:38 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:49:29 +0000
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
Message-ID: <aiaeOVomxQZhoM3K@google.com>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-9-dmatlack@google.com>
 <aiXWmR-ettxin4LC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiXWmR-ettxin4LC@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_034940_469043_B3C2169D 
X-CRM114-Status: GOOD (  22.22  )
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

On Sun, Jun 07, 2026 at 08:37:45PM +0000, Pranjal Shrivastava wrote:
> On Fri, May 22, 2026 at 08:24:06PM +0000, David Matlack wrote:
> > Inherit Access Control Services (ACS) flags on all incoming preserved
> > devices (endpoints and upstream bridges) during a Live Update.
> > 
> > Inheriting ACS flags avoids changing routing rules while memory
> > transactions are in flight from preserved devices. This is also strictly
> > necessary to ensure that IOMMU group assignments do not change across
> > a Live Update for preserved devices, as changing ACS configurations can
> > split or merge IOMMU groups.
> > 
> > Cache the inherited ACS controls established by the previous kernel in
> > struct pci_dev so that ACS controls do not change after a reset
> > (pci_restore_state() calls pci_enable_acs()).
> > 
> > To simplify ACS inheritance, reject preserving any devices that require
> > quirks to enable ACS as those quirks would also have to take Live Update
> > into account.
> > 
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  drivers/pci/liveupdate.c       | 68 ++++++++++++++++++++++++++++++++++
> >  drivers/pci/liveupdate.h       | 11 ++++++
> >  drivers/pci/pci.c              |  5 +++
> >  drivers/pci/pci.h              |  5 +++
> >  drivers/pci/quirks.c           |  7 ++++
> >  include/linux/pci_liveupdate.h |  6 +++
> >  6 files changed, 102 insertions(+)
> > 
> 
> [...]
> 
> >  
> > +void pci_liveupdate_init_acs(struct pci_dev *dev)
> > +{
> > +	guard(rwsem_read)(&pci_liveupdate.rwsem);
> > +
> > +	if (!dev->acs_cap || !dev->liveupdate.incoming)
> > +		return;
> > +
> > +	pci_read_config_word(dev, dev->acs_cap + PCI_ACS_CTRL, &dev->liveupdate.acs_ctrl);
> 
> I might be thinking out loud here, but as an attacker, this motivates me
> to somehow hack the EP FW to mis-report the PCI_ACS_CTRL register across
> a liveupdate to fool the incoming kernel. If the FW feeds a 0, it silently
> strips ACS protections.

Minor note here: I used "0" as an example value, I'm aware that'll
effectively disable ACS and kernel will enforce more security.

My point was that a FW exploit can meddle with the bitfields of the
ACS_CTRL to spoof and mis-report the ACS flags.

Additionally, we might give rise to use-cases that start depending on
this, for e.g. if someone wants to change ACS policies in the
new kernel, the FW may silently update these flags across a kexec.

> 
> Should we also serialize ACS state in ser somehow to ensure we aren't 
> fooled by something like this?
> 

Thanks,
Praan

