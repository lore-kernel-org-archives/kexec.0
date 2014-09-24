Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp10.uk.ibm.com ([195.75.94.106])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XWoLu-0006qL-I7
 for kexec@lists.infradead.org; Wed, 24 Sep 2014 15:19:35 +0000
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 24 Sep 2014 16:19:10 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 369EE17D8045
 for <kexec@lists.infradead.org>; Wed, 24 Sep 2014 16:21:14 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8OFJ7q235520534
 for <kexec@lists.infradead.org>; Wed, 24 Sep 2014 15:19:07 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8OFJ6TZ026153
 for <kexec@lists.infradead.org>; Wed, 24 Sep 2014 09:19:06 -0600
Date: Wed, 24 Sep 2014 17:19:04 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: Add "--mem-usage" support for s390x
Message-ID: <20140924171904.1db5ac90@holzheu>
In-Reply-To: <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
References: <1409541340-2719-1-git-send-email-bhe@redhat.com>
 <20140922170247.36774052@holzheu>
 <20140923024058.GC8697@dhcp-16-116.nay.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Tue, 23 Sep 2014 10:40:58 +0800
Baoquan He <bhe@redhat.com> wrote:

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

Hello Baoquan,

Thanks for the hint! I looked into the x86_64 implementation of 
get_versiondep_info() where version dependent constants are used
for vmalloc_start and others.

For s390x this is not so easy because vmalloc_start is dependent
on the memory size of the system (see setup_memory_end()
in arch/s390/kernel/setup.c). Unfortunately "info->max_mapnr"
is not set at that time.

Any ideas?

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
