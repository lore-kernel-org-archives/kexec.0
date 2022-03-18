From: Coiby Xu <coxu@redhat.com>
Date: Fri, 18 Mar 2022 18:34:23 +0800
Subject: [RFC 4/4] dm-crypt: reuse LUKS master key in kdump kernel
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
Message-ID: <20220318103423.286410-5-coxu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

When libcryptsetup passes key string starting with ":kdump", dm-crypt
will interpret it as reusing the LUKS master key in kdump kernel.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 drivers/md/dm-crypt.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 41f9ca377312..f3986036ec40 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -42,6 +42,7 @@
 
 #include <linux/device-mapper.h>
 #include <linux/kexec.h>
+#include <linux/crash_dump.h>
 
 #include "dm-audit.h"
 
@@ -2602,13 +2603,17 @@ static int crypt_set_key(struct crypt_config *cc, char *key)
 {
 	int r = -EINVAL;
 	int key_string_len = strlen(key);
+	bool retrieve_kdump_key = false;
+
+	if (is_kdump_kernel() && !strncmp(key, ":kdump", 5))
+		retrieve_kdump_key = true;
 
 	/* Hyphen (which gives a key_size of zero) means there is no key. */
-	if (!cc->key_size && strcmp(key, "-"))
+	if (!retrieve_kdump_key && !cc->key_size && strcmp(key, "-"))
 		goto out;
 
 	/* ':' means the key is in kernel keyring, short-circuit normal key processing */
-	if (key[0] == ':') {
+	if (!retrieve_kdump_key && key[0] == ':') {
 		r = crypt_set_keyring_key(cc, key + 1);
 		goto out;
 	}
@@ -2620,9 +2625,15 @@ static int crypt_set_key(struct crypt_config *cc, char *key)
 	kfree_sensitive(cc->key_string);
 	cc->key_string = NULL;
 
-	/* Decode key from its hex representation. */
-	if (cc->key_size && hex2bin(cc->key, key, cc->key_size) < 0)
-		goto out;
+	if (retrieve_kdump_key) {
+		r = retrive_kdump_luks_master_key(cc->key, &cc->key_size);
+		if (r < 0)
+			goto out;
+	} else {
+		/* Decode key from its hex representation. */
+		if (cc->key_size && hex2bin(cc->key, key, cc->key_size) < 0)
+			goto out;
+	}
 
 	r = crypt_setkey(cc);
 	if (!r)
-- 
2.34.1


