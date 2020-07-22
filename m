Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyKRs-0001gd-0n
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 19:30:45 +0000
Received: by mail-pg1-x542.google.com with SMTP id s189so1814825pgc.13
 for <kexec@lists.infradead.org>; Wed, 22 Jul 2020 12:30:39 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 12/18] firmware_loader: Use security_post_load_data()
Date: Wed, 22 Jul 2020 12:30:14 -0700
Message-Id: <20200722193020.2676422-13-keescook@chromium.org>
In-Reply-To: <20200722193020.2676422-1-keescook@chromium.org>
References: <20200722193020.2676422-1-keescook@chromium.org>
MIME-Version: 1.0
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, Stephen Boyd <stephen.boyd@linaro.org>, SeongJae Park <sjpark@amazon.de>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Tushar Sugandhi <tusharsu@linux.microsoft.com>, Peter Jones <pjones@redhat.com>, linux-kselftest@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, Shuah Khan <shuah@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Thomas Cedeno <thomascedeno@google.com>, linux-security-module@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>, Paul Moore <paul@paul-moore.com>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Matthew Garrett <matthewgarrett@google.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Aaron Goidel <acgoide@tycho.nsa.gov>, "Serge E. Hallyn" <serge@hallyn.com>, Wenwen Wang <wenwen@cs.uga.edu>, Kees Cook <keescook@chromium.org>, Scott Branden <scott.branden@broadcom.com>, selinux@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthieu Baerts <matthieu.baerts@tessares.net>, KP Singh <kpsingh@chromium.org>, Eric Paris <eparis@parisplace.org>, linux-integrity@vger.kernel.org, Florent Revest <revest@google.com>, Andrea Righi <andrea.righi@canonical.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Dave Olsthoorn <dave@bewaar.me>, Jessica Yu <jeyu@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Now that security_post_load_data() is wired up, use it instead
of the NULL file argument style of security_post_read_file(),
and update the security_kernel_load_data() call to indicate that a
security_kernel_post_load_data() call is expected.

Wire up the IMA check to match earlier logic. Perhaps a generalized
change to ima_post_load_data() might look something like this:

    return process_buffer_measurement(buf, size,
                                      kernel_load_data_id_str(load_id),
                                      read_idmap[load_id] ?: FILE_CHECK,
                                      0, NULL);

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/fallback.c       |  8 ++++----
 .../base/firmware_loader/fallback_platform.c  |  7 ++++++-
 security/integrity/ima/ima_main.c             | 20 +++++++++----------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index a196aacce22c..7cfdfdcb819c 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -272,9 +272,9 @@ static ssize_t firmware_loading_store(struct device *dev,
 				dev_err(dev, "%s: map pages failed\n",
 					__func__);
 			else
-				rc = security_kernel_post_read_file(NULL,
-						fw_priv->data, fw_priv->size,
-						READING_FIRMWARE);
+				rc = security_kernel_post_load_data(fw_priv->data,
+						fw_priv->size,
+						LOADING_FIRMWARE);
 
 			/*
 			 * Same logic as fw_load_abort, only the DONE bit
@@ -613,7 +613,7 @@ static bool fw_run_sysfs_fallback(u32 opt_flags)
 		return false;
 
 	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
-	ret = security_kernel_load_data(LOADING_FIRMWARE, false);
+	ret = security_kernel_load_data(LOADING_FIRMWARE, true);
 	if (ret < 0)
 		return false;
 
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index a12c79d47efc..4d1157af0e86 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -17,7 +17,7 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
-	rc = security_kernel_load_data(LOADING_FIRMWARE, false);
+	rc = security_kernel_load_data(LOADING_FIRMWARE, true);
 	if (rc)
 		return rc;
 
@@ -27,6 +27,11 @@ int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
 
 	if (fw_priv->data && size > fw_priv->allocated_size)
 		return -ENOMEM;
+
+	rc = security_kernel_post_load_data((u8 *)data, size, LOADING_FIRMWARE);
+	if (rc)
+		return rc;
+
 	if (!fw_priv->data)
 		fw_priv->data = vmalloc(size);
 	if (!fw_priv->data)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 85000dc8595c..1a7bc4c7437d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -648,15 +648,6 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
-	if (!file && read_id == READING_FIRMWARE) {
-		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-			pr_err("Prevent firmware loading_store.\n");
-			return -EACCES;	/* INTEGRITY_UNKNOWN */
-		}
-		return 0;
-	}
-
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -706,7 +697,7 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
 		}
 		break;
 	case LOADING_FIRMWARE:
-		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
+		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE) && !contents) {
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
@@ -739,6 +730,15 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
  */
 int ima_post_load_data(char *buf, loff_t size, enum kernel_load_data_id load_id)
 {
+	if (load_id == LOADING_FIRMWARE) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
+			return -EACCES; /* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
