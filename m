Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aR2ml-0002pZ-Mi
 for kexec@lists.infradead.org; Wed, 03 Feb 2016 19:08:20 +0000
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Thu, 4 Feb 2016 05:07:53 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0AF682CE8054
 for <kexec@lists.infradead.org>; Thu,  4 Feb 2016 06:07:50 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u13J7fhV59769082
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u13J7GKo009017
 for <kexec@lists.infradead.org>; Thu, 4 Feb 2016 06:07:17 +1100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 05/22] firmware: move completing fw into a helper
Date: Wed,  3 Feb 2016 14:06:13 -0500
Message-Id: <1454526390-19792-6-git-send-email-zohar@linux.vnet.ibm.com>
In-Reply-To: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
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
To: linux-security-module@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, linux-modules@vger.kernel.org, fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Kees Cook <keescook@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Biederman <ebiederm@xmission.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Mimi Zohar <zohar@linux.vnet.ibm.com>

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

This will be re-used later through a new extensible interface.

Reviewed-by: Josh Boyer <jwboyer@fedoraproject.org>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 3358f5d..fb64814 100644
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
