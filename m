From: Coiby Xu <coxu@redhat.com>
Date: Fri, 18 Mar 2022 18:34:20 +0800
Subject: [RFC 1/4] kexec,
 dm-crypt: receive LUKS master key from dm-crypt and pass it to kdump
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
Message-ID: <20220318103423.286410-2-coxu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

After receiving the LUKS master key from driver/md/dm-crypt, kdump has 1
hour at maximum to ask kexec to pass the key before the key gets wiped by
kexec. And after kdump retrieves the key, the key will be wiped
immediately.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/md/dm-crypt.c |  5 +++-
 include/linux/kexec.h |  3 ++
 kernel/kexec_core.c   | 66 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index d4ae31558826..41f9ca377312 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -41,6 +41,7 @@
 #include <keys/trusted-type.h>
 
 #include <linux/device-mapper.h>
+#include <linux/kexec.h>
 
 #include "dm-audit.h"
 
@@ -2388,6 +2389,8 @@ static int crypt_setkey(struct crypt_config *cc)
 	unsigned subkey_size;
 	int err = 0, i, r;
 
+	/* save master key to kexec */
+	kexec_save_luks_master_key(cc->key, cc->key_size);
 	/* Ignore extra keys (which are used for IV etc) */
 	subkey_size = crypt_subkey_size(cc);
 
@@ -3580,6 +3583,7 @@ static int crypt_message(struct dm_target *ti, unsigned argc, char **argv,
 			DMWARN("not suspended during key manipulation.");
 			return -EINVAL;
 		}
+
 		if (argc == 3 && !strcasecmp(argv[1], "set")) {
 			/* The key size may not be changed. */
 			key_size = get_key_size(&argv[2]);
@@ -3587,7 +3591,6 @@ static int crypt_message(struct dm_target *ti, unsigned argc, char **argv,
 				memset(argv[2], '0', strlen(argv[2]));
 				return -EINVAL;
 			}
-
 			ret = crypt_set_key(cc, argv[2]);
 			if (ret)
 				return ret;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 0c994ae37729..91507bc684e2 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -205,6 +205,9 @@ int arch_kexec_locate_mem_hole(struct kexec_buf *kbuf);
 extern int kexec_add_buffer(struct kexec_buf *kbuf);
 int kexec_locate_mem_hole(struct kexec_buf *kbuf);
 
+extern int kexec_pass_luks_master_key(void **addr, unsigned long *sz);
+extern int kexec_save_luks_master_key(u8 *key, unsigned int key_size);
+
 /* Alignment required for elf header segment */
 #define ELF_CORE_HEADER_ALIGN   4096
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 68480f731192..86df36b71443 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1218,3 +1218,69 @@ void __weak arch_kexec_protect_crashkres(void)
 
 void __weak arch_kexec_unprotect_crashkres(void)
 {}
+
+
+static u8 *luks_master_key;
+static unsigned int luks_master_key_size;
+
+void wipe_luks_master_key(void)
+{
+	if (luks_master_key) {
+		memset(luks_master_key, 0, luks_master_key_size * sizeof(u8));
+		kfree(luks_master_key);
+		luks_master_key = NULL;
+	}
+}
+
+static void _wipe_luks_master_key(struct work_struct *dummy)
+{
+	wipe_luks_master_key();
+}
+
+static DECLARE_DELAYED_WORK(wipe_luks_master_key_work, _wipe_luks_master_key);
+
+static unsigned __read_mostly wipe_key_delay = 3600; /* 1 hour */
+
+int kexec_save_luks_master_key(u8 *key, unsigned int key_size)
+{
+	if (luks_master_key) {
+		memset(luks_master_key, 0, luks_master_key_size * sizeof(u8));
+		kfree(luks_master_key);
+	}
+
+	luks_master_key = kmalloc(key_size * sizeof(u8), GFP_KERNEL);
+
+	if (!luks_master_key)
+		return -ENOMEM;
+	memcpy(luks_master_key, key, key_size * sizeof(u8));
+	luks_master_key_size = key_size;
+	pr_debug("LUKS master key (size=%u): %64ph\n", key_size, luks_master_key);
+	schedule_delayed_work(&wipe_luks_master_key_work,
+			      round_jiffies_relative(wipe_key_delay * HZ));
+	return 0;
+}
+EXPORT_SYMBOL(kexec_save_luks_master_key);
+
+int kexec_pass_luks_master_key(void **addr, unsigned long *sz)
+{
+	unsigned long luks_key_sz;
+	unsigned char *buf;
+	unsigned int *size_ptr;
+
+	if (!luks_master_key)
+		return -EINVAL;
+
+	luks_key_sz = sizeof(unsigned int) + luks_master_key_size * sizeof(u8);
+
+	buf = vzalloc(luks_key_sz);
+	if (!buf)
+		return -ENOMEM;
+
+	size_ptr = (unsigned int *)buf;
+	memcpy(size_ptr, &luks_master_key_size, sizeof(unsigned int));
+	memcpy(size_ptr + 1, luks_master_key, luks_master_key_size * sizeof(u8));
+	*addr = buf;
+	*sz = luks_key_sz;
+	wipe_luks_master_key();
+	return 0;
+}
-- 
2.34.1


