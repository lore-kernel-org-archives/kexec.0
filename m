Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eaxlj-0002mN-FP
 for kexec@lists.infradead.org; Mon, 15 Jan 2018 05:57:17 +0000
Received: by mail-pg0-x242.google.com with SMTP id z17so7484844pgc.4
 for <kexec@lists.infradead.org>; Sun, 14 Jan 2018 21:57:04 -0800 (PST)
Date: Sun, 14 Jan 2018 21:57:01 -0800
From: Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 4.14 023/159] mm/sparsemem: Allocate mem_section at
 runtime for CONFIG_SPARSEMEM_EXTREME=y
Message-ID: <20180115055701.GA9071@vader>
References: <20180108160444.2ol4fvgqbxnjmlpg@gmail.com>
 <20180108174653.7muglyihpngxp5tl@black.fi.intel.com>
 <20180109001303.dy73bpixsaegn4ol@node.shutemov.name>
 <20180109010927.GA2082@dhcp-128-65.nay.redhat.com>
 <20180109054131.GB1935@localhost.localdomain>
 <20180109072440.GA6521@dhcp-128-65.nay.redhat.com>
 <20180109090552.45ddfk2y25lf4uyn@node.shutemov.name>
 <20180110030804.GB1744@dhcp-128-110.nay.redhat.com>
 <20180110111603.56disgew7ipusgjy@black.fi.intel.com>
 <20180112005549.GA2265@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180112005549.GA2265@dhcp-128-65.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Galbraith <efault@gmx.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>, Cyrill Gorcunov <gorcunov@openvz.org>, "Kirill A. Shutemov" <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On Fri, Jan 12, 2018 at 08:55:49AM +0800, Dave Young wrote:
> On 01/10/18 at 02:16pm, Kirill A. Shutemov wrote:
> > On Wed, Jan 10, 2018 at 03:08:04AM +0000, Dave Young wrote:
> > > On Tue, Jan 09, 2018 at 12:05:52PM +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Jan 09, 2018 at 03:24:40PM +0800, Dave Young wrote:
> > > > > On 01/09/18 at 01:41pm, Baoquan He wrote:
> > > > > > On 01/09/18 at 09:09am, Dave Young wrote:
> > > > > > 
> > > > > > > As for the macro name, VMCOREINFO_SYMBOL_ARRAY sounds better.
> > > > 
> > > > Yep, that's better.
> > > > 
> > > > > > I still think using vmcoreinfo_append_str is better. Unless we replace
> > > > > > all array variables with the newly added macro.
> > > > > > 
> > > > > > vmcoreinfo_append_str("SYMBOL(mem_section)=%lx\n",
> > > > > >                                 (unsigned long)mem_section);
> > > > > 
> > > > > I have no strong opinion, either change all array uses or just introduce
> > > > > the macro and start to use it from now on if we have similar array
> > > > > symbols.
> > > > 
> > > > Do you need some action on my side or will you folks take care about this?
> > > 
> > > I think Baoquan was suggesting to update all array users in current
> > > code, if you can check every VMCOREINFO_SYMBOL and update all the arrays
> > > he will be happy. But if can not do it easily I'm fine with a
> > > VMCOREINFO_SYMBOL_ARRAY changes only now, we kdump people can do it
> > > later as well. 
> > 
> > It seems it's the only array we have there. swapper_pg_dir is a potential
> > candidate, but it's 'unsigned long' on arm.
> > 
> > Below it patch with corrected macro name.
> > 
> > Please, consider applying.
> > 
> > From 70f3a84b97f2de98d1364f7b10b7a42a1d8e9968 Mon Sep 17 00:00:00 2001
> > From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Date: Tue, 9 Jan 2018 02:55:47 +0300
> > Subject: [PATCH] kdump: Write a correct address of mem_section into vmcoreinfo
> > 
> > Depending on configuration mem_section can now be an array or a pointer
> > to an array allocated dynamically. In most cases, we can continue to refer
> > to it as 'mem_section' regardless of what it is.
> > 
> > But there's one exception: '&mem_section' means "address of the array" if
> > mem_section is an array, but if mem_section is a pointer, it would mean
> > "address of the pointer".
> > 
> > We've stepped onto this in kdump code. VMCOREINFO_SYMBOL(mem_section)
> > writes down address of pointer into vmcoreinfo, not array as we wanted.
> > 
> > Let's introduce VMCOREINFO_SYMBOL_ARRAY() that would handle the
> > situation correctly for both cases.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Fixes: 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y")
> > ---
> >  include/linux/crash_core.h | 2 ++
> >  kernel/crash_core.c        | 2 +-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> > index 06097ef30449..b511f6d24b42 100644
> > --- a/include/linux/crash_core.h
> > +++ b/include/linux/crash_core.h
> > @@ -42,6 +42,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
> >  	vmcoreinfo_append_str("PAGESIZE=%ld\n", value)
> >  #define VMCOREINFO_SYMBOL(name) \
> >  	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)&name)
> > +#define VMCOREINFO_SYMBOL_ARRAY(name) \
> > +	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
> >  #define VMCOREINFO_SIZE(name) \
> >  	vmcoreinfo_append_str("SIZE(%s)=%lu\n", #name, \
> >  			      (unsigned long)sizeof(name))
> > diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> > index b3663896278e..4f63597c824d 100644
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -410,7 +410,7 @@ static int __init crash_save_vmcoreinfo_init(void)
> >  	VMCOREINFO_SYMBOL(contig_page_data);
> >  #endif
> >  #ifdef CONFIG_SPARSEMEM
> > -	VMCOREINFO_SYMBOL(mem_section);
> > +	VMCOREINFO_SYMBOL_ARRAY(mem_section);
> >  	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
> >  	VMCOREINFO_STRUCT_SIZE(mem_section);
> >  	VMCOREINFO_OFFSET(mem_section, section_mem_map);
> > -- 
> >  Kirill A. Shutemov
> 
> 
> Acked-by: Dave Young <dyoung@redhat.com>
> 
> If stable kernel took the mem section commits, then should also cc
> stable.  Andrew, can you help to make this in 4.15?
> 
> Thanks
> Dave

