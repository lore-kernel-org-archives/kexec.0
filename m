Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ys3XN-0000iM-4J
 for kexec@lists.infradead.org; Tue, 12 May 2015 06:19:29 +0000
Date: Tue, 12 May 2015 14:18:52 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v11 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150512061852.GA10229@dhcp-16-116.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On 05/11/15 at 05:52pm, Li, Zhen-Hua wrote:
> This patchset is an update of Bill Sumner's patchset, implements a fix for:
> If a kernel boots with intel_iommu=on on a system that supports intel vt-d, 
> when a panic happens, the kdump kernel will boot with these faults:

Test passed on my local workstation. Thanks, Zhenhua.

> 
>     dmar: DRHD: handling fault status reg 102
>     dmar: DMAR:[DMA Read] Request device [01:00.0] fault addr fff80000
>     DMAR:[fault reason 01] Present bit in root entry is clear
> 
>     dmar: DRHD: handling fault status reg 2
>     dmar: INTR-REMAP: Request device [[61:00.0] fault index 42
>     INTR-REMAP:[fault reason 34] Present field in the IRTE entry is clear

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
