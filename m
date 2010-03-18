Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NsLwQ-00072Y-4W
	for kexec@lists.infradead.org; Thu, 18 Mar 2010 20:03:42 +0000
Received: by bwz7 with SMTP id 7so1841022bwz.4
	for <kexec@lists.infradead.org>; Thu, 18 Mar 2010 13:03:37 -0700 (PDT)
From: Ameya Palande <2ameya@gmail.com>
Subject: [PATCH 4/6] kexec-tools: Add kdump and kexec_test to rpm spec
Date: Thu, 18 Mar 2010 22:03:22 +0200
Message-Id: <988766bf0037f2887c3f0ea6fe31f7364f3c5453.1268942234.git.ameya.palande@nokia.com>
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

Without this patch rpmbuild complains about unpackaged kdump and kexec_test
files.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 kexec-tools.spec.in |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
index 2aa1310..5eadece 100644
--- a/kexec-tools.spec.in
+++ b/kexec-tools.spec.in
@@ -30,6 +30,8 @@ make install DESTDIR=${RPM_BUILD_ROOT}
 %files
 %defattr(-,root,root)
 %{_sbindir}/kexec
+%{_sbindir}/kdump
+%{_libdir}/%{name}/kexec_test
 %doc News
 %doc COPYING
 %doc TODO
-- 
1.6.3.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
