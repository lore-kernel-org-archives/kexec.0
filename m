Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTnly-0000Zu-3H
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 09:10:35 +0000
Date: Mon, 24 Aug 2015 17:10:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH RFC] Drop release date from kexec-tools version output
Message-ID: <20150824091005.GA10044@dhcp-16-198.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

kexec --version reports like below:
kexec-tools 2.0.7 released 05 February 2015

The date string is generated when one run bootstrap script, thus
it is more like a build date instead of release date.
Even for distribution like Fedora it will make more sense if it can
report something like "kexec-tools 2.0.7-1 released 05 February 2015"

In case building from git tree, the date cause more confusion.
So let's remove it from version string unless there is better idea
to resolve the issue.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 configure.ac  |    3 ---
 kexec/kexec.c |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

--- kexec-tools.orig/configure.ac
+++ kexec-tools/configure.ac
@@ -10,9 +10,6 @@ AC_CONFIG_HEADERS([include/config.h])
 AC_LANG(C)
 AC_PROG_CC
 
-AC_DEFINE_UNQUOTED(PACKAGE_DATE, "`date '+%d %B %Y'`",
-		[Define to the release date of this package])
-
 
 dnl -- Compilation platform configuration
 dnl -- the host specifices the host machine for the kexec binary, the
--- kexec-tools.orig/kexec/kexec.c
+++ kexec-tools/kexec/kexec.c
@@ -897,7 +897,7 @@ static int my_load_jump_back_helper(unsi
 
 static void version(void)
 {
-	printf(PACKAGE_STRING " released " PACKAGE_DATE "\n");
+	printf(PACKAGE_STRING "\n");
 }
 
 void usage(void)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
