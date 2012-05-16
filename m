Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SUZ8K-0000xR-LL
 for kexec@lists.infradead.org; Wed, 16 May 2012 07:58:59 +0000
Message-ID: <4FB35DEF.2040008@cn.fujitsu.com>
Date: Wed, 16 May 2012 15:57:35 +0800
From: zhangyanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v2 5/5] Documentation: Add ABI entry for sysfs file vmcsinfo
 and vmcsinfo_maxsize
References: <4FB35C48.30708@cn.fujitsu.com>
In-Reply-To: <4FB35C48.30708@cn.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Avi Kivity <avi@redhat.com>, mtosatti@redhat.com
Cc: dzickus@redhat.com, luto@mit.edu, kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com, ludwig.nussel@suse.de, ebiederm@xmission.com, Greg KH <gregkh@linuxfoundation.org>

We create two new sysfs files, vmcsinfo and vmcsinfo_maxsize. And
here we add an Documentation/ABI entry for them.

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 Documentation/ABI/testing/sysfs-kernel-vmcsinfo |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-vmcsinfo

diff --git a/Documentation/ABI/testing/sysfs-kernel-vmcsinfo b/Documentation/ABI/testing/sysfs-kernel-vmcsinfo
new file mode 100644
index 0000000..adbf866
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-vmcsinfo
@@ -0,0 +1,16 @@
+What:		/sys/kernel/vmcsinfo
+Date:		April 2012
+KernelVersion:	3.4.0
+Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
+Description
+		Shows physical address of VMCSINFO. VMCSINFO contains
+		the VMCS revision identifier and encoded offsets of fields
+		in VMCS data on Intel processors equipped with the VT
+		extensions.
+
+What:		/sys/kernel/vmcsinfo_maxsize
+Date:		April 2012
+KernelVersion:	3.4.0
+Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
+Description
+		Shows max size of VMCSINFO.
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
