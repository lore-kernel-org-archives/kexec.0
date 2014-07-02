Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2KfA-0001IP-OJ
 for kexec@lists.infradead.org; Wed, 02 Jul 2014 13:33:29 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 5A2FE12B339
 for <kexec@lists.infradead.org>; Wed,  2 Jul 2014 15:33:01 +0200 (CEST)
Date: Wed, 2 Jul 2014 15:32:59 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/8] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
Message-ID: <20140702133258.GN26537@8bytes.org>
References: <1398386198-19304-1-git-send-email-bill.sumner@hp.com>
 <1398854973.12733.23.camel@i7.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398854973.12733.23.camel@i7.infradead.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: indou.takao@jp.fujitsu.com, bhe@redhat.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, "Hoemann, Jerry" <jerry.hoemann@hp.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, zhenhua@hp.com, Bill Sumner <bill.sumner@hp.com>

Hi David,

On Wed, Apr 30, 2014 at 11:49:33AM +0100, David Woodhouse wrote:
> There could be all kinds of existing mappings in the DMA page tables,
> and I'm not sure it's safe to preserve them. What prevents the crashdump
> kernel from trying to use any of the physical pages which are
> accessible, and which could thus be corrupted by stray DMA?
> 
> In fact, the old kernel could even have set up 1:1 passthrough mappings
> for some devices, which would then be able to DMA *anywhere*. Surely we
> need to prevent that?

Ideally we would prevent that, yes. But the problem is that a failed DMA
transaction might put the device into an unrecoverable state. Usually
any in-flight DMA transactions should only target buffers set up by the
previous kernel and not corrupt any data.

> After the last round of this patchset, we discussed a potential
> improvement where you point every virtual bus address at the *same*
> physical scratch page.

That is a solution to prevent the in-flight DMA failures. But what
happens when there is some in-flight DMA to a disk to write some inodes
or a new superblock. Then this scratch address-space may cause
filesystem corruption at worst.

So with this in mind I would prefer initially taking over the
page-tables from the old kernel before the device drivers re-initialize
the devices.


	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
