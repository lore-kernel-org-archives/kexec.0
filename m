Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VN0cK-0001vP-9j
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 13:19:29 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 2/4] kexec/xen: use libxc to get location of crash notes
Date: Fri, 20 Sep 2013 14:18:45 +0100
Message-ID: <1379683127-14349-3-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379683127-14349-1-git-send-email-david.vrabel@citrix.com>
References: <1379683127-14349-1-git-send-email-david.vrabel@citrix.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Use xc_kexec_get_range(KEXEC_RANGE_MA_CPU) instead of parsing
/proc/iomem (which is only populated by non-upstream ("classic") Xen
kernels).

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 kexec/crashdump-xen.c |   67 +++++++++++++++++++++++++++++-------------------
 1 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index ff4706c..4a5cd8a 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -163,42 +163,55 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
 	return machine;
 }
 
-static int xen_crash_note_callback(void *UNUSED(data), int nr,
-				   char *UNUSED(str),
-				   unsigned long base,
-				   unsigned long length)
-{
-	struct crash_note_info *note = xen_phys_notes + nr;
-
-	note->base = base;
-	note->length = length;
-
-	return 0;
-}
-
+#ifdef HAVE_LIBXENCTRL
 int xen_get_nr_phys_cpus(void)
 {
-	char *match = "Crash note\n";
-	int cpus, n;
+	xc_interface *xc;
+	int max_cpus;
+	int cpu;
 
 	if (xen_phys_cpus)
 		return xen_phys_cpus;
 
-	if ((cpus = kexec_iomem_for_each_line(match, NULL, NULL))) {
-		n = sizeof(struct crash_note_info) * cpus;
-		xen_phys_notes = malloc(n);
-		if (!xen_phys_notes) {
-			fprintf(stderr, "failed to allocate xen_phys_notes.\n");
-			return -1;
-		}
-		memset(xen_phys_notes, 0, n);
-		kexec_iomem_for_each_line(match,
-					  xen_crash_note_callback, NULL);
-		xen_phys_cpus = cpus;
+	xc = xc_interface_open(NULL, NULL, 0);
+	if (!xc) {
+		fprintf(stderr, "failed to open xen control interface.\n");
+		return -1;
+	}
+
+	max_cpus = xc_get_max_cpus(xc);
+	if (max_cpus <= 0)
+		return -1;
+
+	xen_phys_notes = calloc(max_cpus, sizeof(*xen_phys_notes));
+	if (xen_phys_notes == NULL)
+		return -1;
+
+	for (cpu = 0; cpu < max_cpus; cpu++) {
+		uint64_t size, start;
+		int ret;
+
+		ret = xc_kexec_get_range(xc, KEXEC_RANGE_MA_CPU, cpu, &size, &start);
+		if (ret < 0)
+			break;
+
+		xen_phys_notes[cpu].base = start;
+		xen_phys_notes[cpu].length = size;
 	}
 
-	return cpus;
+	xc_interface_close(xc);
+
+	xen_phys_cpus = cpu;
+
+	return cpu;
 }
+#else
+int xen_get_nr_phys_cpus(void)
+{
+	return -1;
+}
+#endif
+
 
 int xen_get_note(int cpu, uint64_t *addr, uint64_t *len)
 {
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
