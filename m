Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cCPlc-0002tq-K1
 for kexec@lists.infradead.org; Thu, 01 Dec 2016 11:43:10 +0000
Subject: Re: [PATCH] iommu/vt-d: Flush old iotlb for kdump when the device
 gets context mapped
References: <582C232F.6080205@redhat.com>
 <CAL-B5D1kkWE4e6P1xY1Cgkf-7+nBXH=C7g21=phEzmM4FPZRRQ@mail.gmail.com>
 <582D1A40.409@redhat.com> <20161129143547.GG2078@8bytes.org>
 <583E8A9B.7070906@redhat.com> <20161130090327.GA4192@x1>
 <20161130095334.GB4192@x1> <20161130102334.GC4192@x1>
 <20161130142642.GJ2078@8bytes.org> <583F87D1.6030402@redhat.com>
 <20161201103307.GL2078@8bytes.org>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <58400D00.6070708@redhat.com>
Date: Thu, 1 Dec 2016 19:44:00 +0800
MIME-Version: 1.0
In-Reply-To: <20161201103307.GL2078@8bytes.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Joerg Roedel <joro@8bytes.org>, xlpang@redhat.com
Cc: Don Brace <don.brace@microsemi.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Myron Stowe <myron.stowe@gmail.com>, Myron Stowe <myron.stowe@redhat.com>, David Woodhouse <dwmw2@infradead.org>

On 12/01/2016 at 06:33 PM, Joerg Roedel wrote:
> On Thu, Dec 01, 2016 at 10:15:45AM +0800, Xunlei Pang wrote:
>> index 3965e73..624eac9 100644
>> --- a/drivers/iommu/intel-iommu.c
>> +++ b/drivers/iommu/intel-iommu.c
>> @@ -2024,6 +2024,25 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>>         if (context_present(context))
>>                 goto out_unlock;
>>  
>> +       /*
>> +        * For kdump cases, old valid entries may be cached due to the
>> +        * in-flight DMA and copied pgtable, but there is no unmapping
>> +        * behaviour for them, thus we need an explicit cache flush for
>> +        * the newly-mapped device. For kdump, at this point, the device
>> +        * is supposed to finish reset at its driver probe stage, so no
>> +        * in-flight DMA will exist, and we don't need to worry anymore
>> +        * hereafter.
>> +        */
>> +       if (context_copied(context)) {
>> +               u16 did_old = context_domain_id(context);
>> +
>> +               if (did_old >= 0 && did_old < cap_ndoms(iommu->cap))
>> +                       iommu->flush.flush_context(iommu, did_old,
>> +                                                  (((u16)bus) << 8) | devfn,
>> +                                                  DMA_CCMD_MASK_NOBIT,
>> +                                                  DMA_CCMD_DEVICE_INVL);
>> +       }
>> +
>>         pgd = domain->pgd;
> Yes, this looks better. Have you tested it the same way as the old
> patch?

Yes, I have tested and it works, will send v3 later.

Regards,
Xunlei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
