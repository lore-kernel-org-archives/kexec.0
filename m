Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZU4ES-000425-VZ
 for kexec@lists.infradead.org; Tue, 25 Aug 2015 02:45:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] makedumpfile: code changes to satisfy the coverity scan
Date: Tue, 25 Aug 2015 02:43:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DE53E9@BPXM01GP.gisp.nec.co.jp>
References: <1440405959-27044-1-git-send-email-cfan@redhat.com>
In-Reply-To: <1440405959-27044-1-git-send-email-cfan@redhat.com>
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
To: Chao Fan <cfan@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Chao,

>Coverity scan found some uncheked return value when calling
>function. So the return value of the function set_page_size
>and lseek should be checked to satisfy the coverity scan.
>
>In the function read_sadump_header, block_size is defined as an
>unsigned long value, and it will never be less than zero, so this
>comparison should be removed.
>
>Signed-off-by: Chao Fan <cfan@redhat.com>
>---
> makedumpfile.c | 3 ++-
> makedumpfile.h | 6 +++++-
> sadump_info.c  | 3 ---
> 3 files changed, 7 insertions(+), 5 deletions(-)
>
>diff --git a/makedumpfile.c b/makedumpfile.c
>index 32f5459..53efc04 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -3213,7 +3213,8 @@ initial(void)
> 			MSG("because the cyclic mode doesn't support sadump format.\n");
> 		}
>
>-		set_page_size(sadump_page_size());
>+		if (!set_page_size(sadump_page_size()))
>+			return FALSE;
>
> 		if (!sadump_initialize_bitmap_memory())
> 			return FALSE;
>diff --git a/makedumpfile.h b/makedumpfile.h
>index d2fadbd..679e075 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -1745,7 +1745,11 @@ is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
> 	off_t offset;
> 	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
> 		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>-		lseek(bitmap->fd, offset, SEEK_SET);
>+		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {

s/old_offset/offset/

>+			ERRMSG("Can't seek the bitmap(%s). %s\n",
>+				bitmap->file_name, strerror(errno));
>+			return FALSE;

You have to include print_info.h to use ERRMSG.


Thanks,
Atsushi Kumagai

>+		}
> 		read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
> 		if (pfn == 0)
> 			bitmap->no_block = 0;
>diff --git a/sadump_info.c b/sadump_info.c
>index e2c4f03..e8154f4 100644
>--- a/sadump_info.c
>+++ b/sadump_info.c
>@@ -465,9 +465,6 @@ read_sadump_header(char *filename)
> 	smh = si->smh_memory;
>
> restart:
>-	if (block_size < 0)
>-		return FALSE;
>-
> 	if (!read_device(sph, block_size, &offset))
> 		return ERROR;
>
>--
>2.4.3

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
