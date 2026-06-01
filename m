Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC286CD6E60
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NMfQo98jo8ECVpuOal5Pj3QkE2scVbvFzpqAZff4Fag=; b=k5zbn40rzkzvWEMtUXdTEpTxfs
	+yhCVY2inWlJt/L53wHilgx6hnstUvfVgEwKNya1nF9AktV6PHE8pHTW5sThn1U07NyjzQ47hyoJk
	il+FSlhF66+OzhCpI0NJAtKKK/ByzBNpCkFgsA4I/VszSaPeL/FTJek6NUZ167oGWT0BnnPha5bXw
	sRMV2HVZaqtOnfyP6894uXcpb8PgnyayYREE9ItVxpq4eEtwUsKSZmfjHbN4U7I9njqgF5oygSA/E
	1nwvhcKi5Cf+MXj6oMhpICrXbsOGfq0J29ALNP2WC+KVDMKIu1BfDkgNG47ZJtCwrV3pl4kWBOi8T
	N8epUBgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQsA-0000000DJAI-3RrA;
	Tue, 02 Jun 2026 15:17:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzHg-0000000AYCR-2FPT;
	Mon, 01 Jun 2026 09:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=NMfQo98jo8ECVpuOal5Pj3QkE2scVbvFzpqAZff4Fag=; b=OhmSxEoVE/2LzXXvmgt6i/g4nG
	un/AYu5XOe/yHMIl1vRj0ovhRVIU6nvpnc3NUYIL3GwJw2fHWsq6JdAemY7IKR8zz5eomL5e2Uaca
	bSJpr2Ji6sbkAlzaGJlz73LmUmPaPvozerelSJUFVeAnybtAOhzOTLg2xoxXwBnt89bkCBO+LlSPF
	8RYUxYK23chBFalew3rEnXIrKGQ1v47CQeMYe4QRme6ciUMRmtXc75fclkUbuReVrL9f5xBbtDU0k
	U94ML5E7DKEFeCCKPMEcER9HqL5SYz1e0rd4gSpVzWLTlg1ghs/RYoAxgPz+EJHoHCDFr1xFyFT3v
	Ba9Ms7Og==;
Received: from canpmsgout09.his.huawei.com ([113.46.200.224])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzHc-00000006IDq-1lcV;
	Mon, 01 Jun 2026 09:50:11 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NMfQo98jo8ECVpuOal5Pj3QkE2scVbvFzpqAZff4Fag=;
	b=lGO4jUMLXh7PUPz2g3M4xRkxm5LnWh5mHdKuAEZ9n+1ROfVyL0Wd+zG8D5OiJA2HGLoHIi0/X
	HGyRAeGV53vEYZwingSDvcOgh4NugimoAxnxaYD3AmA+oZMHaml2368yocWQK7uBIyGSpKMNEYA
	oKNI0Qd3ypUn0f7J0s427qI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4gTTWr5ZSxz1cyQh;
	Mon,  1 Jun 2026 17:42:16 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 420A040539;
	Mon,  1 Jun 2026 17:50:04 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Jun
 2026 17:50:00 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <skhan@linuxfoundation.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <chenhuacai@kernel.org>, <kernel@xen0n.name>,
	<maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <robh@kernel.org>, <saravanak@kernel.org>,
	<akpm@linux-foundation.org>, <bhe@redhat.com>, <rppt@kernel.org>,
	<pasha.tatashin@soleen.com>, <pratyush@kernel.org>, <ruirui.yang@linux.dev>,
	<rdunlap@infradead.org>, <feng.tang@linux.alibaba.com>,
	<dapeng1.mi@linux.intel.com>, <kees@kernel.org>, <elver@google.com>,
	<kuba@kernel.org>, <lirongqing@baidu.com>, <ebiggers@kernel.org>,
	<paulmck@kernel.org>, <sourabhjain@linux.ibm.com>, <thuth@redhat.com>,
	<ardb@kernel.org>, <masahiroy@kernel.org>, <gshan@redhat.com>,
	<james.morse@arm.com>, <maz@kernel.org>, <leitao@debian.org>,
	<yeoreum.yun@arm.com>, <coxu@redhat.com>, <suzuki.poulose@arm.com>,
	<cfsworks@gmail.com>, <osandov@fb.com>, <jbohac@suse.cz>,
	<ryan.roberts@arm.com>, <tangyouling@kylinos.cn>, <ritesh.list@gmail.com>,
	<adityag@linux.ibm.com>, <hbathini@linux.ibm.com>, <bjorn@rivosinc.com>,
	<songshuaishuai@tinylab.org>, <vishal.moola@gmail.com>,
	<junhui.liu@pigmoral.tech>, <djordje.todorovic@htecgroup.com>,
	<austin.kim@lge.com>, <namcao@linutronix.de>, <djbw@kernel.org>,
	<chao.gao@intel.com>, <seanjc@google.com>, <fuqiang.wang@easystack.cn>,
	<liaoyuanhong@vivo.com>, <makb@juniper.net>, <graf@amazon.com>,
	<piliu@redhat.com>, <rafael.j.wysocki@intel.com>,
	<mario.limonciello@amd.com>, <jbouron@amazon.com>, <chenjiahao16@huawei.com>,
	<guoren@kernel.org>, <bauerman@linux.ibm.com>, <bgwin@google.com>,
	<takahiro.akashi@linaro.org>, <x86@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v15 23/23] arm64: crash: Add crash hotplug support
