Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YvM2z-0004vQ-Pb
 for kexec@lists.infradead.org; Thu, 21 May 2015 08:41:48 +0000
Message-ID: <555D99EB.2030603@hp.com>
Date: Thu, 21 May 2015 16:40:11 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 08/10] iommu/vt-d: assign new page table for dma_map
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-9-git-send-email-zhen-hual@hp.com>
 <20150520235242.GA2342@dhcp-17-102.nay.redhat.com> <555D3470.7060902@hp.com>
 <20150521065451.GA23661@dhcp-128-28.nay.redhat.com>
In-Reply-To: <20150521065451.GA23661@dhcp-128-28.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

Hi Baoquan,
During driver being loaded and initialized, when there is a new dma
request, the function
                __get_valid_domain_for_dev
is called, and then new page is mapped.

Please check this:
struct dma_map_ops intel_dma_ops = {
         .alloc = intel_alloc_coherent,
         .free = intel_free_coherent,
         .map_sg = intel_map_sg,
         .unmap_sg = intel_unmap_sg,
         .map_page = intel_map_page,
         .unmap_page = intel_unmap_page,
         .mapping_error = intel_mapping_error,
};

You can also add dump_stack() in __get_valid_domain_for_dev to debug.

Thanks
Zhenhua

On 05/21/2015 02:54 PM, Baoquan He wrote:
> On 05/21/15 at 09:27am, Li, ZhenHua wrote:
>> Hi Baoquan,
>>
>> In the early version of this patchset, old page tables are used by new
>> kernel.  But as discussed, we need to make kernel use new pages when
>> there is a new dma request , so we need to unmap the pages which were
>> mapped in old kernel, and this is what this patch does.
>
> OK, just a new page table allocated in init_domain(), right? I thought a
> specific empty page-table is allocated for these new domains in kdump
> kernel.
>
>>
>> Thanks
>> Zhenhua
>>
>> On 05/21/2015 07:52 AM, Baoquan He wrote:
>>> On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
>>>> When a device driver issues the first dma_map command for a device, we
>>>> assign a new and empty page-table, thus removing all mappings from the
>>>> old kernel for the device.
>>>
>>> Hi Zhenhua,
>>>
>>>  From your patch I got it will remove all mappings, assign a new
>>> page-table. But I didn't got why you stress an empty page-table. Did I
>>> miss anything?
>>>
>>> Thanks
>>> Baoquan
>>>
>>>>
>>>> Signed-off-by: Li, Zhen-Hua <zhen-hual@hp.com>
>>>> --

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
