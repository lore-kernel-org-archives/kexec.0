Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90288C982D0
	for <kexec@archiver.kernel.org>; Thu, 17 Sep 2026 21:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=k/6t/GikBHxugOsJ+dBD227K5m8z7pCCXMsSTk25Xz0=; b=IRV8TopzO7Ku/l
	4IqV+Ercs+XUvpHT6PLxrrC9IEOG7hanHZVkbSnMqyzRziJt/HQlIhJQ+aNjxvscTlzZjjosy4cf1
	CcTqsCt61jDb8GdpZDfzvIIBDRjL5nS2QKNH+5aRLBmB9IwtIHmgxDRGc5u/NkuhP0nW9ncMEwmjy
	A1bgScfpsDt9bgI+CFGk2wwCdiXbOhfOWfFS02UssjDU0Pp+O7t40YEFHPFnjGsE9A9qeWBMrzoB2
	3vUZB456m3dFh7O86X9gSOa94NZ3Oftk7vOgNRPwzRczjCCFr9KeHTq1xuWmJ6prnZUGP2odWHcmt
	TL1BE/gdLFGbUilzuQig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Jp6-0000000CZWz-0PIn;
	Thu, 17 Sep 2026 21:39:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Jp4-0000000CZWm-2LI5
	for kexec@lists.infradead.org;
	Thu, 17 Sep 2026 21:39:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A7C0E600AA;
	Thu, 17 Sep 2026 21:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380321F000FF;
	Thu, 17 Sep 2026 21:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789681153;
	bh=k/6t/GikBHxugOsJ+dBD227K5m8z7pCCXMsSTk25Xz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=NbP9X+YWncmvMuxndz4qUfEghuzl86DRrMSTCxqgT/YNwqK/HEnvZtwSFt79RSKAK
	 xoErzHMOyrD3sCRiN/7HDD4gzJ7HDZJ6Kimrxvr0BjM8PyIHBctpgeH9KHhKEt34JG
	 GlTH6h9ByjAKjWlV/DFUNBx4Wzg2gvuig+LpFnErUDT8KdHEYxgLlcZs9DVO3T4SAN
	 0uraRJMyAV+5iSTuKw1NVEtMYB+KsND+3M7ehE1re7WmFPKb7HRgVHBt2aTu1qI6pE
	 EQDusijHmss/+c8YE7OMIOtuNIDYMqiVSyDNNoRa5DRMO4pMBHuNaFpoYWUORcPohc
	 KcBh2J4m4WNSw==
Date: Thu, 17 Sep 2026 16:39:12 -0500
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
Subject: Re: [PATCH v8 12/12] Documentation: PCI: Add documentation for Live
 Update
Message-ID: <20260917213912.GA1049556@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-13-dmatlack@google.com>
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

On Tue, Jul 28, 2026 at 10:10:06PM +0000, David Matlack wrote:
> Add documentation files for the PCI subsystem's participation in Live
> Update.
> 
> These documentation files are generated from the kernel-doc comments
> in the PCI Live Update source code. They describe the File-Lifecycle
> Bound (FLB) API, the device tracking API, and the specific policies

Most uses fully hyphenate this: "File-Lifecycle-Bound" data, object,
etc.

