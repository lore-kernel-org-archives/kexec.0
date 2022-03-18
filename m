From: Coiby Xu <coxu@redhat.com>
Date: Fri, 18 Mar 2022 18:34:22 +0800
Subject: [RFC 3/4] crash_dump: retrieve LUKS master key in kdump kernel
In-Reply-To: <20220318103423.286410-1-coxu@redhat.com>
References: <20220318103423.286410-1-coxu@redhat.com>
Message-ID: <20220318103423.286410-4-coxu@redhat.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

kdump will retrieve the LUKS master key based on the luksmasterkey
command line parameter.

Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/crash_dump.h |  4 +++
 kernel/crash_dump.c        | 69 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index 620821549b23..24acb84b716e 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -15,6 +15,8 @@
 extern unsigned long long elfcorehdr_addr;
 extern unsigned long long elfcorehdr_size;
 
+extern unsigned long long luks_master_key_addr;
+
 #ifdef CONFIG_CRASH_DUMP
 extern int elfcorehdr_alloc(unsigned long long *addr, unsigned long long *size);
 extern void elfcorehdr_free(unsigned long long addr);
@@ -32,6 +34,8 @@ extern ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf,
 
 void vmcore_cleanup(void);
 
+int retrive_kdump_luks_master_key(u8 *buffer, unsigned int *sz);
+
 /* Architecture code defines this if there are other possible ELF
  * machine types, e.g. on bi-arch capable hardware. */
 #ifndef vmcore_elf_check_arch_cross
diff --git a/kernel/crash_dump.c b/kernel/crash_dump.c
index 92da32275af5..ee32de300b9e 100644
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -15,6 +15,8 @@
 unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
 EXPORT_SYMBOL_GPL(elfcorehdr_addr);
 
+unsigned long long luks_master_key_addr;
+EXPORT_SYMBOL_GPL(luks_master_key_addr);
 /*
  * stores the size of elf header of crash image
  */
@@ -39,3 +41,70 @@ static int __init setup_elfcorehdr(char *arg)
 	return end > arg ? 0 : -EINVAL;
 }
 early_param("elfcorehdr", setup_elfcorehdr);
+
+static int __init setup_luksmasterkey(char *arg)
+{
+	char *end;
+
+	if (!arg)
+		return -EINVAL;
+	luks_master_key_addr = memparse(arg, &end);
+	if (end > arg)
+		return 0;
+
+	luks_master_key_addr = 0;
+	return -EINVAL;
+}
+
+early_param("luksmasterkey", setup_luksmasterkey);
+
+/*
+ * Architectures may override this function to read LUKS master key
+ */
+ssize_t __weak luks_key_read(char *buf, size_t count, u64 *ppos)
+{
+	return read_from_oldmem(buf, count, ppos, 0, false);
+}
+
+int retrive_kdump_luks_master_key(u8 *buffer, unsigned int *sz)
+{
+	unsigned int key_size;
+	size_t lukskeybuf_sz;
+	unsigned int *size_ptr;
+	char *lukskeybuf;
+	u64 addr;
+	int r;
+
+	if (luks_master_key_addr == 0) {
+		pr_debug("LUKS master key memory address inaccessible");
+		return -EINVAL;
+	}
+
+	addr = luks_master_key_addr;
+
+	/* Read LUKS master key size */
+	r = luks_key_read((char *)&key_size, sizeof(unsigned int), &addr);
+
+	if (r < 0)
+		return r;
+
+	pr_debug("Retrieve LUKS master key: size=%u\n", key_size);
+	/* Read in LUKS maste rkey */
+	lukskeybuf_sz = sizeof(unsigned int) + key_size * sizeof(u8);
+	lukskeybuf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					      get_order(lukskeybuf_sz));
+	if (!lukskeybuf)
+		return -ENOMEM;
+
+	addr = luks_master_key_addr;
+	r = luks_key_read((char *)lukskeybuf, lukskeybuf_sz, &addr);
+
+	if (r < 0)
+		return r;
+	size_ptr = (unsigned int *)lukskeybuf;
+	memcpy(buffer, size_ptr + 1, key_size * sizeof(u8));
+	pr_debug("Retrieve LUKS master key (size=%u): %48ph...\n", key_size, buffer);
+	*sz = key_size;
+	return 0;
+}
+EXPORT_SYMBOL(retrive_kdump_luks_master_key);
-- 
2.34.1


