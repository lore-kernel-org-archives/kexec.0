Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T6zq5-0002Xl-Ko
 for kexec@lists.infradead.org; Thu, 30 Aug 2012 08:10:58 +0000
Received: from mailgate3.nec.co.jp ([10.7.69.195])
 by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U8AtSu020730
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:10:55 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
 (8.11.7/3.7W-MAILGATE-NEC)
 id q7U8Ar809396 for kexec@lists.infradead.org;
 Thu, 30 Aug 2012 17:10:53 +0900 (JST)
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
 by mailsv4.nec.co.jp (8.13.8/8.13.4) with ESMTP id q7U8Arhs024930
 for <kexec@lists.infradead.org>; Thu, 30 Aug 2012 17:10:53 +0900 (JST)
Date: Thu, 30 Aug 2012 17:01:11 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: [PATCH 16/16] [v1.5.0] Update version.
Message-Id: <20120830170111.759399af634eddd10433a466@mxc.nes.nec.co.jp>
In-Reply-To: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
References: <20120830164422.8d05cbcdd650398d5d5cbad9@mxc.nes.nec.co.jp>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Thu, 30 Aug 2012 11:30:27 +0900
Subject: [PATCH 16/16] [v1.5.0] Update version.

This patch updates makedumpfile to version 1.5.0.

Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
---
 Makefile            |    4 ++--
 makedumpfile.8      |    2 +-
 makedumpfile.conf.5 |    2 +-
 makedumpfile.spec   |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 7337c58..8198467 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # makedumpfile
 
-VERSION=1.4.4
-DATE=29 May 2012
+VERSION=1.5.0
+DATE=30 Aug 2012
 
 # Honour the environment variable CC
 ifeq ($(strip $CC),)
diff --git a/makedumpfile.8 b/makedumpfile.8
index 95bf3e8..551eeb4 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -1,4 +1,4 @@
-.TH MAKEDUMPFILE 8 "29 May 2012" "makedumpfile v1.4.4" "Linux System Administrator's Manual"
+.TH MAKEDUMPFILE 8 "30 Aug 2012" "makedumpfile v1.5.0" "Linux System Administrator's Manual"
 .SH NAME
 makedumpfile \- make a small dumpfile of kdump
 .SH SYNOPSIS
diff --git a/makedumpfile.conf.5 b/makedumpfile.conf.5
index 93b5356..7fee05b 100644
--- a/makedumpfile.conf.5
+++ b/makedumpfile.conf.5
@@ -1,4 +1,4 @@
-.TH MAKEDUMPFILE.CONF 5 "29 May 2012" "makedumpfile v1.4.4" "Linux System Administrator's Manual"
+.TH MAKEDUMPFILE.CONF 5 "30 Aug 2012" "makedumpfile v1.5.0" "Linux System Administrator's Manual"
 .SH NAME
 makedumpfile.conf \- The filter configuration file for makedumpfile(8).
 .SH DESCRIPTION
diff --git a/makedumpfile.spec b/makedumpfile.spec
index 3e7070c..f8fc453 100644
--- a/makedumpfile.spec
+++ b/makedumpfile.spec
@@ -1,6 +1,6 @@
 Name: makedumpfile
 Summary: makedumpfile package
-Version: 1.4.4
+Version: 1.5.0
 Release: 1
 Group: Applications/Text
 License: GPL
-- 
1.7.9.2

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
