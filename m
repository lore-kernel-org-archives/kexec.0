Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t5425.austin.hp.com ([15.216.225.55])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z2cOj-0006RA-BH
 for kexec@lists.infradead.org; Wed, 10 Jun 2015 09:34:14 +0000
Message-ID: <5578042D.9050407@hp.com>
Date: Wed, 10 Jun 2015 17:32:29 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1433773583.2952.52.camel@infradead.org> <20150608152957.GW20384@8bytes.org>
 <1433778624.2952.82.camel@infradead.org> <20150608161315.GX20384@8bytes.org>
 <1433854550.19447.15.camel@infradead.org> <20150610092150.GZ20384@8bytes.org>
In-Reply-To: <20150610092150.GZ20384@8bytes.org>
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
Cc: bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, David Woodhouse <dwmw2@infradead.org>, vgoyal@redhat.com

On 06/10/2015 05:21 PM, Joerg Roedel wrote:
> On Tue, Jun 09, 2015 at 01:55:50PM +0100, David Woodhouse wrote:
>> On Mon, 2015-06-08 at 18:13 +0200, Joerg Roedel wrote:
>>> So I think we need to read out that bit when we find translation enabled
>>> and if it is different from what we would set it to, we bail out of any
>>> copying, disable translation and proceed as in a normal boot.
>>
>> Given that this is only for kdump and not the general case of kexec,
>> that's probably tolerable. Of course we do still need to make it *not*
>> broken for the case where DMA_RTADDR_RTT is set, as it is at the
>> moment.
>
> Yes, I just sent a patch for this and will include it into my x86/vt-d
> branch if not objections come in.
>
>> And I suspect if we're doing that, it might be simple enough to make it
>> convert to/from the extended page tables. I don't think we want to
>> preserve PASID tables; only the "second level" (i.e. traditional)
>> translation. So we could happily pull the page table pointer out of
>> either kind of context entry, and install it into either kind. I think
>> there's a simple mapping of translation types too. I need to sort out
>> the translation types when adding the real PASID support (imminently!)
>> anyway.
>
> What happens when we take away the PASID tables from a device? Can it
> also go into some failure state?
> When doing this, we need at least setup the page request queue before we
> copy over anything and change the root-entry. Then we can handle any
> faults that are caused by this and tell the device to not try further.
>
>
> 	Joerg
>
Is PASID part of new specs? Is there any plan to upgrade the driver to 
support the latest vt-d specs?

Zhenhua


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
