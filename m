Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZTiFA-0004MH-9W
 for kexec@lists.infradead.org; Mon, 24 Aug 2015 03:16:20 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 262BA461D9
 for <kexec@lists.infradead.org>; Mon, 24 Aug 2015 03:15:59 +0000 (UTC)
From: Chao Fan <cfan@redhat.com>
Subject: [PATCH]makedumpfile.h:makedumpfile.h: check the return value
Date: Mon, 24 Aug 2015 11:15:51 +0800
Message-Id: <1440386153-21638-1-git-send-email-cfan@redhat.com>
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
Cc: Chao Fan <cfan@redhat.com>

makedumpfile.h:1748: check_return: Calling function "lseek" without
checking return value.

makedumpfile.c:3394: example_checked: "lseek(bitmap->fd, offset,
SEEK_SET);" has its value checked, But in makedumpfile.h:1748, the
function will not check the return value.

Signed-off-by: Chao Fan <cfan@redhat.com>
---
 makedumpfile.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/makedumpfile.h b/makedumpfile.h
index d2fadbd..b8b44e0 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1745,7 +1745,12 @@ is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
 	off_t offset;
 	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
 		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
-		lseek(bitmap->fd, offset, SEEK_SET);
+		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {
+			ERRMSG("Can't seek the bitmap(%s). %s\n",
+				bitmap->file_name, strerror(errno));
+			return FALSE;
+		}
+
 		read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
 		if (pfn == 0)
 			bitmap->no_block = 0;
-- 
2.4.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
