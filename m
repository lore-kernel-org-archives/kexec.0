Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XvKXT-0007pM-CD
 for kexec@lists.infradead.org; Mon, 01 Dec 2014 06:32:52 +0000
Message-ID: <547C0B4A.4060303@hp.com>
Date: Mon, 01 Dec 2014 14:31:38 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] iommu/vt-d: Fix crash dump failure caused by legacy
 DMA/IO
References: <1413878659-1383-1-git-send-email-zhen-hual@hp.com>
 <20141022100525.GD9060@dhcp-16-116.nay.redhat.com>
 <545ACF66.9050509@jp.fujitsu.com> <545AD061.4000102@hp.com>
 <545AD353.8060207@jp.fujitsu.com> <545AD8D3.90709@hp.com>
 <545B2885.8070009@jp.fujitsu.com> <545B2C07.1070701@hp.com>
 <5465A0E0.4020001@hp.com> <20141117133858.GA31920@8bytes.org>
In-Reply-To: <20141117133858.GA31920@8bytes.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>
Cc: alex.williamson@redhat.com, Takao Indoh <indou.takao@jp.fujitsu.com>, bhe@redhat.com, tom.vaden@hp.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Joerg,

After I implement these two steps, there comes a new fault:

[1.594890] dmar: DRHD: handling fault status reg 2
[1.594894] dmar: INTR-REMAP: Request device [[41:00.0] fault index 4d
[1.594894] INTR-REMAP:[fault reason 34] Present field in the IRTE entry
is clear

It is caused by similar reason, so I will fix it like fixing the DMAR
faults: Do NOT disable and re-enable the interrupt remapping, try to
use data from old kernel.


Thanks
Zhenhua

On 11/17/2014 09:38 PM, Joerg Roedel wrote:
> On Fri, Nov 14, 2014 at 02:27:44PM +0800, Li, ZhenHua wrote:
>> I am working following  your directions:
>>
>> 1.  If the VT-d driver finds the IOMMU enabled, it reuses its root entry
>> table, and do NOT disable-enable iommu. Other data will be copied.
>>
>> 2. When a device driver issues the first dma_map command for a
>> device, we assign a new and empty page-table, thus removing all
>> mappings from the old kernel for the device.
>>
>> Please let me know if I get something wrong.
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
