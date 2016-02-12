Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp02.in.ibm.com ([125.16.236.2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aUIc6-0002S3-Qc
 for kexec@lists.infradead.org; Fri, 12 Feb 2016 18:38:44 +0000
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <zohar@linux.vnet.ibm.com>;
 Sat, 13 Feb 2016 00:08:20 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1CIajx123265642
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:08:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1CIUX8b031197
 for <kexec@lists.infradead.org>; Sat, 13 Feb 2016 00:00:37 +0530
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v4 03/19] firmware: clean up filesystem load exit path
Date: Fri, 12 Feb 2016 13:29:15 -0500
Message-Id: <1455301771-7703-4-git-send-email-zohar@linux.vnet.ibm.com>
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Kees Cook <keescook@chromium.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-modules@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

This makes the error and success paths more readable while trying to
load firmware from the filesystem.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: David Howells <dhowells@redhat.com>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 drivers/base/firmware_class.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 7bc4ad0..c743a2f 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -361,19 +361,17 @@ static int fw_get_filesystem_firmware(struct device *device,
 			continue;
 		rc = fw_read_file_contents(file, buf);
 		fput(file);
-		if (rc)
+		if (rc) {
 			dev_warn(device, "loading %s failed with error %d\n",
 				 path, rc);
-		else
-			break;
-	}
-	__putname(path);
-
-	if (!rc) {
+			continue;
+		}
 		dev_dbg(device, "direct-loading %s\n",
 			buf->fw_id);
 		fw_finish_direct_load(device, buf);
+		break;
 	}
+	__putname(path);
 
 	return rc;
 }
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
