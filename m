Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cap8x-0000Hu-HV
 for kexec@lists.infradead.org; Mon, 06 Feb 2017 19:40:12 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v2 12/12] kexec: Add option to get crash kernel region size
Date: Mon,  6 Feb 2017 13:42:24 -0600
Message-Id: <1486410144-28595-13-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
References: <1486410144-28595-1-git-send-email-eric.devolder@oracle.com>
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
To: horms@verge.net.au, kexec@lists.infradead.org, andrew.cooper3@citrix.com, dyoung@redhat.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

Here print_crashkernel_region_size() function is available on all archs (even
if the functionality is not implemented on some). So, we can safely use it in
arch independent code and export the functionality to the user space.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 kexec/kexec.8 | 3 +++
 kexec/kexec.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index f4b39a6..e0131b4 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -179,6 +179,9 @@ Load a helper image to jump back to original kernel.
 .TP
 .BI \-\-reuseinitrd
 Reuse initrd from first boot.
+.TP
+.BI \-\-print-ckr-size
+Print crash kernel region size, if available.
 
 
 .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
diff --git a/kexec/kexec.c b/kexec/kexec.c
index a2ba79d..482b6a7 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -995,6 +995,7 @@ void usage(void)
 	       "     --mem-max=<addr> Specify the highest memory address to\n"
 	       "                      load code into.\n"
 	       "     --reuseinitrd    Reuse initrd from first boot.\n"
+	       "     --print-ckr-size Print crash kernel region size.\n"
 	       "     --load-preserve-context Load the new kernel and preserve\n"
 	       "                      context of current kernel during kexec.\n"
 	       "     --load-jump-back-helper Load a helper image to jump back\n"
@@ -1375,6 +1376,9 @@ int main(int argc, char *argv[])
 		case OPT_STATUS:
 			do_status = 1;
 			break;
+		case OPT_PRINT_CKR_SIZE:
+			print_crashkernel_region_size();
+			return 0;
 		default:
 			break;
 		}
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
