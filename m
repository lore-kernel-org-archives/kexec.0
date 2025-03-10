Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A099C3ABA0
	for <kexec@archiver.kernel.org>; Mon, 10 Mar 2025 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1b7amWEdfOMn3dBa5y8kCkl4gC/rL4o8XC5y5Q7zNnY=; b=dT7dIU42fkaegHCYGoRYk60Pi1
	hVql4tJYrsw9KcvfasxFeYtkEV/cgaz5dKk8PHpM13k3MoHcQ5YCEseGn07ScKWpHAOh+KICE55wR
	436KCyR6K26N3CxDIf72rybylEAp4XohbUbUjk9n+ilcuS8De/4x+DqVkVmZNnn8D8PhOV8cp75HU
	ruklNPWgG5sF2alt4rj5GsxbMOwX7mzyNovEAq4divhA6psWbwnrVoiOtmVimnnFu6iY1x9MQ/rZi
	Y651uu12TKdZWXzbVlZPKA0D4gAPJy5AHzwKOs66pXYdPFHnssMENuVQmcp8kF1Vt47It4zvJhH+E
	olXG7q3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trc41-00000002ZQk-1G1h;
	Mon, 10 Mar 2025 12:16:57 +0000
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trbrd-00000002WDz-2wp8
	for kexec@lists.infradead.org;
	Mon, 10 Mar 2025 12:04:12 +0000
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 03EC360B5B;
	Mon, 10 Mar 2025 15:04:04 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id s3o0lL2FT0U0-wpbfwx9m;
	Mon, 10 Mar 2025 15:04:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1741608243;
	bh=1b7amWEdfOMn3dBa5y8kCkl4gC/rL4o8XC5y5Q7zNnY=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=YmAdzPZ6RtAzCKFkm/3kw3wrdqegk5mcA5h8cUxsfgsVjemo8cq/ZFPdS717vlMeI
	 eosrMAMlEZ1IzlszEE9Z4z08VMWAer6yN0gi/IBi+yJJ9S/5qQGFDAuRRnUR03yAJO
	 fX9DMIwj0e2Fd0FPp8DyK3kUZU8pVYI4/J6Kb2vo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [PATCH v2 1/7] kstate: Add kstate - a mechanism to describe and migrate kernel state across kexec
