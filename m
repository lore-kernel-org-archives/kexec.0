Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjREW-00029r-7q
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 09:39:22 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
 (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r539cxjr024432
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 05:38:59 -0400
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/3] kexec man page change for debug option
Date: Mon,  3 Jun 2013 17:38:38 +0800
Message-Id: <a1afe09f2560fc4ea6d0a5791d5e92d2976aa01a.1370252057.git.bhe@redhat.com>
In-Reply-To: <cover.1370252057.git.bhe@redhat.com>
References: <cover.1370252057.git.bhe@redhat.com>
In-Reply-To: <cover.1370252057.git.bhe@redhat.com>
References: <cover.1370252057.git.bhe@redhat.com>
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

In commit 28d4ab53, the arch-specific --debug are moved to
generic place, but the relevant description was not updated
accordingly in man page. Here change it.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kexec/kexec.8 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index aff674c..120af4d 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -104,6 +104,9 @@ command:
 
 .SH OPTIONS
 .TP
+.B \-d\ (\-\-debug)
+Enable debugging messages.
+.TP
 .B \-e\ (\-\-exec)
 Run the currently loaded kernel. Note that it will reboot into the loaded kernel without calling shutdown(8).
 .TP
@@ -167,9 +170,6 @@ Pass ELF boot notes.
 .B \-\-args\-linux
 Pass Linux kernel style options.
 .TP
-.B \-d \ (\-\-debug)
-Enable debugging messages.
-.TP
 .B \-\-real\-mode
 Use the kernel's real mode entry point.
 .RE
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
