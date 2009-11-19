Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NB9nm-0000x8-7d
	for kexec@lists.infradead.org; Thu, 19 Nov 2009 16:24:15 +0000
Date: Thu, 19 Nov 2009 11:23:29 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump issue with percpu_alloc=lpage
Message-ID: <20091119162329.GA2923@redhat.com>
References: <4AE8B612.9080103@ccur.com> <4B03BD7A.9040500@kernel.org>
	<20091119143343.GB8741@redhat.com> <4B055A05.2010205@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4B055A05.2010205@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Tejun Heo <tj@kernel.org>
Cc: John Blackwood <john.blackwood@ccur.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Thu, Nov 19, 2009 at 11:45:25PM +0900, Tejun Heo wrote:
> Hello,
> 
> 11/19/2009 11:33 PM, Vivek Goyal wrote:
> > I did load a kdump kernel on 32-rc7 and it worked fine. But I guess in
> > this case memory might have come from linearly mapped region.
> > 
> > If the default per cpu allocator can get memory from vmalloc region
> > also, then I think we will need this function which can map virtual
> > address to physical address.
> 
> I see.
> 
> > Are there multiple allocators now? If yes, what are the command line
> > options and I can try to use some other allocator and see if I can force
> > the condition where memory comes from vmalloc region and I observe the
> > crash.
> > 
> > Once I can reproduce it, I can also send you the fix you suggested.
> 
> Now there are two allocators - embed (default) and page.  You can
> choose using percpu_alloc= parameter.  Embed allocator will put the
> first chunk in linear mapping area while page will put the first chunk
> in vmalloc area too but regardless of the allocator from the second
> chunk it will always be in the vmalloc area.  So, either using
> percpu_alloc=page or allocating some amount of percpu memory using
> __alloc_percpu() - a thousand 4k blocks will always be enough - should
> do it.
> 
> Thanks.

Hi Tejun,

I implemented your suggested function. This patch seems to be fixing the
issue. Does it look good to you?

Please let me know if you want me to post it to lkml or you will pull it
in your tree and push it to Linus.

Thanks
Vivek


o kdump functionality reserves a per cpu area at boot time and exports the
  physical address of that area to user space through sys interface. This
  area stores some dump related information like cpu register states etc
  at the time of crash.

o We were assuming that per cpu area always come from linearly mapped meory
  region and using __pa() to determine physical address.
  With percpu_alloc=page, per cpu area can come from vmalloc region also and
  __pa() breaks.

o This patch implements new function to convert per cpu address to physical
  address.

Before the patch, crash_notes addresses looked as follows.

cpu0 60fffff49800
cpu1 60fffff60800
cpu2 60fffff77800

These are bogus phsyical addresses.

After the patch, address are following.

cpu0 13eb44000
cpu1 13eb43000
cpu2 13eb42000
cpu3 13eb41000

These look fine. I got 4G of memory and /proc/iomem tell me following.

100000000-13fffffff : System RAM

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 drivers/base/cpu.c     |    2 +-
 include/linux/percpu.h |    2 ++
 mm/percpu.c            |    9 +++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

Index: linux9/mm/percpu.c
===================================================================
--- linux9.orig/mm/percpu.c	2009-11-12 19:46:07.000000000 -0500
+++ linux9/mm/percpu.c	2009-11-19 10:55:35.000000000 -0500
@@ -2069,3 +2069,12 @@ void __init setup_per_cpu_areas(void)
 		__per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
 }
 #endif /* CONFIG_HAVE_SETUP_PER_CPU_AREA */
+
+unsigned long long per_cpu_ptr_to_phys(void *addr)
+{
+	if ((unsigned long)addr < VMALLOC_START ||
+			(unsigned long)addr >= VMALLOC_END)
+		return __pa(addr);
+	else
+		return page_to_phys(vmalloc_to_page(addr));
+}
Index: linux9/include/linux/percpu.h
===================================================================
--- linux9.orig/include/linux/percpu.h	2009-11-12 19:46:07.000000000 -0500
+++ linux9/include/linux/percpu.h	2009-11-19 10:55:47.000000000 -0500
@@ -32,6 +32,8 @@
 	&__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
+extern unsigned long long per_cpu_ptr_to_phys(void *addr);
+
 #ifdef CONFIG_SMP
 
 #ifndef CONFIG_HAVE_LEGACY_PER_CPU_AREA
Index: linux9/drivers/base/cpu.c
===================================================================
--- linux9.orig/drivers/base/cpu.c	2009-11-12 19:46:07.000000000 -0500
+++ linux9/drivers/base/cpu.c	2009-11-19 10:54:08.000000000 -0500
@@ -97,7 +97,7 @@ static ssize_t show_crash_notes(struct s
 	 * boot up and this data does not change there after. Hence this
 	 * operation should be safe. No locking required.
 	 */
-	addr = __pa(per_cpu_ptr(crash_notes, cpunum));
+	addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpunum));
 	rc = sprintf(buf, "%Lx\n", addr);
 	return rc;
 }

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
