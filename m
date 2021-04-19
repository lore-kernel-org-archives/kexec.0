Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYPde-00BCzh-Uc
 for kexec@lists.infradead.org; Mon, 19 Apr 2021 08:52:19 +0000
Date: Mon, 19 Apr 2021 10:52:02 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [patch] x86/crash: fix crash_setup_memmap_entries()
 out-of-bounds access
Message-ID: <20210419085202.GB9093@zn.tnic>
References: <20210416110701.GA3835@dhcp-128-65.nay.redhat.com>
 <063a63ddea914ac654cbe9a1d1d6c76986af7882.camel@gmx.de>
 <20210416114708.GB79779@dhcp-128-65.nay.redhat.com>
 <725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de>
 <20210416121636.GA22348@zn.tnic>
 <a853ea8535151fd8b267d8e68a45b33748978d8a.camel@gmx.de>
 <20210416144459.GB22348@zn.tnic>
 <7826c19ecd583700f56d2db33360e8032e812ecf.camel@gmx.de>
 <87sg3puco5.ffs@nanos.tec.linutronix.de>
 <d725b19b4c02273eaab38a10853fa6fb6d5bc76c.camel@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d725b19b4c02273eaab38a10853fa6fb6d5bc76c.camel@gmx.de>
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
To: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, DaveYoung <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>

Here's an attempt to explain what this fixes:

---
From: Mike Galbraith <efault@gmx.de>
Date: Fri, 16 Apr 2021 14:02:07 +0200
Subject: [PATCH] x86/crash: Fix crash_setup_memmap_entries() out-of-bounds
 access

Commit in Fixes: added support for kexec-ing a kernel on panic using a
new system call. As part of it, it does prepare a memory map for the new
kernel.

However, while doing so, it wrongly accesses memory it has not
allocated: it accesses the first element of the cmem->ranges[] array in
memmap_exclude_ranges() but it has not allocated the memory for it in
crash_setup_memmap_entries(). As KASAN reports:

  BUG: KASAN: vmalloc-out-of-bounds in crash_setup_memmap_entries+0x17e/0x3a0
  Write of size 8 at addr ffffc90000426008 by task kexec/1187

  (gdb) list *crash_setup_memmap_entries+0x17e
  0xffffffff8107cafe is in crash_setup_memmap_entries (arch/x86/kernel/crash.c:322).
  317                                      unsigned long long mend)
  318     {
  319             unsigned long start, end;
  320
  321             cmem->ranges[0].start = mstart;
  322             cmem->ranges[0].end = mend;
  323             cmem->nr_ranges = 1;
  324
  325             /* Exclude elf header region */
  326             start = image->arch.elf_load_addr;
  (gdb)

Make sure the ranges array becomes a single element allocated.

 [ bp: Write a proper commit message. ]

Fixes: dd5f726076cc ("kexec: support for kexec on panic using new system call")
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/725fa3dc1da2737f0f6188a1a9701bead257ea9d.camel@gmx.de
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index a8f3af257e26..b1deacbeb266 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -337,7 +337,7 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	struct crash_memmap_data cmd;
 	struct crash_mem *cmem;
 
-	cmem = vzalloc(sizeof(struct crash_mem));
+	cmem = vzalloc(struct_size(cmem, ranges, 1));
 	if (!cmem)
 		return -ENOMEM;
 
-- 
2.29.2

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
