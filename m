Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpPKJ-000zv0-Ud
 for kexec@lists.infradead.org; Tue, 23 Nov 2021 06:30:49 +0000
Date: Tue, 23 Nov 2021 14:30:34 +0800
From: Dave Young <dyoung@redhat.com>
Subject: [PATCH] MAINTAINERS: update kdump maintainers
Message-ID: <YZyKilzKFsWJYdgn@dhcp-128-65.nay.redhat.com>
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
To: bhe@redhat.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, vgoyal@redhat.com

Remove myself from kdump maintainers as I have no enough time to
maintain it now. But I can review patches on demand though.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 MAINTAINERS |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-x86/MAINTAINERS
===================================================================
--- linux-x86.orig/MAINTAINERS
+++ linux-x86/MAINTAINERS
@@ -10122,9 +10122,9 @@ F:	lib/Kconfig.kcsan
 F:	scripts/Makefile.kcsan
 
 KDUMP
-M:	Dave Young <dyoung@redhat.com>
 M:	Baoquan He <bhe@redhat.com>
 R:	Vivek Goyal <vgoyal@redhat.com>
+R:	Dave Young <dyoung@redhat.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://lse.sourceforge.net/kdump/


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
