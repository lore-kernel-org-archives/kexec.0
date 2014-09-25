Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XX5bN-0001g3-CL
 for kexec@lists.infradead.org; Thu, 25 Sep 2014 09:44:42 +0000
Date: Thu, 25 Sep 2014 17:44:12 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140925094412.GI8697@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
 <20140924171904.1db5ac90@holzheu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140924171904.1db5ac90@holzheu>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

On 09/24/14 at 05:19pm, Michael Holzheu wrote:
> On Tue, 23 Sep 2014 10:40:58 +0800
> Baoquan He <bhe@redhat.com> wrote:
> 
> > On 09/22/14 at 05:02pm, Michael Holzheu wrote:
> > > Hello Baoquan,
> > > 
> > > I looked into your patches and tried to add s390x support.
> > > 
> > > My naive approach was to just enable the is_vmalloc_addr()
> > > for s390x:
> > > 
> > > --- a/makedumpfile.h
> > > +++ b/makedumpfile.h
> > > @@ -814,13 +814,15 @@ unsigned long long vaddr_to_paddr_ppc(un
> > >  #endif          /* powerpc32 */
> > > 
> > >  #ifdef __s390x__ /* s390x */
> > > +int is_vmalloc_addr_s390x(ulong vaddr);
> > >  int get_machdep_info_s390x(void);
> > >  unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
> > >  #define get_phys_base()        TRUE
> > >  #define get_machdep_info()     get_machdep_info_s390x()
> > >  #define get_versiondep_info()  TRUE
> > >  #define vaddr_to_paddr(X)      vaddr_to_paddr_s390x(X)
> > > -#define is_vmalloc_addr(X)     TRUE
> > > +#define is_vmalloc_addr(X)     is_vmalloc_addr_s390x(X)
> > >  #endif          /* s390x */
> > > 
> > >  #ifdef __ia64__ /* ia64 */
> > 
> > Hi Michael, 
> > 
> > Please alse provide a get_versiondep_info_s390x since page_offset is
> > needed in set_kcore_vmcoreinfo() and other information need it too, such
> > as VMALLOC_START/VMEMMAP_START/MODULES_VADDR, if you want to provide a
> > is_vmalloc_addr_s390x before initial() is called.
> 
> Hello Baoquan,
> 
> Thanks for the hint! I looked into the x86_64 implementation of 
> get_versiondep_info() where version dependent constants are used
> for vmalloc_start and others.
> 
> For s390x this is not so easy because vmalloc_start is dependent
> on the memory size of the system (see setup_memory_end()
> in arch/s390/kernel/setup.c). Unfortunately "info->max_mapnr"
> is not set at that time.

I am not aware of s390 arch and memory layout. But I can explain what
those versiondep_info are used for, hope they can help. In fact in
x86_64, page_offset is got for set_kcore_vmcoreinfo(), there the
vmcoreinfo_addr need be converted to kvaddr. Since vmcoreinfo_addr is a
physical addr, we can't use it directly. And
VMALLOC_START/VMEMMAP_START/MODULES_VADDR are all used to filter this
virtual addr space region since our vmcore only care about the physical
ram addr region.

If you need get these before they are used for s390 arch. If necessary
you can build a different code flow if you can achive the goal. All
these are all used to get dumpable load segments from kcore.


> 
> Any ideas?
> 
> Michael
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
