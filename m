Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1Q5MF4-00065Y-FF
	for kexec@lists.infradead.org; Thu, 31 Mar 2011 18:05:11 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1Q5MEz-0005IW-8S
	for kexec@lists.infradead.org; Thu, 31 Mar 2011 20:05:05 +0200
Received: from 134.134.139.76 ([134.134.139.76])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Thu, 31 Mar 2011 20:05:05 +0200
Received: from christopher.leech by 134.134.139.76 with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Thu, 31 Mar 2011 20:05:05 +0200
From: Chris Leech <christopher.leech@linux.intel.com>
Subject: Re: [PATCH V2] kexec, x86: fix kexec
	=?utf-8?b?d2hlbglib290X3BhcmFtcy5oYXJkd2FyZV9zdWJhcmNo?= != 0
Date: Thu, 31 Mar 2011 17:21:15 +0000 (UTC)
Message-ID: <loom.20110331T191730-224@post.gmane.org>
References: <20110328194049.32626.74038.stgit@localhost6.localdomain6>
	<20110328215011.30400.91252.stgit@localhost6.localdomain6>
	<ims7bl$ik5$1@dough.gmane.org>
	<20110329232259.GC27905@verge.net.au>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Simon Horman <horms@...> writes:

> 
> On Tue, Mar 29, 2011 at 09:04:53AM +0000, WANG Cong wrote:
> > On Mon, 28 Mar 2011 14:50:11 -0700, Chris Leech wrote:
> > 
> > > kexec needs to keep the subarch setting the same as the running kernel
> > > in the boot parameters, or the kernel will die in early setup.  I ran
> > > into this with X86_SUBARCH_MRST, but it should apply to CE4100 and any
> > > future subarch that uses non-default early setup code.
> > > 
> > > This patch requires debugfs mounted at /sys/kernel/debug, as that's the
> > > only way I know of to get at the running kernels boot_params. Without
> > > debugfs mounted it falls back to the current behavior of assuming
> > > subarch 0.
> > > 
> > ...
> > >  
> > > +#define BOOT_PARAMS_DBGFS	"/sys/kernel/debug/boot_params/data"
> > 
> > A minor issue here is that you are using a hard-coded debugfs path,
> > debugfs can be also mounted to /debug too, so it is better that if we can 
> > search the path dynamically here.
> 
> Do you think it would be better for the code to loop through
> a few common alternatives for the path?
> 

Not fully tested, but instead of looping through possible mount points maybe 
look through mtab in search of debugfs by fs type.

Something like this?

kexec, x86: search for debugfs mountpoint in /etc/mtab

From: Chris Leech <christopher.leech@linux.intel.com>

Signed-off-by: Chris Leech <christopher.leech@linux.intel.com>
---
 kexec/arch/i386/x86-linux-setup.c |   35 +++++++++++++++++++++++++++++++++--
 1 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/kexec/arch/i386/x86-linux-setup.c b/kexec/arch/i386/x86-linux-
setup.c
index 50b32be..0528cea 100644
--- a/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec/arch/i386/x86-linux-setup.c
@@ -30,6 +30,7 @@
 #include <linux/fb.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <mntent.h>
 #include <x86/x86-linux.h>
 #include "../../kexec.h"
 #include "kexec-x86.h"
@@ -397,14 +398,44 @@ out:
 		real_mode->eddbuf_entries);
 }
 
-#define BOOT_PARAMS_DBGFS	"/sys/kernel/debug/boot_params/data"
+/*
+ * This really only makes sense for virtual filesystems that are only expected
+ * to be mounted once (sysfs, debugsfs, proc), as it will return the first
+ * instance listed in mtab.
+ */
+char *find_mnt_by_fsname(char *fsname)
+{
+	FILE *mtab;
+	struct mntent *mnt;
+	char *mntdir;
+
+	mtab = setmntent("/etc/mtab", "r");
+	if (!mtab)
+		return NULL;
+	for(mnt = getmntent(mtab); mnt; mnt = getmntent(mtab)) {
+		if (strcmp(mnt->mnt_fsname, fsname) == 0)
+			break;
+	}
+	mntdir = mnt ? strdup(mnt->mnt_dir) : NULL;
+	endmntent(mtab);
+	return mntdir;
+}
 
 void setup_subarch(struct x86_linux_param_header *real_mode)
 {
 	int data_file;
 	const off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
+	char *debugfs_mnt;
+	char filename[PATH_MAX];
+
+	debugfs_mnt = find_mnt_by_fsname("debugfs");
+	if (!debugfs_mnt)
+		return;
+	snprintf(filename, PATH_MAX, "%s/%s", debugfs_mnt, "boot_params/data");
+	filename[PATH_MAX-1] = 0;
+	free(debugfs_mnt);
 
-	data_file = open(BOOT_PARAMS_DBGFS, O_RDONLY);
+	data_file = open(filename, O_RDONLY);
 	if (data_file < 0)
 		return;
 	if (lseek(data_file, offset, SEEK_SET) < 0)





_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
