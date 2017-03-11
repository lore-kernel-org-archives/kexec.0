Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.redfish-solutions.com ([66.232.79.143])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cmXSU-0001PI-4T
 for kexec@lists.infradead.org; Sat, 11 Mar 2017 03:12:44 +0000
From: "Philip Prindeville" <philipp@redfish-solutions.com>
Subject: [PATCH v2 1/1] Don't use %L width specifier with integer values
Date: Fri, 10 Mar 2017 20:12:15 -0700
Message-Id: <20170311031215.3628-1-philipp@redfish-solutions.com>
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
To: kexec@lists.infradead.org
Cc: Philip Prindeville <philipp@fedoraproject.org>, Philip Prindeville <philipp@redfish-solutions.com>

From: Philip Prindeville <philipp@redfish-solutions.com>

MUSL doesn't support %L except for floating-point arguments; therefore,
%ll must be used instead with integer arguments.

Signed-off-by: Philip Prindeville <philipp@redfish-solutions.com>
---
 kexec/arch/arm/kexec-arm.c           | 2 +-
 kexec/arch/i386/crashdump-x86.c      | 8 ++++----
 kexec/arch/i386/kexec-x86-common.c   | 2 +-
 kexec/arch/ia64/kexec-elf-rel-ia64.c | 2 +-
 kexec/arch/mips/crashdump-mips.c     | 2 +-
 kexec/arch/mips/kexec-mips.c         | 2 +-
 kexec/arch/s390/kexec-s390.c         | 2 +-
 kexec/crashdump.c                    | 8 ++++----
 kexec/kexec-iomem.c                  | 2 +-
 9 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/kexec/arch/arm/kexec-arm.c b/kexec/arch/arm/kexec-arm.c
index 2194b7cbfcb7a6a103d6f780e4e6515e95006ccc..49f35b11b21c6564a77ea93e388f2612e2c17317 100644
--- a/kexec/arch/arm/kexec-arm.c
+++ b/kexec/arch/arm/kexec-arm.c
@@ -47,7 +47,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 		int count;
 		if (memory_ranges >= MAX_MEMORY_RANGES)
 			break;
