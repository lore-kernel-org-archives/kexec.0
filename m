Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eFRkR-0003m6-Dz
 for kexec@lists.infradead.org; Thu, 16 Nov 2017 21:31:01 +0000
Received: by mail-pg0-f66.google.com with SMTP id j16so299734pgn.9
 for <kexec@lists.infradead.org>; Thu, 16 Nov 2017 13:30:38 -0800 (PST)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [makedumpfile PATCH 2/2] Fix 'kernel_version' variable being
 uninitialized & introduce minor reorganization
Date: Fri, 17 Nov 2017 03:00:00 +0530
Message-Id: <1510867800-6492-2-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1510867800-6492-1-git-send-email-bhsharma@redhat.com>
References: <1510867800-6492-1-git-send-email-bhsharma@redhat.com>
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
To: ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org
Cc: hbathini@linux.vnet.ibm.com, bhsharma@redhat.com, bhupesh.linux@gmail.com, dyoung@redhat.com, piliu@redhat.com

On executing `makedumpfile --mem-usage /proc/kcore`, it
fails currently with the following error message on newer Linux kernels
like 4.13.0 or 4.14.0:

mem-usage not supported for this kernel.
You can try with -f if your kernel's kcore has valid p_paddr
makedumpfile Failed.

This happens because 'info->kernel_version' is uninitialized in function
main(). So when we perform the following check, it fails even though the
kernel version is greater than 4.11.0:

if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
				!info->flag_force) {

Fix this by reorganizing the code to:
- Add an API to populate the kernel version.
- Call this API rather than replicating the open code across other APIs
  across 'makedumpfile.c'

After this patch, '--mem-usage' can be used properly with makedumpfile.
Here are the logs I observe on a Fedora 26 ppc64le system:

The kernel version is not supported.
The makedumpfile operation may be incomplete.

TYPE		PAGES			EXCLUDABLE	DESCRIPTION
----------------------------------------------------------------------
ZERO		99              	yes		Pages filled
with zero
NON_PRI_CACHE	7817            	yes		Cache pages
without private flag
PRI_CACHE	63603           	yes		Cache pages with
private flag
USER		4105            	yes		User process
pages
FREE		165446          	yes		Free pages
KERN_DATA	6738            	no		Dumpable kernel
data

page size:		65536
Total pages on system:	247808
Total size on system:	16240345088      Byte

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 makedumpfile.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 7ce0c6d648aa..4bde542b4f0c 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1089,6 +1089,21 @@ fallback_to_current_page_size(void)
 	return TRUE;
 }
 
+static int populate_kernel_version(void)
+{
+	struct utsname utsname;
+
+	if (uname(&utsname)) {
+		ERRMSG("Cannot get name and information about current kernel : %s\n",
+		       strerror(errno));
+		return FALSE;
+	}
+
+	info->kernel_version = get_kernel_version(utsname.release);
+
+	return TRUE;
+}
+
 int
 check_release(void)
 {
@@ -1120,11 +1135,8 @@ check_release(void)
 		}
 	}
 
-	info->kernel_version = get_kernel_version(info->system_utsname.release);
-	if (info->kernel_version == FALSE) {
-		ERRMSG("Can't get the kernel version.\n");
+	if (!populate_kernel_version())
 		return FALSE;
-	}
 
 	return TRUE;
 }
@@ -10973,20 +10985,14 @@ int is_crashkernel_mem_reserved(void)
 
 static int get_page_offset(void)
 {
-	struct utsname utsname;
-	if (uname(&utsname)) {
-		ERRMSG("Cannot get name and information about current kernel : %s",
-		       strerror(errno));
+	if (!populate_kernel_version())
 		return FALSE;
-	}
 
-	info->kernel_version = get_kernel_version(utsname.release);
 	get_versiondep_info();
 
 	return TRUE;
 }
 
-
 /* Returns the physical address of start of crash notes buffer for a kernel. */
 static int get_sys_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len)
 {
@@ -11363,6 +11369,9 @@ main(int argc, char *argv[])
 			MSG("Try `makedumpfile --help' for more information.\n");
 			goto out;
 		}
+		if (!populate_kernel_version())
+			goto out;
+
 		if (info->kernel_version < KERNEL_VERSION(4, 11, 0) &&
 				!info->flag_force) {
 			MSG("mem-usage not supported for this kernel.\n");
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
