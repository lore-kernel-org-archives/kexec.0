Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2353.austin.hp.com ([15.217.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YiGBV-0003kd-45
 for kexec@lists.infradead.org; Wed, 15 Apr 2015 05:48:25 +0000
Message-ID: <552DFB56.1070600@hp.com>
Date: Wed, 15 Apr 2015 13:47:02 +0800
From: "Li, ZhenHua" <zhen-hual@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150415005731.GC19051@localhost.localdomain>
In-Reply-To: <20150415005731.GC19051@localhost.localdomain>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 04/15/2015 08:57 AM, Dave Young wrote:
> Again, I think it is bad to use old page table, below issues need consider:
> 1) make sure old page table are reliable across crash
> 2) do not allow writing oldmem after crash
>
> Please correct me if I'm wrong, or if above is not doable I think I will vote for
> resetting pci bus.
>
> Thanks
> Dave
>
Hi Dave,

When updating the context tables, we have to write their address to root 
tables, this will cause writing to old mem.

Resetting the pci bus has been discussed, please check this:
http://lists.infradead.org/pipermail/kexec/2014-October/012752.html
https://lkml.org/lkml/2014/10/21/890

Thanks
Zhenhua




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
