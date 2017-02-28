Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1ciaim-0006Wy-3v
 for kexec@lists.infradead.org; Tue, 28 Feb 2017 05:53:13 +0000
Received: by mail-pf0-f176.google.com with SMTP id x66so1185892pfb.3
 for <kexec@lists.infradead.org>; Mon, 27 Feb 2017 21:52:51 -0800 (PST)
From: Pratyush Anand <panand@redhat.com>
Subject: [Makedumpfile Patch v2 2/7] initial(): call cach_init() a bit early
Date: Tue, 28 Feb 2017 11:22:36 +0530
Message-Id: <17681897e6f793895e0dcfd3b83eb07f25ae6ed5.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
In-Reply-To: <cover.1488260510.git.panand@redhat.com>
References: <cover.1488260510.git.panand@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: ats-kumagai@wm.jp.nec.com
Cc: Pratyush Anand <panand@redhat.com>, dyoung@redhat.com, kexec@lists.infradead.org, bhe@redhat.com

Call cach_init() before get_kcore_dump_loads(), because latter uses
cache_search().

Call path is like this :
get_kcore_dump_loads() -> process_dump_load() -> vaddr_to_paddr() ->
vtop4_x86_64() -> readmem() -> cache_search()

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 makedumpfile.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 6942047199de..3b8e9810468d 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3878,6 +3878,9 @@ initial(void)
 	if (!get_value_for_old_linux())
 		return FALSE;
 
+	if (!is_xen_memory() && !cache_init())
+		return FALSE;
+
 	if (info->flag_mem_usage && !get_kcore_dump_loads())
 		return FALSE;
 
@@ -4000,9 +4003,6 @@ out:
 		}
 	}
 
-	if (!is_xen_memory() && !cache_init())
-		return FALSE;
-
 	if (debug_info && !get_machdep_info())
 		return FALSE;
 
-- 
2.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