Date: Mon, 10 Mar 2025 13:03:12 +0100
Message-ID: <20250310120318.2124-2-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250310120318.2124-1-arbn@yandex-team.com>
References: <20250310120318.2124-1-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_050410_092616_E13BD9AA 
X-CRM114-Status: GOOD (  37.84  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

KSTATE (kernel state) is a mechanism to describe internal kernel state
save it into the memory and restore the state after kexec in new kernel.

The end goal here and the main use case for this is to be able to
update host kernel under VMs with VFIO pass-through devices running
on that host.

The idea behind KSTATE resembles QEMU's migration framework [1], which
solves quite similar problem - migrate state of VM/emulated devices
across different versions of QEMU.

This and following patches try to establish some basic infrastructure
to describe and migrate in-kernel data structures.

State of kernel data (usually it's some struct) is described by the
'struct kstate_description' containing the array of individual
fields descpriptions - 'struct kstate_field'. Each field
has set of bits in ->flags which instructs how to save/restore
a certain field of the struct. E.g. (see kstate.h for the full list):
    KS_BASE_TYPE flag tells that field can be just copied by value,

    KS_POINTER means that the struct member is a pointer to the actual
     data, so it needs to be dereference before saving/restoring data
     to/from kstate data steam.

kstate_register() call accepts kstate_description along with an instance
of an object and registers it in the global 'states' list.

During kexec reboot phase we go through the list of 'kstate_description's
and each instance of kstate_description forms the 'struct kstate_entry'
which save into the kstate's data stream.

The 'kstate_entry' contains information like ID of kstate_description, version
of it, size of migration data and the data itself. The ->data is formed in
accordance to the kstate_field's of the corresponding kstate_description.

After the reboot, when the kstate_register() called it parses migration
stream, finds the appropriate 'kstate_entry' and restores the contents of
the object in accordance with kstate_description and ->fields.

 [1] https://www.qemu.org/docs/master/devel/migration/main.html#vmstate

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 include/linux/kstate.h | 178 ++++++++++++++++++++++++++
 kernel/Kconfig.kexec   |  13 ++
 kernel/Makefile        |   1 +
 kernel/kstate.c        | 282 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 474 insertions(+)
 create mode 100644 include/linux/kstate.h
 create mode 100644 kernel/kstate.c

diff --git a/include/linux/kstate.h b/include/linux/kstate.h
new file mode 100644
index 000000000000..4fc01e535bc0
--- /dev/null
+++ b/include/linux/kstate.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _KSTATE_H
+#define _KSTATE_H
+
+#include <linux/atomic.h>
+#include <linux/build_bug.h>
+#include <linux/list.h>
+#include <linux/stringify.h>
+
+struct kstate_description;
+struct kstate_stream;
+struct kimage;
+
+enum kstate_flags {
+
+	/*
+	 * The struct member at 'obj + kstate_field.offset' is some basic
+	 * type, just copy it by value. The size is kstate_field->size.
+	 */
+
+	KS_BASE_TYPE = (1 << 0),
+
+	/*
+	 * The struct member at 'obj + kstate_field.offset' is a pointer
+	 * to the actual data (e.g. struct a { int *b; }).
+	 * save_kstate() will dereference the pointer to get the actual data
+	 * and store it to the stream. restore_kstate() will copy the data from
+	 * the stream to wherever the pointer points to.
+	 */
+	KS_POINTER = (1 << 1),
+
+	/*
+	 * The struct member at 'obj + kstate_field.offset' is another struct.
+	 * kstate_field->ksd points to 'kstate_description' of that struct.
+	 */
+	KS_STRUCT = (1 << 2),
+
+	/*
+	 * Some non-trivial field that requires custom kstate_field->save()
+	 * ->restore() callbacks to save/restore data.
+	 */
+	KS_CUSTOM = (1 << 3),
+
+	/*
+	 * The field is a array of kstate_field->count() pointers
+	 * (e.g. struct a { uint8_t *b[]; }). Dereference each array entry
+	 * before store/restore data.
+	 */
+	KS_ARRAY_OF_POINTER = (1 << 4),
+
+	/*
+	 * The field is a pointer to vmemmap or linear memory (determined by
+	 * kstate_field->addr_type). This is used for pointers to persistent
+	 * pages/data. Store offset from the start of the area instead of
+	 * pointer itself, so we could defeat KASLR on restore phase (by adding
+	 * new kernel's corresponding offset).
+	 */
+	KS_ADDRESS = (1 << 5),
+
+	/* Marks the end of fields list */
+	KS_END = (1UL << 31),
+};
+
+enum kstate_addr_type {
+	KS_VMEMMAP_ADDR,
+	KS_LINEAR_ADDR,
+};
+
+struct kstate_stream {
+	void *start;
+	void *pos;
+	size_t size;
+};
+
+struct kstate_field {
+	const char *name;
+	size_t offset;
+	size_t size;
+	enum kstate_flags flags;
+	const struct kstate_description *ksd;
+	enum kstate_addr_type addr_type;
+	int version_id;
+	int (*restore)(struct kstate_stream *stream, void *obj,
+		const struct kstate_field *field);
+	int (*save)(struct kstate_stream *stream, void *obj,
+		const struct kstate_field *field);
+	int (*count)(void);
+};
+
+enum kstate_ids {
+	KSTATE_LAST_ID = -1,
+};
+
+struct kstate_description {
+	const char *name;
+	enum kstate_ids id;
+	atomic_t instance_id;
+	int version_id;
+	struct list_head state_list;
+
+	const struct kstate_field *fields;
+};
+
+struct state_entry {
+	u64 id;
+	struct list_head list;
+	struct kstate_description *kstd;
+	void *obj;
+};
+
+extern int kstate_save_data(struct kstate_stream *stream, void *val, size_t size);
+
+static inline bool kstate_get_byte(struct kstate_stream *stream)
+{
+	bool ret = *(u8 *)stream->pos;
+	stream->pos++;
+        return ret;
+}
+
+static inline unsigned long kstate_get_ulong(struct kstate_stream *stream)
+{
+	unsigned long ret = *(unsigned long *)stream->pos;
+	stream->pos += sizeof(unsigned long);
+        return ret;
+}
+
+#ifdef CONFIG_KSTATE
+
+int kstate_save_state(void);
+void free_kstate_stream(void);
+
+int kstate_register(struct kstate_description *state, void *obj);
+
+struct kstate_entry;
+int save_kstate(struct kstate_stream *stream, int id,
+		const struct kstate_description *kstate,
+		void *obj);
+void restore_kstate(struct kstate_stream *stream, int id,
+		const struct kstate_description *kstate, void *obj);
+
+#else
+
+#define kstate_register(state, obj)
+
+static inline int kstate_save_state(void) { return 0; }
+static inline void free_kstate_stream(void) { }
+
+#endif
+
+
+#define KSTATE_BASE_TYPE(_f, _state, _type) {		\
+	.name = (__stringify(_f)),			\
+	.size = sizeof(_type) + BUILD_BUG_ON_ZERO(	\
+			!__same_type(typeof_member(_state, _f), _type)),\
+	.flags = KS_BASE_TYPE,				\
+	.offset = offsetof(_state, _f),			\
+}
+
+#define KSTATE_POINTER(_f, _state) {			\
+		.name = (__stringify(_f)),		\
+		.size = sizeof(*(((_state *)0)->_f)),	\
+		.flags = KS_POINTER,			\
+		.offset = offsetof(_state, _f),		\
+	}
+
+#define KSTATE_ADDRESS(_f, _state, _addr_type) {	\
+		.name = (__stringify(_f)),		\
+		.size = sizeof(*(((_state *)0)->_f)),	\
+		.addr_type = (_addr_type),		\
+		.flags = KS_ADDRESS,			\
+		.offset = offsetof(_state, _f),		\
+	}
+
+#define KSTATE_END_OF_LIST() {	\
+		.flags = KS_END,\
+	}
+
+#endif
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 4d111f871951..480dc156b08b 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -151,4 +151,17 @@ config CRASH_MAX_MEMORY_RANGES
 	  the computation behind the value provided through the
 	  /sys/kernel/crash_elfcorehdr_size attribute.
 
