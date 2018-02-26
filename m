Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eqHSj-0007Zn-AU
 for kexec@lists.infradead.org; Mon, 26 Feb 2018 12:00:59 +0000
From: Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH 1/5] kexec: Return -ENOSYS when kexec does not know how to
 call KEXEC_FILE_LOAD
Date: Mon, 26 Feb 2018 13:00:34 +0100
Message-Id: <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1519646210.git.msuchanek@suse.de>
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
To: msuchanek@suse.de, kexec@lists.infradead.org
Cc: Tony Jones <tonyj@suse.com>, horms@verge.net.au, Petr Tesarik <ptesarik@suse.cz>

When the kernel does not know a syscall number it returns -ENOSYS but
when kexec does not know a syscall number it returns -1. Return -ENOSYS
from kexec as well.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 kexec/kexec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index cfd837c1b6bb..ab8cff7fe083 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1166,7 +1166,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
 
 	if (!is_kexec_file_load_implemented()) {
 		fprintf(stderr, "syscall kexec_file_load not available.\n");
-		return -1;
+		return -ENOSYS;
 	}
 
 	if (argc - fileind <= 0) {
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
