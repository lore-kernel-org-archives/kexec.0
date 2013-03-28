Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UL8AS-0006IN-SC
 for kexec@lists.infradead.org; Thu, 28 Mar 2013 08:26:41 +0000
Message-ID: <5153FC27.70001@cn.fujitsu.com>
Date: Thu, 28 Mar 2013 16:15:35 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] sysfs: Add crash_notes_size to export percpu note size
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
To: Greg KH <gregkh@linuxfoundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

For percpu notes, we are exporting only address and not size. So
the userspace tool kexec-tools is putting an upper limit of 1024
and putting the value in p_memsz and p_filesz fields. So the patch
add the new sysfile crash_notes_size to export the exact percpu
note size and let the kexec-tools parse it intead of using 1024.

The idea came from Vivek Goyal. And a later patch will be sent to
kexec-tools to let it parse the size.

Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
---
 drivers/base/cpu.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fb10728..a55b590 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -132,6 +132,17 @@ static ssize_t show_crash_notes(struct device *dev, struct device_attribute *att
 	return rc;
 }
 static DEVICE_ATTR(crash_notes, 0400, show_crash_notes, NULL);
+
+static ssize_t show_crash_notes_size(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	ssize_t rc;
+
+	rc = sprintf(buf, "%lu\n", sizeof(note_buf_t));
+	return rc;
+}
+static DEVICE_ATTR(crash_notes_size, 0400, show_crash_notes_size, NULL);
 #endif
 
 /*
@@ -259,6 +270,9 @@ int __cpuinit register_cpu(struct cpu *cpu, int num)
 #ifdef CONFIG_KEXEC
 	if (!error)
 		error = device_create_file(&cpu->dev, &dev_attr_crash_notes);
+	if (!error)
+		error = device_create_file(&cpu->dev,
+					   &dev_attr_crash_notes_size);
 #endif
 	return error;
 }
-- 
1.7.1

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
