Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uz1WA-0006IF-76
 for kexec@lists.infradead.org; Tue, 16 Jul 2013 09:25:59 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Tue, 16 Jul 2013 10:20:35 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3639C219005F
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 10:29:30 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6G9PJME47382780
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 09:25:19 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6G9PTWF017236
 for <kexec@lists.infradead.org>; Tue, 16 Jul 2013 03:25:30 -0600
Date: Tue, 16 Jul 2013 11:25:27 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130716112527.35decf17@holzheu>
In-Reply-To: <20130715142708.GB23772@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702154214.GC22603@redhat.com>
 <20130715154451.02a3a767@holzheu>
 <20130715142708.GB23772@redhat.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, kexec@lists.infradead.org, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, 15 Jul 2013 10:27:08 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Mon, Jul 15, 2013 at 03:44:51PM +0200, Michael Holzheu wrote:
> > On Tue, 2 Jul 2013 11:42:14 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Mon, Jul 01, 2013 at 09:32:37PM +0200, Michael Holzheu wrote:
> > > > For zfcpdump we can't map the HSA storage because it is only available
> > > > via a read interface. Therefore, for the new vmcore mmap feature we have
> > > > introduce a new mechanism to create mappings on demand.
> > > > 
> > > > This patch introduces a new architecture function remap_oldmem_pfn_range()
> > > > that should be used to create mappings with remap_pfn_range() for oldmem
> > > > areas that can be directly mapped. For zfcpdump this is everything besides
> > > > of the HSA memory. For the areas that are not mapped by remap_oldmem_pfn_range()
> > > > a generic vmcore a new generic vmcore fault handler mmap_vmcore_fault()
> > > > is called.
> > > > 
> > > > This handler works as follows:
> > > > 
> > > > * Get already available or new page from page cache (find_or_create_page)
> > > > * Check if /proc/vmcore page is filled with data (PageUptodate)
> > > > * If yes:
> > > >   Return that page
> > > > * If no:
> > > >   Fill page using __vmcore_read(), set PageUptodate, and return page
> > > > 
> > > > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > > 
> > > In general vmcore related changes look fine to me. I am not very familiar
> > > with the logic of finding pages in page cache and using page uptodate
> > > flag.
> > > 
> > > Hatayama, can you please review it.
> > > 
> > > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> > 
> > Hello Vivek and Andrew,
> > 
> > We just realized that Hatayama's mmap patches went into v3.11-rc1. This currently
> > breaks s390 kdump because of the following two issues:
> > 
> > 1) The copy_oldmem_page() is now used for copying to vmalloc memory
> > 2) The mmap() implementation is not compatible with the current
> >    s390 crashkernel swap:
> >    See: http://marc.info/?l=kexec&m=136940802511603&w=2
> > 
> > The "kdump: Introduce ELF header in new memory feature" patch series will
> > fix both issues for s390.
> > 
> > There is the one small open discussion left:
> > 
> > http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg464856.html
> > 
> > But once we have finished that, would it be possible to get the
> > patches in 3.11?
> 
> How about taking mmap() fault handler patches in 3.12. And in 3.11, deny
> mmap() on s390 forcing makedumpfile to fall back on read() interface. That
> way there will be no regression and mmap() related speedup will show up
> in next release on s390.

Hello Vivek and Hatayama,

But then we still would have to somehow fix the copy_oldmem_page() issue (1).

We would prefer to add the current patch series with "#ifndef CONFIG_S390" in
the fault handler.

@Vivek:

Since you are the kdump maintainer, could you tell us which of the both
variants you would like to have?

static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
{
...

#ifndef CONFIG_S390
	return VM_FAULT_SIGBUS;
#endif

or 

#ifndef CONFIG_S390
        WARN_ONCE(1, "vmcore: Unexpected call of mmap_vmcore_fault()");
#endif

For all architectures besides of s390 this would implement the requested behavior.

Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
