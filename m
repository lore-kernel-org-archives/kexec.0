Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from szxga02-in.huawei.com ([119.145.14.65])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wdu0O-0002zc-D8
 for kexec@lists.infradead.org; Sat, 26 Apr 2014 04:14:26 +0000
From: Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 4/4] makedumpfile: use pread/pwrite to eliminate lseek
Date: Sat, 26 Apr 2014 12:07:09 +0800
Message-ID: <1398485229-43295-5-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
References: <1398485229-43295-1-git-send-email-wangnan0@huawei.com>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: Wang Nan <wangnan0@huawei.com>, Liu Hua <sdu.liu@huawei.com>, Petr Tesarik <ptesarik@suse.cz>, kexec@lists.infradead.org, Geng Hui <hui.geng@huawei.com>

Original code use lseek..read/write pattern for read from/write to
specific position of a file. This patch replaces them by pread/pwrite,
reduces more than 100 LOC.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: Petr Tesarik <ptesarik@suse.cz>
Cc: kexec@lists.infradead.org
Cc: Geng Hui <hui.geng@huawei.com>
Cc: Liu Hua <sdu.liu@huawei.com>
---
 makedumpfile.c | 188 +++++++++++----------------------------------------------
 1 file changed, 36 insertions(+), 152 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 33c378d..934db88 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -25,6 +25,8 @@
 #include <sys/time.h>
 #include <limits.h>
 
+#include <unistd.h>
+
 struct symbol_table	symbol_table;
 struct size_table	size_table;
 struct offset_table	offset_table;
@@ -259,16 +261,11 @@ read_page_desc(unsigned long long paddr, page_desc_t *pd)
 	pfn = paddr_to_pfn(paddr);
 	desc_pos = pfn_to_pos(pfn);
 	offset += (off_t)desc_pos * sizeof(page_desc_t);
-	if (lseek(info->fd_memory, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek %s. %s\n",
-				 info->name_memory, strerror(errno));
-		return FALSE;
-	}
 
 	/*
 	 * Read page descriptor
 	 */
