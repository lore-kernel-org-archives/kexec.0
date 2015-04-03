Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YdwJ9-00079i-67
 for kexec@lists.infradead.org; Fri, 03 Apr 2015 07:46:28 +0000
Message-ID: <551E450F.4030903@hp.com>
Date: Fri, 03 Apr 2015 15:45:19 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 07/10] iommu/vt-d: enable kdump support in iommu module
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <1426743388-26908-8-git-send-email-zhen-hual@hp.com>
 <20150402110608.GL4441@8bytes.org>
In-Reply-To: <20150402110608.GL4441@8bytes.org>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

Hi Joerg,
Thinking about it carefully, I think you suggestions are very helpful, 
and the checks should be:
* All these things should be done in the second kernel, not only the 
kdump kernel. Sometimes user may use kexec manually start a new kernel.
* Copying those tables should only happen in the second kernel, only in 
this situation: iommu is enabled in both first and second kernel.

So, I think we can do this:
1. Use a new variable iommu_enabled_in_last_kernel;
2. When iommu module is loaded, it means the iommu is enabled in current 
kernel.  Then we check DMA_GSTS_TES:
    * if DMA_GSTS_TES is set, then it should be the second kernel(kexec 
starts this kernel manually, or it is kdump kernel), and the first 
kernel used iommu tables.  Here we need to copy these tables; then set 
iommu_enabled_in_last_kernel to 1.
    * if DMA_GSTS_TES is NOT set, then we do not need to care about 
these tables.

3. Replace all
#ifdef CONFIG_CRASH_DUMP
	if (is_kdump_kernel()) {
             // Do some thing
         }
#endif

To:
if (iommu_enabled_in_last_kernel) {
      // Do some thing
}

Do you agree with these?

Thanks
Zhenhua

On 04/02/2015 07:06 PM, Joerg Roedel wrote:
> On Thu, Mar 19, 2015 at 01:36:25PM +0800, Li, Zhen-Hua wrote:
>> +#ifdef CONFIG_CRASH_DUMP
>> +		if (is_kdump_kernel())
>> +			__iommu_update_old_root_entry(iommu, bus);
>> +#endif
>
> All the is_kdump_kernel checks in this patch (and maybe in other patches
> too) should really be checks whether translation on the IOMMU was
> enabled or not when the kernel booted. You might also boot from a kernel
> that had translation disabled into a kdump kernel that wants to enable
> it. In this case these checks would break.
>
> Speaking of booting from kernels with translation disabled, there is a
> valid use of is_kdump_enabled(), to omit iommu initialization in the
> kdump kernel when translation was disabled before. But the other checks
> should depend on the state the iommu had when booting the kdump kernel.
>
>
> 	Joerg
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
