Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6541FB44B2
	for <kexec@archiver.kernel.org>; Fri, 24 Apr 2026 12:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ZJ9GWp1jxsGc6Vz7xGAdGWrQ1InyP2sPpCeJqxt7fc=; b=xDnlZII4sbADjCLOiuagFkJfdR
	B188rccDxEyQDmhXsNZ9l8JoznKlCL43tj+nq0jxLXiV1Kp1/e6jZResouDmCytCpPW3gKkeYVFZb
	BIwnvvBUi2YSm0CW1owZ2+OcKGrRqsQzA+cNnjhPqsjKmN8aqSAPw0DWOiNujI5pMOZXFaHoQiajM
	BmSly2iihyE7kT2r47k4AB1GA1NF8g4nRI1EEXyl8U439kbs8QQJnxlCN6bfm9F63V7fMpRL6M4/l
	JT+P3hybDAMK4jmea/EgVFYY7ynA+5kzUFM6iJ5EueMis69vZSRFQbE8+rx9Z7rPO0ADLi0BWiBlm
	4EZF8bmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGFif-0000000DBan-0NLV;
	Fri, 24 Apr 2026 12:33:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGFiZ-0000000DBaM-3TrS
	for kexec@lists.infradead.org;
	Fri, 24 Apr 2026 12:33:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B099405EA;
	Fri, 24 Apr 2026 12:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B592C19425;
	Fri, 24 Apr 2026 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777033991;
	bh=m0zzjIAi6G3mbiTZhqEoSZO9I9LqVeMoE28CldoBOQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eLDco3bBc0PX4AYSurXPqBWJwbosfw7HJtTqQMEb1e7HgcJDAe2lM28587PkhaPlf
	 65Ybv2D8qAO2qCUzL4klNk66vCwfZaUL2iaIUwmPoboyVmiwjsSJWr3w5R7+2uw1ij
	 xGl/2h1ImWFD8mCquOSBL4AUB29FAxoOrHCDjoA+yL2OBuPkkPXwi+jeidmphGPEhV
	 KMoX5Tj2FsFwb01ItnjsOxDDTNrvMDxm00VuwVngUAlJ5KIAKdlSl4SYgSrlog1dyB
	 T0s0pJ+dPo4hV5tygEubPKF5IlbBSUmlRP4SNsGhqvjn+1jn/Eys+M7Qwq6Os0g1+d
	 3knpQBIl8aGWQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  linux-pci@vger.kernel.org,  Adithya Jayachandran
 <ajayachandra@nvidia.com>,  Alexander Graf <graf@amazon.com>,  Alex
 Williamson <alex@shazbot.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  Chris Li <chrisl@kernel.org>,  David Rientjes <rientjes@google.com>,
  Jacob Pan <jacob.pan@linux.microsoft.com>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Joerg Roedel <joro@8bytes.org>,  Jonathan Corbet
 <corbet@lwn.net>,  Josh Hilke <jrhilke@google.com>,  Leon Romanovsky
 <leonro@nvidia.com>,  Lukas Wunner <lukas@wunner.de>,  Mike Rapoport
 <rppt@kernel.org>,  Parav Pandit <parav@nvidia.com>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pranjal Shrivastava <praan@google.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Robin Murphy
 <robin.murphy@arm.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Samiullah
 Khawaja <skhawaja@google.com>,  Shuah Khan <skhan@linuxfoundation.org>,
  Will Deacon <will@kernel.org>,  William Tu <witu@nvidia.com>,  Yi Liu
 <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the
 PCI core
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com> (David Matlack's
	message of "Thu, 23 Apr 2026 21:23:05 +0000")
References: <20260423212316.3431746-1-dmatlack@google.com>
	<20260423212316.3431746-2-dmatlack@google.com>
Date: Fri, 24 Apr 2026 14:33:04 +0200
Message-ID: <2vxzeck45yin.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_053311_890377_0BD9D5B9 
X-CRM114-Status: GOOD (  13.93  )
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

Hi David,

On Thu, Apr 23 2026, David Matlack wrote:
[...]
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c9b7b6f9828e..94af31837375 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
> +PCI LIVE UPDATE
> +M:	Bjorn Helgaas <bhelgaas@google.com>
> +M:	David Matlack <dmatlack@google.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	drivers/pci/liveupdate.c
> +F:	include/linux/kho/abi/pci.h
> +

Can we please also add these files under the "LIVE UPDATE" entry. The
code here concerns both live update and PCI. We can figure out the
maintenance details as we go along, but I think the live update
maintainers should at least get all the patches for PCI live update.

Perhaps also add the kexec list here? We plan to use it to maintain the
LUO patches, and adding it will make sure we get the patches in case
someone updates the file list here but forgets to update it in the LIVE
UPDATE entry.

>  PCI MSI DRIVER FOR ALTERA MSI IP
>  L:	linux-pci@vger.kernel.org
>  S:	Orphan
[...]

-- 
Regards,
Pratyush Yadav

