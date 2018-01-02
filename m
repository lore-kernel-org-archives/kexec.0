Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eWINt-00005D-27
 for kexec@lists.infradead.org; Tue, 02 Jan 2018 08:57:26 +0000
Date: Tue, 2 Jan 2018 16:57:03 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] handle renamed init_level4_pgt -> init_top_pgt
Message-ID: <20180102085703.GA18368@dhcp-128-65.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701F22E63@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F2A617@BPXM01GP.gisp.nec.co.jp>
 <20171220072443.GA7413@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F2D609@BPXM01GP.gisp.nec.co.jp>
 <20171222045444.GA978@dhcp-128-65.nay.redhat.com>
 <20171222054829.GA21523@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F31899@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701F31899@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, Jeff Mahoney <jeffm@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, bhe@redhat.com

Hi Atsushi,

Happy new year!

On 12/26/17 at 08:21am, Atsushi Kumagai wrote:
> >On 12/22/17 at 12:54pm, Dave Young wrote:
> >> Hi Atsushi,
> >> On 12/21/17 at 08:48am, Atsushi Kumagai wrote:
> >> > Hello Dave,
> >> >
> >> > >[dyoung@dhcp-*-* makedumpfile]$ sudo ./makedumpfile -l -d 31 /mnt/vmcore/vmcore /tmp/vmcore.1
> >> > >The kernel version is not supported.
> >> > >The makedumpfile operation may be incomplete.
> >> > >Checking for memory holes                         : [100.0 %] |                  __vtop4_x86_64: Can't get a valid
> >pte.
> >> > >readmem: Can't convert a virtual address(ffff88007ebb1000) to physical address.
> >> > >readmem: type_addr: 0, addr:ffff88007ebb1000, size:32768
> >> > >__exclude_unnecessary_pages: Can't read the buffer of struct page.
> >> > >create_2nd_bitmap: Can't exclude unnecessary pages.
> >> > >
> >> > >makedumpfile Failed.
> >> > >
> >> > >If you need the vmcore for debugging please let me know, my test is just
> >> > >a normal test in kvm guest.
> >> >
> >> > Thanks for your report.
> >> > I can't reproduce that in my environment, could you give me the vmcore ?
> >> > It's helpful if you append the vmlinux and the .config.
> >>
> >> I'm bisecting it, nearly finished, will post the results and share
> >> vmcore if needed soon.
> >
> >vmcore/vmlinux (gzipped) and .config:
> >http://people.redhat.com/ruyang/rhbz1528542/
> 
> Thanks.
> 
> >Bisect result is below:
> 
> I'm not sure why this commit affects makedumpfile yet, but
> I'll give priority to release v1.6.3 since the commit will not be included
> in the supported kernel(4.14).
> 
> Regards,
> Atsushi Kumagai
> 
> >83e3c48729d9ebb7af5a31a504f3fd6aff0348c4 is the first bad commit
> >commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
> >Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >Date:   Fri Sep 29 17:08:16 2017 +0300
> >
> >    mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y
> >
> >    Size of the mem_section[] array depends on the size of the physical address space.
> >
> >    In preparation for boot-time switching between paging modes on x86-64
> >    we need to make the allocation of mem_section[] dynamic, because otherwise
> >    we waste a lot of RAM: with CONFIG_NODE_SHIFT=10, mem_section[] size is 32kB
> >    for 4-level paging and 2MB for 5-level paging mode.
> >
> >    The patch allocates the array on the first call to sparse_memory_present_with_active_regions().
> >
> >    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >    Cc: Andrew Morton <akpm@linux-foundation.org>
> >    Cc: Andy Lutomirski <luto@amacapital.net>
> >    Cc: Borislav Petkov <bp@suse.de>
> >    Cc: Cyrill Gorcunov <gorcunov@openvz.org>
> >    Cc: Linus Torvalds <torvalds@linux-foundation.org>
> >    Cc: Peter Zijlstra <peterz@infradead.org>
> >    Cc: Thomas Gleixner <tglx@linutronix.de>
> >    Cc: linux-mm@kvack.org
> >    Link: http://lkml.kernel.org/r/20170929140821.37654-2-kirill.shutemov@linux.intel.com
> >    Signed-off-by: Ingo Molnar <mingo@kernel.org>
> >
> >:040000 040000 68b7ff3eedc2c9ff56e31108f7e982eacbb233fc 0014ee63bebe14efb0e36e0028e2cbe718fd6c30 M	include
> >:040000 040000 78adbc296527c802400b1f68e0fbd716920726fa a4eea8117cb318527c0d5a6281d68f312f644831 M	mm

The root cause is this commit makes mem_section as a pointer instead of
the static array.

VMCOREINFO_SYMBOL() expand it as &mem_section, this is not correct in
the test case any more.

This hack code works for me:

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b3663896278e..f5fe6068ae39 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -376,6 +376,8 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
 	return __pa(vmcoreinfo_note);
 }
+#define VMCOREINFO_SYMBOL_HACK(name) \
+	vmcoreinfo_append_str("SYMBOL(%s)=%lx\n", #name, (unsigned long)name)
 
 static int __init crash_save_vmcoreinfo_init(void)
 {
@@ -410,10 +412,11 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
-	VMCOREINFO_SYMBOL(mem_section);
+	VMCOREINFO_SYMBOL_HACK(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
 	VMCOREINFO_STRUCT_SIZE(mem_section);
 	VMCOREINFO_OFFSET(mem_section, section_mem_map);
+
 #endif
 	VMCOREINFO_STRUCT_SIZE(page);
 	VMCOREINFO_STRUCT_SIZE(pglist_data);


But probably we need this instead, but I can not test it because I do
not know how to fix makedumpfile to use a _NUMBER instead of a SYMBOL.
Thus bring up the issue, seeking for thoughts and discussion.

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b3663896278e..dfa2238e2c28 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -410,10 +410,17 @@ static int __init crash_save_vmcoreinfo_init(void)
	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
 #ifdef CONFIG_SPARSEMEM
+#ifdef CONFIG_SPARSEMEM_EXTREME
+	VMCOREINFO_NUMBER(mem_section);
+#else
	VMCOREINFO_SYMBOL(mem_section);
+#endif
	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);
	VMCOREINFO_STRUCT_SIZE(mem_section);
	VMCOREINFO_OFFSET(mem_section, section_mem_map);

[snip]

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
