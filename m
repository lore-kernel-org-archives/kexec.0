Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailhub5.stratus.com ([134.111.1.18])
 by bombadil.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SXbob-0001xj-60
 for kexec@lists.infradead.org; Thu, 24 May 2012 17:27:09 +0000
Message-ID: <4FBE6F5B.2070503@stratus.com>
Date: Thu, 24 May 2012 13:26:51 -0400
From: Dmitry Trikoz <Dmitry.Trikoz@stratus.com>
MIME-Version: 1.0
Subject: Kexec corrupts command line in x86-linux-setup.c setup_edd_info()
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au

Hi,
I've been chasing strange problem with kdump kernel. It was crashing on 
boot without any messages to the console.
Finally I found that kdump kernel command line was corrupt.
Digging down I found the problem in  setup_edd_info() and 
add_edd_entry(). It doesn't check for array size of
real_mode->eddbuf[] and real_mode->edd_mbr_sig_buffer[]
So when it overruns eddbuf[] it corrupts command_line that follows it.

Here is the fix:

--- a/kexec-tools/kexec/arch/i386/x86-linux-setup.c
+++ b/kexec-tools/kexec/arch/i386/x86-linux-setup.c
@@ -275,9 +275,9 @@ static int add_edd_entry(struct 
x86_linux_param_header *real_mode,
                                 "must not be NULL", __FUNCTION__);
                 return -1;
         }
-
-       edd_info = &real_mode->eddbuf[*current_edd];
-       memset(edd_info, 0, sizeof(struct edd_info));
+       if (*current_mbr >= EDD_MBR_SIG_MAX) {
+               return 0;
+       }

         /* extract the device number */
         if (sscanf(basename(sysfs_name), "int13_dev%hhx", &devnum) != 1) {
@@ -293,12 +293,21 @@ static int add_edd_entry(struct 
x86_linux_param_header *real_mode,
                 dbgprintf("EDD Device 0x%x: mbr_sig=0x%x\n", devnum, 
mbr_sig);
         }

+       if (*current_edd >= EDDMAXNR) {
+               return 0;
+       }
+
+       edd_info = &real_mode->eddbuf[*current_edd];
+       memset(edd_info, 0, sizeof(struct edd_info));
+
         /* set the device number */
         edd_info->device = devnum;

         /* set the version */
-       if (file_scanf(sysfs_name, "version", "0x%hhx", &version) != 1)
+       if (file_scanf(sysfs_name, "version", "0x%hhx", &version) != 1) {
+               fprintf(stderr, "sysfs_name %s version file error\n", 
sysfs_name);
                 return -1;
+       }

         edd_info->version = version;

Sincerely,

Dmitry Trikoz

dmitry.trikoz@stratus.com


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
