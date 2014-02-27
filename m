Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WIuWk-00021r-9V
 for kexec@lists.infradead.org; Thu, 27 Feb 2014 06:33:10 +0000
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <aruna@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 16:32:10 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F1A322BB003F
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:32:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1R6CKdu49807536
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:12:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1R6W6Qi014303
 for <kexec@lists.infradead.org>; Thu, 27 Feb 2014 17:32:06 +1100
Subject: [PATCH 10/10] Install sample eppic scripts
From: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 12:02:04 +0530
Message-ID: <20140227063204.5924.43768.stgit@aruna-ThinkPad-T420>
In-Reply-To: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
References: <20140227063007.5924.5819.stgit@aruna-ThinkPad-T420>
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
 Makefile          |    1 +
 makedumpfile.spec |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 10178ba..6e8e9b9 100644
--- a/Makefile
+++ b/Makefile
@@ -91,3 +91,4 @@ install:
 	cp makedumpfile.8.gz ${DESTDIR}/usr/share/man/man8
 	cp makedumpfile.conf.5.gz ${DESTDIR}/usr/share/man/man5
 	cp makedumpfile.conf ${DESTDIR}/etc/makedumpfile.conf.sample
+	cp eppic_scripts/* ${DESTDIR}/usr/share/makedumpfile-${VERSION}/eppic_scripts/
diff --git a/makedumpfile.spec b/makedumpfile.spec
index ea7fba4..7f5d1d4 100644
--- a/makedumpfile.spec
+++ b/makedumpfile.spec
@@ -28,6 +28,8 @@ mkdir -p %{buildroot}/bin
 mkdir -p %{buildroot}/etc
 mkdir -p %{buildroot}/usr/share/man/man5
 mkdir -p %{buildroot}/usr/share/man/man8
+mkdir -p %{buildroot}/usr/share/%{name}-%{version}/
+mkdir -p %{buildroot}/usr/share/%{name}-%{version}/eppic-scripts/
 make install DESTDIR=%{buildroot}
 
 %clean
@@ -39,6 +41,7 @@ rm -rf %{buildroot}
 /bin/makedumpfile-R.pl
 /usr/share/man/man5/makedumpfile.conf.5.gz
 /usr/share/man/man8/makedumpfile.8.gz
+%doc /usr/share/%{name}-%{version}/eppic_scripts/
 
 %changelog
 * Fri Aug 21 2008 Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
