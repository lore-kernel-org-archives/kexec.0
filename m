Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xg34P-000808-8i
 for kexec@lists.infradead.org; Mon, 20 Oct 2014 02:51:41 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s9K2pJgw001331
 for <kexec@lists.infradead.org>; Mon, 20 Oct 2014 10:51:19 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH v4 4/4] makedumpfile: Fix reassemble_kdump_header()
Date: Mon, 20 Oct 2014 10:48:46 +0800
Message-ID: <1413773326-16075-5-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1413773326-16075-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1413773326-16075-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: kexec@lists.infradead.org

fix it to take over incomplete flags of all dump file

Singed-of-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 4dba83e..f072069 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -8695,8 +8695,14 @@ reassemble_kdump_header(void)
 	/*
 	 * Write common header.
 	 */
-	if (!read_disk_dump_header(&dh, SPLITTING_DUMPFILE(0)))
-		return FALSE;
+	int i;
+	for ( i = 0; i < info->num_dumpfile; i++){
+		if (!read_disk_dump_header(&dh, SPLITTING_DUMPFILE(i)))
+			return FALSE;
+		int status = dh.status & DUMP_DH_COMPRESSED_INCOMPLETE;
+		if (status)
+			break;
+	}
 
 	if (lseek(info->fd_dumpfile, 0x0, SEEK_SET) < 0) {
 		ERRMSG("Can't seek a file(%s). %s\n",
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
