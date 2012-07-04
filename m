Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SmMio-0007JQ-U6
 for kexec@lists.infradead.org; Wed, 04 Jul 2012 10:22:18 +0000
Message-ID: <4FF415A4.8040405@cn.fujitsu.com>
Date: Wed, 04 Jul 2012 18:06:28 +0800
From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v4 3/3] Documentation: Add ABI entry for vmcs sysfs interface
References: <4FF413D2.4030006@cn.fujitsu.com>
In-Reply-To: <4FF413D2.4030006@cn.fujitsu.com>
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

Signed-off-by: zhangyanfei <zhangyanfei@cn.fujitsu.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |   21 ++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 5dab364..6efbd6c 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -9,6 +9,27 @@ Description:
 
 		/sys/devices/system/cpu/cpu#/
 
+What:		/sys/devices/system/cpu/vmcs_id
+Date:		June 2012
+KernelVersion:	3.5.0
+Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
+Description:
+		Vmcs revision identifier in Intel cpu. The value enables
+		software to avoid using a VMCS region formatted for one
+		processor on a processor that uses a different format.
+
+What:		/sys/devices/system/cpu/vmcs/
+Date:		June 2012
+KernelVersion:	3.5.0
+Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
+Description:
+		A collection of vmcs fields' offsets for Intel cpu.
+
+		Individual offsets are contained in subfiles named by
+		the filed's encoding, e.g.:
+
+		/sys/devices/system/cpu/vmcs/0800
+
 What:		/sys/devices/system/cpu/kernel_max
 		/sys/devices/system/cpu/offline
 		/sys/devices/system/cpu/online
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
