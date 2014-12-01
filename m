Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XvQAs-0006z2-H5
 for kexec@lists.infradead.org; Mon, 01 Dec 2014 12:33:55 +0000
Date: Mon, 1 Dec 2014 13:33:27 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
Message-ID: <20141201123327.GJ3762@8bytes.org>
References: <20141022100525.GD9060@dhcp-16-116.nay.redhat.com>
 <545ACF66.9050509@jp.fujitsu.com> <545AD061.4000102@hp.com>
 <545AD353.8060207@jp.fujitsu.com> <545AD8D3.90709@hp.com>
 <545B2885.8070009@jp.fujitsu.com> <545B2C07.1070701@hp.com>
 <5465A0E0.4020001@hp.com> <20141117133858.GA31920@8bytes.org>
 <547C0B4A.4060303@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <547C0B4A.4060303@hp.com>
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
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, Takao Indoh <indou.takao@jp.fujitsu.com>, bhe@redhat.com, tom.vaden@hp.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On Mon, Dec 01, 2014 at 02:31:38PM +0800, Li, ZhenHua wrote:
> After I implement these two steps, there comes a new fault:
> 
> [1.594890] dmar: DRHD: handling fault status reg 2
> [1.594894] dmar: INTR-REMAP: Request device [[41:00.0] fault index 4d
> [1.594894] INTR-REMAP:[fault reason 34] Present field in the IRTE entry
> is clear
> 
> It is caused by similar reason, so I will fix it like fixing the DMAR
> faults: Do NOT disable and re-enable the interrupt remapping, try to
> use data from old kernel.

Yes, that sounds right, thanks. Looking forward to your patches.


	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
