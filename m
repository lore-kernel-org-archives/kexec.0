Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDbN6-0000of-T7
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 14:00:37 +0000
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
 by g1t0026.austin.hp.com (Postfix) with ESMTP id A973BC2FF
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 14:00:32 +0000 (UTC)
Subject: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to
 speedup kernel dump process
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 07 Mar 2013 22:00:29 +0800
Message-ID: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
MIME-Version: 1.0
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
To: kexec@lists.infradead.org
Cc: lisa.mitchell@hp.com

This patch intend to speedup the memory pages scanning process in
selective dump mode.

Test result (On HP ProLiant DL980 G7 with 1TB RAM, makedumpfile
v1.5.3):

						Total scan Time
Original kernel
	+ makedumpfile v1.5.3 cyclic mode	1958.05 seconds
Original kernel
	+ makedumpfile v1.5.3 non-cyclic mode	1151.50 seconds
Patched kernel
	+ patched makedumpfile v1.5.3		17.50 seconds

Traditionally, to reduce the size of dump file, dumper scans all memory
pages to exclude the unnecessary memory pages after capture kernel
booted, and scan it in userspace code (makedumpfile).

It introduces several problems:

1. Requires more memory to store memory bitmap on systems with large
amount of memory installed. And in capture kernel there is only a few
free memory available, it will cause an out of memory error and fail.
(Non-cyclic mode)

2. Scans all memory pages in makedumpfile is a very slow process. On
system with 1TB or more memory installed, the scanning process is very
long. Typically on 1TB idle system, it takes about 19 minutes. On system
with 4TB or more memory installed, it even doesn't work. To address the
out of memory issue on system with big memory (4TB or more memory
installed),  makedumpfile v1.5.1 introduces a new cyclic mode. It only
scans a piece of memory pages each time, and do it cyclically to scan
all memory pages. But it runs more slowly, on 1TB system, takes about 33
minutes.

3. Scans memory pages code in makedumpfile is very complicated, without
kernel memory management related data structure, makedumpfile has to
build up its own data structure, and will not able to use some macros
that only be available in kernel (e.g. page_to_pfn), and has to use some
slow lookup algorithm instead.

This patch introduces a new way to scan memory pages. It reserves a
piece of memory (1 bit for each page, 32MB per TB memory on x86 systems)
in the first kernel. During the kernel crash process, it scans all
memory pages, clear the bit for all excluded memory pages in the
reserved memory.

We have several benefits by this new approach:

1. It's extremely fast, on 1TB system only takes about 17.5 seconds to
scan all memory pages!

2. Reduces the memory requirement of makedumpfile by putting the
reserved memory in the first kernel memory space.

3. Simplifies the complexity of existing memory pages scanning code in
userspace.

To do:
1. It only has been verified on x86 64bit platform, needs to be modified
for other platforms. (ARM, XEN, PPC, etc...)

---

Jingbai Ma (5):
      crash dump bitmap: add a kernel config and help document
      crash dump bitmap: init crash dump bitmap in kernel booting process
      crash dump bitmap: scan memory pages in kernel crash process
      crash dump bitmap: add a proc interface for crash dump bitmap
      crash dump bitmap: workaround for kernel 3.9-rc1 kdump issue


 Documentation/kdump/crash_dump_bitmap.txt |  378 +++++++++++++++++++++++++++++
 arch/x86/Kconfig                          |   16 +
 arch/x86/kernel/setup.c                   |   62 +++++
 fs/proc/Makefile                          |    1 
 fs/proc/crash_dump_bitmap.c               |  221 +++++++++++++++++
 include/linux/crash_dump_bitmap.h         |   59 +++++
 kernel/Makefile                           |    1 
 kernel/crash_dump_bitmap.c                |  201 +++++++++++++++
 kernel/kexec.c                            |    5 
 9 files changed, 943 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/kdump/crash_dump_bitmap.txt
 create mode 100644 fs/proc/crash_dump_bitmap.c
 create mode 100644 include/linux/crash_dump_bitmap.h
 create mode 100644 kernel/crash_dump_bitmap.c

--
Jingbai Ma <jingbai.ma@hp.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
