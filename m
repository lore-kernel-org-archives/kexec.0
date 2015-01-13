Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YAzsY-0005ig-Ct
 for kexec@lists.infradead.org; Tue, 13 Jan 2015 11:43:22 +0000
Date: Tue, 13 Jan 2015 19:41:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 02/10] iommu/vt-d: Items required for kdump
Message-ID: <20150113114108.GB24543@dhcp-16-105.nay.redhat.com>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, Joerg Roedel <joro@8bytes.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 Zhen-Hua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com

On 01/12/15 at 10:29am, Vivek Goyal wrote:
> On Mon, Jan 12, 2015 at 04:22:08PM +0100, Joerg Roedel wrote:
> > It looks like you are still copying the io-page-tables from the old
> > kernel into the kdump kernel, is that right? With the approach that was
> > proposed you only need to copy over the context entries 1-1. They are
> > still pointing to the page-tables in the old kernels memory (which is
> > just fine).
> 
> Kdump has the notion of backup region. Where certain parts of old kernels
> memory can be moved to a different location (first 640K on x86 as of now)
> and new kernel can make use of this memory now.

Hi Vivek,

About backup region I am a bit confusing. Just say x86, we usually copy
it to a backup region. And this first 640K will be used as a usable
memory region in 2nd kernel since its content has been copied to backup
region. And that backup region is taken from crashkernel reserved
memory and not passed to 2nd kernel as usable memory region.

Here did you mean the old page table could fall into first 640K memory
region or that reserved backup region?  Since as I understand the backup
region is taken from crashkernel memory which is not used by 1st kernel
process.

Thanks
Baoquan

> 
> So we will have to just make sure that no parts of this old page table
> fall into backup region.
> 
> Thanks
> Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
