Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1Lw7BU-00076V-BT
	for kexec@lists.infradead.org; Tue, 21 Apr 2009 04:02:19 +0000
Message-ID: <49ED3CD5.2000900@mxs.nes.nec.co.jp>
Date: Tue, 21 Apr 2009 12:26:13 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: [PATCH] makedumpfile: Save utsname data into disk_dump_header.(Re:
	makedumpfile question / request)
References: <474287444.42861240232368767.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <474287444.42861240232368767.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: kexec-ml <kexec@lists.infradead.org>, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>


Hi Dave,

Dave Anderson wrote:
>>> Is there a reason that makedumpfile does not fill in the utsname structure
>>> in the compressed dumpfile's header?  
>> Thank you for good point.
>>
>> makedumpfile does not fill it because makedumpfile might not be able to
>> get kernel debug information (containing symbol system_utsname/init_uts_ns).
>> makedumpfile does not need kernel debug information if dump_level is 0 or 1,
>> and it does not read a new_utsname structure. (check_release() is not called.)
>>
>>
>>> The data structure does get read into a local new_utsname structure in the
>>> check_release() function, but it doesn't get saved and copied into the
>>> disk_dump_header in write_kdump_header().
>>>
>>> It would be helpful if that were in place as a quick ID for what the
>>> compressed dumpfile contains.
>> I feel that is worth.
>> How about saving new_utsname data into disk_dump_header only if dump_level
>> is 2 or bigger ?
> 
> Well, that's certainly preferable than the way it is now.
> 
> But let me ask you this...
> 
> Given that the init_uts_ns structure is always located in:
> 
> (1) unity-mapped memory, or in a mapped kernel region for x86_64/ia64, and
> (2) that your initial() function calls get_phys_base() in all cases,
> 
> can't you just strip the relevant unity-mapping from the supplied 
> VMCOREINFO/init_uts_ns symbol value, apply the phys_base, and then
> read it from the vmcore file?

Thank you for the comment.
We can do it by the attached patch.


Thanks
Ken'ichi Ohmichi

---
[PATCH] Save utsname data into disk_dump_header.

By this patch, makedumpfile saves utsname data into disk_dump_header.
The crash utility can output the data by 'help -n' command:

crash> help -n
diskdump_data:
             flags: 6 (KDUMP_CMPRS_LOCAL|ERROR_EXCLUDED)
               dfd: 3
               ofp: 3b29b4d760
      machine_type: 62 (EM_X86_64)

            header: c34c70
           signature: "KDUMP   "
      header_version: 2
             utsname:
               sysname: Linux
              nodename: localhost.localdomain
               release: 2.6.29-rc7
               version: #1 SMP Mon Mar 9 11:20:46 JST 2009
               machine: x86_64
            domainname: (none)
           timestamp:
[snip]

Signed-off-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
---
diff -puN a/makedumpfile.c b/makedumpfile.c
--- a/makedumpfile.c	2009-04-20 15:26:23.000000000 +0900
+++ b/makedumpfile.c	2009-04-21 12:48:00.000000000 +0900
@@ -382,9 +382,8 @@ fallback_to_current_page_size(void)
 }
 
 int
-check_release(void)
+get_utsname(struct utsname *system_utsname)
 {
-	struct utsname system_utsname;
 	unsigned long utsname;
 
 	/*
@@ -398,13 +397,18 @@ check_release(void)
 		ERRMSG("Can't get the symbol of system_utsname.\n");
 		return FALSE;
 	}
-	if (!readmem(VADDR, utsname, &system_utsname, sizeof(struct utsname))){
+	if (!readmem(VADDR, utsname, system_utsname, sizeof(struct utsname))){
 		ERRMSG("Can't get the address of system_utsname.\n");
 		return FALSE;
 	}
+	return TRUE;
+}
 
+int
+check_release(void)
+{
 	if (info->flag_read_vmcoreinfo) {
-		if (strcmp(system_utsname.release, info->release)) {
+		if (strcmp(info->system_utsname.release, info->release)) {
 			ERRMSG("%s and %s don't match.\n",
 			    info->name_vmcoreinfo, info->name_memory);
 			retcd = WRONG_RELEASE;
@@ -412,7 +416,7 @@ check_release(void)
 		}
 	}
 
-	info->kernel_version = get_kernel_version(system_utsname.release);
+	info->kernel_version = get_kernel_version(info->system_utsname.release);
 	if (info->kernel_version == FALSE) {
 		if (!info->flag_read_vmcoreinfo)
 			ERRMSG("Or %s and %s don't match.\n",
@@ -3378,7 +3382,7 @@ get_mem_map(void)
 int
 initial(void)
 {
-	int flag_need_debuginfo;
+	int flag_get_debuginfo = FALSE, flag_need_debuginfo = FALSE;
 
 	if (!(vt.mem_flags & MEMORY_XEN) && info->flag_exclude_xen_dom) {
 		MSG("'-X' option is disable,");
@@ -3398,6 +3402,7 @@ initial(void)
 		if (!read_vmcoreinfo())
 			return FALSE;
 		close_vmcoreinfo();
+		flag_get_debuginfo = TRUE;
 	/*
 	 * Get the debug information for analysis from the kernel file
 	 */
@@ -3413,6 +3418,7 @@ initial(void)
 
 		if (!get_srcfile_info())
 			return FALSE;
+		flag_get_debuginfo = TRUE;
 	} else {
 		/*
 		 * Check whether /proc/vmcore contains vmcoreinfo,
@@ -3438,6 +3444,7 @@ initial(void)
 		if (!read_vmcoreinfo_from_vmcore(info->offset_vmcoreinfo,
 		    info->size_vmcoreinfo, FALSE))
 			return FALSE;
+		flag_get_debuginfo = TRUE;
 	}
 
 	if (!get_value_for_old_linux())
@@ -3454,6 +3461,12 @@ out:
 	if (!get_max_mapnr())
 		return FALSE;
 
+	if (flag_get_debuginfo) {
+		if (!get_machdep_info())
+			return FALSE;
+		if (!get_utsname(&info->system_utsname))
+			return FALSE;
+	}
 	if ((info->max_dump_level <= DL_EXCLUDE_ZERO) && !info->flag_dmesg)
 		flag_need_debuginfo = FALSE;
 	else 
@@ -3465,10 +3478,6 @@ out:
 		else
 			return TRUE;
 	}
-
-	if (!get_machdep_info())
-		return FALSE;
-
 	if (!check_release())
 		return FALSE;
 
@@ -4969,6 +4978,7 @@ write_kdump_header(void)
 	dh->bitmap_blocks
 	    = divideup(info->len_bitmap, dh->block_size);
 	memcpy(&dh->timestamp, &info->timestamp, sizeof(dh->timestamp));
+	memcpy(&dh->utsname, &info->system_utsname, sizeof(dh->utsname));
 
 	size = sizeof(struct disk_dump_header);
 	if (!write_buffer(info->fd_dumpfile, 0, dh, size, info->name_dumpfile))
diff -puN a/makedumpfile.h b/makedumpfile.h
--- a/makedumpfile.h	2009-04-20 15:26:23.000000000 +0900
+++ b/makedumpfile.h	2009-04-21 12:47:58.000000000 +0900
@@ -750,6 +750,7 @@ struct splitting_info {
 struct DumpInfo {
 	int32_t		kernel_version;      /* version of first kernel*/
 	struct timeval	timestamp;
+	struct utsname	system_utsname;
 
 	/*
 	 * General info:

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
