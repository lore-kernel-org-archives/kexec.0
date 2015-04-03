Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YdxA9-0006tT-PX
 for kexec@lists.infradead.org; Fri, 03 Apr 2015 08:41:14 +0000
Date: Fri, 3 Apr 2015 16:40:31 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
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
To: "Li, Zhen-Hua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

> To fix this problem, we modifies the behaviors of the intel vt-d in the 
> crashdump kernel:
> 
> For DMA Remapping:
> 1. To accept the vt-d hardware in an active state,
> 2. Do not disable and re-enable the translation, keep it enabled.
> 3. Use the old root entry table, do not rewrite the RTA register.
> 4. Malloc and use new context entry table, copy data from the old ones that
>    used by the old kernel.

Have not read all the patches, but I have a question, not sure this has been
answered before. Old memory is not reliable, what if the old memory get corrupted
before panic? Is it safe to continue using it in 2nd kernel, I worry that it will
cause problems.

Hope I'm wrong though.

Thanks
Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
