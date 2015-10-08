Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1444346477.29301.80.camel@infradead.org>
Subject: [PATCH 1/2] configure: Set SUBARCH=BE for powerpc
From: Geoff Levand <geoff@infradead.org>
Date: Thu, 08 Oct 2015 16:21:17 -0700
Mime-Version: 1.0
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

When building a 32 bit version of kexec-tools for powerpc64
set the default powerpc64 SUBARCH as BE.

Fixes build errors like these:

 powerpc-linux-gnu/bin/ld: unrecognised emulation mode: elf64lppc

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index ddb5e2b..2dc70df 100644
--- a/configure.ac
+++ b/configure.ac
@@ -24,6 +24,7 @@ case $target_cpu in
 		;;
 	powerpc )
 		ARCH="ppc"
+		SUBARCH="BE"
 		;;
 	powerpc64 )
 		ARCH="ppc64"
-- 
2.5.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
