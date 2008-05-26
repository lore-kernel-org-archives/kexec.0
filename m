Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K0eEK-0003OB-9m
	for kexec@lists.infradead.org; Mon, 26 May 2008 15:03:21 +0000
From: Bernhard Walle <bwalle@suse.de>
Subject: [PATCH] Specify the arch on kexec_unload.
Date: Mon, 26 May 2008 16:46:58 +0200
Message-Id: <1211813218-21886-1-git-send-email-bwalle@suse.de>
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
Cc: sharyath@in.ibm.com, Bernhard Walle <bwalle@suse.de>

This fixes the problem in kexec-tools that the patch
http://article.gmane.org/gmane.linux.kernel/685027 tries to fix in kernel.

The fix in userspace is correct.

Signed-off-by: Bernhard Walle <bwalle@suse.de>
---
 kexec/kexec.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 096fa4f..1550d68 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -702,6 +702,14 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 int k_unload (unsigned long kexec_flags)
 {
 	int result;
+	long native_arch;
+
+	/* set the arch */
+	native_arch = physical_arch();
+	if (native_arch < 0) {
+		return -1;
+	}
+	kexec_flags |= native_arch;
 
 	result = kexec_load(NULL, 0, NULL, kexec_flags);
 	if (result != 0) {
-- 
1.5.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
