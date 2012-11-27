Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Td9GP-0004Rl-Vm
 for kexec@lists.infradead.org; Tue, 27 Nov 2012 00:43:02 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7CD963EE0C0
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:43:00 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 62B2545DE52
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:43:00 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 492F145DE4E
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:43:00 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 393DF1DB8041
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:43:00 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id D57EE1DB803F
 for <kexec@lists.infradead.org>; Tue, 27 Nov 2012 09:42:59 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Message-Id: <20121127004213.3604.53413.sendpatchset@tindoh.g01.fujitsu.local>
In-Reply-To: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
Subject: [PATCH v7 3/5] Make reset_devices available at early stage
Date: Tue, 27 Nov 2012 09:42:59 +0900 (JST)
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
To: linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, kexec@lists.infradead.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

Change reset_devices from __setup to early_param so this parameter is
available at early stage.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 init/main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index e33e09d..f2b24cb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -144,10 +144,10 @@ EXPORT_SYMBOL(reset_devices);
 static int __init set_reset_devices(char *str)
 {
 	reset_devices = 1;
-	return 1;
+	return 0;
 }
 
-__setup("reset_devices", set_reset_devices);
+early_param("reset_devices", set_reset_devices);
 
 static const char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 const char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
-- 
1.7.1



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
