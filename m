Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UcCXo-0002D4-LO
 for kexec@lists.infradead.org; Tue, 14 May 2013 10:33:22 +0000
From: WANG Chao <chaowang@redhat.com>
Subject: [PATCH] kexec: check if memory is reserved only when loading kdump
 kernel.
Date: Tue, 14 May 2013 18:32:50 +0800
Message-Id: <1368527570-19499-1-git-send-email-chaowang@redhat.com>
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

When memory for crashkernel isn't reserved, it's confusing that kexec
spits error message for unloading kdump kernel as if we were loading it:

  # kexec -p -u
  Memory for crashkernel is not reserved
  Please reserve memory by passing "crashkernel=X@Y" parameter to the kernel
  Then try loading kdump kernel
  # echo $?
  1

It's more appropriate to test if memory is reserved only when
loading kdump kernel. With this patch:

  # kexec -p -u
  # echo $?
  0

It's also the same behavior with the case of trying to unload kernel
from unloaded state.

Signed-off-by: WANG Chao <chaowang@redhat.com>
---
 kexec/kexec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kexec/kexec.c b/kexec/kexec.c
index 911c0f6..6a13f79 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -1175,7 +1175,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if ((kexec_flags & KEXEC_ON_CRASH) && !is_crashkernel_mem_reserved()) {
+	if (do_load && (kexec_flags & KEXEC_ON_CRASH) &&
+	    !is_crashkernel_mem_reserved()) {
 		die("Memory for crashkernel is not reserved\n"
 		    "Please reserve memory by passing"
 		    "\"crashkernel=X@Y\" parameter to kernel\n"
-- 
1.8.2.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
