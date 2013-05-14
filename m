Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uc6MV-0004RN-Hp
 for kexec@lists.infradead.org; Tue, 14 May 2013 03:57:16 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] kexec: Replace printf() with die() to error out to stderr
Date: Tue, 14 May 2013 11:56:48 +0800
Message-Id: <1368503808-16601-1-git-send-email-chaowang@redhat.com>
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
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

Error messages are mixed stderr with stdout when we use die() along with
printf(). So use die() to keep error out consistent.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/kexec.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 53d6edc..911c0f6 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1176,17 +1176,17 @@ int main(int argc, char *argv[])
 	}
 
 	if ((kexec_flags & KEXEC_ON_CRASH) && !is_crashkernel_mem_reserved()) {
-		printf("Memory for crashkernel is not reserved\n");
-		printf("Please reserve memory by passing ");
-		printf("\"crashkernel=X@Y\" parameter to the kernel\n");
-		die("Then try loading kdump kernel\n");
+		die("Memory for crashkernel is not reserved\n"
+		    "Please reserve memory by passing"
+		    "\"crashkernel=X@Y\" parameter to kernel\n"
+		    "Then try to loading kdump kernel\n");
 	}
 
 	if (do_load && (kexec_flags & KEXEC_PRESERVE_CONTEXT) &&
 	    mem_max == ULONG_MAX) {
-		printf("Please specify memory range used by kexeced kernel\n");
-		printf("to preserve the context of original kernel with \n");
-		die("\"--mem-max\" parameter\n");
+		die("Please specify memory range used by kexeced kernel\n"
+		    "to preserve the context of original kernel with \n"
+		    "\"--mem-max\" parameter\n");
 	}
 
 	fileind = optind;
-- 
1.8.2.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
