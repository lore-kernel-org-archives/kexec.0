Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UwXvC-00086z-Lr
 for kexec@lists.infradead.org; Tue, 09 Jul 2013 13:25:35 +0000
From: Maxim Uvarov <maxim.uvarov@oracle.com>
Subject: [PATCH] calculate cyclic buffer size according to info->num_dumpfile
Date: Tue,  9 Jul 2013 17:32:29 +0400
Message-Id: <1373376749-5413-1-git-send-email-maxim.uvarov@oracle.com>
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
To: kexec@lists.infradead.org
Cc: nishimura@mxp.nes.nec.co.jp, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp, usui@mxm.nes.nec.co.jp, d.hatayama@jp.fujitsu.com

Dump kernel work in limited memory space and makedumpfile buffers
have to fit to empty memory due to not be killed with OOM-killer.
Signed-off-by: Maxim Uvarov <maxim.uvarov@oracle.com>
---
 makedumpfile.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..52606ab 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2996,7 +2996,7 @@ out:
 			/*
 			 * Truncate the buffer size to free memory size.
 			 */
-			free_memory = get_free_memory_size();
+			free_memory = (get_free_memory_size() / info->num_dumpfile);
 			if (info->bufsize_cyclic > free_memory) {
 				MSG("Specified buffer size is larger than free memory.\n");
 				MSG("The buffer size for the cyclic mode will ");
@@ -8548,6 +8548,8 @@ calculate_cyclic_buffer_size(void) {
 	 */
 	free_size = get_free_memory_size() * 0.4;
 	needed_size = (info->max_mapnr * 2) / BITPERBYTE;
+	/* if --split was specified cyclic buffer allocated per dump file */
+	needed_size /= info->num_dumpfile;
 
 	info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
 
-- 
1.7.9.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
