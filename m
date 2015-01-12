Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([81.169.241.247] helo=theia.8bytes.org)
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YAhWI-0003wv-91
 for kexec@lists.infradead.org; Mon, 12 Jan 2015 16:07:10 +0000
Date: Mon, 12 Jan 2015 17:06:46 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Items required for kdump
Message-ID: <20150112160646.GF6343@8bytes.org>
References: <1421046388-27925-1-git-send-email-zhen-hual@hp.com>
 <1421046388-27925-3-git-send-email-zhen-hual@hp.com>
 <20150112152207.GC6343@8bytes.org>
 <20150112152919.GA16162@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150112152919.GA16162@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 Zhen-Hua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com

On Mon, Jan 12, 2015 at 10:29:19AM -0500, Vivek Goyal wrote:
> Kdump has the notion of backup region. Where certain parts of old kernels
> memory can be moved to a different location (first 640K on x86 as of now)
> and new kernel can make use of this memory now.
> 
> So we will have to just make sure that no parts of this old page table
> fall into backup region.

Uuh, looks like the 'iommu-with-kdump-issue' isn't complicated enough
yet ;)
Sadly, your above statement is true for all hardware-accessible data
structures in IOMMU code. I think about how we can solve this, is there
an easy way to allocate memory that is not in any backup region?

Thanks,

	Joerg


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
