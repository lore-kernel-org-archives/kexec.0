Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YdxV1-0001xi-Uk
 for kexec@lists.infradead.org; Fri, 03 Apr 2015 09:02:48 +0000
Message-ID: <551E56F6.60503@hp.com>
Date: Fri, 03 Apr 2015 17:01:42 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
In-Reply-To: <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Hi Dave,

There may be some possibilities that the old iommu data is corrupted by
some other modules. Currently we do not have a better solution for the
dmar faults.

But I think when this happens, we need to fix the module that corrupted
the old iommu data. I once met a similar problem in normal kernel, the
queue used by the qi_* functions was written again by another module.
The fix was in that module, not in iommu module.


Thanks
Zhenhua

On 04/03/2015 04:40 PM, Dave Young wrote:
>> To fix this problem, we modifies the behaviors of the intel vt-d in the
>> crashdump kernel:
>>
>> For DMA Remapping:
>> 1. To accept the vt-d hardware in an active state,
>> 2. Do not disable and re-enable the translation, keep it enabled.
>> 3. Use the old root entry table, do not rewrite the RTA register.
>> 4. Malloc and use new context entry table, copy data from the old ones that
>>     used by the old kernel.
>
> Have not read all the patches, but I have a question, not sure this has been
> answered before. Old memory is not reliable, what if the old memory get corrupted
> before panic? Is it safe to continue using it in 2nd kernel, I worry that it will
> cause problems.
>
> Hope I'm wrong though.
>
> Thanks
> Dave
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
