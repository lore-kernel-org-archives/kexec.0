Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1abJxP-0003eE-8s
 for kexec@lists.infradead.org; Thu, 03 Mar 2016 03:29:44 +0000
Subject: Re: [PATCH] iommu/vt-d: Assign old irt entries a common valid vector
 in kdump kernel
References: <1456912948-5052-1-git-send-email-xlpang@redhat.com>
 <20160302145823.GV22747@8bytes.org>
From: Xunlei Pang <xlpang@redhat.com>
Message-ID: <56D7AF8A.7080008@redhat.com>
Date: Thu, 3 Mar 2016 11:29:14 +0800
MIME-Version: 1.0
In-Reply-To: <20160302145823.GV22747@8bytes.org>
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
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>

On 03/02/2016 at 10:58 PM, Joerg Roedel wrote:
> On Wed, Mar 02, 2016 at 06:02:28PM +0800, Xunlei Pang wrote:
>> Currently, the kernel copies the old irt entries during iommu
>> initialization for kdump, so old vectors in the first kernel are
>> used but having no related kernel irq handlers set explicitly,
>> this can lead to some problems after lapics are enabled:
>>  - When some in-flight dma finished and triggered an interrupt,
>>    the kernel will throw a warning message in do_IRQ() like "No
>>    irq handler", because handle_irq() will return false with no
>>    irq_desc handlers. This may confuse users.
>>  - When the in-flight dma interrupt arrives, and if there happens
>>    to be an irq with the same vector allocated in kdump kernel,
>>    it will invoke the existing ISR registered in kdump kernel as
>>    if one valid interrupt in the kdump kernel happens. This might
>>    cause some wrong software logic, for example if the ISR always
>>    wakes up a process.
> Hmm, the current situation with misdirected irq messages in the kdump
> kernel is not different from a situation without any iommu at all,
> right?

Right, non-iommu in-flight DMA after crash also suffers from this.
I think both of them should be fixed if possible.

> And the goal of preserving the old mappings is to get as close as
> possible to the situation without iommu. This seems to carry the VT-d
> driver away from that.

Without iommu, it's not so easy to fix due to the MSI registers
located in different pci devices. But vt-d introduces a mechanism
to redirect both MSI/MSI-X and I/O APIC to a common IR table,
so we can handle that much easily with the help of the IR table.

On kdump side, present-day servers with vt-d enabled are
becoming increasingly common-place, if this does happen in
real world(usually it will), that would be hard to dig it out, so I
think it would be better if we can fix it.

Also CC kexec list

Regards,
Xunlei

>
>
> 	Joerg
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
