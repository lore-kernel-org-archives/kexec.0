Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XycxJ-00055U-Af
 for kexec@lists.infradead.org; Wed, 10 Dec 2014 08:49:09 +0000
Date: Wed, 10 Dec 2014 16:46:52 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
Message-ID: <20141210084652.GA25091@dhcp-16-105.nay.redhat.com>
References: <1413878659-1383-1-git-send-email-zhen-hual@hp.com>
 <20141022100525.GD9060@dhcp-16-116.nay.redhat.com>
 <545ACF66.9050509@jp.fujitsu.com> <545AD061.4000102@hp.com>
 <545AD353.8060207@jp.fujitsu.com> <545AD8D3.90709@hp.com>
 <545B2885.8070009@jp.fujitsu.com> <545B2C07.1070701@hp.com>
 <5465A0E0.4020001@hp.com> <20141117133858.GA31920@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20141117133858.GA31920@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: alex.williamson@redhat.com, Takao Indoh <indou.takao@jp.fujitsu.com>, tom.vaden@hp.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li, ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Hi Joerg, ZhenHua,

This issue happens on AMD iommu too, do you have any plans or
thoughts on that?

Thanks
Baoquan

On 11/17/14 at 02:38pm, Joerg Roedel wrote:
> On Fri, Nov 14, 2014 at 02:27:44PM +0800, Li, ZhenHua wrote:
> > I am working following  your directions:
> > 
> > 1.  If the VT-d driver finds the IOMMU enabled, it reuses its root entry
> > table, and do NOT disable-enable iommu. Other data will be copied.
> > 
> > 2. When a device driver issues the first dma_map command for a
> > device, we assign a new and empty page-table, thus removing all
> > mappings from the old kernel for the device.
> > 
> > Please let me know if I get something wrong.
> 
> Yes, this sounds right. Happily waiting for patches :)
> 
> 
> 	Joerg
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
