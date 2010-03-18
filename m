Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwM-00071X-KU
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:38 +0000
Received: by bwz7 with SMTP id 7so1840949bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:32 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 1/6] kexec-tools: Fix rpm Version tag
Date: Thu, 18 Mar 2010 22:03:19 +0200
Message-Id: <b96760a9de92fbec85ca69ee398b94d72cda4ade.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
In-Reply-To: <cover.1268942234.git.ameya.palande@nokia.com>
References: <cover.1268942234.git.ameya.palande@nokia.com>
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

Version tag in rpm spec file doesn't allow '-', so use '_' to fix the rpm
build.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 88d2e0b..f3994a3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl
 dnl 
 
 dnl ---Required
-AC_INIT(kexec-tools, 2.0.1-git)
+AC_INIT(kexec-tools, 2.0.1_git)
 AC_CONFIG_AUX_DIR(./config)
 AC_CONFIG_HEADERS([include/config.h])
 AC_LANG(C)
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
