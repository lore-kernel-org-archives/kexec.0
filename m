Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay.parallels.com ([195.214.232.42])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SZfmJ-0004GE-Kr
 for kexec@lists.infradead.org; Wed, 30 May 2012 10:05:20 +0000
From: Vladimir Davydov <vdavydov@parallels.com>
Subject: [PATCH] kexec: consolidate crash late initialization
Date: Wed, 30 May 2012 14:05:09 +0400
Message-ID: <1338372309-24983-1-git-send-email-vdavydov@parallels.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Eric Biederman <ebiederm@xmission.com>
Cc: Vladimir Davydov <vdavydov@parallels.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Use one module_init() instead of two.
---
 kernel/kexec.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec.c b/kernel/kexec.c
index 4e2e472..c3341cb 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -1240,7 +1240,6 @@ static int __init crash_notes_memory_init(void)
 	}
 	return 0;
 }
-module_init(crash_notes_memory_init)
 
 
 /*
@@ -1520,7 +1519,13 @@ static int __init crash_save_vmcoreinfo_init(void)
 	return 0;
 }
 
-module_init(crash_save_vmcoreinfo_init)
+static int __init crash_init(void)
+{
+	crash_notes_memory_init();
+	crash_save_vmcoreinfo_init();
+	return 0;
+}
+module_init(crash_init)
 
 /*
  * Move into place and start executing a preloaded standalone
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
