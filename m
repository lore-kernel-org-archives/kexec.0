Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZpAwC-0006d1-J0
 for kexec@lists.infradead.org; Thu, 22 Oct 2015 08:09:29 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 1/2] sadump, bugfix: change bit order
Date: Thu, 22 Oct 2015 08:06:17 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DF6A47@BPXM01GP.gisp.nec.co.jp>
References: <20151020.160741.273311739.d.hatayama@jp.fujitsu.com>
In-Reply-To: <20151020.160741.273311739.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "indou.takao@jp.fujitsu.com" <indou.takao@jp.fujitsu.com>

Hello HATAYAMA-san,

I'll merge these two patches into v1.5.9.

Thanks,
Atsushi Kumagai

>sadump formats associate each bit in a bitmap with a physical page in
>reverse order with the kdump-compressed format.
>
>We had not detected this bug for considerably long term because
>bitmaps in sadump formats consist mostly of 0x00 and 0xff excluding a
>very limited amount of memory space for firmware.
>
>Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
>Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>---
> sadump_info.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 73 insertions(+), 2 deletions(-)
>
>diff --git a/sadump_info.c b/sadump_info.c
>index e2c4f03..e30b802 100644
>--- a/sadump_info.c
>+++ b/sadump_info.c
>@@ -85,6 +85,7 @@ struct sadump_info {
> 	unsigned long long backup_offset;
> 	int kdump_backed_up;
> 	mdf_pfn_t max_mapnr;
>+	struct dump_bitmap *ram_bitmap;
> };
>
> static char *guid_to_str(efi_guid_t *guid, char *buf, size_t buflen);
>@@ -127,6 +128,35 @@ static int get_registers(int cpu, struct elf_prstatus *prstatus);
> static struct sadump_info sadump_info = {};
> static struct sadump_info *si = &sadump_info;
>
>+static inline int
>+sadump_is_on(char *bitmap, mdf_pfn_t i)
>+{
>+	return bitmap[i >> 3] & (1 << (7 - (i & 7)));
>+}
>+
>+static inline int
>+sadump_is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
>+{
>+	off_t offset;
>+
>+	if (pfn == 0 || bitmap->no_block != pfn/PFN_BUFBITMAP) {
>+		offset = bitmap->offset + BUFSIZE_BITMAP*(pfn/PFN_BUFBITMAP);
>+		lseek(bitmap->fd, offset, SEEK_SET);
>+		read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP);
>+		if (pfn == 0)
>+			bitmap->no_block = 0;
>+		else
>+			bitmap->no_block = pfn / PFN_BUFBITMAP;
>+	}
>+	return sadump_is_on(bitmap->buf, pfn % PFN_BUFBITMAP);
>+}
>+
>+static inline int
>+sadump_is_ram(mdf_pfn_t pfn)
>+{
>+	return sadump_is_dumpable(si->ram_bitmap, pfn);
>+}
>+
> int
> check_and_get_sadump_header_info(char *filename)
> {
>@@ -161,6 +191,21 @@ check_and_get_sadump_header_info(char *filename)
> 	return TRUE;
> }
>
>+static void
>+reverse_bit(char *buf, int len)
>+{
>+	int i;
>+	unsigned char c;
>+
>+	for (i = 0; i < len; i++) {
>+		c = buf[i];
>+		c = ((c & 0x55) << 1) | ((c & 0xaa) >> 1); /* Swap 1bit */
>+		c = ((c & 0x33) << 2) | ((c & 0xcc) >> 2); /* Swap 2bit */
>+		c = (c << 4) | (c >> 4); /* Swap 4bit */
>+		buf[i] = c;
>+	}
>+}
>+
> int
> sadump_copy_1st_bitmap_from_memory(void)
> {
>@@ -189,6 +234,14 @@ sadump_copy_1st_bitmap_from_memory(void)
> 			       info->name_memory, strerror(errno));
> 			return FALSE;
> 		}
>+		/*
>+		 * sadump formats associate each bit in a bitmap with
>+		 * a physical page in reverse order with the
>+		 * kdump-compressed format. We need to change bit
>+		 * order to reuse bitmaps in sadump formats in the
>+		 * kdump-compressed format.
>+		 */
>+		reverse_bit(buf, sizeof(buf));
> 		if (write(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
> 			ERRMSG("Can't write the bitmap(%s). %s\n",
> 			       info->bitmap1->file_name, strerror(errno));
>@@ -812,6 +865,19 @@ sadump_initialize_bitmap_memory(void)
> 	info->bitmap_memory = bmp;
> 	si->block_table = block_table;
>
>+	bmp = malloc(sizeof(struct dump_bitmap));
>+	if (bmp == NULL) {
>+		ERRMSG("Can't allocate memory for the memory-bitmap. %s\n",
>+		       strerror(errno));
>+		return FALSE;
>+	}
>+	bmp->fd = info->fd_memory;
>+	bmp->file_name = info->name_memory;
>+	bmp->no_block = -1;
>+	memset(bmp->buf, 0, BUFSIZE_BITMAP);
>+	bmp->offset = si->sub_hdr_offset + sh->block_size * sh->sub_hdr_size;
>+	si->ram_bitmap = bmp;
>+
> 	return TRUE;
> }
>
>@@ -981,7 +1047,12 @@ readpage_sadump(unsigned long long paddr, void *bufptr)
> 	if (pfn >= si->max_mapnr)
> 		return FALSE;
>
>-	if (!is_dumpable(info->bitmap_memory, pfn)) {
>+	if (!sadump_is_ram(pfn)) {
>+		ERRMSG("pfn(%llx) is not ram.\n", pfn);
>+		return FALSE;
>+	}
>+
>+	if (!sadump_is_dumpable(info->bitmap_memory, pfn)) {
> 		ERRMSG("pfn(%llx) is excluded from %s.\n", pfn,
> 		       info->name_memory);
> 		return FALSE;
>@@ -1146,7 +1217,7 @@ pfn_to_block(mdf_pfn_t pfn)
> 		block = 0;
>
> 	for (p = section * SADUMP_PF_SECTION_NUM; p < pfn; ++p)
>-		if (is_dumpable(info->bitmap_memory, p))
>+		if (sadump_is_dumpable(info->bitmap_memory, p))
> 			block++;
>
> 	return block;
>--
>1.9.3
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
