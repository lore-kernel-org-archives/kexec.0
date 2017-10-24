Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e6rxI-0001WD-TF
 for kexec@lists.infradead.org; Tue, 24 Oct 2017 05:40:50 +0000
Message-Id: <20171024053901.813846011@redhat.com>
Date: Tue, 24 Oct 2017 13:31:50 +0800
From: dyoung@redhat.com
Subject: [PATCH 3/3] kdump: round up the total memory size to 128M for
 crashkernel reservation
MIME-Version: 1.0
Content-Disposition: inline; filename=kdump-crashkernel-roundup-total-mem.patch
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
Cc: bhe@redhat.com, corbet@lwn.net, yinghai@kernel.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

The total memory size we get in kernel is usually slightly less than 2G with a
2G memory module machine. The main reason is bios/firmware reserve some area
it will not export all memory as usable to Linux.

2G memory X86 kvm guest test result of the total_mem value:
UEFI boot with ovmf: 0x7ef10000
Legacy boot kvm guest: 0x7ff7cc00

An option is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw this up.
Thus we choose to round up total size to 128M to workaround this problem.
This is a best effort workaround, will improve it when we have better way
in the future. 

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kernel/crash_core.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- linux.orig/kernel/crash_core.c
+++ linux/kernel/crash_core.c
@@ -42,6 +42,15 @@ static int __init parse_crashkernel_mem(
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
+	total_mem = roundup(total_mem, 0x8000000);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -86,13 +95,13 @@ static int __init parse_crashkernel_mem(
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
@@ -126,9 +135,9 @@ static int __init parse_crashkernel_mem(
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
