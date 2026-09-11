Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6ADC88E4D
	for <kexec@archiver.kernel.org>; Fri, 11 Sep 2026 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mwDk3fh+JvGyN78BSU6J48zvCwmsI7FUHYkydOLS1VI=; b=gxbYPihW8fdZgPIw3TEE3cdfWM
	eAjrlAKaZON/SOVIFHqfqG4qmw69VKLfn5P5jRemkV8Jd+ilE5FmvEEdk5dT1wy85UIaWKpXgHRze
	/DeWDLJNtot3D8s3kZ826NwhfXA72BkiMRIPU4jsZKFi6lUPfSxjz3Uv4UUUxsBNgMB2m5KPfw17o
	Mc3cbHm2Ixqp8sHWSBSN8wXW0D+oAkC7rQbxIuLOX4bsK0NvQWX3fb0wH0prAlbsy4s2gxVQr4lf1
	IcDIJc3SuWUmmhOr+yBNjqxeUxXTXeEBpOXCcT50bgoDFYwXXRlDnBv1HY6ENiOrVlwsg1smYi4j9
	7gflm0tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x54bw-0000000HHrH-3n2y;
	Fri, 11 Sep 2026 17:00:24 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x54bq-0000000HHoi-3rNa
	for kexec@lists.infradead.org;
	Fri, 11 Sep 2026 17:00:23 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-475920b9ca2so422744fac.1
        for <kexec@lists.infradead.org>; Fri, 11 Sep 2026 10:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789146018; x=1789750818; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mwDk3fh+JvGyN78BSU6J48zvCwmsI7FUHYkydOLS1VI=;
        b=RhtfDTD1uS07WYx7WAwBPrm/Ruc5Q/y8RSM+OUqxnpNc3jp2N2vsQMDrG3ZmlqjZ1p
         oqnPg1IJ7wcfpQzKS2HMjt3YGwJXqUwwtXB7ynLIVOPQyxELxucqzgHJVD0i+DGVh2Ny
         0ZvuuvmN/SuwafS3MQS3I52IFwf8w6hKvl6LFKXZAIR8xoT4zpGd11lpDfYD4tGsyPTA
         LrLL2H9CWz07dsoHThFaIbOlhtbdTbnAGhKOfEaux+LXCc9I0gy6ENHUbfYngyZ1aDVw
         dL0Zz2EYx94tam3fZqpvanjq+deRQDpJCP2dhyIf2OYgCXV11+uy+l5VMyCCSDbCzXYr
         320A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789146018; x=1789750818;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mwDk3fh+JvGyN78BSU6J48zvCwmsI7FUHYkydOLS1VI=;
        b=j/tggqCycCAG7MxFCvL+C1iqUM4moUvykMfiq3nshY/bV2Z9sReMEgcaE6KOZtM1Y4
         6EPOX0eFDlpUc62T1mwgy/Lcx961qddaXTysEVT5/ujTD/Ct6ci5qtzaEJBafhvmi4gq
         6PR9usf7+t4rRwxt+FY8XS4B/RIYJRqlImrf9dAEIJ0DrOpXhrnLf4g7Wad9w/adkNZ4
         mXPhqNbPRlDhocLHGaVphuqnwyhoSIHpciHaCvW5WPeFs7/XIHXm1MUpjf2L9QamXS1e
         RooEiDaxAzW7wsCc0nbvH3P5rEUuCnEM6igFSol5qI2TtpqtzM2Ttl/SlewHbrN3L8I3
         7Qvg==
X-Gm-Message-State: AFuF++ko18YuvdyXoDnlGDdyNSxgbd1z5TR0ortXPm8cKAs/+uBRGXnv
	57QLH9km/6NqlJuROLJMaIlbuzU+RjP/IM7Io7yrpjcapvRl5Szq08TpVtsf3HHFew==
X-Gm-Gg: AYBFou0KcmOsR8hzyp9eDMfpe6ld1gsAOivLf0u2/IXawOpEy9Stva0FDTUzaSUIP67
	n8P8K9Fa1oAQbef4tP8ieGXcKlWUQscKDAFjvV3qNIJnzHCYYptZCxeJ1jjUWzMHNpJ4BRHkT3q
	h+kfZ8xTERJcXeaEx5ykrvR1knoq9pajNHstHjn5W/CtNpdghkY7qr1sPSjbTLNNyutqguXGgal
	0oziMLsFgLeJcmaXFGoZ1ugcq/mFV/RKL10RhhR2dcdFmqmRulxOzTsBcxdKVOyiSo/c/7qLEc9
	+UkNjg4WhmlGmwEs/2J49wH5L6HKkU2Idgi06OCwzKQ74Yd/iMJU7WTq/QzGzHNup7z8JlEDCHs
	4RN+2fXgBSgDjq+nNW2Y3X+3VpbffSbJGOPGppQNIROg4hZx0/G3H+dKm+HYOv2CuekDexru+jQ
	vXEXicExP7jKYpGcECmKfWgU2rQhfTrSfG5ce/+Er9s42N/b6E4Ybo4Uts8SiJOzYHQKwN7Hcd9
	oqUZJeBQyDRnRpC2srUCrzq+PrR6OsIk7fAywpV
X-Received: by 2002:a05:6870:7183:b0:475:a112:1275 with SMTP id 586e51a60fabf-47debded110mr3337322fac.34.1789146016740;
        Fri, 11 Sep 2026 10:00:16 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8bd0284sm2467114fac.9.2026.09.11.10.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:00:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 17:00:10 +0000
From: David Matlack <dmatlack@google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <aqQzmvgILmU8F4TR@google.com>
References: <20260728221007.2098560-7-dmatlack@google.com>
 <20260910235126.GA367952@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910235126.GA367952@bhelgaas>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260911_100020_180549_D0313838 
X-CRM114-Status: GOOD (  20.16  )
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

On 2026-09-10 06:51 PM, Bjorn Helgaas wrote:
> On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> > When a PCI device is preserved across a Live Update, all of its upstream
> > bridges up to the root port must also be preserved. This enables the PCI
> > core and any drivers bound to the bridges to manage bridges correctly
> > across a Live Update.
> > 
> > Notably, this will be used in subsequent commits to ensure that
> > preserved devices can continue performing memory transactions without a
> > disruption or change in routing.
> > 
> > To preserve bridges, the PCI core tracks the number of downstream
> > devices preserved under each bridge using a reference count in struct
> > pci_dev_ser. This allows a bridge to remain preserved until all its
> > downstream preserved devices are unpreserved or finish their
> > participation in the Live Update.
> 
> This seems to hint that we're going to allow bridge reconfiguration in
> some cases, e.g., for hot-adds.  The simplest case is "leave config of
> all bridges the same", and I thought that was what the previous patch
> commit log said.
> 
> What's the benefit added by this patch?

It is used in the following patches:

 PCI: liveupdate: Adopt ACS controls in incoming preserved devices
 PCI: liveupdate: Adopt ARI Forwarding Enable on preserved bridges
 PCI: liveupdate: Do not disable bus mastering on preserved devices during kexec

to preserve certain configuration on bridges that have downstream
endpoints that are being preserved. To support P2PDMA we will also have
to preserve bridge memory windows (future series).

If we are ok with applying those policies to all bridges on the system
whenever one or more endpoints anywhere on the system are being
preserved, then I agree we don't need this patch. But I thought it would
be cleaner to track things per-device.

