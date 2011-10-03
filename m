Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([2406:a000:f000:9500::1])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RAWyS-000582-FJ
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 01:05:43 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH v2] sh: Take into account the base of System RAM in
	virt_to_phys()
Date: Mon,  3 Oct 2011 10:05:18 +0900
Message-Id: <1317603918-30762-1-git-send-email-horms@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Previously virt_to_phys() assumed that physical memory always started
at address 0. This is not always the case.

Tested on an sh7757lcr (32bit system) whose only System RAM region is
40000000-4effffff and an ecovec24 (29bit system).

Signed-off-by: Simon Horman <horms@verge.net.au>

---
 kexec/arch/sh/kexec-sh.c |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 44 insertions(+), 1 deletions(-)

v2
* Only use the base of System RAM as an offset into physical memory
  if 32bit addressing is in use.

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 4b21ee8..94ebbc7 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -185,13 +185,56 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 	}
 }
 
+static int is_32bit(void)
+{
+	const char *cpuinfo = "/proc/cpuinfo";
+	char line[MAX_LINE], key[MAX_LINE], value[MAX_LINE];
+	FILE *fp;
+	int count;
+	int status = 0;
+
+	fp = fopen(cpuinfo, "r");
+	if (!fp)
+		die("Cannot open %s\n", cpuinfo);
+
+	while(fgets(line, sizeof(line), fp) != 0) {
+		count = sscanf(line, "%s : %s", key, value);
+		if (count != 2)
+			continue;
+		if (!strcmp(key, "address sizes")) {
+			if (!strcmp(value, "32 bits physical"))
+				status = 1;
+			break;
+		}
+	}
+
+	fclose(fp);
+
+	return status;
+}
+
 unsigned long virt_to_phys(unsigned long addr)
 {
 	unsigned long seg = addr & 0xe0000000;
+	unsigned long long start = 0;
+
 	if (seg != 0x80000000 && seg != 0xc0000000)
 		die("Virtual address %p is not in P1 or P2\n", (void *)addr);
 
-	return addr - seg;
+	/* If 32bit addressing is used then the base of system RAM
+	 * is an offset into physical memory. */
+	if (is_32bit()) {
+		unsigned long long end;
+		int ret;
+
+		/* Assume there is only one "System RAM" region */
+		ret = parse_iomem_single("System RAM\n", &start, &end);
+		if (ret)
+			die("Could not parse System RAM region "
+			    "in /proc/iomem\n");
+	}
+
+	return addr - seg + start;
 }
 
 /*
-- 
1.7.5.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
