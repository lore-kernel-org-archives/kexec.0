Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ey0-f177.google.com ([209.85.215.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSPDQ-0004q2-SQ
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 08:27:05 +0000
Received: by eye3 with SMTP id 3so6054795eye.36
 for <kexec@lists.infradead.org>; Mon, 21 Nov 2011 00:26:58 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] fix rpm build errors
Date: Mon, 21 Nov 2011 16:26:04 +0800
Message-Id: <1321863964-12184-1-git-send-email-xiyou.wangcong@gmail.com>
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
Cc: WANG Cong <xiyou.wangcong@gmail.com>, horms@verge.net.au

a) rpmbuild doesn't like '-' in version, replace it with '.'.
b) update the files installed in kexec-tools.spec

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

---
diff --git a/configure.ac b/configure.ac
index 7dd6028..4388bb9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -4,7 +4,7 @@ dnl
 dnl 
 
 dnl ---Required
-AC_INIT(kexec-tools, 2.0.2-git)
+AC_INIT(kexec-tools, 2.0.2.git)
 AC_CONFIG_AUX_DIR(./config)
 AC_CONFIG_HEADERS([include/config.h])
 AC_LANG(C)
diff --git a/kexec-tools.spec.in b/kexec-tools.spec.in
index 0f0ff07..8871f28 100644
--- a/kexec-tools.spec.in
+++ b/kexec-tools.spec.in
@@ -31,11 +31,13 @@ make install DESTDIR=${RPM_BUILD_ROOT}
 %defattr(-,root,root)
 %{_sbindir}/kexec
 %{_sbindir}/kdump
-%{_libdir}/%{name}/kexec_test
+%{_sbindir}/vmcore-dmesg
 %doc News
 %doc COPYING
 %doc TODO
-#%{_mandir}/man8/kexec.8.gz
+%{_mandir}/man8/kexec.8.gz
+%{_mandir}/man8/kdump.8.gz
+%{_mandir}/man8/vmcore-dmesg.8.gz
 
 %changelog
 * Tue Dec 16 2004 Eric Biederman <ebiederman@lnxi.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