-	if (read(info->fd_memory, pd, sizeof(*pd)) != sizeof(*pd)) {
+	if (pread(info->fd_memory, pd, sizeof(*pd), offset) != sizeof(*pd)) {
 		ERRMSG("Can't read %s. %s\n",
 				info->name_memory, strerror(errno));
 		return FALSE;
@@ -374,8 +371,6 @@ next_region:
 static int
 read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 {
-	const off_t failed = (off_t)-1;
-
 	if (info->flag_usemmap == MMAP_ENABLE &&
 	    page_is_fractional(offset) == FALSE) {
 		if (!read_with_mmap(offset, bufptr, size)) {
@@ -392,13 +387,7 @@ read_from_vmcore(off_t offset, void *bufptr, unsigned long size)
 			read_from_vmcore(offset, bufptr, size);
 		}
 	} else {
-		if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-			ERRMSG("Can't seek the dump memory(%s). (offset: %llx) %s\n",
-			       info->name_memory, (unsigned long long)offset, strerror(errno));
-			return FALSE;
-		}
-
-		if (read(info->fd_memory, bufptr, size) != size) {
+		if (pread(info->fd_memory, bufptr, size, offset) != size) {
 			ERRMSG("Can't read the dump memory(%s). %s\n",
 			       info->name_memory, strerror(errno));
 			return FALSE;
@@ -520,18 +509,12 @@ readpage_kdump_compressed(unsigned long long paddr, void *bufptr)
 		return FALSE;
 	}
 
-	if (lseek(info->fd_memory, pd.offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek %s. %s\n",
-				info->name_memory, strerror(errno));
-		return FALSE;
-	}
-
 	/*
 	 * Read page data
 	 */
 	rdbuf = pd.flags & (DUMP_DH_COMPRESSED_ZLIB | DUMP_DH_COMPRESSED_LZO |
 		DUMP_DH_COMPRESSED_SNAPPY) ? buf : bufptr;
-	if (read(info->fd_memory, rdbuf, pd.size) != pd.size) {
+	if (pread(info->fd_memory, rdbuf, pd.size, pd.offset) != pd.size) {
 		ERRMSG("Can't read %s. %s\n",
 				info->name_memory, strerror(errno));
 		return FALSE;
@@ -1555,7 +1538,6 @@ get_str_osrelease_from_vmlinux(void)
 	struct utsname system_utsname;
 	unsigned long long utsname;
 	off_t offset;
-	const off_t failed = (off_t)-1;
 
 	/*
 	 * Get the kernel version.
@@ -1576,11 +1558,7 @@ get_str_osrelease_from_vmlinux(void)
 		    utsname);
 		return FALSE;
 	}
-	if (lseek(fd, offset, SEEK_SET) == failed) {
-		ERRMSG("Can't seek %s. %s\n", name, strerror(errno));
-		return FALSE;
-	}
-	if (read(fd, &system_utsname, sizeof system_utsname)
+	if (pread(fd, &system_utsname, sizeof(system_utsname), offset)
 	    != sizeof system_utsname) {
 		ERRMSG("Can't read %s. %s\n", name, strerror(errno));
 		return FALSE;
@@ -2124,7 +2102,6 @@ copy_vmcoreinfo(off_t offset, unsigned long size)
 {
 	int fd;
 	char buf[VMCOREINFO_BYTES];
-	const off_t failed = (off_t)-1;
 
 	if (!offset || !size)
 		return FALSE;
@@ -2134,12 +2111,7 @@ copy_vmcoreinfo(off_t offset, unsigned long size)
 		    info->name_vmcoreinfo, strerror(errno));
 		return FALSE;
 	}
-	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		    info->name_memory, strerror(errno));
-		return FALSE;
-	}
-	if (read(info->fd_memory, &buf, size) != size) {
+	if (pread(info->fd_memory, &buf, size, offset) != size) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		    info->name_memory, strerror(errno));
 		return FALSE;
@@ -3318,12 +3290,7 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
 	new_offset = bitmap->offset + BUFSIZE_BITMAP * (pfn / PFN_BUFBITMAP);
 
 	if (0 <= bitmap->no_block && old_offset != new_offset) {
-		if (lseek(bitmap->fd, old_offset, SEEK_SET) < 0 ) {
-			ERRMSG("Can't seek the bitmap(%s). %s\n",
-			    bitmap->file_name, strerror(errno));
-			return FALSE;
-		}
-		if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
+		if (pwrite(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP, old_offset)
 		    != BUFSIZE_BITMAP) {
 			ERRMSG("Can't write the bitmap(%s). %s\n",
 			    bitmap->file_name, strerror(errno));
@@ -3331,12 +3298,7 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
 		}
 	}
 	if (old_offset != new_offset) {
-		if (lseek(bitmap->fd, new_offset, SEEK_SET) < 0 ) {
-			ERRMSG("Can't seek the bitmap(%s). %s\n",
-			    bitmap->file_name, strerror(errno));
-			return FALSE;
-		}
-		if (read(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
+		if (pread(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP, new_offset)
 		    != BUFSIZE_BITMAP) {
 			ERRMSG("Can't read the bitmap(%s). %s\n",
 			    bitmap->file_name, strerror(errno));
@@ -3398,12 +3360,7 @@ sync_bitmap(struct dump_bitmap *bitmap)
 	if (bitmap->no_block < 0)
 		return TRUE;
 
-	if (lseek(bitmap->fd, offset, SEEK_SET) < 0 ) {
-		ERRMSG("Can't seek the bitmap(%s). %s\n",
-		    bitmap->file_name, strerror(errno));
-		return FALSE;
-	}
-	if (write(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP)
+	if (pwrite(bitmap->fd, bitmap->buf, BUFSIZE_BITMAP, offset)
 	    != BUFSIZE_BITMAP) {
 		ERRMSG("Can't write the bitmap(%s). %s\n",
 		    bitmap->file_name, strerror(errno));
@@ -3519,14 +3476,7 @@ is_in_segs(unsigned long long paddr)
 int
 read_cache(struct cache_data *cd)
 {
-	const off_t failed = (off_t)-1;
-
-	if (lseek(cd->fd, cd->offset, SEEK_SET) == failed) {
-		ERRMSG("Can't seek the dump file(%s). %s\n",
-		    cd->file_name, strerror(errno));
-		return FALSE;
-	}
-	if (read(cd->fd, cd->buf, cd->cache_size) != cd->cache_size) {
+	if (pread(cd->fd, cd->buf, cd->cache_size, cd->offset) != cd->cache_size) {
 		ERRMSG("Can't read the dump file(%s). %s\n",
 		    cd->file_name, strerror(errno));
 		return FALSE;
@@ -4892,24 +4842,16 @@ copy_bitmap(void)
 
 	offset = 0;
 	while (offset < (info->len_bitmap / 2)) {
-		if (lseek(info->bitmap1->fd, info->bitmap1->offset + offset,
-		    SEEK_SET) == failed) {
-			ERRMSG("Can't seek the bitmap(%s). %s\n",
-			    info->name_bitmap, strerror(errno));
-			return FALSE;
-		}
-		if (read(info->bitmap1->fd, buf, sizeof(buf)) != sizeof(buf)) {
+		if (pread(info->bitmap1->fd, buf, sizeof(buf),
+					info->bitmap1->offset + offset)
+				!= sizeof(buf)) {
 			ERRMSG("Can't read the dump memory(%s). %s\n",
 			    info->name_memory, strerror(errno));
 			return FALSE;
 		}
-		if (lseek(info->bitmap2->fd, info->bitmap2->offset + offset,
-		    SEEK_SET) == failed) {
-			ERRMSG("Can't seek the bitmap(%s). %s\n",
-			    info->name_bitmap, strerror(errno));
-			return FALSE;
-		}
-		if (write(info->bitmap2->fd, buf, sizeof(buf)) != sizeof(buf)) {
+		if (pwrite(info->bitmap2->fd, buf, sizeof(buf),
+					info->bitmap2->offset + offset)
+				!= sizeof(buf)) {
 			ERRMSG("Can't write the bitmap(%s). %s\n",
 		    	info->name_bitmap, strerror(errno));
 			return FALSE;
@@ -5456,12 +5398,8 @@ write_elf_header(struct cache_data *cd_header)
 		    strerror(errno));
 		goto out;
 	}
-	if (lseek(info->fd_memory, offset_note_memory, SEEK_SET) == failed) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		    info->name_memory, strerror(errno));
-		goto out;
-	}
-	if (read(info->fd_memory, buf, size_note) != size_note) {
+	if (pread(info->fd_memory, buf, size_note, offset_note_memory)
+			!= size_note) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		    info->name_memory, strerror(errno));
 		goto out;
@@ -5570,12 +5508,8 @@ write_kdump_header(void)
 		}
 
 		if (!info->flag_sadump) {
-			if (lseek(info->fd_memory, offset_note, SEEK_SET) < 0) {
-				ERRMSG("Can't seek the dump memory(%s). %s\n",
-				       info->name_memory, strerror(errno));
-				goto out;
-			}
-			if (read(info->fd_memory, buf, size_note) != size_note) {
+			if (pread(info->fd_memory, buf, size_note, offset_note)
+					!= size_note) {
 				ERRMSG("Can't read the dump memory(%s). %s\n",
 				       info->name_memory, strerror(errno));
 				goto out;
@@ -6586,12 +6520,7 @@ copy_eraseinfo(struct cache_data *cd_eraseinfo)
 		    strerror(errno));
 		return FALSE;
 	}
-	if (lseek(info->fd_memory, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		    info->name_memory, strerror(errno));
-		goto out;
-	}
-	if (read(info->fd_memory, buf, size) != size) {
+	if (pread(info->fd_memory, buf, size, offset) != size) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		    info->name_memory, strerror(errno));
 		goto out;
@@ -7169,12 +7098,8 @@ init_xen_crash_info(void)
 		return FALSE;
 	}
 
-	if (lseek(info->fd_memory, offset_xen_crash_info, SEEK_SET) < 0) {
-		ERRMSG("Can't seek the dump memory(%s). %s\n",
-		       info->name_memory, strerror(errno));
-		return FALSE;
-	}
-	if (read(info->fd_memory, buf, size_xen_crash_info)
+	if (pread(info->fd_memory, buf, size_xen_crash_info,
+				offset_xen_crash_info)
 	    != size_xen_crash_info) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		       info->name_memory, strerror(errno));
@@ -8155,12 +8080,7 @@ __read_disk_dump_header(struct disk_dump_header *dh, char *filename)
 		    filename, strerror(errno));
 		return FALSE;
 	}
-	if (lseek(fd, 0x0, SEEK_SET) < 0) {
-		ERRMSG("Can't seek a file(%s). %s\n",
-		    filename, strerror(errno));
-		goto out;
-	}
-	if (read(fd, dh, sizeof(struct disk_dump_header))
+	if (pread(fd, dh, sizeof(struct disk_dump_header), 0x0)
 	    != sizeof(struct disk_dump_header)) {
 		ERRMSG("Can't read a file(%s). %s\n",
 		    filename, strerror(errno));
@@ -8204,12 +8124,7 @@ read_kdump_sub_header(struct kdump_sub_header *kh, char *filename)
 		    filename, strerror(errno));
 		return FALSE;
 	}
-	if (lseek(fd, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek a file(%s). %s\n",
-		    filename, strerror(errno));
-		goto out;
-	}
-	if (read(fd, kh, sizeof(struct kdump_sub_header))
+	if (pread(fd, kh, sizeof(struct kdump_sub_header), offset)
 	     != sizeof(struct kdump_sub_header)) {
 		ERRMSG("Can't read a file(%s). %s\n",
 		    filename, strerror(errno));
@@ -8373,19 +8288,11 @@ copy_same_data(int src_fd, int dst_fd, off_t offset, unsigned long size)
 		ERRMSG("Can't allocate memory.\n");
 		return FALSE;
 	}
-	if (lseek(src_fd, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek a source file. %s\n", strerror(errno));
-		goto out;
-	}
-	if (read(src_fd, buf, size) != size) {
+	if (pread(src_fd, buf, size, offset) != size) {
 		ERRMSG("Can't read a source file. %s\n", strerror(errno));
 		goto out;
 	}
-	if (lseek(dst_fd, offset, SEEK_SET) < 0) {
-		ERRMSG("Can't seek a destination file. %s\n", strerror(errno));
-		goto out;
-	}
-	if (write(dst_fd, buf, size) != size) {
+	if (pwrite(pdst_fd, buf, size, offset) != size) {
 		ERRMSG("Can't write a destination file. %s\n", strerror(errno));
 		goto out;
 	}
@@ -8412,12 +8319,7 @@ reassemble_kdump_header(void)
 	if (!read_disk_dump_header(&dh, SPLITTING_DUMPFILE(0)))
 		return FALSE;
 
-	if (lseek(info->fd_dumpfile, 0x0, SEEK_SET) < 0) {
-		ERRMSG("Can't seek a file(%s). %s\n",
-		    info->name_dumpfile, strerror(errno));
-		return FALSE;
-	}
-	if (write(info->fd_dumpfile, &dh, sizeof(dh)) != sizeof(dh)) {
+	if (pwrite(info->fd_dumpfile, &dh, sizeof(dh), 0x0) != sizeof(dh)) {
 		ERRMSG("Can't write a file(%s). %s\n",
 		    info->name_dumpfile, strerror(errno));
 		return FALSE;
@@ -8435,12 +8337,8 @@ reassemble_kdump_header(void)
 	kh.start_pfn_64 = 0;
 	kh.end_pfn_64 = 0;
 
-	if (lseek(info->fd_dumpfile, info->page_size, SEEK_SET) < 0) {
-		ERRMSG("Can't seek a file(%s). %s\n",
-		    info->name_dumpfile, strerror(errno));
-		return FALSE;
-	}
-	if (write(info->fd_dumpfile, &kh, sizeof(kh)) != sizeof(kh)) {
+	if (pwrite(info->fd_dumpfile, &kh, sizeof(kh), info->page_size)
+			!= sizeof(kh)) {
 		ERRMSG("Can't write a file(%s). %s\n",
 		    info->name_dumpfile, strerror(errno));
 		return FALSE;
@@ -8623,22 +8521,12 @@ reassemble_kdump_pages(void)
 
 			print_progress(PROGRESS_COPY, num_dumped, num_dumpable);
 
-			if (lseek(fd, offset_ph_org, SEEK_SET) < 0) {
-				ERRMSG("Can't seek a file(%s). %s\n",
-				    SPLITTING_DUMPFILE(i), strerror(errno));
-				goto out;
-			}
-			if (read(fd, &pd, sizeof(pd)) != sizeof(pd)) {
+			if (pread(fd, &pd, sizeof(pd)) != sizeof(pd), offset_ph_org) {
 				ERRMSG("Can't read a file(%s). %s\n",
 				    SPLITTING_DUMPFILE(i), strerror(errno));
 				goto out;
 			}
-			if (lseek(fd, pd.offset, SEEK_SET) < 0) {
-				ERRMSG("Can't seek a file(%s). %s\n",
-				    SPLITTING_DUMPFILE(i), strerror(errno));
-				goto out;
-			}
-			if (read(fd, data, pd.size) != pd.size) {
+			if (pread(fd, data, pd.size, pd.offset) != pd.size) {
 				ERRMSG("Can't read a file(%s). %s\n",
 				    SPLITTING_DUMPFILE(i), strerror(errno));
 				goto out;
@@ -8692,13 +8580,9 @@ reassemble_kdump_pages(void)
 			    SPLITTING_DUMPFILE(i), strerror(errno));
 			goto out;
 		}
-		if (lseek(fd, SPLITTING_OFFSET_EI(i), SEEK_SET) < 0) {
-			ERRMSG("Can't seek a file(%s). %s\n",
-			    SPLITTING_DUMPFILE(i), strerror(errno));
-			goto out;
-		}
-		if (read(fd, data, SPLITTING_SIZE_EI(i)) !=
-						SPLITTING_SIZE_EI(i)) {
+		if (pread(fd, data, SPLITTING_SIZE_EI(i),
+					SPLITTING_OFFSET_EI(i))
+				!= SPLITTING_SIZE_EI(i)) {
 			ERRMSG("Can't read a file(%s). %s\n",
 			    SPLITTING_DUMPFILE(i), strerror(errno));
 			goto out;
-- 
1.8.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
