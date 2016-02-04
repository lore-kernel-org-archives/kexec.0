Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x230.google.com ([2607:f8b0:400e:c03::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aRRFM-00029s-QV
 for kexec@lists.infradead.org; Thu, 04 Feb 2016 21:15:32 +0000
Received: by mail-pa0-x230.google.com with SMTP id cy9so21687089pac.0
 for <kexec@lists.infradead.org>; Thu, 04 Feb 2016 13:15:04 -0800 (PST)
Date: Thu, 4 Feb 2016 13:15:02 -0800
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3.1] firmware: clean up filesystem load exit path
Message-ID: <20160204211501.GA14755@www.outflux.net>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, Josh Boyer <jwboyer@fedoraproject.org>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, David Woodhouse <dwmw2@infradead.org>, linux-modules@vger.kernel.org

This makes the error and success paths more readable while trying to
load firmware from the filesystem.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Josh Boyer <jwboyer@fedoraproject.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
Suggested as an alternative to "[PATCH v3 06/22] firmware: fold successful fw read early"
---
 drivers/base/firmware_class.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 62e052b50aa9..484afbd783f8 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -352,19 +352,17 @@ static int fw_get_filesystem_firmware(struct device *device,
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
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
