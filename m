Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([2a01:238:4383:600:38bc:a715:4b6d:a889]
 helo=theia.8bytes.org)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YAgm4-0006Mz-8J
 for kexec@lists.infradead.org; Mon, 12 Jan 2015 15:19:25 +0000
Date: Mon, 12 Jan 2015 16:18:55 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 01/10] iommu/vt-d: Update iommu_attach_domain() and
 its callers
Message-ID: <20150112151855.GB6343@8bytes.org>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
 <1421046388-27925-2-git-send-email-zhen-hual@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1421046388-27925-2-git-send-email-zhen-hual@hp.com>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On Mon, Jan 12, 2015 at 03:06:19PM +0800, Li, Zhen-Hua wrote:
> Allow specification of the domain-id for the new domain.
> This patch only adds the 'did' parameter to iommu_attach_domain()
> and modifies all of its callers to specify the default value of -1
> which says "no did specified, allocate a new one".

I think its better to keep the old iommu_attach_domain() interface in
place and introduce a new function (like iommu_attach_domain_with_id()
or something) which has the additional parameter. Then you can rewrite
iommu_attach_domain():

	iommu_attach_domai(...)
	{
		return iommu_attach_domain_with_id(..., -1);
	}

This way you don't have to update all the callers of
iommu_attach_domain() and the interface is more readable.


	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