> applied to preserved devices (such as bus number inheritance and bus
> mastering preservation).
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/PCI/index.rst           |  1 +
>  Documentation/PCI/liveupdate.rst      | 35 +++++++++++++++++++++++++++
>  Documentation/core-api/liveupdate.rst |  1 +
>  MAINTAINERS                           |  1 +
>  4 files changed, 38 insertions(+)
>  create mode 100644 Documentation/PCI/liveupdate.rst
> 
> diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
> index 5d720d2a415e..23fb737ac969 100644
> --- a/Documentation/PCI/index.rst
> +++ b/Documentation/PCI/index.rst
> @@ -20,3 +20,4 @@ PCI Bus Subsystem
>     controller/index
>     boot-interrupts
>     tph
> +   liveupdate
> diff --git a/Documentation/PCI/liveupdate.rst b/Documentation/PCI/liveupdate.rst
> new file mode 100644
> index 000000000000..96b1d7f5df3a
> --- /dev/null
> +++ b/Documentation/PCI/liveupdate.rst
> @@ -0,0 +1,35 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +===========================
> +PCI Support for Live Update
> +===========================
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :doc: PCI Live Update
> +
> +Driver API
> +==========
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :export:
> +
> +Internal API
> +============
> +
> +.. kernel-doc:: drivers/pci/liveupdate.c
> +   :internal:
> +
> +Live Update ABI
> +===============
> +
> +.. kernel-doc:: include/linux/kho/abi/pci.h
> +   :doc: PCI File-Lifecycle Bound (FLB) Live Update ABI

Ditto (and in include/linux/kho/abi/pci.h itself).

Trying to understand the FLB concept, I found
kernel/liveupdate/luo_flb.c.  I know that's already merged so this
isn't really the place to ask about it.  But FWIW here are some
questions from this naive reader:

   File-Lifecycle-Bound (FLB) objects provide a mechanism for managing
   global state that is shared across multiple live-updatable files.
   The lifecycle of this shared state is tied to the preservation of
   the files that depend on it.

I understand "global state", but I don't know whether "global" is
relevant here.

I don't know what "shared across live-updatable files" means.  Is the
sharing a fundamental aspect or just a typical use case reflecting the
level the data is for (e.g., bus vs device)?

I'm imagining a *kernel* being "live-updated", i.e., a kernel being
updated while things around it (devices, some user-space things) stay
alive, so I guess "live-updatable files" would be preserved across a
kexec?  I don't think of devices as being "live-updated" since they
themselves aren't being updated; in fact, the whole point is that they
*aren't* updated.

Do these FLB objects appear in a filesystem?  Or are they merely blobs
of data that are preserved across kexec?  I suppose there must be a
mechanism for the new kernel to identify and request one of the
several FLB objects saved by the pre-kexec kernel?

What does "lifecycle is tied to preservation of files" mean?  I
expected to learn about the beginning and end of the object lifetime.

   An FLB represents a global resource, such as the IOMMU core state,
   that is required by multiple file descriptors (e.g., all VFIO fds).

I have the impression that the important thing about FLB is the
lifetime of some data, e.g., something that lasts longer than the
kernel that produced it.

   The preservation of the FLB's state is triggered when the *first*
   file depending on it is preserved. The cleanup of this state
   (unpreserve or finish) is triggered when the *last* file depending
   on it is unpreserved or finished.

Maybe this means .unpreserve() (in pre-kexec kernel) or .finish() (in
new post-kexec kernel) is the end of an FLB object lifetime?

> +.. kernel-doc:: include/linux/kho/abi/pci.h
> +   :internal:
> +
> +See Also
> +========
> +
> + * :doc:`/core-api/liveupdate`
> + * :doc:`/core-api/kho/index`
> diff --git a/Documentation/core-api/liveupdate.rst b/Documentation/core-api/liveupdate.rst
> index b3c689e633c1..2bce2644eba2 100644
> --- a/Documentation/core-api/liveupdate.rst
> +++ b/Documentation/core-api/liveupdate.rst
> @@ -74,3 +74,4 @@ See Also
>  
>  - :doc:`Live Update uAPI </userspace-api/liveupdate>`
>  - :doc:`/core-api/kho/index`
> +- :doc:`PCI </PCI/liveupdate>`
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08a724b860dc..347c435ca404 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20833,6 +20833,7 @@ L:	kexec@lists.infradead.org
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
> +F:	Documentation/PCI/liveupdate.rst
>  F:	drivers/pci/liveupdate.c
>  F:	drivers/pci/liveupdate.h
>  F:	include/linux/kho/abi/pci.h
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 

