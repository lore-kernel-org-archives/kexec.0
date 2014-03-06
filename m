Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WLW9J-0003Vo-FX
 for kexec@lists.infradead.org; Thu, 06 Mar 2014 11:07:38 +0000
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 6 Mar 2014 16:37:11 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 53EDA3940049
 for <kexec@lists.infradead.org>; Thu,  6 Mar 2014 16:37:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s26B6tsF1048840
 for <kexec@lists.infradead.org>; Thu, 6 Mar 2014 16:36:55 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s26B70SE018126
 for <kexec@lists.infradead.org>; Thu, 6 Mar 2014 16:37:01 +0530
Subject: [PATCH 2/2] makedumpfile/eppic: Install sample eppic scripts
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 06 Mar 2014 16:37:00 +0530
Message-ID: <20140306110622.12770.63373.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140306110550.12770.17915.stgit@aruna-ThinkPad-T420>
References: <20140306110550.12770.17915.stgit@aruna-ThinkPad-T420>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp

Install sample eppic scripts in the documentation directory

Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
---
 Makefile          |    2 ++
 makedumpfile.spec |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 2f4845c..6ee2da5 100644
--- a/Makefile
+++ b/Makefile
@@ -91,3 +91,5 @@ install:
 	install -m 644 -t ${DESTDIR}/usr/share/man/man8 makedumpfile.8.gz
 	install -m 644 -t ${DESTDIR}/usr/share/man/man5 makedumpfile.conf.5.gz
 	install -m 644 -D makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
+	mkdir -p ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts
+	install -m 644 -t ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/ eppic_scripts/*
diff --git a/makedumpfile.spec b/makedumpfile.spec
index c433730..f076bb6 100644
--- a/makedumpfile.spec
+++ b/makedumpfile.spec
@@ -28,6 +28,7 @@ mkdir -p %{buildroot}/usr/sbin
 mkdir -p %{buildroot}/etc
 mkdir -p %{buildroot}/usr/share/man/man5
 mkdir -p %{buildroot}/usr/share/man/man8
+mkdir -p %{buildroot}/usr/share/%{name}-%{version}/eppic-scripts/
 make install DESTDIR=%{buildroot}
 
 %clean
@@ -39,6 +40,7 @@ rm -rf %{buildroot}
 /usr/sbin/makedumpfile-R.pl
 /usr/share/man/man5/makedumpfile.conf.5.gz
 /usr/share/man/man8/makedumpfile.8.gz
+/usr/share/%{name}-%{version}/eppic_scripts/
 
 %changelog
 * Wed Dec 18 2013 Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
