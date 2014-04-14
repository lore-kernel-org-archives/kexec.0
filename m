Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WZiJ8-0001Wq-Rk
 for kexec@lists.infradead.org; Mon, 14 Apr 2014 14:56:27 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH v6 7/9] x86, cleanup: kexec memory range .end to be inclusive
Date: Mon, 14 Apr 2014 22:55:39 +0800
Message-Id: <1397487341-17287-8-git-send-email-chaowang@redhat.com>
In-Reply-To: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
References: <1397487341-17287-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au, vgoyal@redhat.com, ebiederm@xmission.com, hpa@zytor.com, trenn@suse.de, dyoung@redhat.com, linn@hp.com
Cc: kexec@lists.infradead.org

Later kexec and kdump memory range will be mapped to E820entry. But
currently kexec memory range .end field is exclusive while crash memory
range is inclusive.

Given the fact that the exported proc iomem and sysfs memmap are both
inclusive, change kexec memory range .end to be inclusive. Later the
unified memory range of both kexec and kdump can use the same E820
filling code.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/arch/i386/kexec-x86-common.c | 3 +--
 kexec/arch/i386/x86-linux-setup.c  | 2 +-
 kexec/firmware_memmap.c            | 1 -
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index e416177..bc622e9 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -79,7 +79,6 @@ static int get_memory_ranges_proc_iomem(struct memory_range **range, int *ranges
 		if (count != 2)
 			continue;
 		str = line + consumed;
-		end = end + 1;
 
 		dbgprintf("%016Lx-%016Lx : %s", start, end, str);
 
@@ -188,7 +187,7 @@ static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 
 	for (i = 0; i < rc; ++i) {
 		memory_range[i].start = e820entries[i].addr;
-		memory_range[i].end = e820entries[i].addr + e820entries[i].size;
+		memory_range[i].end = e820entries[i].addr + e820entries[i].size - 1;
 		memory_range[i].type = xen_e820_to_kexec_type(e820entries[i].type);
 	}
 
diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-setup.c
index 8ed36cc..9f8355f 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -784,7 +784,7 @@ void setup_linux_system_parameters(struct kexec_info *info,
 	real_mode->e820_map_nr = ranges;
 	for(i = 0; i < ranges; i++) {
 		real_mode->e820_map[i].addr = range[i].start;
-		real_mode->e820_map[i].size = range[i].end - range[i].start;
+		real_mode->e820_map[i].size = range[i].end - range[i].start + 1;
 		switch (range[i].type) {
 		case RANGE_RAM:
 			real_mode->e820_map[i].type = E820_RAM; 
diff --git a/kexec/firmware_memmap.c b/kexec/firmware_memmap.c
index 9598933..6be3c7c 100644
--- a/kexec/firmware_memmap.c
+++ b/kexec/firmware_memmap.c
@@ -145,7 +145,6 @@ static int parse_memmap_entry(const char *entry, struct memory_range *range)
 	range->end = parse_numeric_sysfs(filename);
 	if (range->end == ULLONG_MAX)
 		return -1;
-	range->end++; /* inclusive vs. exclusive ranges */
 
 	/*
 	 * entry/type
-- 
1.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
