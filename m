Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wc8nD-0004qG-Sb
 for kexec@lists.infradead.org; Mon, 21 Apr 2014 07:37:32 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: code cleanup: set_bitmap
Date: Mon, 21 Apr 2014 07:33:47 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97205CAA@BPXM01GP.gisp.nec.co.jp>
References: <1397456126-81299-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1397456126-81299-1-git-send-email-wangnan0@huawei.com>
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
To: "wangnan0@huawei.com" <wangnan0@huawei.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "hui.geng@huawei.com" <hui.geng@huawei.com>

Hello Wang,

>This patch makes set_bitmap() to call sync_bitmap() instead rewrite
>identical code to do same thing.

I found a simple mistake.

>@@ -3317,20 +3345,11 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
> 	old_offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
> 	new_offset = bitmap->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
>
>-	if (0 <= bitmap->no_block && old_offset != new_offset) {
>-		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {
>-			ERRMSG("Can't seek the bitmap(%s). %s\n",
>-			    bitmap->file_name, strerror(errno));
>-			return FALSE;
>-		}
>-		if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
>-		    != BUFSIZE_BITMAP) {
>-			ERRMSG("Can't write the bitmap(%s). %s\n",
>-			    bitmap->file_name, strerror(errno));
>+	if (old_offset != new_offset) {
>+		if (sync_bitmap(bitmap)) {
>+			ERRMSG("Can't sync bitmap\n");
> 			return FALSE;
> 		}

sync_bitmap() returns TRUE(1) when it succeeds, so this check is wrong.


Thanks
Atsushi Kumagai

>-	}
>-	if (old_offset != new_offset) {
> 		if (lseek(bitmap->fd, new_offset, SEEK_SET) < 0 ) {
> 			ERRMSG("Can't seek the bitmap(%s). %s\n",
> 			    bitmap->file_name, strerror(errno));
>@@ -3379,33 +3398,6 @@ set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *c
> }
>
> int
>-sync_bitmap(struct dump_bitmap *bitmap)
>-{
>-	off_t offset;
>-	offset = bitmap->offset + BUFSIZE_BITMAP * bitmap->no_block;
>-
>-	/*
>-	 * The bitmap buffer is not dirty, and it is not necessary
>-	 * to write out it.
>-	 */
>-	if (bitmap->no_block < 0)
>-		return TRUE;
>-
>-	if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
>-		ERRMSG("Can't seek the bitmap(%s). %s\n",
>-		    bitmap->file_name, strerror(errno));
>-		return FALSE;
>-	}
>-	if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
>-	    != BUFSIZE_BITMAP) {
>-		ERRMSG("Can't write the bitmap(%s). %s\n",
>-		    bitmap->file_name, strerror(errno));
>-		return FALSE;
>-	}
>-	return TRUE;
>-}
>-
>-int
> sync_1st_bitmap(void)
> {
> 	return sync_bitmap(info->bitmap1);
>--
>1.8.5.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
