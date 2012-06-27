Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1Sjo5x-0006ir-UG
 for kexec@lists.infradead.org; Wed, 27 Jun 2012 08:59:30 +0000
Message-ID: <4FEACAA8.8010402@cn.fujitsu.com>
Date: Wed, 27 Jun 2012 16:56:08 +0800
From: Yanfei Zhang <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH v3 5/5] Documentation: Add ABI entry for vmcs sysfs interface
References: <4FEAC945.50700@cn.fujitsu.com>
In-Reply-To: <4FEAC945.50700@cn.fujitsu.com>
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
 Documentation/ABI/testing/sysfs-devices-cpu-vmcs |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-cpu-vmcs

diff --git a/Documentation/ABI/testing/sysfs-devices-cpu-vmcs b/Documentation/ABI/testing/sysfs-devices-cpu-vmcs
new file mode 100644
index 0000000..0846b07
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-cpu-vmcs
@@ -0,0 +1,11 @@
+What:		/sys/devices/cpu/vmcs/
+Date:		June 2012
+KernelVersion:	3.5.0
+Contact:	Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
+Description:
+		A collection of vmcs fields' offsets for Intel cpu.
+
+		Individual offsets are contained in subfiles named by
+		the filed's encoding, e.g.:
+
+		/sys/devices/cpu/vmcs/0800
-- 
1.7.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
