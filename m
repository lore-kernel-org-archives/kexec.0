Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([125.16.236.7])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUIb1-0002AJ-U3
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 18:37:36 +0000
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:07:13 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CIajvT23265642
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:07:04 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CIUOfB031028
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:29 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 02/19] firmware: move completing fw into a helper
Date: Fri, 12 Feb 2016 13:29:14 -0500
Message-Id: <1455301771-7703-3-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1455301771-7703-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module <linux-security-module@vger.kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

This will be re-used later through a new extensible interface.

Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Acked-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_class.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index ce88355..7bc4ad0 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -322,6 +322,15 @@ fail:
 	return rc;
 }
 
+static void fw_finish_direct_load(struct device *device,
+				  struct firmware_buf *buf)
+{
+	mutex_lock(&fw_lock);
+	set_bit(FW_STATUS_DONE, &buf->status);
+	complete_all(&buf->completion);
+	mutex_unlock(&fw_lock);
+}
+
 static int fw_get_filesystem_firmware(struct device *device,
 				       struct firmware_buf *buf)
 {
@@ -363,10 +372,7 @@ static int fw_get_filesystem_firmware(struct device *device,
 	if (!rc) {
 		dev_dbg(device, "direct-loading %s\n",
 			buf->fw_id);
-		mutex_lock(&fw_lock);
-		set_bit(FW_STATUS_DONE, &buf->status);
-		complete_all(&buf->completion);
-		mutex_unlock(&fw_lock);
+		fw_finish_direct_load(device, buf);
 	}
 
 	return rc;
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
