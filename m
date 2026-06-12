Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A7CCD98CE
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 06:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhHuyn9lAJ2TBe6sen6L7PJ/bBv8t8Eeg7AMLr+RBEY=; b=sWNAHlCbDXQe42ZIHO/y9pOq0s
	DQXZF6c3Ppe6WbS1S4SLiMGbnzLYxkwWUhykyUgImybDiwQIvplHYaMD+Pz4ZE4RhK+MVZxJ6yCxK
	hI6XlwdreqPqja/BpCjSPZFa9aRvR2fNksjIsBFcGZL3EN+UCCVbUjokyTE157FGAsW8QN9/QKBTS
	c6AKowVNf9ws6rEDBgZgiN5PR3uF2FBEza7+x3/+rfNYJ6TtWrJhJUOJY3lfFEOIbvpsRNweTMJa7
	qRgTAzCfjESrT+jK94kC9S1z2l9QQSN6INUgC8r6yaLb53Q+wsXcAX7naBksINGdcQEBYrLtWTBk4
	o+8nnhWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXvnA-0000000AQiG-1t7N;
	Fri, 12 Jun 2026 06:55:00 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXvn8-0000000AQi6-1Nfq
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 06:54:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7876C42E06;
	Fri, 12 Jun 2026 06:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB881F000E9;
	Fri, 12 Jun 2026 06:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781247297;
	bh=rhHuyn9lAJ2TBe6sen6L7PJ/bBv8t8Eeg7AMLr+RBEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0zzp1VbOhwnHnR764SOHjzuUzLuCf0hRmFHEPQHn1tmhTJaP/SX0y/55bvPDoiUq
	 gHAzxMyVZaibctQ25ccizJUQKTyJATi/4P8mTr3aQ/Y/0adVBv/1q2JqZm6ekcZ9Ih
	 CGF+TxCzYGZuuURbgXg2XnPALpoKh4JJdoEBKPj9BmMmHB8rGL07qaCd9dfbsxGeNL
	 i6hZeQjlmqhXgDiZpvcUl+Wavsxqw/L6/g++NrRJpEcVX9rYWXvtLgMiuxkSMvw/DF
	 Bo3QwomiMYWWwXnnVD8pGpnHdoP752N3NYpX4UVdc35IRZBcPCtdTkCZhUnq8nvWSY
	 D04t4dmjsEA3Q==
Date: Fri, 12 Jun 2026 09:54:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 01/12] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <aiutNINqxhtlm2Dt@kernel.org>
References: <20260522202410.3104264-1-dmatlack@google.com>
 <20260522202410.3104264-2-dmatlack@google.com>
 <178124130274.908199.14827357870284807134.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178124130274.908199.14827357870284807134.b4-review@b4>
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

On Fri, Jun 12, 2026 at 05:15:02AM +0000, Pasha Tatashin wrote:
> On Fri, 22 May 2026 20:23:59 +0000, David Matlack <dmatlack@google.com> wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2fb1c75afd16..6c618830cf61 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20530,6 +20530,16 @@ L:	linux-pci@vger.kernel.org
> >  S:	Supported
> >  F:	Documentation/PCI/pci-error-recovery.rst
> >  
> > +PCI LIVE UPDATE
> > +M:	David Matlack <dmatlack@google.com>
> 
> Please add Pratyush, Mike, and myself so we are notified directly of 
> incoming patches, the same as with other areas where the liveupdate/ 
> tree is specified.

Or we can add PCI liveupdate files to LIVEUPDATE entry.

-- 
Sincerely yours,
Mike.

