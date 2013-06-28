Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UsTpS-0006T0-Pv
 for kexec@lists.infradead.org; Fri, 28 Jun 2013 08:14:51 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
 (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5S8EWEv008634
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Fri, 28 Jun 2013 04:14:32 -0400
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] makedumpfile: Add help and man message for '--help'
Date: Fri, 28 Jun 2013 16:13:52 +0800
Message-Id: <dcfd01a7c8d76b35563a7fe161e5677acd5d127c.1372407106.git.bhe@redhat.com>
In-Reply-To: <3bf9ad39c659faf5e4cb03545c83d50f81d7962f.1372407106.git.bhe@redhat.com>
References: <3bf9ad39c659faf5e4cb03545c83d50f81d7962f.1372407106.git.bhe@redhat.com>
In-Reply-To: <3bf9ad39c659faf5e4cb03545c83d50f81d7962f.1372407106.git.bhe@redhat.com>
References: <3bf9ad39c659faf5e4cb03545c83d50f81d7962f.1372407106.git.bhe@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Baoquan He <bhe@redhat.com>

Conventionally '-h' and '--help' are all provided. Currently makedumpfile
lacks help and man message for '--help'. Here add it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.8 | 2 +-
 print_info.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.8 b/makedumpfile.8
index 61bd5f2..eb2cf3d 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -539,7 +539,7 @@ order from left to right.  \fIVMCORE\fRs are assembled into a single
 Print debugging message.
 
 .TP
-\fB\-h\fR
+\fB\-h (\-\-help)\fR
 Show help message and LZO/snappy support status (enabled/disabled).
 
 .TP
diff --git a/print_info.c b/print_info.c
index 06939e0..3527970 100644
--- a/print_info.c
+++ b/print_info.c
@@ -255,7 +255,7 @@ print_usage(void)
 	MSG("  [-f]:\n");
 	MSG("      Overwrite DUMPFILE even if it already exists.\n");
 	MSG("\n");
-	MSG("  [-h]:\n");
+	MSG("  [-h, --help]:\n");
 	MSG("      Show help message and LZO/snappy support status (enabled/disabled).\n");
 	MSG("\n");
 	MSG("  [-v]:\n");
-- 
1.8.2.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
