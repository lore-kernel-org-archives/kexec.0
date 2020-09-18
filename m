Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJBV0-00026s-Ru
 for kexec@lists.infradead.org; Fri, 18 Sep 2020 08:12:08 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH] docs: admin-guide: update kdump documentation due to change
 of crash URL
Date: Fri, 18 Sep 2020 16:09:58 +0800
Message-Id: <20200918080958.19841-1-lijiang@redhat.com>
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
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com, bhe@redhat.com, corbet@lwn.net

Since crash utility has moved to github, the original URL is no longer
available. Let's update it accordingly.

Suggested-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 Documentation/admin-guide/kdump/kdump.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..75a9dd98e76e 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -509,9 +509,12 @@ ELF32-format headers using the --elf32-core-headers kernel option on the
 dump kernel.
 
 You can also use the Crash utility to analyze dump files in Kdump
-format. Crash is available on Dave Anderson's site at the following URL:
+format. Crash is available at the following URL:
 
-   http://people.redhat.com/~anderson/
+   https://github.com/crash-utility/crash
+
+Crash document can be found at:
+   https://crash-utility.github.io/
 
 Trigger Kdump on WARN()
 =======================
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
