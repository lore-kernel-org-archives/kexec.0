Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from relay1.sgi.com ([192.48.179.29] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGveR-0007bI-JI
 for kexec@lists.infradead.org; Tue, 03 Sep 2013 18:48:32 +0000
Date: Tue, 3 Sep 2013 13:48:09 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH] makedumpfile: search for a debug vmlinux
Message-ID: <20130903184809.GB13282@sgi.com>
References: <E1VEnuJ-0000KR-TT@eag09.americas.sgi.com>
 <521FF12D.3050505@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521FF12D.3050505@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

On Fri, Aug 30, 2013 at 10:11:09AM +0900, HATAYAMA Daisuke wrote:
> (2013/08/29 7:08), Cliff Wickman wrote:
> > From: Cliff Wickman <cpw@sgi.com>
> > 
> > 
> > makedumpfile needs the debug info from either /proc/vmcore or in vmlinux
> > to know how to find free pages using the buddy method.
> > 
> > The distro procedures do not pass the vmlinux (with the -x option), so
> > add a search for a debug vmlinux in the usual locations.
> > It's not needed if the page info is in vmcore.  But warn if it is found
> > in neither place.
> > 
> 
> makedumpfile is designed to get necessary debug information from VMCOREINFO note
> available from /proc/vmcore. Why do you need vmlinux?
 
The vmcore doesn't always provide the page structure information.
Specifically, the offset of 'private' and '_mapcount' in the page
structure, which are needed for identification of user huge pages.
(I've seen this to be true on a sles11s2 and rhel65 (3.0.80 2.6.32-410))
I'm using the huge page patch from Petr Tesarik. The one that I think you
said Kumagai-san is reworking.

I did improve my patch, as provided below.
The below version does not try to replace the debuginfo from vmcore, but
only to extract the few bits of page structure information needed for 
the Tesarik patch.

You may not see the need for the additional (page) info on current kernels.
So I understand that you may not be interested in this patch, as it may
not be needed for kernels that are current when the huge page
identification patch is ready.

-Cliff




makedumpfile needs some debug info from either /proc/vmcore or in vmlinux
to know how to find free pages using the buddy method.

The distro procedures do not pass the vmlinux (with the -x option), so
add a search for a debug vmlinux in the usual locations.
It's not needed if the page info is in vmcore.
Get it from a debug vmlinux if one is found.
Warn if it is found in neither place.

-cpw
---

Index: makedumpfile-1.5.4/makedumpfile.c
===================================================================
--- makedumpfile-1.5.4.orig/makedumpfile.c
+++ makedumpfile-1.5.4/makedumpfile.c
@@ -23,6 +23,7 @@
 #include <stddef.h>
 #include <ctype.h>
 #include <sys/time.h>
+#include <sys/stat.h>
 
 struct symbol_table	symbol_table;
 struct size_table	size_table;
@@ -33,6 +34,7 @@ struct srcfile_table	srcfile_table;
 
 struct vm_table		vt = { 0 };
 struct DumpInfo		*info = NULL;
+struct utsname		utsname;
 
 char filename_stdout[] = FILENAME_STDOUT;
 
@@ -62,6 +64,7 @@ unsigned long long num_dumped;
 int retcd = FAILED;	/* return code */
 int aflag = 0;
 int total_cycles = 0;
+static char vmpathname[200];
 
 #define INITIALIZE_LONG_TABLE(table, value) \
 do { \
@@ -2857,6 +2860,84 @@ initialize_bitmap_memory(void)
 }
 
 int
+get_page_info(char *vmpathname)
+{
+	int fd;
+
+	if (vmpathname) {
+		if ((fd = open(vmpathname, O_RDONLY)) < 0) {
+			ERRMSG("Can't open the kernel file(%s). %s\n",
+			    vmpathname, strerror(errno));
+			return FALSE;
+		}
+		info->fd_vmlinux = fd;
+	}
+	set_dwarf_debuginfo("vmlinux", NULL, vmpathname, info->fd_vmlinux);
+	OFFSET_INIT(page.private, "page", "private");
+	ENUM_NUMBER_INIT(PG_buddy, "PG_buddy");
+	OFFSET_INIT(page._mapcount, "page", "_mapcount");
+	return TRUE;
+}
+
+/*
+ * Look for a debug vmlinux in the usual places.
+ */
+int
+find_vmlinux()
+{
+	int ret;
+	struct stat stat_buf;
+
+	ret = uname(&utsname);
+	if (ret < 0) {
+		fprintf(stderr, "uname failed; errno %d", errno);
+		return 0;
+	}
+
+	/* these may work if the crash kernel is in multi-user mode */
+	sprintf(vmpathname, "/usr/lib/debug/lib/modules/%s/vmlinux",
+		utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/usr/lib/debug/boot/vmlinux-%s.debug",
+		utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/boot/vmlinux-%s", utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+
+	/*
+	 * the crash kernel normally runs with the root device mounted
+	 * as /root or /mnt
+	 */
+	sprintf(vmpathname, "/root/usr/lib/debug/lib/modules/%s/vmlinux",
+		utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/root/usr/lib/debug/boot/vmlinux-%s.debug",
+		utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/root/boot/vmlinux-%s", utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/mnt/usr/lib/debug/lib/modules/%s/vmlinux",
+		utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/mnt/usr/lib/debug/boot/vmlinux-%s.debug",
+		utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+	sprintf(vmpathname, "/mnt/boot/vmlinux-%s", utsname.release);
+	if (!stat(vmpathname, &stat_buf))
+		return 1;
+
+	return 0;
+}
+
+int
 initial(void)
 {
 	off_t offset;
@@ -3007,10 +3088,25 @@ initial(void)
 	 *       than -x/-i option.
 	 */
 	if (has_vmcoreinfo()) {
+		PROGRESS_MSG("Getting debug information from /proc/vmcore\n");
 		get_vmcoreinfo(&offset, &size);
 		if (!read_vmcoreinfo_from_vmcore(offset, size, FALSE))
 			return FALSE;
 		debug_info = TRUE;
+		if (OFFSET(page.private) == NOT_FOUND_STRUCTURE) {
+			/* before giving up on identifying page flags, try
+ 			   any found vmlinux */
+			if (find_vmlinux()) {
+				PROGRESS_MSG("Getting page info from %s\n",
+					vmpathname);
+				if (!get_page_info(vmpathname)) {
+					PROGRESS_MSG("No page info in %s\n",
+						vmpathname);
+				}
+			} else
+				PROGRESS_MSG(
+				"No vmlinux and no page info in vmcore\n");
+		}
 	}
 
 out:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
