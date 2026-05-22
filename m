Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2612CD5BB4
	for <kexec@archiver.kernel.org>; Fri, 22 May 2026 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=3pwqqJmK0UZHpTQbgMPdFytZpYtz+77BknUANKGAa1k=; b=iGLgi2ZI6AXqSw
	DXRGsMNGpuWEq6HftwnBMBLnX93aIbbwKnbvBfmU6gfAiC/p4wSNhVOsubocwZhrBKU3qITR4t7Is
	rMNmade5GTzZ8YQ2f8s22uL4fFuffD1L4G/+IFAnzRwkdktyajwzxRsskJAo2Ci09p0hDKTDXgSNG
	ULL+2hNZ98XsMjq6evW2KJGXc3KV2edrvKHiPpdoxHi5DhUusgLd9W02Tg0owz0aITs1maC3Mucie
	xLpgvFXSQAwScVmiU2sKNvjddVBemnHxqYKRoW3B29NqxAKq6c5HvPasdEwJH4dHA7WkwKmkpyP7a
	hjhPhvbXNb/J8jXYWi0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQUCB-0000000BdKv-26JK;
	Fri, 22 May 2026 18:02:03 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQUC9-0000000BdKQ-0s62
	for kexec@lists.infradead.org;
	Fri, 22 May 2026 18:02:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id D93A142DE8;
	Fri, 22 May 2026 18:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 91D7A1F000E9;
	Fri, 22 May 2026 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779472920;
	bh=3pwqqJmK0UZHpTQbgMPdFytZpYtz+77BknUANKGAa1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=TXo6wUbvp686W6gRZC9qm8zmd4BiXLPz+wTU2Jsq2lT4E9qOQM9JxVXC0FxlBZ5pg
	 iVw25MMaBsEi28vn1ODnZDud0jzMfw9NP4SR4+uPXPdaQLdtGDAKm+TIOPQSuX7fjx
	 yk/Z2M+PGaVjVwx1oP3yx6UayfL38rLK20qYZ+qf5KhiR4ygA7F/s3E+Fm1++h3vnl
	 Z07mNXiFezn3JCqacgY51FX6uymKGoCnYQPub6wfFXnuNVTZZJIVNpB7KgHDxNkwSC
	 unRmAtTZKUdsX9Fn3QNUMDYspPEoPO0/Xa2Weh/cf2OfnuHBRN2njlHAHVl6ZgSqzO
	 gfcXyx/Vw6YbQ==
Date: Fri, 22 May 2026 13:01:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v5 10/11] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <20260522180159.GA231364@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512184846.119396-11-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_110201_266999_981BD0EF 
X-CRM114-Status: GOOD (  10.71  )
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

On Tue, May 12, 2026 at 06:48:45PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.
> 
> Preserved devices must be allowed to perform memory transactions during
> a Live Update to minimize downtime and ensure continuous operation.
> Clearing the bus mastering bit would prevent these devices from issuing
> any memory requests while the new kernel boots.

s/minimize downtime and//

Ensuring continuous operation is the critical piece here.  Minimizing
downtime is always good but IMO it's not actually a reason for this
change.

I guess what this is probably saying is that the continuous operation
and Live Update are what minimizes downtime, and preserving bus
mastering is a piece of that.

> Because bridges upstream of preserved endpoint devices are also
> automatically preserved, this change also avoids clearing bus mastering
> on them. This is critical because clearing bus mastering on an upstream
> bridge prevents the bridge from forwarding memory requests upstream (i.e.
> it would prevent the endpoint device from accessing system RAM and doing
> peer-to-peer transactions with devices not downstream of the bridge).

