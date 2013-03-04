Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDQru-0007YH-RY
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 02:47:44 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id E093F3EE081
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:36 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C384745DE58
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:36 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id A94E045DE54
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:36 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 7BE90E08005
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:36 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 33E4DE08001
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 11:47:36 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 1/3] elf,
 sadump: move KEXEC macros from sadump_info.c to elf_info.h
Date: Mon, 04 Mar 2013 13:18:29 +0900
Message-ID: <20130304041829.16856.83840.stgit@localhost6.localdomain6>
In-Reply-To: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
References: <20130304041724.16856.19272.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

Move KEXEC_CORE_NOTE_NAME and KEXEC_CORE_NOTE_NAME_BYTES in elf_info.h
to export them in elf_info.c. Later patch refers to them when reading
PT_NOTE program header entries.

During this change, round-up operations are dropped to make it uniform
to other macros such as VMCOREINFO_NOTE_NAME that is similarly
exported from elf_info.h.

Instead, the roundup-operations dropped are moved into
KEXEC_NOTE_BYTES.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 elf_info.h    |    3 +++
 sadump_info.c |    4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/elf_info.h b/elf_info.h
index 3b430dd..eb58023 100644
--- a/elf_info.h
+++ b/elf_info.h
@@ -19,6 +19,9 @@
 #include <elf.h>
 #include <sys/types.h>
 
+#define KEXEC_CORE_NOTE_NAME "CORE"
+#define KEXEC_CORE_NOTE_NAME_BYTES sizeof(KEXEC_CORE_NOTE_NAME)
+
 #define ERASEINFO_NOTE_NAME		"ERASEINFO"
 #define ERASEINFO_NOTE_NAME_BYTES	(sizeof(ERASEINFO_NOTE_NAME))
 
diff --git a/sadump_info.c b/sadump_info.c
index 9346bf1..be6cf55 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -37,12 +37,10 @@
 
 #endif
 
-#define KEXEC_CORE_NOTE_NAME "CORE"
-#define KEXEC_CORE_NOTE_NAME_BYTES roundup(sizeof(KEXEC_CORE_NOTE_NAME), 4)
 #define KEXEC_CORE_NOTE_DESC_BYTES roundup(sizeof(struct elf_prstatus), 4)
 
 #define KEXEC_NOTE_BYTES ((KEXEC_NOTE_HEAD_BYTES * 2) +                \
-			  KEXEC_CORE_NOTE_NAME_BYTES +		       \
+			  roundup(KEXEC_CORE_NOTE_NAME_BYTES, 4) +     \
 			  KEXEC_CORE_NOTE_DESC_BYTES )
 
 #define for_each_online_cpu(cpu)					\


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
