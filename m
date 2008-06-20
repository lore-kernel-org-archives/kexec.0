Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K9iyO-0001bn-Ja
	for kexec@lists.infradead.org; Fri, 20 Jun 2008 15:56:25 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH 3/3] Limit E820 map when a user-defined memory map is specified
Date: Fri, 20 Jun 2008 17:57:00 +0200
Message-Id: <1213977420-1555-4-git-send-email-bwalle@suse.de>
In-Reply-To: <1213977420-1555-1-git-send-email-bwalle@suse.de>
References: <1213977420-1555-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
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
Cc: Bernhard Walle <bwalle@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

This patch brings back limiting of the E820 map when a user-defined
E820 map is specified. While the behaviour of i386 (32 bit) was to limit
the E820 map (and /proc/iomem), the behaviour of x86-64 (64 bit) was not to
limit.

That patch limits the E820 map again for both x86 architectures.

Code was tested for compilation and booting on a 32 bit and 64 bit system.


Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 arch/x86/kernel/e820.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f5b1736..2e7d385 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -934,6 +934,33 @@ static void early_panic(char *msg)
 	panic(msg);
 }
 
+void __init e820_limit_regions(unsigned long long size)
+{
+	unsigned long long current_addr;
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		current_addr = e820.map[i].addr + e820.map[i].size;
+		if (current_addr < size)
+			continue;
+
+		if (e820.map[i].type != E820_RAM)
+			continue;
+
+		if (e820.map[i].addr >= size) {
+			/*
+			 * This region starts past the end of the
+			 * requested size, skip it completely.
+			 */
+			e820.nr_map = i;
+		} else {
+			e820.nr_map = i + 1;
+			e820.map[i].size -= current_addr - size;
+		}
+		return;
+	}
+}
+
 /* "mem=nopentium" disables the 4MB page tables. */
 static int __init parse_memopt(char *p)
 {
@@ -951,6 +978,8 @@ static int __init parse_memopt(char *p)
 
 	mem_size = memparse(p, &p);
 	end_user_pfn = mem_size>>PAGE_SHIFT;
+	e820_limit_regions(mem_size);
+
 	return 0;
 }
 early_param("mem", parse_memopt);
@@ -995,6 +1024,7 @@ static int __init parse_memmap_opt(char *p)
 		e820_add_region(start_at, mem_size, E820_RESERVED);
 	} else {
 		end_user_pfn = (mem_size >> PAGE_SHIFT);
+		e820_limit_regions(mem_size);
 	}
 	return *p == '\0' ? 0 : -EINVAL;
 }
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
