Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zf2Fv-0004et-FI
 for kexec@lists.infradead.org; Thu, 24 Sep 2015 08:51:55 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH] Documentation: Update the default value of crashkernel low
Date: Thu, 24 Sep 2015 16:51:25 +0800
Message-Id: <1443084685-1999-1-git-send-email-bhe@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, joro@8bytes.org, corbet@lwn.net, kexec@lists.infradead.org, akpm@linux-foundation.org

In commit 94fb933 ("x86/crash: Allocate enough low memory when
crashkernel=high") the default value of crashkernel low memory
is changed to 256M. In this patch update it accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/kernel-parameters.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 22a4b68..945bc0d 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -789,8 +789,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
-			requires at least 64M+32K low memory.  Kernel would
-			try to allocate 72M below 4G automatically.
+			requires at least 64M+32K low memory, also enough extra
+			low memory is needed to make sure DMA buffers for 32-bit
+			devices won't run out. Kernel would try to allocate at
+			at least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