Date: Mon, 1 Jun 2026 17:48:05 +0800
Message-ID: <20260601094805.2928614-24-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260601094805.2928614-1-ruanjinjie@huawei.com>
References: <20260601094805.2928614-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_105009_358766_721CBB16 
X-CRM114-Status: GOOD (  33.96  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:17:11 -0700
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

Due to CPU/Memory hotplug or online/offline events, the elfcorehdr
(which describes the CPUs and memory of the crashed kernel) of kdump
image becomes outdated. Consequently, attempting dump collection with
an outdated elfcorehdr can lead to inaccurate dump collection.

The current solution to address the above issue involves monitoring
the CPU/Memory add/remove events in userspace using udev rules and
whenever there are changes in CPU and memory resources, the entire
kdump image is loaded again. The kdump image includes kernel, initrd,
elfcorehdr, FDT, purgatory. Given that only elfcorehdr gets outdated
due to CPU/Memory add/remove events, reloading the entire kdump image
is inefficient. More importantly, kdump remains inactive for a
substantial amount of time until the kdump reload completes.

To address the aforementioned issue, commit 247262756121 ("crash: add
generic infrastructure for crash hotplug support") added a generic
infrastructure that allows architectures to selectively update the
kdump image component during CPU or memory add/remove events within
the kernel itself.

In the event of a CPU or memory add/remove events, the generic crash
hotplug event handler, crash_handle_hotplug_event(), is triggered. It
then acquires the necessary locks to update the kdump image and invokes
the architecture-specific crash hotplug handler,
arch_crash_handle_hotplug_event(), to update the required kdump image
components.

[1] has supported virtual CPU hotplug in virtual machines for ARM64,
allowing vCPUs to be added or removed at runtime to meet Kubernetes
demands.

On ARM64, only memory add/remove events are handled. Here's why:

1. Physical CPU hotplug: Not supported on ARM64 hardware.

2. ACPI vCPU hotplug (KVM virtual machine):
   - vCPU hotplug is implemented as a static firmware policy where all
     possible vCPUs are pre-described in the MADT table at boot.
   - The vCPU status will be automatically updated after vCPU hotplug.
   - No FDT or elfcorehdr update needed.

3. Device tree booted Virtual Machine vCPU hotplug:
  - The elfcorehdr is built using for_each_possible_cpu(), so it
    already includes all possible CPUs and doesn't need updates.

For memory add/remove events, the elfcorehdr is updated to reflect
the current memory layout.

This patch adds the ARCH_SUPPORTS_CRASH_HOTPLUG config option and
implements:
- arch_crash_hotplug_support(): Check if hotplug update is supported
- arch_crash_get_elfcorehdr_size(): Return elfcorehdr buffer size
- arch_crash_handle_hotplug_event(): Handle memory hotplug events

This follows the same approach as x86 commit
ea53ad9cf73b ("x86/crash: add x86 crash hotplug support") and powerpc
commit b741092d5976 ("powerpc/crash: add crash CPU hotplug support")
and commit 849599b702ef ("powerpc/crash: add crash memory hotplug
support").

The test is based on the following QEMU version:
	https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Replace your '-smp' argument with something like:
 | -smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1

then feed the following to the Qemu montior to hotplug vCPU;
 | (qemu) device_add driver=host-arm-cpu,core-id=1,id=cpu1
 | (qemu) device_del cpu1

feed the following to the Qemu montior to hotplug memory;
 | (qemu) object_add memory-backend-ram,id=mem1,size=256M
 | (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
 | (qemu) device_del dimm1

The qemu startup configuration is as follows:
qemu-system-aarch64 \
		-M virt,gic-version=3,acpi=on,highmem=on \
		-enable-kvm \
		-cpu host \
		-kernel Image \
		-smp cpus=1,maxcpus=3,cores=3,threads=1,sockets=1 \
		-bios /usr/share/edk2/aarch64/QEMU_EFI.fd \
		-m 2G,slots=64,maxmem=16G \
		-nographic \
		-no-reboot \
		-device virtio-rng-pci \
		-append "root=/dev/vda rw console=ttyAMA0 kgdboc=ttyAMA0,115200 \
			earlycon acpi=on crashkernel=512M" \
		-drive if=none,file=images/rootfs.ext4,format=raw,id=hd0 \
		-device virtio-blk-device,drive=hd0 \

There are two system calls, `kexec_file_load` and `kexec_load`, used to
load the kdump image. Only kexec_file_load syscall way is tested now.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Breno Leitao <leitao@debian.org>
Cc: Kees Cook <kees@kernel.org>
[1]: https://lore.kernel.org/all/20240529133446.28446-1-Jonathan.Cameron@huawei.com/
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                     |   3 +
 arch/arm64/include/asm/kexec.h         |  13 +++
 arch/arm64/kernel/Makefile             |   2 +-
 arch/arm64/kernel/crash.c              | 152 +++++++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c        |  21 +++-
 arch/arm64/kernel/machine_kexec_file.c |  40 ++-----
 6 files changed, 195 insertions(+), 36 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..9091c67e1cc2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1609,6 +1609,9 @@ config ARCH_DEFAULT_CRASH_DUMP
 config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 	def_bool CRASH_RESERVE
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 892e5bebda95..4f3d4fc2807e 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -130,6 +130,19 @@ extern int load_other_segments(struct kimage *image,
 		char *cmdline);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+#define pnum_hdr_sz(pnum) ((pnum) * sizeof(Elf64_Phdr) + sizeof(Elf64_Ehdr))
+
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags);
+#define arch_crash_hotplug_support arch_crash_hotplug_support
+
+unsigned int arch_crash_get_elfcorehdr_size(void);
+#define crash_get_elfcorehdr_size arch_crash_get_elfcorehdr_size
+#endif
+
 #endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 74b76bb70452..0625422fc528 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -64,7 +64,7 @@ obj-$(CONFIG_KEXEC_CORE)		+= machine_kexec.o relocate_kernel.o	\
 obj-$(CONFIG_KEXEC_FILE)		+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_ARM64_RELOC_TEST)		+= arm64-reloc-test.o
 arm64-reloc-test-y := reloc_test_core.o reloc_test_syms.o
-obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o
+obj-$(CONFIG_CRASH_DUMP)		+= crash_dump.o crash.o
 obj-$(CONFIG_VMCORE_INFO)		+= vmcore_info.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
diff --git a/arch/arm64/kernel/crash.c b/arch/arm64/kernel/crash.c
new file mode 100644
index 000000000000..5882b9b5a90e
--- /dev/null
+++ b/arch/arm64/kernel/crash.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Architecture specific functions for kexec based crash dumps.
+ */
+
+#define pr_fmt(fmt)	"crash hp: " fmt
+
+#include <linux/kexec.h>
+#include <linux/elf.h>
+#include <linux/memblock.h>
+#include <linux/vmalloc.h>
+#include <linux/cacheflush.h>
+#include <linux/crash_core.h>
+
+#include <asm/kexec.h>
+
+#if defined(CONFIG_KEXEC_FILE) || defined(CONFIG_CRASH_HOTPLUG)
+unsigned int arch_get_system_nr_ranges(void)
+{
+	/* for exclusion of crashkernel region */
+	unsigned int nr_ranges = 2 + crashk_cma_cnt + CRASH_HOTPLUG_SAFETY_PADDING;
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end)
+		nr_ranges++;
+
+	return nr_ranges;
+}
+
+int arch_crash_populate_cmem(struct crash_mem *cmem)
+{
+	phys_addr_t start, end;
+	u64 i;
+
+	for_each_mem_range(i, &start, &end) {
+		if (unlikely(cmem->nr_ranges >= cmem->max_nr_ranges))
+			return -EAGAIN;
+
+		cmem->ranges[cmem->nr_ranges].start = start;
+		cmem->ranges[cmem->nr_ranges].end = end - 1;
+		cmem->nr_ranges++;
+	}
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_CRASH_HOTPLUG
+int arch_crash_hotplug_support(struct kimage *image, unsigned long kexec_flags)
+{
+#ifdef CONFIG_KEXEC_FILE
+	if (image->file_mode)
+		return 1;
+#endif
+	/*
+	 * For kexec_load syscall, crash hotplug support requires
+	 * KEXEC_CRASH_HOTPLUG_SUPPORT flag to be passed by userspace.
+	 */
+	return kexec_flags & KEXEC_CRASH_HOTPLUG_SUPPORT;
+}
+
+unsigned int arch_crash_get_elfcorehdr_size(void)
+{
+	unsigned int phdr_cnt;
+
+	/* A program header for possible CPUs, vmcoreinfo and kernel_map */
+	phdr_cnt = 2 + num_possible_cpus();
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		phdr_cnt += CONFIG_CRASH_MAX_MEMORY_RANGES;
+
+	return pnum_hdr_sz(phdr_cnt);
+}
+
+/**
+ * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
+ *			       elfcorehdr in the kexec segment array.
+ * @image: the active struct kimage
+ */
+static void update_crash_elfcorehdr(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = (void *)__va(mem);
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy((void *)old_elfcorehdr, elfbuf, elfsz);
+	dcache_clean_inval_poc((unsigned long)old_elfcorehdr,
+			       (unsigned long)old_elfcorehdr + elfsz);
+	xchg(&kexec_crash_image, image);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ * @arg: struct memory_notify handler for memory hotplug case and
+ *       NULL for CPU hotplug case.
+ *
+ * Update the kdump image based on the type of hotplug event:
+ * - CPU add and remove: No action is needed.
+ * - Memory add/remove: Update the elfcorehdr to reflect the current memory layout.
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
+{
+	if ((image->file_mode || image->elfcorehdr_updated) &&
+		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
+		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
+		return;
+
+	update_crash_elfcorehdr(image);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
index 93c36a3aa618..21f38de7a8b6 100644
--- a/arch/arm64/kernel/kexec_image.c
+++ b/arch/arm64/kernel/kexec_image.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	"kexec_file(Image): " fmt
 
+#include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
@@ -92,16 +93,32 @@ static void *image_load(struct kimage *image,
 #ifdef CONFIG_CRASH_DUMP
 	if (image->type == KEXEC_TYPE_CRASH) {
 		/* load elf core header */
-		unsigned long headers_sz;
+		unsigned long headers_sz, pnum = 0;
 		void *headers;
 
-		ret = crash_prepare_headers(true, &headers, &headers_sz, NULL);
+		ret = crash_prepare_headers(true, &headers, &headers_sz, &pnum);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			return ERR_PTR(ret);
 		}
 		image->elf_headers = headers;
 		image->elf_headers_sz = headers_sz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+		/*
+		 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map
+		 * maximum CPUs and maximum memory ranges.
+		 */
+		if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+			pnum = 2 + num_possible_cpus() + CONFIG_CRASH_MAX_MEMORY_RANGES;
+		else
+			pnum += 2 + num_possible_cpus();
+
+		if (pnum < (unsigned long)PN_XNUM)
+			image->elf_headers_sz = max(pnum_hdr_sz(pnum), headers_sz);
+		else
+			pr_err("number of Phdrs %lu exceeds max\n", pnum);
+#endif
 	}
 #endif
 
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index d0f73eb3f856..0016001f4d00 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -10,11 +10,11 @@
 
 #define pr_fmt(fmt) "kexec_file: " fmt
 
+#include <linux/elf.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
 #include <linux/libfdt.h>
-#include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/slab.h>
@@ -39,38 +39,6 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_CRASH_DUMP
-unsigned int arch_get_system_nr_ranges(void)
-{
-	/* for exclusion of crashkernel region */
-	unsigned int nr_ranges = 2 + crashk_cma_cnt + CRASH_HOTPLUG_SAFETY_PADDING;
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end)
-		nr_ranges++;
-
-	return nr_ranges;
-}
-
-int arch_crash_populate_cmem(struct crash_mem *cmem)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	for_each_mem_range(i, &start, &end) {
-		if (unlikely(cmem->nr_ranges >= cmem->max_nr_ranges))
-			return -EAGAIN;
-
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
-		cmem->nr_ranges++;
-	}
-
-	return 0;
-}
-#endif
-
 /*
  * Tries to add the initrd and DTB to the image. If it is not possible to find
  * valid locations, this function will undo changes to the image and return non
@@ -98,6 +66,12 @@ int load_other_segments(struct kimage *image,
 		kbuf.bufsz = image->elf_headers_sz;
 		kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 		kbuf.memsz = image->elf_headers_sz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+		if (image->elf_headers_sz < pnum_hdr_sz(PN_XNUM))
+			image->elfcorehdr_index = image->nr_segments;
+#endif
+
 		kbuf.buf_align = SZ_64K; /* largest supported page size */
 		kbuf.buf_max = ULONG_MAX;
 		kbuf.top_down = true;
-- 
2.34.1