-		count = sscanf(line, "%Lx-%Lx : %n",
+		count = sscanf(line, "%llx-%llx : %n",
 			&start, &end, &consumed);
 		if (count != 2)
 			continue;
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index c4cf2013a00107e960e921225aa593f465f3164d..285dea9abd4b19c4733851f91cbed90e789327ba 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -119,7 +119,7 @@ static unsigned long long get_kernel_sym(const char *symbol)
 	}
 
 	while(fgets(line, sizeof(line), fp) != NULL) {
-		if (sscanf(line, "%Lx %c %s", &vaddr, &type, sym) != 3)
+		if (sscanf(line, "%llx %c %s", &vaddr, &type, sym) != 3)
 			continue;
 		if (strcmp(sym, symbol) == 0) {
 			dbgprintf("kernel symbol %s vaddr = %16llx\n", symbol, vaddr);
@@ -296,12 +296,12 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 
 		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
 			break;
-		count = sscanf(line, "%Lx-%Lx : %n",
+		count = sscanf(line, "%llx-%llx : %n",
 			&start, &end, &consumed);
 		if (count != 2)
 			continue;
 		str = line + consumed;
-		dbgprintf("%016Lx-%016Lx : %s",
+		dbgprintf("%016llx-%016llx : %s",
 			start, end, str);
 		/* Only Dumping memory of type System RAM. */
 		if (memcmp(str, "System RAM\n", 11) == 0) {
@@ -778,7 +778,7 @@ static int get_crash_notes(int cpu, uint64_t *addr, uint64_t *len)
 		*addr = x86__pa(vaddr + (cpu * MAX_NOTE_BYTES));
 		*len = MAX_NOTE_BYTES;
 
-		dbgprintf("crash_notes addr = %Lx\n",
+		dbgprintf("crash_notes addr = %llx\n",
 			  (unsigned long long)*addr);
 
 		fclose(fp);
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 3e97239c0c78b49523bbddab346abd7d138b5a9c..be03618770f784bb13dbf49218f87e56d6eba0a0 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -81,7 +81,7 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 		int count;
 		if (memory_ranges >= MAX_MEMORY_RANGES)
 			break;
-		count = sscanf(line, "%Lx-%Lx : %n",
+		count = sscanf(line, "%llx-%llx : %n",
 			&start, &end, &consumed);
 		if (count != 2)
 			continue;
diff --git a/kexec/arch/ia64/kexec-elf-rel-ia64.c b/kexec/arch/ia64/kexec-elf-rel-ia64.c
index 7f7c08cba4b14c3ed847e2be511b09faf554e12f..500f2473ee38f79508012b43b49ae0c75c0d8a19 100644
--- a/kexec/arch/ia64/kexec-elf-rel-ia64.c
+++ b/kexec/arch/ia64/kexec-elf-rel-ia64.c
@@ -155,6 +155,6 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr,
 	}
 	return;
 overflow:
-	die("overflow in relocation type %lu val %Lx\n", 
+	die("overflow in relocation type %lu val %llx\n",
 			r_type, value);
 }
diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
index 9c33599a34ed6f1a4a280173deb1e9a9a38ee44a..6308ec81276f0a8a1a61bb907054bddcd7a4f93e 100644
--- a/kexec/arch/mips/crashdump-mips.c
+++ b/kexec/arch/mips/crashdump-mips.c
@@ -173,7 +173,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		int type, consumed, count;
 		if (memory_ranges >= CRASH_MAX_MEMORY_RANGES)
 			break;
-		count = sscanf(line, "%Lx-%Lx : %n",
+		count = sscanf(line, "%llx-%llx : %n",
 			&start, &end, &consumed);
 		if (count != 2)
 			continue;
diff --git a/kexec/arch/mips/kexec-mips.c b/kexec/arch/mips/kexec-mips.c
index ee3cd3a8b6ebc69dfcd7c90d10bd16d7d60760ee..2e5b700da1ed36a9268ffec7ef80f23aee46d78f 100644
--- a/kexec/arch/mips/kexec-mips.c
+++ b/kexec/arch/mips/kexec-mips.c
@@ -48,7 +48,7 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	while (fgets(line, sizeof(line), fp) != 0) {
 		if (memory_ranges >= MAX_MEMORY_RANGES)
 			break;
-		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
+		count = sscanf(line, "%llx-%llx : %n", &start, &end, &consumed);
 		if (count != 2)
 			continue;
 		str = line + consumed;
diff --git a/kexec/arch/s390/kexec-s390.c b/kexec/arch/s390/kexec-s390.c
index f863483ce8084187c625ad407c23a19a8928a80a..33ba6b970664323af096d2305be1ce596cfa72d6 100644
--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -170,7 +170,7 @@ int get_memory_ranges_s390(struct memory_range memory_range[], int *ranges,
 		if (current_range == MAX_MEMORY_RANGES)
 			break;
 
-		sscanf(line,"%Lx-%Lx : %n", &start, &end, &cons);
+		sscanf(line,"%llx-%llx : %n", &start, &end, &cons);
 		str = line+cons;
 		if ((memcmp(str, sys_ram, strlen(sys_ram)) == 0) ||
 		    ((memcmp(str, crash_kernel, strlen(crash_kernel)) == 0) &&
diff --git a/kexec/crashdump.c b/kexec/crashdump.c
index 15c11051fb98b365fc2f4fb1b54642052b796bb8..0b363c503833d419d31eeb0b6b61ca46934a81b1 100644
--- a/kexec/crashdump.c
+++ b/kexec/crashdump.c
@@ -98,7 +98,7 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 	}
 	if (!fgets(line, sizeof(line), fp))
 		die("Cannot parse %s: %s\n", crash_notes, strerror(errno));
-	count = sscanf(line, "%Lx", &temp);
+	count = sscanf(line, "%llx", &temp);
 	if (count != 1)
 		die("Cannot parse %s: %s\n", crash_notes, strerror(errno));
 	*addr = (uint64_t) temp;
@@ -112,7 +112,7 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 		if (!fgets(line, sizeof(line), fp))
 			die("Cannot parse %s: %s\n",
 			    crash_notes_size, strerror(errno));
-		count = sscanf(line, "%Lu", &temp);
+		count = sscanf(line, "%llu", &temp);
 		if (count != 1)
 			die("Cannot parse %s: %s\n",
 			    crash_notes_size, strerror(errno));
@@ -120,7 +120,7 @@ int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len)
 		fclose(fp);
 	}
 
-	dbgprintf("%s: crash_notes addr = %Lx, size = %Lu\n", __FUNCTION__,
+	dbgprintf("%s: crash_notes addr = %llx, size = %llu\n", __FUNCTION__,
 		  (unsigned long long)*addr, (unsigned long long)*len);
 
 	return 0;
@@ -141,7 +141,7 @@ static int get_vmcoreinfo(const char *kdump_info, uint64_t *addr, uint64_t *len)
 
 	if (!fgets(line, sizeof(line), fp))
 		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
-	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
+	count = sscanf(line, "%llx %llx", &temp, &temp2);
 	if (count != 2)
 		die("Cannot parse %s: %s\n", kdump_info, strerror(errno));
 
diff --git a/kexec/kexec-iomem.c b/kexec/kexec-iomem.c
index 485a2e810080e20f8af447ab900c7481a361915b..7ec385371a2c188020cf54e10b8d1867400771ea 100644
--- a/kexec/kexec-iomem.c
+++ b/kexec/kexec-iomem.c
@@ -44,7 +44,7 @@ int kexec_iomem_for_each_line(char *match,
 		die("Cannot open %s\n", iomem);
 
 	while(fgets(line, sizeof(line), fp) != 0) {
-		count = sscanf(line, "%Lx-%Lx : %n", &start, &end, &consumed);
+		count = sscanf(line, "%llx-%llx : %n", &start, &end, &consumed);
 		if (count != 2)
 			continue;
 		str = line + consumed;
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
