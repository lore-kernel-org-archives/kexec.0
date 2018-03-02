Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1erdZ9-00057u-Ue
 for kexec@lists.infradead.org; Fri, 02 Mar 2018 05:49:17 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 3/4] Makedumpfile: Add a new function check_5level_paging()
Date: Fri,  2 Mar 2018 13:48:40 +0800
Message-Id: <20180302054841.22195-4-bhe@redhat.com>
In-Reply-To: <20180302054841.22195-1-bhe@redhat.com>
References: <20180302054841.22195-1-bhe@redhat.com>
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
Cc: douly.fnst@cn.fujitsu.com, indou.takao@jp.fujitsu.com, mas-hayashi@tg.jp.nec.com, Baoquan He <bhe@redhat.com>, mas-tachibana@vf.jp.nec.com

Use it to check if the corrupted kernel is in 5-level paging.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86_64.c b/arch/x86_64.c
index cbe45c2..e88ee0b 100644
--- a/arch/x86_64.c
+++ b/arch/x86_64.c
@@ -33,6 +33,15 @@ get_xen_p2m_mfn(void)
 	return NOT_FOUND_LONG_VALUE;
 }
 
+static int
+check_5level_paging(void)
+{
+	if (NUMBER(pgtable_l5_enabled) != 0)
+		return TRUE;
+	else
+		return FALSE;
+}
+
 unsigned long
 get_kaslr_offset_x86_64(unsigned long vaddr)
 {
-- 
2.13.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
