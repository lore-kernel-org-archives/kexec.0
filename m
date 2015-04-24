Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YlYwH-0008PH-KB
 for kexec@lists.infradead.org; Fri, 24 Apr 2015 08:26:21 +0000
Date: Fri, 24 Apr 2015 16:25:28 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v10 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150424082528.GA23912@dhcp-128-91.nay.redhat.com>
References: <1428655333-19504-1-git-send-email-zhen-hual@hp.com>
 <20150415005731.GC19051@localhost.localdomain>
 <552DFB56.1070600@hp.com>
 <20150415064803.GF19051@localhost.localdomain>
 <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150424080147.GC4458@dhcp-16-116.nay.redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

Hi, Baoquan

> I support this patchset.
> 
> We should not fear oldmem since reserved crashkernel region is similar.
> No one can guarantee that any crazy code won't step into crashkernel
> region just because 1st kernel says it's reversed for kdump kernel. Here
> the root table and context tables are also not built to allow legal code
> to danamge. Both of them has the risk to be corrupted, for trying our
> best to get a dumped vmcore the risk is worth being taken.

old mem is mapped in 1st kernel so compare with the reserved crashkernel
they are more likely to be corrupted. they are totally different. 

> 
> And the resetting pci way has been NACKed by David Woodhouse, the
> maintainer of intel iommu. Because the place calling the resetting pci
> code is ugly before kdump kernel or in kdump kernel. And as he said a
> certain device made mistakes why we blame on all devices. We should fix
> that device who made mistakes. 

Resetting pci bus is not ugly than fixing a problem with risk and to fix
the problem it introduced in the future.

I know it is late to speak out, but sorry I still object and have to NACK this
oldmem approach from my point.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
