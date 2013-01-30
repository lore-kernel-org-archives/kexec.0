Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0aFA-0002WB-MK
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:10:40 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] x86 e820: Introduce memmap=kdump_reserve_usable for kdump
 usage
Date: Wed, 30 Jan 2013 17:10:27 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
 <201301301703.42601.trenn@suse.de>
In-Reply-To: <201301301703.42601.trenn@suse.de>
MIME-Version: 1.0
Message-Id: <201301301710.27822.trenn@suse.de>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai@kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, x86@kernel.org, vgoyal@redhat.com

kdump voided the whole original e820 map and half way made
it up via memmap= options passed via kdump boot params again.

But this is conceptionally wrong. The whole original memory ranges
which are declared reserved, ACPI data/nvs or however are not usable
must stay the same and get honored by the kdump kernel.

Therefore memmap=kdump_reserve_usable gets introduced.
kdump passes this one and originally usable memory gets converted
by the kernel to the Linux kernel specific kdump reserved e820 type.
kdump passes the usable memory ranges where the kdump kernel resides
in via memmap=x@y parameter(s).

This preserves all e820 information and the kdump kernel can look
it up and be sure it is valid.
It also cleans up unnecessary memmap= boot parameter passing of
reserved memory areas via kexec-tools. This information is already
passed via boot structures.

This also fixes mmconf (extended PCI config access) and
possibly other kernel parts which rely on remapped memory to be
in reserved or ACPI (data/nvs) declared e820 memory areas.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 Documentation/kernel-parameters.txt |    9 +++++++++
 arch/x86/kernel/e820.c              |   22 ++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index da0e077..f38375a 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1518,6 +1518,15 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			BIOS output or other requirements. See the memmap=nn@ss
 			option description.
 
+	memmap=kdump_reserve_usable
+			[KNL,X86] Convert usable memory areas into a special
+			Linux kernel specific kdump reserved type.
+			Usable memory areas the kdump kernel resides in have
+			to be passed via memmap=X@Y parameters which overrides
+			these areas again to be usable.
+			This boot parameter is intended for kdump usage.
+			Passing exactmap overrules kdump_reserve_usable.
+
 	memmap=nn[KMG]@ss[KMG]
 			[KNL] Force usage of a specific region of memory
 			Region of memory to be used, from ss to ss+nn.
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7c6a72e..9c00bfa 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -839,6 +839,7 @@ static int __init parse_memopt(char *p)
 early_param("mem", parse_memopt);
 
 static bool __initdata exactmap_parsed;
+static bool __initdata kdump_res_parsed;
 
 static int __init parse_memmap_one(char *p)
 {
@@ -848,7 +849,8 @@ static int __init parse_memmap_one(char *p)
 	if (!p)
 		return -EINVAL;
 
-	if (!strncmp(p, "exactmap", 8)) {
+	if (!strncmp(p, "exactmap", 8) ||
+	    !strncmp(p, "kdump_reserve_usable", 20)) {
 		if (exactmap_parsed)
 			return 0;
 
@@ -861,7 +863,13 @@ static int __init parse_memmap_one(char *p)
 		 */
 		saved_max_pfn = e820_end_of_ram_pfn();
 #endif
-		e820.nr_map = 0;
+		if (!strncmp(p, "kdump_reserve_usable", 20)) {
+			/* remove all old E820_RAM ranges */
+			e820_update_range(0, ULLONG_MAX, E820_RAM,
+					  E820_RESERVED_KDUMP);
+			kdump_res_parsed = true;
+		} else
+			e820.nr_map = 0;
 		userdef = 1;
 		return 0;
 	}
@@ -874,6 +882,11 @@ static int __init parse_memmap_one(char *p)
 	userdef = 1;
 	if (*p == '@') {
 		start_at = memparse(p+1, &p);
+		if (kdump_res_parsed) {
+			/* Remove old reserved so new ram could take over. */
+			e820_remove_range(start_at, mem_size,
+					  E820_RESERVED_KDUMP, 0);
+		}
 		e820_add_region(start_at, mem_size, E820_RAM);
 	} else if (*p == '#') {
 		start_at = memparse(p+1, &p);
@@ -893,6 +906,11 @@ static int __init parse_memmap_opt(char *str)
 	p = strstr(p, "exactmap");
 	if (p)
 		parse_memmap_one("exactmap");
+	else {
+		p = strstr(boot_command_line, "kdump_reserve_usable");
+		if (p)
+			parse_memmap_one("kdump_reserve_usable");
+	}
 
 	while (str) {
 		char *k = strchr(str, ',');

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
