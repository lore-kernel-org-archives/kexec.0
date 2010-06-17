Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OPI4C-0006LC-9G
	for kexec@lists.infradead.org; Thu, 17 Jun 2010 16:35:49 +0000
Received: from estes.americas.sgi.com (estes.americas.sgi.com [128.162.236.10])
	by relay2.corp.sgi.com (Postfix) with ESMTP id B26EF304097
	for <kexec@lists.infradead.org>; Thu, 17 Jun 2010 09:35:44 -0700 (PDT)
Received: from eag09.americas.sgi.com (eag09.americas.sgi.com [128.162.232.15])
	by estes.americas.sgi.com (Postfix) with ESMTP id 97C2D7000784
	for <kexec@lists.infradead.org>; Thu, 17 Jun 2010 11:35:44 -0500 (CDT)
Received: from cpw by eag09.americas.sgi.com with local (Exim 4.69)
	(envelope-from <cpw@sgi.com>) id 1OPI5S-0007ip-Iq
	for kexec@lists.infradead.org; Thu, 17 Jun 2010 11:37:06 -0500
Subject: [PATCH] kexec: Unusable memory range type
Message-Id: <E1OPI5S-0007ip-Iq@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Thu, 17 Jun 2010 11:37:06 -0500
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org


On SGI UV (x86_64) kexec grumbles about 'Unusable memory' ranges:
   Unknown type (%s) while parsing %s. Please "
   "report this as bug. Using RANGE_RESERVED now.

uv44-sys:~ # cat /proc/iomem
00000000-00000fff : System RAM
00001000-00005fff : reserved
00006000-0008efff : System RAM
0008f000-0008ffff : ACPI Non-volatile Storage
00090000-0009ffff : System RAM
00100000-75ffcfff : System RAM
  01000000-0139dcaf : Kernel code
  0139dcb0-0192c12f : Kernel data
  01a28000-01cd7777 : Kernel bss
  02000000-09ffffff : Crash kernel
75ffd000-76013fff : Unusable memory
76014000-766a6fff : System RAM
766a7000-766d6fff : Unusable memory
...

This patch keeps Unusable memory as another RANGE_RESERVED area, but
without the warning message.

Diffed against git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools.git

Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 kexec/firmware_memmap.c |    2 ++
 1 file changed, 2 insertions(+)

Index: kexec-tools/kexec/firmware_memmap.c
===================================================================
--- kexec-tools.orig/kexec/firmware_memmap.c
+++ kexec-tools/kexec/firmware_memmap.c
@@ -161,6 +161,8 @@ static int parse_memmap_entry(const char
 		range->type = RANGE_RAM;
 	else if (strcmp(type, "ACPI Tables") == 0)
 		range->type = RANGE_ACPI;
+	else if (strcmp(type, "Unusable memory") == 0)
+		range->type = RANGE_RESERVED;
 	else if (strcmp(type, "reserved") == 0)
 		range->type = RANGE_RESERVED;
 	else if (strcmp(type, "Unusable memory") == 0)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
