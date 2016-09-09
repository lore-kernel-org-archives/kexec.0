Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1biGHw-0006E9-14
 for kexec@lists.infradead.org; Fri, 09 Sep 2016 07:31:53 +0000
Date: Fri, 9 Sep 2016 09:31:25 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] Cleanup: Use a negative number for uninitialized file
 descriptors
Message-ID: <20160909093125.44a3987e@hananiah.suse.cz>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E67C13@BPXM01GP.gisp.nec.co.jp>
References: <20160810125658.23366-1-mwilck@suse.de>
 <20160810125658.23366-4-mwilck@suse.de>
 <20160810150846.6a257447@hananiah.suse.cz>
 <1470836145.3194.31.camel@suse.de>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E5CE94@BPXM01GP.gisp.nec.co.jp>
 <20160816075911.09a0659d@hananiah.suse.cz>
 <1471419459.3229.1.camel@suse.de>
 <20160906102235.7c186773@hananiah.suse.cz>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E67C13@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Martin Wilck <mwilck@suse.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Atsushi,

On Fri, 9 Sep 2016 06:27:17 +0000
Atsushi Kumagai <ats-kumagai@wm.jp.nec.com> wrote:

> Hello Petr,
> 
> >Do not use zero to denote an invalid file descriptor.
> >
> >First, zero is a valid value, although quite unlikely to be used for
> >anything except standard input.
> >
> >Second, open(2) returns a negative value on failure, so there are
> >already checks for a negative value in some places.
> >
> >The purpose of this patch is not to allow running in an evil environment
> >(with closed stdin), but to aid in debugging by using a consistent value
> >for uninitialized file descriptors which is also regarded as invalid by
> >the kernel. For example, attempts to close a negative FD will fail
> >(unlike an attempt to close FD 0).
> >
> >Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> 
> Good, thanks for your work, but could you fix
> more two points as below ?

I see. I skipped elf_info.c, dwarf_info.c, sadump_info.c and other
files, because the file descriptors there are initialized from other
variables, already checked in the main module, but you're right, the
checks should become consistent.

Expect a version 2 of the patch soon.

Petr T

