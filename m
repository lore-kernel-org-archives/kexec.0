Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qc0-x22a.google.com ([2607:f8b0:400d:c01::22a])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WFwAE-0007w7-TS
 for kexec@lists.infradead.org; Wed, 19 Feb 2014 01:41:31 +0000
Received: by mail-qc0-f170.google.com with SMTP id e9so26957471qcy.15
 for <kexec@lists.infradead.org>; Tue, 18 Feb 2014 17:41:09 -0800 (PST)
MIME-Version: 1.0
Date: Tue, 18 Feb 2014 17:41:09 -0800
Message-ID: <CAMBSHm9PtrthK+VvddYenWVgWmE00cQUkROAVPxsKkMnYs_KMw@mail.gmail.com>
Subject: Kexec on mips64
From: Matthew Fleming <mdf356@gmail.com>
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
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

I've been working on kexec into a kdump kernel on mips64 for work.
Since kexec isn't supported by Cavium on the 2.3 SDK, I'm a bit on my
own.  Based on patches from Cavium, I can get the system to crash and
boot into the kdump kernel, and come up to a shell on the console.
However, gdb on /proc/vmcore basically doesn't work for me.

One issue is that x/w on various kernel addresses doesn't work.  I
traced it to what looks like a bug in the kexec binary when it sets up
the elf notes.  The below patch seems to fix the issue, but I wonder
why this has not been seen by others.

I'm still using the kexec-tools-2.0.4 sources, but the is no
difference between 2.0.4 and 2.0.5 in this file.  2.0.5 threw an error
when trying to load the kernel and I haven't had time to debug that
yet, so I've been proceeding with 2.0.4.

Thanks,
matthew



diff -r -U8 --show-c-func
/tmp/kexec-tools-2.0.4/kexec/arch/mips/crashdump-mips.h
/home/sciadmin/workspace/ws_mdf_kdump/target/cavium/SDK/2.3/linux/embedded_rootfs/build/kexec-tools-2.0.4/kexec/arch/mips/crashdump-mips.h
--- /tmp/kexec-tools-2.0.4/kexec/arch/mips/crashdump-mips.h 2011-10-02
15:56:38.000000000 -0700
+++ /home/sciadmin/workspace/ws_mdf_kdump/target/cavium/SDK/2.3/linux/embedded_rootfs/build/kexec-tools-2.0.4/kexec/arch/mips/crashdump-mips.h
2014-02-18 17:00:27.848982998 -0800
@@ -1,23 +1,23 @@
 #ifndef CRASHDUMP_MIPS_H
 #define CRASHDUMP_MIPS_H

 struct kexec_info;
 int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline,
  unsigned long max_addr, unsigned long min_base);
 #ifdef __mips64
 #define PAGE_OFFSET 0xa800000000000000ULL
+#define MAXMEM 0
 #else
 #define PAGE_OFFSET 0x80000000
+#define MAXMEM 0x80000000
 #endif
 #define __pa(x) ((unsigned long)(X) & 0x7fffffff)

-#define MAXMEM 0x80000000
-
 #define CRASH_MAX_MEMMAP_NR (KEXEC_MAX_SEGMENTS + 1)
 #define CRASH_MAX_MEMORY_RANGES (MAX_MEMORY_RANGES + 2)

 #define COMMAND_LINE_SIZE 512

 /* Backup Region, First 1M of System RAM. */
 #define BACKUP_SRC_START 0x00000000
 #define BACKUP_SRC_END 0x000fffff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
