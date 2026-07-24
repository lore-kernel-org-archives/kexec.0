Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 215DEC531F9
	for <kexec@archiver.kernel.org>; Fri, 24 Jul 2026 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=ZKQYivscj2/YLitJTr85nVGb3DcdncClDyomNie32W0=; b=kZKXM0b/fg6GWS
	NZqWV1XmpMcEUX4YR6glYkOWfZbjxl2NF348zgwHOZZpZe/qGsHF+/Di4Wp1qF4u3PV4/+D4I6T3t
	PGl+PE5KZhaXdXAitdniqLVypqQACzZalfC+7rHXFuTrthTDUG3PFHlX5SJblgge0YYrbj/MdimSQ
	F7IL+a0MlXV9F6Cemq8L6vS+lUUaHkTuDAKyHWfiSbzErguNlFYtF71EgUNOiAEcfIXdOYwkQsbB8
	/BanuOs+3GBXWU18qqDzyKBNeS5E+fumc+Iym6X6KFIVfmpMNOgQXBm4jJDfiUtRmN4lM18Z+MokY
	V4IkDhJhrPFUji/heMLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnMZm-0000000HDvm-2iVR;
	Fri, 24 Jul 2026 20:32:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnMZi-0000000HDvf-0cXH
	for kexec@lists.infradead.org;
	Fri, 24 Jul 2026 20:32:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2CA6144011;
	Fri, 24 Jul 2026 20:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F0D1F000E9;
	Fri, 24 Jul 2026 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784925170;
	bh=ZKQYivscj2/YLitJTr85nVGb3DcdncClDyomNie32W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=lMBvjMyc2ADRRvgYO7Si5PcjiSQSr5it1WztjtKdT5vjbWClOEsrOrjW3ofWdtYfH
	 qY32i4tEpHCBD4Mk6wgQcyrclEAtjJ/PyKX8hekEPUjzN7bYF0Qp+wSJyfEzum6Y8s
	 ch9DH0xsWI6UY9vX2KspJTFw23p+foJLZIkGbpDv3Uq9ozpqJK5St52wuLIjzmuwm/
	 tmQQi51M4YEeH6IPo+uSf6l7FgqA18Z3vFp/BGwvx1MVr29TJfAep47O8oSuX1TpYj
	 Y9IJC6d6F9PLPw/2QMcqnW3IXzspoFpC5TEl2RxCXyb06cQvqhFLLRoRaMiWRf+fzn
	 H85M2Nv5O2FJg==
Date: Fri, 24 Jul 2026 15:32:49 -0500
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
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260724203249.GA1033821@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>
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

On Fri, Jul 10, 2026 at 09:26:05PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> ...

> +++ b/include/linux/pci_liveupdate.h

> +#include <linux/kho/abi/pci.h>
>  #include <linux/liveupdate.h>
>  #include <linux/types.h>
> +#include <linux/spinlock_types.h>

Alpha order unless there's a special rule about spinlock_types.h.

