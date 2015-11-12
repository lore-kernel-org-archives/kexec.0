Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zx19a-0007y6-PT
 for kexec@lists.infradead.org; Thu, 12 Nov 2015 23:19:44 +0000
From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 028/155] x86/kexec: Fix kexec crash in syscall
 kexec_file_load()
Date: Thu, 12 Nov 2015 15:16:22 -0800
Message-Id: <1447370309-357-29-git-send-email-kamal@canonical.com>
In-Reply-To: <1447370309-357-1-git-send-email-kamal@canonical.com>
References: <1447370309-357-1-git-send-email-kamal@canonical.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Viresh Kumar <viresh.kumar@linaro.org>, Kamal Mostafa <kamal@canonical.com>, Mike Galbraith <efault@gmx.de>, kexec@lists.infradead.org, Ingo Molnar <mingo@kernel.org>, "Lee,
 Chun-Yi" <jlee@suse.com>, Takashi Iwai <tiwai@suse.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Jiang Liu <jiang.liu@linux.intel.com>, Vivek Goyal <vgoyal@redhat.com>

3.19.8-ckt10 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>

commit e3c41e37b0f4b18cbd4dac76cbeece5a7558b909 upstream.

The original bug is a page fault crash that sometimes happens
on big machines when preparing ELF headers:

    BUG: unable to handle kernel paging request at ffffc90613fc9000
    IP: [<ffffffff8103d645>] prepare_elf64_ram_headers_callback+0x165/0x260

The bug is caused by us under-counting the number of memory ranges
and subsequently not allocating enough ELF header space for them.
The bug is typically masked on smaller systems, because the ELF header
allocation is rounded up to the next page.

This patch modifies the code in fill_up_crash_elf_data() by using
walk_system_ram_res() instead of walk_system_ram_range() to correctly
count the max number of crash memory ranges. That's because the
walk_system_ram_range() filters out small memory regions that
reside in the same page, but walk_system_ram_res() does not.

Here's how I found the bug:

After tracing prepare_elf64_headers() and prepare_elf64_ram_headers_callback(),
the code uses walk_system_ram_res() to fill-in crash memory regions information
to the program header, so it counts those small memory regions that
reside in a page area.

But, when the kernel was using walk_system_ram_range() in
fill_up_crash_elf_data() to count the number of crash memory regions,
it filters out small regions.

I printed those small memory regions, for example:

  kexec: Get nr_ram ranges. vaddr=0xffff880077592258 paddr=0x77592258, sz=0xdc0

Based on the code in walk_system_ram_range(), this memory region
will be filtered out:

  pfn = (0x77592258 + 0x1000 - 1) >> 12 = 0x77593
  end_pfn = (0x77592258 + 0xfc0 -1 + 1) >> 12 = 0x77593
  end_pfn - pfn = 0x77593 - 0x77593 = 0  <=== if (end_pfn > pfn) is FALSE

So, the max_nr_ranges that's counted by the kernel doesn't include
small memory regions - causing us to under-allocate the required space.
That causes the page fault crash that happens in a later code path
when preparing ELF headers.

This bug is not easy to reproduce on small machines that have few
CPUs, because the allocated page aligned ELF buffer has more free
space to cover those small memory regions' PT_LOAD headers.

Signed-off-by: Lee, Chun-Yi <jlee@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Link: http://lkml.kernel.org/r/1443531537-29436-1-git-send-email-jlee@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/x86/kernel/crash.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index aceb2f9..58a47b5 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -184,10 +184,9 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_KEXEC_FILE
-static int get_nr_ram_ranges_callback(unsigned long start_pfn,
-				unsigned long nr_pfn, void *arg)
+static int get_nr_ram_ranges_callback(u64 start, u64 end, void *arg)
 {
-	int *nr_ranges = arg;
+	unsigned int *nr_ranges = arg;
 
 	(*nr_ranges)++;
 	return 0;
@@ -213,7 +212,7 @@ static void fill_up_crash_elf_data(struct crash_elf_data *ced,
 
 	ced->image = image;
 
-	walk_system_ram_range(0, -1, &nr_ranges,
+	walk_system_ram_res(0, -1, &nr_ranges,
 				get_nr_ram_ranges_callback);
 
 	ced->max_nr_ranges = nr_ranges;
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
