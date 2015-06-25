Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z82Uk-0005Aw-AW
 for kexec@lists.infradead.org; Thu, 25 Jun 2015 08:26:52 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
 [127.0.0.1])
 by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t5P8OmQ0017709
 for <kexec@lists.infradead.org>; Thu, 25 Jun 2015 16:24:48 +0800
From: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
Subject: [PATCH 2/2] makedumpfile: Optimise the function reserve_diskspace
Date: Thu, 25 Jun 2015 16:22:56 +0800
Message-ID: <1435220576-32595-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
References: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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

In current implementation, reserve_diskspace use the buffer as large as
the space that needs to be reserved. The space is reserved for PT_LOAD.
Theoretically the size of the whole PT_LOAD can be very large. So it's
necessary to make reserve_diskspace use a limited size of memory.

Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>
---
 makedumpfile.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 88e3389..f7f1f77 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -3801,7 +3801,8 @@ read_flat_data_header(struct makedumpfile_data_header *fdh)
 int
 reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
 {
-	size_t buf_size;
+	off_t off;
+	size_t buf_size, write_size;
 	char *buf = NULL;
 
 	int ret = FALSE;
@@ -3809,6 +3810,7 @@ reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
 	assert(start_offset < end_offset);
 	buf_size = end_offset - start_offset;
 
+	buf_size = MIN(info->page_size, buf_size);
 	if ((buf = malloc(buf_size)) == NULL) {
 		ERRMSG("Can't allocate memory for the size of reserved diskspace. %s\n",
 		       strerror(errno));
@@ -3816,8 +3818,15 @@ reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
 	}
 
 	memset(buf, 0, buf_size);
-	if (!write_buffer(fd, start_offset, buf, buf_size, file_name))
-		goto out;
+	off = start_offset;
+
+	while (off < end_offset) {
+		write_size = MIN(buf_size, end_offset - off);
+		if (!write_buffer(fd, off, buf, write_size, file_name))
+			goto out;
+
+		off += write_size;
+	}
 
 	ret = TRUE;
 out:
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