> dwarf_info.c::
>    1595         if (dwarf_info.module_name
>    1596                         && strcmp(dwarf_info.module_name, "vmlinux")
>    1597                         && strcmp(dwarf_info.module_name, "xen-syms")) {
>    1598                 if (dwarf_info.fd_debuginfo > 0)                 // should be '>= 0'
>    1599                         close(dwarf_info.fd_debuginfo);
> 
> sadump_info.c::
>    1919                 for (i = 1; i < si->num_disks; ++i) {
>    1920                         if (si->diskset_info[i].fd_memory)      // should be 'fd_memory >=0'
>    1921                                 close(si->diskset_info[i].fd_memory);
> 
> 
> Thanks,
> Atsushi Kumagai
> 
> >---
> > makedumpfile.c | 68 +++++++++++++++++++++++++++++++++-------------------------
> > makedumpfile.h |  2 +-
> > 2 files changed, 40 insertions(+), 30 deletions(-)
> >
> >diff --git a/makedumpfile.c b/makedumpfile.c
> >index 21784e8..d168dfd 100644
> >--- a/makedumpfile.c
> >+++ b/makedumpfile.c
> >@@ -3730,10 +3730,10 @@ free_for_parallel()
> > 		return;
> >
> > 	for (i = 0; i < info->num_threads; i++) {
> >-		if (FD_MEMORY_PARALLEL(i) > 0)
> >+		if (FD_MEMORY_PARALLEL(i) >= 0)
> > 			close(FD_MEMORY_PARALLEL(i));
> >
> >-		if (FD_BITMAP_MEMORY_PARALLEL(i) > 0)
> >+		if (FD_BITMAP_MEMORY_PARALLEL(i) >= 0)
> > 			close(FD_BITMAP_MEMORY_PARALLEL(i));
> > 	}
> > }
> >@@ -4038,13 +4038,13 @@ out:
> > void
> > initialize_bitmap(struct dump_bitmap *bitmap)
> > {
> >-	if (info->fd_bitmap) {
> >+	if (info->fd_bitmap >= 0) {
> > 		bitmap->fd        = info->fd_bitmap;
> > 		bitmap->file_name = info->name_bitmap;
> > 		bitmap->no_block  = -1;
> > 		memset(bitmap->buf, 0, BUFSIZE_BITMAP);
> > 	} else {
> >-		bitmap->fd        = 0;
> >+		bitmap->fd        = -1;
> > 		bitmap->file_name = NULL;
> > 		bitmap->no_block  = -1;
> > 		memset(bitmap->buf, 0, info->bufsize_cyclic);
> >@@ -4154,7 +4154,7 @@ set_bitmap_buffer(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cyc
> > int
> > set_bitmap(struct dump_bitmap *bitmap, mdf_pfn_t pfn, int val, struct cycle *cycle)
> > {
> >-	if (bitmap->fd) {
> >+	if (bitmap->fd >= 0) {
> > 		return set_bitmap_file(bitmap, pfn, val);
> > 	} else {
> > 		return set_bitmap_buffer(bitmap, pfn, val, cycle);
> >@@ -4170,7 +4170,7 @@ sync_bitmap(struct dump_bitmap *bitmap)
> > 	/*
> > 	 * The bitmap doesn't have the fd, it's a on-memory bitmap.
> > 	 */
> >-	if (bitmap->fd == 0)
> >+	if (bitmap->fd < 0)
> > 		return TRUE;
> > 	/*
> > 	 * The bitmap buffer is not dirty, and it is not necessary
> >@@ -5403,7 +5403,7 @@ create_1st_bitmap_buffer(struct cycle *cycle)
> > int
> > create_1st_bitmap(struct cycle *cycle)
> > {
> >-	if (info->bitmap1->fd) {
> >+	if (info->bitmap1->fd >= 0) {
> > 		return create_1st_bitmap_file();
> > 	} else {
> > 		return create_1st_bitmap_buffer(cycle);
> >@@ -5414,7 +5414,7 @@ static inline int
> > is_in_segs(unsigned long long paddr)
> > {
> > 	if (info->flag_refiltering || info->flag_sadump) {
> >-		if (info->bitmap1->fd == 0) {
> >+		if (info->bitmap1->fd < 0) {
> > 			initialize_1st_bitmap(info->bitmap1);
> > 			create_1st_bitmap_file();
> > 		}
> >@@ -5872,7 +5872,7 @@ copy_bitmap_file(void)
> > int
> > copy_bitmap(void)
> > {
> >-	if (info->fd_bitmap) {
> >+	if (info->fd_bitmap >= 0) {
> > 		return copy_bitmap_file();
> > 	} else {
> > 		return copy_bitmap_buffer();
> >@@ -6313,7 +6313,7 @@ prepare_bitmap1_buffer(void)
> > 		return FALSE;
> > 	}
> >
> >-	if (info->fd_bitmap) {
> >+	if (info->fd_bitmap >= 0) {
> > 		if ((info->bitmap1->buf = (char *)malloc(BUFSIZE_BITMAP)) == NULL) {
> > 			ERRMSG("Can't allocate memory for the 1st bitmaps's buffer. %s\n",
> > 			       strerror(errno));
> >@@ -6352,7 +6352,7 @@ prepare_bitmap2_buffer(void)
> > 		       strerror(errno));
> > 		return FALSE;
> > 	}
> >-	if (info->fd_bitmap) {
> >+	if (info->fd_bitmap >= 0) {
> > 		if ((info->bitmap2->buf = (char *)malloc(BUFSIZE_BITMAP)) == NULL) {
> > 			ERRMSG("Can't allocate memory for the 2nd bitmaps's buffer. %s\n",
> > 			       strerror(errno));
> >@@ -7582,7 +7582,7 @@ kdump_thread_function_cyclic(void *arg) {
> >
> > 	fd_memory = FD_MEMORY_PARALLEL(kdump_thread_args->thread_num);
> >
> >-	if (info->fd_bitmap) {
> >+	if (info->fd_bitmap >= 0) {
> > 		bitmap_parallel.buf = malloc(BUFSIZE_BITMAP);
> > 		if (bitmap_parallel.buf == NULL){
> > 			ERRMSG("Can't allocate memory for bitmap_parallel.buf. %s\n",
> >@@ -7628,7 +7628,7 @@ kdump_thread_function_cyclic(void *arg) {
> > 			pthread_mutex_lock(&info->current_pfn_mutex);
> > 			for (pfn = info->current_pfn; pfn < cycle->end_pfn; pfn++) {
> > 				dumpable = is_dumpable(
> >-					info->fd_bitmap ? &bitmap_parallel : info->bitmap2,
> >+					info->fd_bitmap >= 0 ? &bitmap_parallel : info->bitmap2,
> > 					pfn,
> > 					cycle);
> > 				if (dumpable)
> >@@ -7723,7 +7723,7 @@ next:
> > 	retval = NULL;
> >
> > fail:
> >-	if (bitmap_memory_parallel.fd > 0)
> >+	if (bitmap_memory_parallel.fd >= 0)
> > 		close(bitmap_memory_parallel.fd);
> > 	if (bitmap_parallel.buf != NULL)
> > 		free(bitmap_parallel.buf);
> >@@ -8461,7 +8461,7 @@ out:
> >
> > int
> > write_kdump_bitmap1(struct cycle *cycle) {
> >-	if (info->bitmap1->fd) {
> >+	if (info->bitmap1->fd >= 0) {
> > 		return write_kdump_bitmap1_file();
> > 	} else {
> > 		return write_kdump_bitmap1_buffer(cycle);
> >@@ -8470,7 +8470,7 @@ write_kdump_bitmap1(struct cycle *cycle) {
> >
> > int
> > write_kdump_bitmap2(struct cycle *cycle) {
> >-	if (info->bitmap2->fd) {
> >+	if (info->bitmap2->fd >= 0) {
> > 		return write_kdump_bitmap2_file();
> > 	} else {
> > 		return write_kdump_bitmap2_buffer(cycle);
> >@@ -8597,9 +8597,10 @@ close_vmcoreinfo(void)
> > void
> > close_dump_memory(void)
> > {
> >-	if ((info->fd_memory = close(info->fd_memory)) < 0)
> >+	if (close(info->fd_memory) < 0)
> > 		ERRMSG("Can't close the dump memory(%s). %s\n",
> > 		    info->name_memory, strerror(errno));
> >+	info->fd_memory = -1;
> > }
> >
> > void
> >@@ -8608,9 +8609,10 @@ close_dump_file(void)
> > 	if (info->flag_flatten)
> > 		return;
> >
> >-	if ((info->fd_dumpfile = close(info->fd_dumpfile)) < 0)
> >+	if (close(info->fd_dumpfile) < 0)
> > 		ERRMSG("Can't close the dump file(%s). %s\n",
> > 		    info->name_dumpfile, strerror(errno));
> >+	info->fd_dumpfile = -1;
> > }
> >
> > void
> >@@ -8620,9 +8622,10 @@ close_dump_bitmap(void)
> > 	    && !info->flag_sadump && !info->flag_mem_usage)
> > 		return;
> >
> >-	if ((info->fd_bitmap = close(info->fd_bitmap)) < 0)
> >+	if (close(info->fd_bitmap) < 0)
> > 		ERRMSG("Can't close the bitmap file(%s). %s\n",
> > 		    info->name_bitmap, strerror(errno));
> >+	info->fd_bitmap = -1;
> > 	free(info->name_bitmap);
> > 	info->name_bitmap = NULL;
> > }
> >@@ -8631,16 +8634,18 @@ void
> > close_kernel_file(void)
> > {
> > 	if (info->name_vmlinux) {
> >-		if ((info->fd_vmlinux = close(info->fd_vmlinux)) < 0) {
> >+		if (close(info->fd_vmlinux) < 0) {
> > 			ERRMSG("Can't close the kernel file(%s). %s\n",
> > 			    info->name_vmlinux, strerror(errno));
> > 		}
> >+		info->fd_vmlinux = -1;
> > 	}
> > 	if (info->name_xen_syms) {
> >-		if ((info->fd_xen_syms = close(info->fd_xen_syms)) < 0) {
> >+		if (close(info->fd_xen_syms) < 0) {
> > 			ERRMSG("Can't close the kernel file(%s). %s\n",
> > 			    info->name_xen_syms, strerror(errno));
> > 		}
> >+		info->fd_xen_syms = -1;
> > 	}
> > }
> >
> >@@ -10202,7 +10207,7 @@ reassemble_kdump_header(void)
> >
> > 	ret = TRUE;
> > out:
> >-	if (fd > 0)
> >+	if (fd >= 0)
> > 		close(fd);
> > 	free(buf_bitmap);
> >
> >@@ -10212,7 +10217,7 @@ out:
> > int
> > reassemble_kdump_pages(void)
> > {
> >-	int i, fd = 0, ret = FALSE;
> >+	int i, fd = -1, ret = FALSE;
> > 	off_t offset_first_ph, offset_ph_org, offset_eraseinfo;
> > 	off_t offset_data_new, offset_zero_page = 0;
> > 	mdf_pfn_t pfn, start_pfn, end_pfn;
> >@@ -10336,7 +10341,7 @@ reassemble_kdump_pages(void)
> > 			offset_data_new += pd.size;
> > 		}
> > 		close(fd);
> >-		fd = 0;
> >+		fd = -1;
> > 	}
> > 	if (!write_cache_bufsz(&cd_pd))
> > 		goto out;
> >@@ -10379,7 +10384,7 @@ reassemble_kdump_pages(void)
> > 		size_eraseinfo += SPLITTING_SIZE_EI(i);
> >
> > 		close(fd);
> >-		fd = 0;
> >+		fd = -1;
> > 	}
> > 	if (size_eraseinfo) {
> > 		if (!write_cache_bufsz(&cd_data))
> >@@ -10400,7 +10405,7 @@ out:
> >
> > 	if (data)
> > 		free(data);
> >-	if (fd > 0)
> >+	if (fd >= 0)
> > 		close(fd);
> >
> > 	return ret;
> >@@ -10973,6 +10978,11 @@ main(int argc, char *argv[])
> > 		    strerror(errno));
> > 		goto out;
> > 	}
> >+	info->fd_vmlinux = -1;
> >+	info->fd_xen_syms = -1;
> >+	info->fd_memory = -1;
> >+	info->fd_dumpfile = -1;
> >+	info->fd_bitmap = -1;
> > 	initialize_tables();
> >
> > 	/*
> >@@ -11268,11 +11278,11 @@ out:
> > 				free(info->bitmap_memory->buf);
> > 			free(info->bitmap_memory);
> > 		}
> >-		if (info->fd_memory)
> >+		if (info->fd_memory >= 0)
> > 			close(info->fd_memory);
> >-		if (info->fd_dumpfile)
> >+		if (info->fd_dumpfile >= 0)
> > 			close(info->fd_dumpfile);
> >-		if (info->fd_bitmap)
> >+		if (info->fd_bitmap >= 0)
> > 			close(info->fd_bitmap);
> > 		if (vt.node_online_map != NULL)
> > 			free(vt.node_online_map);
> >diff --git a/makedumpfile.h b/makedumpfile.h
> >index 533e5b8..1814139 100644
> >--- a/makedumpfile.h
> >+++ b/makedumpfile.h
> >@@ -1955,7 +1955,7 @@ is_dumpable_file(struct dump_bitmap *bitmap, mdf_pfn_t pfn)
> > static inline int
> > is_dumpable(struct dump_bitmap *bitmap, mdf_pfn_t pfn, struct cycle *cycle)
> > {
> >-	if (bitmap->fd == 0) {
> >+	if (bitmap->fd < 0) {
> > 		return is_dumpable_buffer(bitmap, pfn, cycle);
> > 	} else {
> > 		return is_dumpable_file(bitmap, pfn);
> >--
> >2.6.6


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
