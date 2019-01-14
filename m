Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj8DV-0000GK-Sq
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:48:17 +0000
From: Eric DeVolder <eric.devolder@oracle.com>
Subject: [RFC v1 4/8] kexec: xen/common/Makefile: include building of OpenSSL
Date: Mon, 14 Jan 2019 13:48:01 -0600
Message-Id: <1547495285-28907-5-git-send-email-eric.devolder@oracle.com>
In-Reply-To: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
References: <1547495285-28907-1-git-send-email-eric.devolder@oracle.com>
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
To: xen-devel@lists.xen.org
Cc: daniel.kiper@oracle.com, eric.devolder@oracle.com, kexec@lists.infradead.org, boris.ostrovsky@oracle.com

Changes needed to the xen/common/Makefile in order to stitch in the
compiling of OpenSSL as well as the PECOFF file decoder and signature
verification code.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 xen/common/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/xen/common/Makefile b/xen/common/Makefile
index b1a5c42..bf91227 100644
--- a/xen/common/Makefile
+++ b/xen/common/Makefile
@@ -74,3 +74,7 @@ subdir-$(coverage) += gcov
 
 subdir-y += libelf
 subdir-$(HAS_DEVICE_TREE) += libfdt
+
+obj-$(HAS_KEXEC) += ped.o v_openssl.o
+subdir-$(HAS_KEXEC) += openssl-1.1.0i
+
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
