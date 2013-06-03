Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UjREW-00029u-6w
 for kexec@lists.infradead.org; Mon, 03 Jun 2013 09:39:21 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
 (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
 by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r539d36g024436
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <kexec@lists.infradead.org>; Mon, 3 Jun 2013 05:39:03 -0400
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/3] add missed options to man page
Date: Mon,  3 Jun 2013 17:38:40 +0800
Message-Id: <88fe03bd42cc406c51ee5cdab77ece45d81a9e96.1370252057.git.bhe@redhat.com>
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

several options are missed in man page, add it now. They are
--reuseinitrd, --load-preserve-context, --load-jump-back-helper
and --entry=<addr>.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kexec/kexec.8 |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kexec/kexec.8 b/kexec/kexec.8
index 2f94448..2575f9e 100644
--- a/kexec/kexec.8
+++ b/kexec/kexec.8
@@ -162,6 +162,16 @@ to load code into.
 .TP
 .BI \-\-entry= addr
 Specify the jump back address. (0 means it's not jump back or preserve context)
+.TP
+.BI \-\-load\-preserve\-context
+Load the new kernel and preserve context of current kernel during kexec.
+.TP
+.BI \-\-load\-jump\-back\-helper
+Load a helper image to jump back to original kernel.
+.TP
+.BI \-\-reuseinitrd
+Reuse initrd from first boot.
+
 
 .SH SUPPORTED KERNEL FILE TYPES AND OPTIONS
 .B Beoboot-x86
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
