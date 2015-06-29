Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z9UZ2-000625-WF
 for kexec@lists.infradead.org; Mon, 29 Jun 2015 08:37:18 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 2/2] makedumpfile: Optimise the function reserve_diskspace
Date: Mon, 29 Jun 2015 08:33:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DCA52D@BPXM01GP.gisp.nec.co.jp>
References: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
 <1435220576-32595-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1435220576-32595-2-git-send-email-zhouwj-fnst@cn.fujitsu.com>
Content-Language: ja-JP
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Zhou,

>In current implementation, reserve_diskspace use the buffer as large as
>the space that needs to be reserved. The space is reserved for PT_LOAD.
>Theoretically the size of the whole PT_LOAD can be very large. So it's
>necessary to make reserve_diskspace use a limited size of memory.
>
>Signed-off-by: Zhou wenjian <zhouwj-fnst@cn.fujitsu.com>

Looks good to me, thanks.
I'll merge this into v1.5.9.


Thanks
Atsushi Kumagai

>---
> makedumpfile.c |   15 ++++++++++++---
> 1 files changed, 12 insertions(+), 3 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 88e3389..f7f1f77 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -3801,7 +3801,8 @@ read_flat_data_header(struct makedumpfile_data_header *fdh)
> int
> reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
> {
>-	size_t buf_size;
>+	off_t off;
>+	size_t buf_size, write_size;
> 	char *buf = NULL;
>
> 	int ret = FALSE;
>@@ -3809,6 +3810,7 @@ reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
> 	assert(start_offset < end_offset);
> 	buf_size = end_offset - start_offset;
>
>+	buf_size = MIN(info->page_size, buf_size);
> 	if ((buf = malloc(buf_size)) == NULL) {
> 		ERRMSG("Can't allocate memory for the size of reserved diskspace. %s\n",
> 		       strerror(errno));
>@@ -3816,8 +3818,15 @@ reserve_diskspace(int fd, off_t start_offset, off_t end_offset, char *file_name)
> 	}
>
> 	memset(buf, 0, buf_size);
>-	if (!write_buffer(fd, start_offset, buf, buf_size, file_name))
>-		goto out;
>+	off = start_offset;
>+
>+	while (off < end_offset) {
>+		write_size = MIN(buf_size, end_offset - off);
>+		if (!write_buffer(fd, off, buf, write_size, file_name))
>+			goto out;
>+
>+		off += write_size;
>+	}
>
> 	ret = TRUE;
> out:
>--
>1.7.1
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
