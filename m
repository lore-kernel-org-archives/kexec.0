Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:190:3424::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dAEEW-0002rK-3W
 for kexec@lists.infradead.org; Mon, 15 May 2017 11:32:13 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH] dracut-module-setup: Fix test for inclusion of DRM modules
Date: Mon, 15 May 2017 13:31:40 +0200
Message-Id: <20170515113140.12620-1-benjamin@sipsolutions.net>
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
To: kexec@lists.infradead.org
Cc: Benjamin Berg <bberg@redhat.com>

From: Benjamin Berg <bberg@redhat.com>

The /sys/modules/*/drivers sysfs entries do not exist anymore on newer
kernels which means that the DRM moduels would never be included.
Instead check if there is any device with a "drm" sysfs directory to
decide on whether DRM modules need to be included.
---
 dracut-module-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dracut-module-setup.sh b/dracut-module-setup.sh
index 9f88b4e..8495fd9 100755
--- a/dracut-module-setup.sh
+++ b/dracut-module-setup.sh
@@ -20,7 +20,7 @@ check() {
 depends() {
     local _dep="base shutdown"
 
-    if [ -d /sys/module/drm/drivers ]; then
+    if [ -n "$( find /sys/devices -name drm )" ]; then
         _dep="$_dep drm"
     fi
 
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
