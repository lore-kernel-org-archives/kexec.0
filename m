Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UyjlG-0005yg-7V
 for kexec@lists.infradead.org; Mon, 15 Jul 2013 14:28:23 +0000
Date: Mon, 15 Jul 2013 10:27:08 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130715142708.GB23772@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <20130702154214.GC22603@redhat.com>
 <20130715154451.02a3a767@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130715154451.02a3a767@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Jan Willeke <willeke@de.ibm.com>, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Jul 15, 2013 at 03:44:51PM +0200, Michael Holzheu wrote:
> On Tue, 2 Jul 2013 11:42:14 -0400
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > On Mon, Jul 01, 2013 at 09:32:37PM +0200, Michael Holzheu wrote:
> > > For zfcpdump we can't map the HSA storage because it is only available
> > > via a read interface. Therefore, for the new vmcore mmap feature we have
> > > introduce a new mechanism to create mappings on demand.
> > > 
> > > This patch introduces a new architecture function remap_oldmem_pfn_range()
> > > that should be used to create mappings with remap_pfn_range() for oldmem
> > > areas that can be directly mapped. For zfcpdump this is everything besides
> > > of the HSA memory. For the areas that are not mapped by remap_oldmem_pfn_range()
> > > a generic vmcore a new generic vmcore fault handler mmap_vmcore_fault()
> > > is called.
> > > 
> > > This handler works as follows:
> > > 
> > > * Get already available or new page from page cache (find_or_create_page)
> > > * Check if /proc/vmcore page is filled with data (PageUptodate)
> > > * If yes:
> > >   Return that page
> > > * If no:
> > >   Fill page using __vmcore_read(), set PageUptodate, and return page
> > > 
> > > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
> > 
> > In general vmcore related changes look fine to me. I am not very familiar
> > with the logic of finding pages in page cache and using page uptodate
> > flag.
> > 
> > Hatayama, can you please review it.
> > 
> > Acked-by: Vivek Goyal <vgoyal@redhat.com>
> 
> Hello Vivek and Andrew,
> 
> We just realized that Hatayama's mmap patches went into v3.11-rc1. This currently
> breaks s390 kdump because of the following two issues:
> 
> 1) The copy_oldmem_page() is now used for copying to vmalloc memory
> 2) The mmap() implementation is not compatible with the current
>    s390 crashkernel swap:
>    See: http://marc.info/?l=kexec&m=136940802511603&w=2
> 
> The "kdump: Introduce ELF header in new memory feature" patch series will
> fix both issues for s390.
> 
> There is the one small open discussion left:
> 
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg464856.html
> 
> But once we have finished that, would it be possible to get the
> patches in 3.11?

How about taking mmap() fault handler patches in 3.12. And in 3.11, deny
mmap() on s390 forcing makedumpfile to fall back on read() interface. That
way there will be no regression and mmap() related speedup will show up
in next release on s390.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
