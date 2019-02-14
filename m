Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guNWx-0002XW-JV
 for kexec@lists.infradead.org; Thu, 14 Feb 2019 20:22:49 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: [PATCH] makedumpfile: fixing possible memory leaks seen in static
 analysis
Date: Thu, 14 Feb 2019 20:21:58 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035686B5@BPXM09GP.gisp.nec.co.jp>
Content-Language: en-US
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
To: kexec mailing list <kexec@lists.infradead.org>
Cc: "Nisha.Parrakat@kpit.com" <Nisha.Parrakat@kpit.com>

From: Nisha Parrakat <nisha.parrakat@kpit.com>

Description:
Fixed memory leaks found based on cppcheck and codesonar run.

Running makedumpfile with valgrind din't show any memory leaks but static
analysis tools were used to check for possible memory leaks.

Signed-off-by: Nisha Parrakat <Nisha.Parrakat@kpit.com>

diff -Naur a/dwarf_info.c b/dwarf_info.c
--- a/dwarf_info.c	2018-07-03 20:52:46.000000000 +0200
+++ b/dwarf_info.c	2019-01-29 21:17:45.949544759 +0100
@@ -332,6 +332,8 @@
 	dwarf_info.dwfl = dwfl;
 	return TRUE;
 err_out:
+	if( dwfl_fd != -1)
+		close(dwfl_fd);
 	if (dwfl)
 		dwfl_end(dwfl);
 
diff -Naur a/erase_info.c b/erase_info.c
--- a/erase_info.c	2018-07-03 20:52:46.000000000 +0200
+++ b/erase_info.c	2019-01-29 21:17:45.949544759 +0100
@@ -599,6 +599,8 @@
 	return ce;
 
 err_out:
+	if(ptr && ptr->name) /*free strdup malloced memory*/
+		free( ptr->name );
 	if (ce)
 		free_config_entry(ce);
 	if (ptr)
@@ -1030,6 +1032,8 @@
 	}
 	return config;
 err_out:
+	if (config && config->module_name) /*free strdup memory*/
+		free ( config->module_name );
 	if (config)
 		free_config(config);
 	return NULL;

diff --git a/makedumpfile.c b/makedumpfile.c
index 8923538..0f7b90a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -2720,16 +2720,19 @@ copy_vmcoreinfo(off_t offset, unsigned long size)
 	if (lseek(info->fd_memory, offset, SEEK_SET) == failed) {
 		ERRMSG("Can't seek the dump memory(%s). %s\n",
 		    info->name_memory, strerror(errno));
+                close(fd);
 		return FALSE;
 	}
 	if (read(info->fd_memory, &buf, size) != size) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		    info->name_memory, strerror(errno));
+                close(fd);
 		return FALSE;
 	}
 	if (write(fd, &buf, size) != size) {
 		ERRMSG("Can't write the vmcoreinfo file(%s). %s\n",
 		    info->name_vmcoreinfo, strerror(errno));
+                close(fd);
 		return FALSE;
 	}
 	if (close(fd) < 0) {
@@ -3639,6 +3642,7 @@ initialize_bitmap_memory(void)
 	if (bmp->buf == NULL) {
 		ERRMSG("Can't allocate memory for the bitmap buffer. %s\n",
 		    strerror(errno));
+		free(bmp);
 		return FALSE;
 	}
 	bmp->fd        = info->fd_memory;
@@ -8486,7 +8490,7 @@ write_eraseinfo(struct cache_data *cd_page, unsigned long *size_out)
 	int i, j, obuf_size = 0, ei_size = 0;
 	int ret = FALSE;
 	unsigned long size_eraseinfo = 0;
-	char *obuf = NULL;
+	char *obuf = NULL; char *obuf_new = NULL;
 	char size_str[MAX_SIZE_STR_LEN];
 
 	for (i = 1; i < num_erase_info; i++) {
@@ -8511,12 +8515,14 @@ write_eraseinfo(struct cache_data *cd_page, unsigned long *size_out)
 			 */
 			if (ei_size > obuf_size) {
 				obuf_size = ei_size;
-				obuf = realloc(obuf, obuf_size);
-				if (!obuf) {
+				obuf_new = realloc(obuf, obuf_size);
+				if (!obuf_new) {
 					ERRMSG("Can't allocate memory for"
 						" output buffer\n");
+                                        free(obuf);
 					return FALSE;
-				}
+				}else
+					obuf = obuf_new;
 			}
 			sprintf(obuf, "erase %s %s", erase_info[i].symbol_expr,
 							size_str);
@@ -9074,12 +9080,14 @@ init_xen_crash_info(void)
 	if (lseek(info->fd_memory, offset_xen_crash_info, SEEK_SET) < 0) {
 		ERRMSG("Can't seek the dump memory(%s). %s\n",
 		       info->name_memory, strerror(errno));
+		free(buf);
 		return FALSE;
 	}
 	if (read(info->fd_memory, buf, size_xen_crash_info)
 	    != size_xen_crash_info) {
 		ERRMSG("Can't read the dump memory(%s). %s\n",
 		       info->name_memory, strerror(errno));
+		free(buf);
 		return FALSE;
 	}
 
@@ -10533,7 +10541,7 @@ reassemble_kdump_pages(void)
 	struct page_desc pd, pd_zero;
 	struct cache_data cd_pd, cd_data;
 	struct timespec ts_start;
-	char *data = NULL;
+	char *data = NULL; char* data_new = NULL;
 	unsigned long data_buf_size = info->page_size;
 
 	if (!prepare_bitmap2_buffer())
@@ -10663,11 +10671,13 @@ reassemble_kdump_pages(void)
 
 		if (SPLITTING_SIZE_EI(i) > data_buf_size) {
 			data_buf_size = SPLITTING_SIZE_EI(i);
-			if ((data = realloc(data, data_buf_size)) == NULL) {
+			if ((data_new = realloc(data, data_buf_size)) == NULL) {
 				ERRMSG("Can't allocate memory for eraseinfo"
 					" data.\n");
+				free(data_new);
 				goto out;
-			}
+			}else
+				data = data_new;
 		}
 		if ((fd = open(SPLITTING_DUMPFILE(i), O_RDONLY)) < 0) {
 			ERRMSG("Can't open a file(%s). %s\n",
@@ -11177,12 +11187,14 @@ static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 	if (!fgets(line, sizeof(line), fp)) {
 		ERRMSG("Cannot parse %s: %s, fgets failed.\n",
 		       "/sys/kernel/vmcoreinfo", strerror(errno));
+		fclose(fp);
 		return FALSE;
 	}
 	count = sscanf(line, "%Lx %Lx", &temp, &temp2);
 	if (count != 2) {
 		ERRMSG("Cannot parse %s: %s, sscanf failed.\n",
 		       "/sys/kernel/vmcoreinfo", strerror(errno));
+		fclose(fp);
 		return FALSE;
 	}



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
