Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwUdy-0008Cb-2G
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 14:13:43 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [PATCH v0] Fix broken Xen support in configure.ac
Date: Fri,  7 Apr 2017 09:13:06 -0500
Message-Id: <1491574386-14764-1-git-send-email-eric.devolder@oracle.com>
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
To: kexec@lists.infradead.org, horms@verge.net.au, andrew.cooper3@citrix.com
Cc: daniel.kiper@oracle.com, konrad.wilk@oracle.com

Commit 2cf7cb9a "kexec: implemented XEN KEXEC STATUS to determine
if an image is loaded" added configure-time detection of the
kexec_status() call, but in doing so had the unintended side
effect of disabling support for Xen altogether due to the
missing HAVE_LIBXENCTRL=1. This corrects the broken behavior
while still maintaining the original intention of detecting
support for kexec_status() call.

---
Broken behavior (HAVE_LIBXENCTRL is missing altogether):
  ...
  checking xenctrl.h usability... yes
  checking xenctrl.h presence... yes
  checking for xenctrl.h... yes
  checking for xc_kexec_load in -lxenctrl... yes
  checking for xc_kexec_status in -lxenctrl... yes

  in include/config.h:
  /* The kexec_status call is available */
  #define HAVE_KEXEC_CMD_STATUS 1

Fixed behaviour (restores HAVE_LIBXENCTRL):
  ...
  checking xenctrl.h usability... yes
  checking xenctrl.h presence... yes
  checking for xenctrl.h... yes
  checking for xc_kexec_load in -lxenctrl... yes
  checking for xc_kexec_status in -lxenctrl... yes

  in include/config.h:
  /* The kexec_status call is available */
  #define HAVE_KEXEC_CMD_STATUS 1
  /* Define to 1 if you have the `xenctrl' library (-lxenctrl). */
  #define HAVE_LIBXENCTRL 1

Reported-and-Tested-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 configure.ac | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 53fffc3..87a9ac8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -165,9 +165,9 @@ fi
 dnl find Xen control stack libraries
 if test "$with_xen" = yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
-		[AC_CHECK_LIB(xenctrl, xc_kexec_load, [ have_xenctrl_h=yes ],
+		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
 		AC_MSG_NOTICE([Xen support disabled]))])
-		if test "$have_xenctrl_h" = yes ; then
+		if test "$ac_cv_lib_xenctrl_xc_kexec_load" = yes ; then
 			AC_CHECK_LIB(xenctrl, xc_kexec_status,
 				AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
 					[The kexec_status call is available]),
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
