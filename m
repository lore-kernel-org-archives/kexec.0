Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.nokia.com ([192.100.105.134] helo=mgw-mx09.nokia.com)
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NwDYZ-0002Mx-Ue
	for kexec@lists.infradead.org; Mon, 29 Mar 2010 11:55:04 +0000
From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] kexec-tools: Use the build date for package release
Date: Mon, 29 Mar 2010 14:52:58 +0300
Message-Id: <ef5c633db9ef8fe23d82ddcfd862bf565435ed45.1269863565.git.ameya.palande@nokia.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au

kexec built from git HEAD shows release date as 13th August 2009, which is not
correct. Instead of that use the build date as release date.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index f3994a3..fcf50e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -9,7 +9,7 @@ AC_CONFIG_AUX_DIR(./config)
 AC_CONFIG_HEADERS([include/config.h])
 AC_LANG(C)
 
-AC_DEFINE_UNQUOTED(PACKAGE_DATE, "13th August 2009",
+AC_DEFINE_UNQUOTED(PACKAGE_DATE, "`date '+%d %B %Y'`",
 		[Define to the release date of this package])
 
 
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
