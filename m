From: Matthew Wilcox <willy@infradead.org>
Date: Sat, 9 Apr 2022 02:44:37 +0100
Subject: [PATCH v5 RESEND 1/3] vmcore: Convert copy_oldmem_page() to take
 an iov_iter
In-Reply-To: <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
References: <20220408090636.560886-2-bhe@redhat.com>
 <202204082128.JKXXDGpa-lkp@intel.com>
 <YlDbJSy4AI3/cODr@MiWiFi-R3L-srv>
Message-ID: <YlDlBQYr9ldLWpFz@casper.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Sat, Apr 09, 2022 at 09:02:29AM +0800, Baoquan He wrote:
> I tried on x86_64 system, for the 1st step, I got this:
> 
> [ ~]# wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> /root/bin/make.cross: No such file or directory

... I don't think we need to reproduce it to see the problem.

> > sparse warnings: (new ones prefixed by >>)
> > >> arch/sh/kernel/crash_dump.c:23:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem * @@
> >    arch/sh/kernel/crash_dump.c:23:36: sparse:     expected void const *addr
> >    arch/sh/kernel/crash_dump.c:23:36: sparse:     got void [noderef] __iomem *
> > 
> > vim +23 arch/sh/kernel/crash_dump.c
> > 
> >     13	
> >     14	ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn,
> >     15				 size_t csize, unsigned long offset)
> >     16	{
> >     17		void  __iomem *vaddr;
> >     18	
> >     19		if (!csize)
> >     20			return 0;
> >     21	
> >     22		vaddr = ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> >   > 23		csize = copy_to_iter(vaddr + offset, csize, iter);

Unlike other architectures, sh4 does this by calling ioremap().
That gives us an __iomem qualified pointer, which it then warns about
passing to copy_to_iter().

There are a bunch of hacky things we could do to fix it, but for such an
unmaintained arch as sh, I'm inclined to do nothing.  We're more likely
to break something while fixing the warning.  Someone who knows the arch
can figure out what to do properly.