Hm, this fix means that the vmlinux symbol table and vmcoreinfo have
different values for mem_section. That seems... odd. I had to patch
makedumpfile to fix the case of an explicit vmlinux being passed on the
command line (which I realized I don't need to do, but it should still
work):

From 542a11a8f28b0f0a989abc3adff89da22f44c719 Mon Sep 17 00:00:00 2001
Message-Id: <542a11a8f28b0f0a989abc3adff89da22f44c719.1515995400.git.osandov@fb.com>
From: Omar Sandoval <osandov@fb.com>
Date: Sun, 14 Jan 2018 17:10:30 -0800
Subject: [PATCH] Fix SPARSEMEM_EXTREME support on Linux v4.15 when passing
 vmlinux

Since kernel commit 83e3c48729d9 ("mm/sparsemem: Allocate mem_section at
runtime for CONFIG_SPARSEMEM_EXTREME=y"), mem_section is a dynamically
allocated array of pointers to mem_section instead of a static one
(i.e., struct mem_section ** instead of struct mem_section * []). This
adds an extra layer of indirection that breaks makedumpfile, which will
end up with a bunch of bogus mem_maps.

Since kernel commit a0b1280368d1 ("kdump: write correct address of
mem_section into vmcoreinfo"), the mem_section symbol in vmcoreinfo
contains the address of the actual struct mem_section * array instead of
the address of the pointer in .bss, which gets rid of the extra
indirection. However, makedumpfile still uses the debugging symbol from
the vmlinux image. Fix this by allowing symbols from the vmcore to
override symbols from the vmlinux image. As the comment in initial()
says, "vmcoreinfo in /proc/vmcore is more reliable than -x/-i option".

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 makedumpfile.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index 57cf4d9..d68c798 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -274,8 +274,10 @@ do { \
 } while (0)
 #define READ_SYMBOL(str_symbol, symbol) \
 do { \
-	if (SYMBOL(symbol) == NOT_FOUND_SYMBOL) { \
-		SYMBOL(symbol) = read_vmcoreinfo_symbol(STR_SYMBOL(str_symbol)); \
+	unsigned long _tmp_symbol; \
+	_tmp_symbol = read_vmcoreinfo_symbol(STR_SYMBOL(str_symbol)); \
+	if (_tmp_symbol != NOT_FOUND_SYMBOL) { \
+		SYMBOL(symbol) = _tmp_symbol; \
 		if (SYMBOL(symbol) == INVALID_SYMBOL_DATA) \
 			return FALSE; \
 	} \
-- 
2.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