+config ARCH_HAS_KSTATE
+	bool
+
+config KSTATE
+	bool "Migrate internal kernel state across kexec"
+	default n
+	depends on ARCH_HAS_KSTATE
+	depends on KEXEC_FILE
+	help
+	  KSTATE (kernel state) is a mechanism to describe internal kernel
+	  state, save it into the memory and restore the state after kexec
+	  in new kernel.
+
 endmenu
diff --git a/kernel/Makefile b/kernel/Makefile
index 87866b037fbe..6bdf947fc84f 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -75,6 +75,7 @@ obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
+obj-$(CONFIG_KSTATE) += kstate.o
 obj-$(CONFIG_BACKTRACE_SELF_TEST) += backtracetest.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_CGROUPS) += cgroup/
diff --git a/kernel/kstate.c b/kernel/kstate.c
new file mode 100644
index 000000000000..a73a9a42e55b
--- /dev/null
+++ b/kernel/kstate.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/ctype.h>
+#include <linux/kexec.h>
+#include <linux/kstate.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+
+static LIST_HEAD(states);
+
+struct kstate_entry {
+	int state_id;
+	int version_id;
+	int instance_id;
+	int size;
+	DECLARE_FLEX_ARRAY(u8, data);
+};
+
+struct kstate_stream kstate_stream;
+
+static unsigned long get_addr_offset(const struct kstate_field *field)
+{
+	switch (field->addr_type) {
+	case KS_VMEMMAP_ADDR:
+		return VMEMMAP_START;
+	case KS_LINEAR_ADDR:
+		return PAGE_OFFSET;
+	default:
+		WARN_ON(1);
+	}
+	return 0;
+}
+
+static int alloc_space(struct kstate_stream *stream, size_t size)
+{
+	void *new_start;
+	size_t new_size;
+	size_t cur_size = stream->pos - stream->start;
+
+	size = size + 4; /* Always alloc extra for KSTATE_LAST_ID */
+	if (cur_size + size < stream->size)
+		return 0;
+
+	new_size = PAGE_ALIGN(cur_size + size);
+
+	new_start = vrealloc(stream->start, new_size, GFP_KERNEL);
+	if (!new_start)
+		return -ENOMEM;
+
+	stream->start = new_start;
+	stream->size = new_size;
+	stream->pos = stream->start + cur_size;
+	return 0;
+}
+
+int kstate_save_data(struct kstate_stream *stream, void *val, size_t size)
+{
+	int ret;
+
+	ret = alloc_space(stream, size);
+	if (ret)
+		return ret;
+	memcpy(stream->pos, val, size);
+	stream->pos += size;
+	return 0;
+}
+
+int save_kstate(struct kstate_stream *stream, int id,
+		const struct kstate_description *kstate,
+		void *obj)
+{
+	const struct kstate_field *field = kstate->fields;
+	struct kstate_entry *ke;
+	unsigned long ke_off;
+	int ret = 0;
+
+	ret = alloc_space(stream, sizeof(*ke));
+	if (ret)
+		goto err;
+
+	ke_off = stream->pos - stream->start;
+	ke = stream->pos;
+	stream->pos += sizeof(*ke);
+
+	ke->state_id = kstate->id;
+	ke->version_id = kstate->version_id;
+	ke->instance_id = id;
+
+	while (field->flags != KS_END) {
+		void *first,  *cur;
+		int n_elems = 1;
+		int size, i;
+
+		first = obj + field->offset;
+
+		if (field->flags & KS_POINTER)
+			first = *(void **)(obj + field->offset);
+		if (field->count)
+			n_elems = field->count();
+		size = field->size;
+		for (i = 0; i < n_elems; i++) {
+			cur = first + i * size;
+
+			if (field->flags & KS_ARRAY_OF_POINTER)
+				cur = *(void **)cur;
+
+			if (field->flags & KS_STRUCT) {
+				ret = save_kstate(stream, 0, field->ksd, cur);
+				if (ret)
+					goto err;
+			} else if (field->flags & KS_CUSTOM) {
+				if (field->save) {
+					ret = field->save(stream, cur, field);
+					if (ret)
+						goto err;
+				}
+			} else if (field->flags & (KS_BASE_TYPE|KS_POINTER)) {
+				ret = kstate_save_data(stream, cur, size);
+				if (ret)
+					goto err;
+			} else if (field->flags & KS_ADDRESS) {
+				void *addr_offset = *(void **)cur
+					- get_addr_offset(field);
+				ret = kstate_save_data(stream, &addr_offset,
+						sizeof(addr_offset));
+				if (ret)
+					goto err;
+			} else
+				WARN_ON_ONCE(1);
+		}
+		field++;
+
+	}
+
+	ke = stream->start + ke_off;
+	ke->size = (stream->pos - stream->start) - (ke_off + sizeof(*ke));
+err:
+	if (ret)
+		pr_err("kstate: save of state %s failed\n", kstate->name);
+
+	return ret;
+}
+
+static int alloc_kstate_stream(void)
+{
+	size_t size = PAGE_SIZE;
+	void *buf;
+
+	buf = vzalloc(size);
+	if (!buf)
+		return -ENOMEM;
+
+	kstate_stream.size = size;
+	kstate_stream.start = kstate_stream.pos = buf;
+	return 0;
+}
+
+void free_kstate_stream(void)
+{
+	vfree(kstate_stream.start);
+	kstate_stream.start = NULL;
+	kstate_stream.size = 0;
+}
+
+int kstate_save_state(void)
+{
+	struct state_entry *se;
+	struct kstate_entry *ke;
+	int ret;
+
+	ret = alloc_kstate_stream();
+	if (ret)
+		return ret;
+
+	list_for_each_entry(se, &states, list) {
+		ret = save_kstate(&kstate_stream, se->id, se->kstd, se->obj);
+		if (ret)
+			return ret;
+	}
+	ke = kstate_stream.pos;
+	ke->state_id = KSTATE_LAST_ID;
+	return 0;
+}
+
+void restore_kstate(struct kstate_stream *stream, int id,
+		const struct kstate_description *kstate, void *obj)
+{
+	const struct kstate_field *field = kstate->fields;
+	struct kstate_entry *ke = stream->pos;
+	stream->pos = ke->data;
+
+	WARN_ONCE(ke->version_id != kstate->version_id, "version mismatch %d %d\n",
+		ke->version_id, kstate->version_id);
+
+	WARN_ONCE(ke->instance_id != id, "instance id mismatch %d %d\n",
+		ke->instance_id, id);
+
+	while (field->flags != KS_END) {
+		void *first, *cur;
+		int n_elems = 1;
+		int size, i;
+
+		first = obj + field->offset;
+		if (field->flags & KS_POINTER)
+			first = *(void **)(obj + field->offset);
+		if (field->count)
+			n_elems = field->count();
+		size = field->size;
+		for (i = 0; i < n_elems; i++) {
+			cur = first + i * size;
+
+			if (field->flags & KS_ARRAY_OF_POINTER)
+				cur = *(void **)cur;
+
+			if (field->flags & KS_STRUCT)
+				restore_kstate(stream, 0, field->ksd, cur);
+			else if (field->flags & KS_CUSTOM) {
+				if (field->restore)
+					field->restore(stream, cur, field);
+			} else if (field->flags & (KS_BASE_TYPE | KS_POINTER)) {
+				memcpy(cur, stream->pos, size);
+				stream->pos += size;
+			} else if (field->flags & KS_ADDRESS) {
+				*(void **)cur = (*(void **)stream->pos) +
+					get_addr_offset(field);
+				stream->pos += sizeof(void *);
+			} else
+				WARN_ON_ONCE(1);
+
+		}
+		field++;
+	}
+}
+
+static void restore_migrate_state(unsigned long kstate_data,
+				struct state_entry *se)
+{
+	struct kstate_stream stream;
+	struct kstate_entry *ke;
+
+	if (kstate_data == -1)
+		return;
+
+	ke = (struct kstate_entry *)phys_to_virt(kstate_data);
+	if (WARN_ON_ONCE(ke->state_id == 0))
+		return;
+
+	stream.start = stream.pos = ke;
+	while (ke->state_id != KSTATE_LAST_ID) {
+		if (ke->state_id != se->kstd->id ||
+		    ke->instance_id != se->id) {
+			ke = (struct kstate_entry *)(ke->data + ke->size);
+			continue;
+		}
+		stream.pos = ke;
+		restore_kstate(&stream, se->id, se->kstd, se->obj);
+		ke = (struct kstate_entry *)(ke->data + ke->size);
+	}
+}
+
+static void __kstate_register(struct kstate_description *state, void *obj,
+			struct state_entry *se)
+{
+	se->kstd = state;
+	se->id = atomic_inc_return(&state->instance_id);
+	se->obj = obj;
+	list_add(&se->list, &states);
+	restore_migrate_state(0 /*migrate_stream_addr*/, se);
+}
+
+int kstate_register(struct kstate_description *state, void *obj)
+{
+	struct state_entry *se;
+
+	se = kmalloc(sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+
+	__kstate_register(state, obj, se);
+	return 0;
+}
+
-- 
2.45.3


