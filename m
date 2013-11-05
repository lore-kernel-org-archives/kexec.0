Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdcAx-0002c5-Jv
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 08:39:52 +0000
Message-Id: <20131105083428.411624560@dhcp-16-126.nay.redhat.com>
Date: Tue, 05 Nov 2013 16:29:48 +0800
From: dyoung@redhat.com
Subject: [patch 1/3 v2] Add function get_bootparam
References: <20131105082947.500512312@dhcp-16-126.nay.redhat.com>
Content-Disposition: inline;
 filename=01-kexec-add-function-get-boot-param.patch
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: mjg59@srcf.ucam.org, linux-efi@vger.kernel.org, x86@kernel.org, James.Bottomley@HansenPartnership.com, horms@verge.net.au, bp@alien8.de, ebiederm@xmission.com, hpa@zytor.com, Dave Young <dyoung@redhat.com>, vgoyal@redhat.com

Not only setup_subarch will get data from debugfs file
boot_params/data, later code for adding efi_info will
also need do same thing. Thus add a common function here
for later use.

v1->v2: make get_bootparam() static

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 kexec/arch/i386/x86-linux-setup.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- kexec-tools.orig/kexec/arch/i386/x86-linux-setup.c
+++ kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -436,10 +436,9 @@ char *find_mnt_by_fsname(char *fsname)
 	return mntdir;
 }
 
-void setup_subarch(struct x86_linux_param_header *real_mode)
+static void get_bootparam(void *buf, off_t offset, size_t size)
 {
 	int data_file;
-	const off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
 	char *debugfs_mnt;
 	char filename[PATH_MAX];
 
@@ -447,7 +446,7 @@ void setup_subarch(struct x86_linux_para
 	if (!debugfs_mnt)
 		return;
 	snprintf(filename, PATH_MAX, "%s/%s", debugfs_mnt, "boot_params/data");
-	filename[PATH_MAX-1] = 0;
+	filename[PATH_MAX - 1] = 0;
 	free(debugfs_mnt);
 
 	data_file = open(filename, O_RDONLY);
@@ -455,11 +454,18 @@ void setup_subarch(struct x86_linux_para
 		return;
 	if (lseek(data_file, offset, SEEK_SET) < 0)
 		goto close;
-	read(data_file, &real_mode->hardware_subarch, sizeof(uint32_t));
+	read(data_file, buf, size);
 close:
 	close(data_file);
 }
 
+void setup_subarch(struct x86_linux_param_header *real_mode)
+{
+	off_t offset = offsetof(typeof(*real_mode), hardware_subarch);
+
+	get_bootparam(&real_mode->hardware_subarch, offset, sizeof(uint32_t));
+}
+
 void setup_linux_system_parameters(struct kexec_info *info,
 				   struct x86_linux_param_header *real_mode)
 {


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
