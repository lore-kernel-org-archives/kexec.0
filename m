Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382AFD45FA
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 22:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=RWJQBb7FI+E6UXTMK0GR6QK91Ndc7kSh6Tn7RraZLas=; b=AEZXm7G1iLR1Ew
	07/F7NfKZFrydUKkI2Jb/yqIXnei+txvVGTMsSnfnZuEy/h1nK8LOaGgGRXOtEsbG337YY18GO2Cc
	WYKN7+bPapZlPvPEVF/hY3nDFA9qJUwk7JgMF+RiiCDw5bd+mHh+urrwp6Eks9M5RgkgNdImo30CR
	A6v+QAEtd+aDSOo1X4qOamC6O0sohe0xWIKKM2eC3HZhwfQ3kQ1j0uEwc+GRfEsY+XfSWfwiu6BIu
	HNaW3tROjPVFMg78b05YDSZ+lpJneHcAAfdzW6PJijAMun4ita/VNOJhT/AKDFFY6Oa5rIOx9w9aw
	YjpFFmP2/DakTdXyjAfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNfb-000000051T4-3AIy;
	Wed, 25 Feb 2026 22:47:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvNfZ-000000051Su-363M
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 22:47:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 70D1B60053;
	Wed, 25 Feb 2026 22:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB83BC116D0;
	Wed, 25 Feb 2026 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772059668;
	bh=xWdLF6QkhbCc2tLcZVVjn/HGUxUqWIXlhi0KcVCVHrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KN3WnNG6ESqaiUtKkFDTZzH5NwOfPaEq3SyKjlnj2BVvSVQdzrUGi+rO3bBGnd9Ho
	 LpbZbnimfO8+EWuNKwp9Kq/5DffXALvIy8g8aExAHiolfdguYmdbVu0XP84pBoVoDG
	 2ANaWg1zO/7DOmKgmZKDkcv1ZqdjQpAE9igTSVdboUsROFqdafQ4Ta1ZmMLSBkwm5g
	 zQZOt3jfGQKtw6ZQ2AYAzx6QVBaEg7bthNexA/udyyfyBqcl3NkKXPxr3odyqMidAa
	 N9Jhv8lkZdyJYuDO5Mg8YthFxaBnptnFCNCrWT2+YaGtcpTMCUtsROxDVq68gXD+2b
	 uimsyOI0k4irQ==
Date: Wed, 25 Feb 2026 16:47:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <20260225224746.GA3714478@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-4-dmatlack@google.com>
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

On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:
> Inherit bus numbers from the previous kernel during a Live Update when
> one or more PCI devices are being preserved. This is necessary so that
> preserved devices can DMA through the IOMMU during a Live Update
> (changing bus numbers would break IOMMU translation).

I think changing bus numbers would break DMA regardless of whether an
IOMMU is involved.  Completions carrying the data for DMA reads are
routed back to the Requester ID of the read.

