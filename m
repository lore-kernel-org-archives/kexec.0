Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-dm3nam03on0042.outbound.protection.outlook.com
 ([104.47.41.42] helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBJ5w-0005aQ-2G
 for kexec@lists.infradead.org; Thu, 18 May 2017 10:55:49 +0000
From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: [PATCH v2] kexec/kdump: Minor Documentation updates for arm64 and
 Image
Date: Thu, 18 May 2017 16:23:13 +0530
Message-ID: <1495104793-6563-1-git-send-email-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
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
To: dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com, corbet@lwn.net, takahiro.akashi@linaro.org, panand@redhat.com
Cc: Bharat Bhushan <Bharat.Bhushan@nxp.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

This patch have minor updates in Documentation for arm64i as
relocatable kernel.
Also this patch updates documentation for using uncompressed
image "Image" which is used for ARM64.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
v1->v2
  - "a uncompressed" replaced with "an uncompressed"

 Documentation/kdump/kdump.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index 615434d..5181445 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -112,8 +112,8 @@ There are two possible methods of using Kdump.
 2) Or use the system kernel binary itself as dump-capture kernel and there is
    no need to build a separate dump-capture kernel. This is possible
    only with the architectures which support a relocatable kernel. As
-   of today, i386, x86_64, ppc64, ia64 and arm architectures support relocatable
-   kernel.
+   of today, i386, x86_64, ppc64, ia64, arm and arm64 architectures support
+   relocatable kernel.
 
 Building a relocatable kernel is advantageous from the point of view that
 one does not have to build a second kernel for capturing the dump. But
@@ -339,7 +339,7 @@ For arm:
 For arm64:
 	- Use vmlinux or Image
 
-If you are using a uncompressed vmlinux image then use following command
+If you are using an uncompressed vmlinux image then use following command
 to load dump-capture kernel.
 
    kexec -p <dump-capture-kernel-vmlinux-image> \
@@ -361,6 +361,12 @@ to load dump-capture kernel.
    --dtb=<dtb-for-dump-capture-kernel> \
    --append="root=<root-dev> <arch-specific-options>"
 
+If you are using an uncompressed Image, then use following command
+to load dump-capture kernel.
+
+   kexec -p <dump-capture-kernel-Image> \
+   --initrd=<initrd-for-dump-capture-kernel> \
+   --append="root=<root-dev> <arch-specific-options>"
 
 Please note, that --args-linux does not need to be specified for ia64.
 It is planned to make this a no-op on that architecture, but for now
-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
