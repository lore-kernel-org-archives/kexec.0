Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eAS0R-0006zj-UN
 for kexec@lists.infradead.org; Fri, 03 Nov 2017 02:46:53 +0000
Date: Fri, 3 Nov 2017 10:46:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH 3/3 update] kdump: round up the total memory size to 128M for
 crashkernel reservation
Message-ID: <20171103024622.GA5584@dhcp-128-65.nay.redhat.com>
References: <20171024053901.813846011@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171024053901.813846011@redhat.com>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, corbet@lwn.net, bhsharma@redhat.com, akpm@linux-foundation.org, yinghai@kernel.org, vgoyal@redhat.com

The total memory size we get in kernel is usually slightly less than 2G with a
2G memory module machine. The main reason is bios/firmware reserve some area
it will not export all memory as usable to Linux.

2G memory X86 kvm guest test result of the total_mem value:
UEFI boot with ovmf: 0x7ef10000
Legacy boot kvm guest: 0x7ff7cc00
This is also a problem on arm64 UEFI booted system according to my test.

Thus for example crashkernel=1G-2G:128M,  if we have a 1G memory
machine, we get total size 1023M from firmware then it will not fall
into 1G-2G thus no memory reserved.

An option is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw this up.
Thus round up total size to 128M to workaround this problem.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
Changes from previous version of 3/3:
1. improve changelog: add examples why this is a problem (comment from
   Baoquan He)
2. change to use SZ_128M (comment from Bhupesh Sharma)

 kernel/crash_core.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- linux-x86.orig/kernel/crash_core.c
+++ linux-x86/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/crash_core.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/sizes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -42,6 +43,15 @@ static int __init parse_crashkernel_mem(
 {
 	char *cur = cmdline, *tmp;
 	bool infinite_end = false;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware usually reserves some memory regions for it's own use.
+	 * so we get less than actual system memory size.
+	 * We workaround this by round up the total size to 128M which is
+	 * enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -86,13 +96,13 @@ static int __init parse_crashkernel_mem(
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			if (end == ULLONG_MAX)
 				infinite_end = true;
@@ -126,9 +136,9 @@ static int __init parse_crashkernel_mem(
 				pr_warn("Memory reservation scale order expected after '^'\n");
 				return -EINVAL;
 			}
-			size = (system_ram - *crash_size) >> shift;
+			size = (total_mem - *crash_size) >> shift;
 			size = *crash_size + roundup(size, 1ULL << 20);
-			if (size < system_ram)
+			if (size < total_mem)
 				*crash_size = size;
 			cur = tmp;
 		} else

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
