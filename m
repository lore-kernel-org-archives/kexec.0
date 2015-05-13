Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsSWK-0008AY-8f
 for kexec@lists.infradead.org; Wed, 13 May 2015 09:00:04 +0000
Message-ID: <55531231.6040506@hp.com>
Date: Wed, 13 May 2015 16:58:25 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v11 06/10] iommu/vt-d: datatypes and functions used for
 kdump
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-7-git-send-email-zhen-hual@hp.com>
 <20150513085609.GD3736@dhcp-128-28.nay.redhat.com>
In-Reply-To: <20150513085609.GD3736@dhcp-128-28.nay.redhat.com>
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

Hi Dave,

iommu->root_entry_old_virt is used to store the mapped old rta.
iommu->root_entry_old_phys is used to store the physical address stored 
in registers.
So we must not free/unmap iommu->root_entry_old_phys .

Zhenhua
On 05/13/2015 04:56 PM, Baoquan He wrote:
>> +
>> +	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
>> +	if (!iommu->root_entry_old_phys) {
>> +		pr_err("Could not read old root entry address.");
>> +		return -1;
>> +	}
>> +
>
> I didn't find where you call iounmap to free mapping of
> iommu->root_entry_old_phys. Am I missing anything?
>
>> +	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
>> +						VTD_PAGE_SIZE);
>> +	if (!iommu->root_entry_old_virt) {
>> +		pr_err("Could not map the old root entry.");
>> +		return -ENOMEM;
>> +	}


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
