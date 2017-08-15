Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dhWHv-0002ta-2J
 for kexec@lists.infradead.org; Tue, 15 Aug 2017 07:29:19 +0000
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 1/2] makedumpfile/ppc64: set page_offset in
 get_versiondep_info_ppc64()
Date: Tue, 15 Aug 2017 15:21:05 +0800
Message-Id: <1502781666-20987-2-git-send-email-piliu@redhat.com>
In-Reply-To: <1502781666-20987-1-git-send-email-piliu@redhat.com>
References: <1502781666-20987-1-git-send-email-piliu@redhat.com>
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
To: kexec@lists.infradead.org
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>

Envalue info->page_offset in get_versiondep_info_ppc64() is a little
misleading. But since show_mem_usage->get_page_offset->get_versiondep_info
needs to get this info, so initialize it in get_versiondep_info_ppc64().

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 arch/ppc64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index 6aeab7e..3fd6002 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -576,6 +576,7 @@ get_versiondep_info_ppc64()
 		ERRMSG("Can't initialize for vmalloc translation\n");
 		return FALSE;
 	}
+	info->page_offset = __PAGE_OFFSET;
 
 	return TRUE;
 }
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
