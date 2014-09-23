Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XWGA2-0007Gy-Js
 for kexec@lists.infradead.org; Tue, 23 Sep 2014 02:49:03 +0000
Date: Tue, 23 Sep 2014 10:48:35 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140923024835.GD8697@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
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

On 09/23/14 at 10:40am, Baoquan He wrote:
> On 09/22/14 at 05:02pm, Michael Holzheu wrote:
> > Hello Baoquan,
> > 
> > I looked into your patches and tried to add s390x support.
> > 
> > My naive approach was to just enable the is_vmalloc_addr()
> > for s390x:
> > 
> > --- a/makedumpfile.h
> > +++ b/makedumpfile.h
> > @@ -814,13 +814,15 @@ unsigned long long vaddr_to_paddr_ppc(un
> >  #endif          /* powerpc32 */
> > 
> >  #ifdef __s390x__ /* s390x */
> > +int is_vmalloc_addr_s390x(ulong vaddr);
> >  int get_machdep_info_s390x(void);
> >  unsigned long long vaddr_to_paddr_s390x(unsigned long vaddr);
> >  #define get_phys_base()        TRUE
> >  #define get_machdep_info()     get_machdep_info_s390x()

Well, seems you have added the get_machdep_info_s390x(). Could you post
your complete patch? Because I didn't see it in current devel branch.

> >  #define get_versiondep_info()  TRUE
> >  #define vaddr_to_paddr(X)      vaddr_to_paddr_s390x(X)
> > -#define is_vmalloc_addr(X)     TRUE
> > +#define is_vmalloc_addr(X)     is_vmalloc_addr_s390x(X)
> >  #endif          /* s390x */
> > 
> >  #ifdef __ia64__ /* ia64 */
> 
> Hi Michael, 
> 
> Please alse provide a get_versiondep_info_s390x since page_offset is
> needed in set_kcore_vmcoreinfo() and other information need it too, such
> as VMALLOC_START/VMEMMAP_START/MODULES_VADDR, if you want to provide a
> is_vmalloc_addr_s390x before initial() is called.
> 
> 
> Thanks
> Baoquan
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
