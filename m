Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ydx1H-0000WH-94
 for kexec@lists.infradead.org; Fri, 03 Apr 2015 08:32:04 +0000
Message-ID: <551E4FC4.3030601@hp.com>
Date: Fri, 03 Apr 2015 16:31:00 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403082816.GE22579@dhcp-128-53.nay.redhat.com>
In-Reply-To: <20150403082816.GE22579@dhcp-128-53.nay.redhat.com>
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

On 04/03/2015 04:28 PM, Dave Young wrote:
> On 03/19/15 at 01:36pm, Li, Zhen-Hua wrote:
>> This patchset is an update of Bill Sumner's patchset, implements a fix for:
>> If a kernel boots with intel_iommu=on on a system that supports intel vt-d,
>> when a panic happens, the kdump kernel will boot with these faults:
> Zhenhua,
>
> I will review the patchset recently, sorry for jumping in late.
>
> Thanks
> Dave
>
Hi Dave,
Thanks for your review. And please also take a look at the plan I sent 
in another mail:

Change use of
      if (is_kdump_kernel()) { }

To:
     if (iommu_enabled_in_last_kernel) { }


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
