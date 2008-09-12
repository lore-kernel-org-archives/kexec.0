Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]
	helo=relay.sgi.com)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KeEzC-0002UC-SR
	for kexec@lists.infradead.org; Fri, 12 Sep 2008 20:11:23 +0000
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by netops-testserver-3.corp.sgi.com (Postfix) with ESMTP id 4CF1390893
	for <kexec@lists.infradead.org>; Fri, 12 Sep 2008 13:11:22 -0700 (PDT)
Message-ID: <48CACCBA.9030905@sgi.com>
Date: Fri, 12 Sep 2008 13:10:34 -0700
From: Jay Lan <jlan@sgi.com>
MIME-Version: 1.0
Subject: [PATCH]IA64: do not include uncached memory to vmcore
Content-Type: multipart/mixed; boundary="------------010607040108090700060609"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.
--------------010607040108090700060609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Currently a memory segment in memory map with attribute of EFI_MEMORY_UC
is denoted as "System RAM" in /proc/iomem, while memory of attribute
(EFI_MEMORY_WB|EFI_MEMORY_UC) is also labeled the same.

The kexec utility then includes uncached memory as part of vmcore.
The kdump kernel may MCA when it tries to save the vmcore to a disk.
A normal "cached" access can cause MCAs.

Since kexec assembled memory ranges with memory tagged as "System RAM",
the uncached memory will be excluded if it is labeled differently.

Simon, since only IA64 will create "Uncached RAM" label, i do not
make changes to other arch.

Our HP machine in the lab is dead. I am sorry that i can not test
against other IA64 systems (than SGI's). Feedback is very much
appreciated.

The corresponding kernel patch is needed to test this kexec patch:
http://marc.info/?l=linux-ia64&m=122122791230130&w=2
This patch without the kernel patch will have no effect and do no
harm.


Signed-off-by: Jay Lan <jlan@sgi.com>


--------------010607040108090700060609
Content-Type: text/plain;
 name="UC-mem.kexec"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="UC-mem.kexec"

---
 kexec/arch/ia64/crashdump-ia64.c     |    5 ++++-
 kexec/arch/ia64/kexec-ia64.c         |    5 ++++-
 kexec/firmware_memmap.c              |    2 ++
 kexec/kexec.h                        |    1 +
 11 files changed, 27 insertions(+), 3 deletions(-)

Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-10 17:17:57.751956424 -0700
+++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-10 17:18:02.060031443 -0700
@@ -212,8 +212,11 @@ static int get_crash_memory_ranges(struc
 			kernel_code_start = start;
 			kernel_code_end = end;
 			continue;
-		}else
+		} else if (memcmp(str, "Uncached RAM\n", 13) == 0) {
+			type = RANGE_UNCACHED;
+		} else {
 			continue;
+		}
 		crash_memory_range[memory_ranges].start = start;
 		crash_memory_range[memory_ranges].end = end;
 		crash_memory_range[memory_ranges].type = type;
Index: kexec-tools/kexec/kexec.h
===================================================================
--- kexec-tools.orig/kexec/kexec.h	2008-09-10 17:07:20.892688089 -0700
+++ kexec-tools/kexec/kexec.h	2008-09-10 17:18:02.072031652 -0700
@@ -110,6 +110,7 @@ struct memory_range {
 #define RANGE_RESERVED	1
 #define RANGE_ACPI	2
 #define RANGE_ACPI_NVS	3
+#define RANGE_UNCACHED	4
 };
 
 struct kexec_info {
Index: kexec-tools/kexec/arch/ia64/kexec-ia64.c
===================================================================
--- kexec-tools.orig/kexec/arch/ia64/kexec-ia64.c	2008-09-10 17:07:20.892688089 -0700
+++ kexec-tools/kexec/arch/ia64/kexec-ia64.c	2008-09-10 17:18:02.100032140 -0700
@@ -139,8 +139,11 @@ int get_memory_ranges(struct memory_rang
 			memory_ranges = split_range(memory_ranges, start, end);
 			saved_efi_memmap_size = end - start;
 			continue;
-		} else
+		} else if (memcmp(str, "Uncached RAM\n", 13) == 0) {
+			type = RANGE_UNCACHED;
+		} else {
 			continue;
+		}
 		/*
 		 * Check if this memory range can be coalesced with
 		 * the previous range
Index: kexec-tools/kexec/firmware_memmap.c
===================================================================
--- kexec-tools.orig/kexec/firmware_memmap.c	2008-09-10 17:07:20.892688089 -0700
+++ kexec-tools/kexec/firmware_memmap.c	2008-09-10 17:18:02.120032488 -0700
@@ -158,6 +158,8 @@ static int parse_memmap_entry(const char
 		range->type = RANGE_RESERVED;
 	else if (strcmp(type, "ACPI Non-volatile Storage") == 0)
 		range->type = RANGE_ACPI_NVS;
+	else if (strcmp(type, "Uncached RAM") == 0)
+		range->type = RANGE_UNCACHED;
 	else {
 		fprintf(stderr, "Unknown type (%s) while parsing %s. Please "
 			"report this as bug. Using RANGE_RESERVED now.\n",


--------------010607040108090700060609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------010607040108090700060609--

