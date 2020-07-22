Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyKRv-0001iY-AV
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 19:30:48 +0000
Received: by mail-pj1-x1041.google.com with SMTP id mn17so2028071pjb.4
 for <kexec@lists.infradead.org>; Wed, 22 Jul 2020 12:30:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 16/18] firmware: Store opt_flags in fw_priv
Date: Wed, 22 Jul 2020 12:30:18 -0700
Message-Id: <20200722193020.2676422-17-keescook@chromium.org>
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

Instead of passing opt_flags around so much, store it in the private
structure so it can be examined by internals without needing to add more
arguments to functions.

Co-developed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/fallback.c       | 11 +++-----
 drivers/base/firmware_loader/fallback.h       |  5 ++--
 .../base/firmware_loader/fallback_platform.c  |  4 +--
 drivers/base/firmware_loader/firmware.h       |  3 ++-
 drivers/base/firmware_loader/main.c           | 25 +++++++++++--------
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 7cfdfdcb819c..0a94c8739959 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -490,13 +490,11 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
 /**
  * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
  * @fw_sysfs: firmware sysfs information for the firmware to load
- * @opt_flags: flags of options, FW_OPT_*
  * @timeout: timeout to wait for the load
  *
  * In charge of constructing a sysfs fallback interface for firmware loading.
  **/
-static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
-				  u32 opt_flags, long timeout)
+static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 {
 	int retval = 0;
 	struct device *f_dev = &fw_sysfs->dev;
@@ -518,7 +516,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 	list_add(&fw_priv->pending_list, &pending_fw_head);
 	mutex_unlock(&fw_lock);
 
-	if (opt_flags & FW_OPT_UEVENT) {
+	if (fw_priv->opt_flags & FW_OPT_UEVENT) {
 		fw_priv->need_uevent = true;
 		dev_set_uevent_suppress(f_dev, false);
 		dev_dbg(f_dev, "firmware: requesting %s\n", fw_priv->fw_name);
@@ -580,10 +578,10 @@ static int fw_load_from_user_helper(struct firmware *firmware,
 	}
 
 	fw_sysfs->fw_priv = firmware->priv;
-	ret = fw_load_sysfs_fallback(fw_sysfs, opt_flags, timeout);
+	ret = fw_load_sysfs_fallback(fw_sysfs, timeout);
 
 	if (!ret)
-		ret = assign_fw(firmware, device, opt_flags);
+		ret = assign_fw(firmware, device);
 
 out_unlock:
 	usermodehelper_read_unlock();
@@ -625,7 +623,6 @@ static bool fw_run_sysfs_fallback(u32 opt_flags)
  * @fw: pointer to firmware image
  * @name: name of firmware file to look for
  * @device: device for which firmware is being loaded
- * @opt_flags: options to control firmware loading behaviour
  * @ret: return value from direct lookup which triggered the fallback mechanism
  *
  * This function is called if direct lookup for the firmware failed, it enables
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 2afdb6adb23f..3af7205b302f 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -67,10 +67,9 @@ static inline void unregister_sysfs_loader(void)
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
 
 #ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
-int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags);
+int firmware_fallback_platform(struct fw_priv *fw_priv);
 #else
-static inline int firmware_fallback_platform(struct fw_priv *fw_priv,
-					     u32 opt_flags)
+static inline int firmware_fallback_platform(struct fw_priv *fw_priv)
 {
 	return -ENOENT;
 }
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 4d1157af0e86..38de68d7e973 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -8,13 +8,13 @@
 #include "fallback.h"
 #include "firmware.h"
 
-int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
+int firmware_fallback_platform(struct fw_priv *fw_priv)
 {
 	const u8 *data;
 	size_t size;
 	int rc;
 
-	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
+	if (!(fw_priv->opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
 	rc = security_kernel_load_data(LOADING_FIRMWARE, true);
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 933e2192fbe8..7ad5fe52bc72 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -68,6 +68,7 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	u32 opt_flags;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
 	struct page **pages;
@@ -136,7 +137,7 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 	__fw_state_set(fw_priv, FW_STATUS_DONE);
 }
 
-int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags);
+int assign_fw(struct firmware *fw, struct device *device);
 
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 void fw_free_paged_buf(struct fw_priv *fw_priv);
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index d95249b5284e..814a18cc51bd 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -168,7 +168,9 @@ static int fw_cache_piggyback_on_request(const char *name);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
-					  void *dbuf, size_t size)
+					  void *dbuf,
+					  size_t size,
+					  u32 opt_flags)
 {
 	struct fw_priv *fw_priv;
 
@@ -186,6 +188,7 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->opt_flags = opt_flags;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	INIT_LIST_HEAD(&fw_priv->pending_list);
@@ -210,8 +213,10 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 /* Returns 1 for batching firmware requests with the same name */
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
-				struct fw_priv **fw_priv, void *dbuf,
-				size_t size, u32 opt_flags)
+				struct fw_priv **fw_priv,
+				void *dbuf,
+				size_t size,
+				u32 opt_flags)
 {
 	struct fw_priv *tmp;
 
@@ -227,7 +232,7 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 		}
 	}
 
-	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
+	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, opt_flags);
 	if (tmp) {
 		INIT_LIST_HEAD(&tmp->list);
 		if (!(opt_flags & FW_OPT_NOCACHE))
@@ -635,7 +640,7 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 }
 #endif
 
-int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
+int assign_fw(struct firmware *fw, struct device *device)
 {
 	struct fw_priv *fw_priv = fw->priv;
 	int ret;
@@ -654,8 +659,8 @@ int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 	 * should be fixed in devres or driver core.
 	 */
 	/* don't cache firmware handled without uevent */
-	if (device && (opt_flags & FW_OPT_UEVENT) &&
-	    !(opt_flags & FW_OPT_NOCACHE)) {
+	if (device && (fw_priv->opt_flags & FW_OPT_UEVENT) &&
+	    !(fw_priv->opt_flags & FW_OPT_NOCACHE)) {
 		ret = fw_add_devm_name(device, fw_priv->fw_name);
 		if (ret) {
 			mutex_unlock(&fw_lock);
@@ -667,7 +672,7 @@ int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 	 * After caching firmware image is started, let it piggyback
 	 * on request firmware.
 	 */
-	if (!(opt_flags & FW_OPT_NOCACHE) &&
+	if (!(fw_priv->opt_flags & FW_OPT_NOCACHE) &&
 	    fw_priv->fwc->state == FW_LOADER_START_CACHE) {
 		if (fw_cache_piggyback_on_request(fw_priv->fw_name))
 			kref_get(&fw_priv->ref);
@@ -778,7 +783,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 #endif
 
 	if (ret == -ENOENT)
-		ret = firmware_fallback_platform(fw->priv, opt_flags);
+		ret = firmware_fallback_platform(fw->priv);
 
 	if (ret) {
 		if (!(opt_flags & FW_OPT_NO_WARN))
@@ -787,7 +792,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 				 name, ret);
 		ret = firmware_fallback_sysfs(fw, name, device, opt_flags, ret);
 	} else
-		ret = assign_fw(fw, device, opt_flags);
+		ret = assign_fw(fw, device);
 
  out:
 	if (ret < 0) {
-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
