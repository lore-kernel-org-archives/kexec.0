Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5d5n-0005V3-Mw
	for kexec@lists.infradead.org; Thu, 27 Nov 2008 09:23:23 +0000
Date: Thu, 27 Nov 2008 10:23:18 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: makedumpfile-1.3.1: Support linux-2.6.27 and linux-2.6.28.
Message-ID: <20081127102319.5f7f90a5@hale.suse.de>
In-Reply-To: <492DF215.8050105@mxs.nes.nec.co.jp>
References: <492DF215.8050105@mxs.nes.nec.co.jp>
Mime-Version: 1.0
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>, kexec-ml <kexec@lists.infradead.org>

* Ken'ichi Ohmichi [2008-11-27 10:04]:
> 
> Changelog:
>  o New feature
>    - Support linux-2.6.26 sparsemem on i386.

BTW: Which option must be enabled for the kernel that this is
'sparsemem', i.e. that this support is needed?

  CONFIG_ARCH_SPARSEMEM_ENABLE=y
  CONFIG_SPARSEMEM_MANUAL
  CONFIG_SPARSEMEM_STATIC=y
  CONFIG_SPARSEMEM_VMEMMAP_ENABLE


    Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
