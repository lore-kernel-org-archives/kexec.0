Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JWD1z-0001Hv-Fs
	for kexec@lists.infradead.org; Mon, 03 Mar 2008 15:56:47 +0000
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id EB7D23983B
	for <kexec@lists.infradead.org>; Mon,  3 Mar 2008 16:56:44 +0100 (CET)
Date: Mon, 3 Mar 2008 16:56:44 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] reduce alignment constraint on ia64 elf core header
Message-ID: <20080303155644.GB30167@suse.de>
References: <20080303143026.GA15484@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080303143026.GA15484@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

* Neil Horman <nhorman@tuxdriver.com> [2008-03-03 15:30]:
> Hey all-
> 	Patch to reduce the alignment constraints on ia64 elf core headers.
> >From what I can see there is no need to align the elf core header structure to
> the EFI_PAGE_SIZE (given that the EFI will never read this data, only the kernel
> will when booting a kdump kernel).  And since this is going into our reserved
> memory, it saves us 3K (4K vs 1K alignment).  Tested successfully by myself on
> several ia64 boxes.

This is wrong. Please read this thead:

https://lists.linux-foundation.org/pipermail/fastboot/2007-February/012882.html



        Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
