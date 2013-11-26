Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VlP6p-000683-LP
 for kexec@lists.infradead.org; Tue, 26 Nov 2013 20:19:48 +0000
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 3/3] makedumpfile/xen: Fail immediately if dump level is
 invalid
Date: Tue, 26 Nov 2013 21:18:49 +0100
Message-Id: <1385497129-19501-4-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1385497129-19501-1-git-send-email-daniel.kiper@oracle.com>
References: <1385497129-19501-1-git-send-email-daniel.kiper@oracle.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: andrew.cooper3@citrix.com, david.vrabel@citrix.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>

Do not try to process Xen crash dump if dump level is invalid.
Fail immediately and print relevant error message.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 makedumpfile.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b160cea..389efc5 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -64,6 +64,8 @@ do { \
 static void check_cyclic_buffer_overrun(void);
 static void setup_page_is_buddy(void);
 
+int get_next_dump_level(int index);
+
 void
 initialize_tables(void)
 {
@@ -2903,7 +2905,7 @@ initial(void)
 {
 	off_t offset;
 	unsigned long size;
-	int debug_info = FALSE;
+	int debug_info = FALSE, dump_level, i;
 
 #ifdef USELZO
 	if (lzo_init() == LZO_E_OK)
@@ -2926,6 +2928,20 @@ initial(void)
 #endif
 
 	if (is_xen_memory()) {
+		for (i = 0; ; ++i) {
+			dump_level = get_next_dump_level(i);
+
+			if (dump_level < 0)
+				break;
+
+			if (dump_level <= 1)
+				continue;
+
+			MSG("Allowed Dump_Level for Xen dump filtering is 0 or 1\n");
+
+			return FALSE;
+		}
+
 		if(info->flag_cyclic) {
 			info->flag_cyclic = FALSE;
 			MSG("Switched running mode from cyclic to non-cyclic,\n");
-- 
1.7.10.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
