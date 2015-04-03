Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2352.austin.hp.com ([15.217.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YdwRa-0002lb-Na
 for kexec@lists.infradead.org; Fri, 03 Apr 2015 07:55:12 +0000
Message-ID: <551E471F.7090504@hp.com>
Date: Fri, 03 Apr 2015 15:54:07 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150402111133.GM4441@8bytes.org>
In-Reply-To: <20150402111133.GM4441@8bytes.org>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

Hi Joerg,
This is quite strange. I checked the patches from patch 01 to 10 using 
./scripts/checkpatch.pl under the kernel source directory, but got 0 
errors and 0 warning.  Only some white spaces in the cover letter 00, 
but is could not be checked by this script.

But I checked the intel-iommu.c using "checkpatch.pl -f", found too many 
warnings and errors. Maybe we need a new patch to fix them.

Thanks
Zhenhua

On 04/02/2015 07:11 PM, Joerg Roedel wrote:
> Hi Zhen-Hua,
>
> On Thu, Mar 19, 2015 at 01:36:18PM +0800, Li, Zhen-Hua wrote:
>> This patchset is an update of Bill Sumner's patchset, implements a fix for:
>> If a kernel boots with intel_iommu=on on a system that supports intel vt-d,
>> when a panic happens, the kdump kernel will boot with these faults:
>
> I reviewed this patch-set and it is getting closer to a point where it
> could be merged. I found a few white-space errors in the review, please
> do a check_patch run on the next round and fix these. Besides that and
> given some third-party testing and reviews I think we can look forward
> to merge it early after the merge-window for v4.1, to give it enough
> testing in -next too.
>
>
> 	Joerg
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
