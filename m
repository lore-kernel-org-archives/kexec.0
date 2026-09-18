Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C8C982EE
	for <kexec@archiver.kernel.org>; Sun, 20 Sep 2026 20:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EOHA0/QYz5xuB3tvJyr3yacJBYiZYap2Q9rrEaqTc0c=; b=0crNGFmKeLBHcI
	fcoBhi73e9gNC4XJw/WTphnlXJnkHiZ3IBHH6CuYjO/VWeE+BICk/ZrIyYzpAkYNc6UeaZxuqz+s4
	rpJBXukdf6UJb+cHBcmOXdf7FPT8asvkZ+x3OuJNIsY34EP0DeV5dpPYzQEdhAtXJ7s8nSLMI8qVn
	1faBUbIF6WvNxJhRne7RdZUkMZW8k3SV5QF+HfdOT/g5nfEVSmSMPBDoAOo0IhWwBTJAuAd9ijGlq
	AlyRE9UrbaXjaKiaKt7B1HEoKNcDQje0Ok0LVcRlaZ84aOq3qSF3rb5aob0Fig3hfy9BqvA6c+/df
	n8D0YKeUGr4aOMsZf6ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8O4T-00000000MYw-2ZDP;
	Sun, 20 Sep 2026 20:23:33 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7VSJ-0000000E2Pk-3C4d;
	Fri, 18 Sep 2026 10:04:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=EOHA0/QYz5xuB3tvJyr3yacJBYiZYap2Q9rrEaqTc0c=; b=BO2ylophSolG9+t2iUhStNV5t8
	hqOXeIhETtsmRI2jbNNl0okpl6D6SFYt0ITieTS5YUd9iG78DouvphnYo+pKo9Zua50AQZrQfcgjy
	QAWolsYTfBXyx6bGFW03rhxW//Yp45YZMHcaXIg6XWMXiIAItmW3w1RLG0AHFH0BMccyNbMJHxAcf
	LYT2qgYZcvESBzKc0xYza8giFf0n7t7PPDsv+p3YA9WdhG7xujJLORV1i4f+gkJ0HpBlhdsHHf3NC
	2gF3lwOsCR1JUiudTQaOKMCAD6n5PDom7kXGgwF+pLQXuGXuCKXKVmOyJAtXfkxHAbNvRg/nqe42B
	KDokcCEQ==;
Received: from canpmsgout02.his.huawei.com ([113.46.200.217])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x7VSF-00000009tTy-2CUs;
	Fri, 18 Sep 2026 10:04:30 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=EOHA0/QYz5xuB3tvJyr3yacJBYiZYap2Q9rrEaqTc0c=;
	b=qk1PVVbtJxXdKcs9wpTlzPoFToj5fhJMqZXlKRUbGqvztUzDiFmXx13jYea2QU56vbEQg6D2C
	eV1GOMr3NYNQwfkv/JjGEqLjMUkL4BPXCI42trcrh9qwTFWSefYzUaLRrZed3BOpq8NJrKi5BeS
	kyXWpicfA8rwz/bHdl6VRMI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4hmSbp3RV0zcb3G;
	Fri, 18 Sep 2026 17:52:54 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D11E40561;
	Fri, 18 Sep 2026 18:04:09 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemk200008.china.huawei.com
 (7.202.194.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 18:04:07 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <chleroy@kernel.org>,
	<ritesh.list@gmail.com>, <sshegde@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<dakr@kernel.org>, <akpm@linux-foundation.org>, <baoquan.he@linux.dev>,
	<rppt@kernel.org>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>,
	<ruirui.yang@linux.dev>, <kees@kernel.org>, <thuth@redhat.com>,
	<ruanjinjie@huawei.com>, <gshan@redhat.com>, <ardb@kernel.org>,
	<james.morse@arm.com>, <leitao@debian.org>, <yeoreum.yun@arm.com>,
	<sourabhjain@linux.ibm.com>, <robh@kernel.org>, <coxu@redhat.com>,
	<tangyouling@kylinos.cn>, <liukexin@kylinos.cn>, <guodongtai@kylinos.cn>,
	<maqianga@uniontech.com>, <zhangtianyang@loongson.cn>, <blum@kernel.org>,
	<adityag@linux.ibm.com>, <chao.gao@intel.com>, <kas@kernel.org>,
	<vishal.l.verma@intel.com>, <seanjc@google.com>, <piliu@redhat.com>,
	<jbouron@amazon.com>, <me@linux.beauty>, <mclapinski@google.com>,
	<graf@amazon.com>, <bgwin@google.com>, <eric.devolder@oracle.com>,
	<hbathini@linux.ibm.com>, <takahiro.akashi@linaro.org>,
	<lizhengyu3@huawei.com>, <palmer@rivosinc.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
	<driver-core@lists.linux.dev>, <kexec@lists.infradead.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v5 00/17] crash: Rework and add arm64 crash hotplug support
Date: Fri, 18 Sep 2026 18:04:25 +0800
Message-ID: <20260918100442.3841135-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk200008.china.huawei.com (7.202.194.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_110428_227816_8EC24FAA 
X-CRM114-Status: GOOD (  19.10  )
X-Mailman-Approved-At: Sun, 20 Sep 2026 13:23:20 -0700
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

When CPU or memory hotplug events occur, the elfcorehdr in the kdump
image becomes stale, potentially leading to incomplete crash dumps.

Currently, userspace udev rules reload the entire kdump image upon such
events, which is inefficient and leaves kdump inactive for a long time.

Commit 247262756121 ("crash: add generic infrastructure for crash hotplug
support") introduced a kernel mechanism to update only the elfcorehdr.
This patch set implements crash hotplug support for arm64.

As Baoquan and Catalin suggested, it also addresses and fixes several
pre-existing code issues found by Sashiko AI [1][2].

The major improvements and fixes included in this series are:
- Fix several memory leaks for arm64, and similar issues on LoongArch.
- Fix TOCTOU race in crash memory range collection
- Simplify arm64 load_other_segments().
- Implement infrastructure for arm64 crash memory hotplug support.

This patch set is rebased on v7.3-rc3.

TESTING
=======

Only kexec_file_load path has been tested; kexec_load is expected to
work via KEXEC_CRASH_HOTPLUG_SUPPORT flag but not yet verified.

Tested on an arm64 guest using KVM-QEMU[3] with the following
configuration:
        -M virt,acpi=on,highmem=on
        -m 4G,slots=256,maxmem=16G
        -smp cpus=4,maxcpus=8,cores=4,threads=2,sockets=1

1. Memory Hot-Add Test

[Step 1] Load kexec first:
        ./kexec --kexec-file-syscall ...

[Step 2] Hotplug and online 128M memory and trigger crash:
        (qemu) object_add memory-backend-ram,id=mem1,size=128M
        (qemu) device_add pc-dimm,id=dimm3,memdev=mem1,addr=0x160000000
        echo 1 > /sys/devices/system/memory/memory44/online
        echo c > /proc/sysrq-trigger

[Step 3] Verify vmcore layout in the secondary kernel:
        readelf -l /proc/vmcore

The newly added 128M memory segment (0x160000000) is successfully
recognized and populated as a LOAD segment:

        LOAD 0x... 0x0000000160000000 0x08000000 0x08000000 RWE 0x0

2. Memory Hot-Remove Test

[Step 1] Add memory device and online 128M memory first:
        (qemu) device_add pc-dimm,id=dimm3,memdev=mem1,addr=0x160000000
        echo 1 > /sys/devices/system/memory/memory44/online

[Step 2] Load kexec, offline memory, and crash:
        ./kexec --kexec-file-syscall ...
        echo 0 > /sys/devices/system/memory/memory44/online
        echo c > /proc/sysrq-trigger

[Step 3] Verify vmcore layout:
        readelf -l /proc/vmcore

Result: The 0x160000000 segment is cleanly excluded from the vmcore
        program headers, and the dump completes without any hang.

3. CPU Hot-Add Test

[Step 1] Load kexec first:
        ./kexec --kexec-file-syscall ...

[Step 2] hotplug and online one CPU, then crash:
        (qemu) device_add driver=host-arm-cpu,core-id=2,thread-id=0,id=cpu4
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo c > /proc/sysrq-trigger

[Step 3] Verify notes count:
        readelf -n /proc/vmcore | grep -w CORE | wc -l
        5

Result: Crash hotplug responds correctly; the newly plugged CPU4 is
        tracked, and 5 NT_PRSTATUS notes are generated.

4. CPU Hot-Remove Test

[Step 1] Add CPU device and online it first:
        (qemu) device_add driver=host-arm-cpu,core-id=2,thread-id=0,id=cpu4
        echo 1 > /sys/devices/system/cpu/cpu4/online

[Step 2] Load kexec, remove CPU, and crash:
        ./kexec --kexec-file-syscall ...
        (qemu) device_del cpu4
        echo c > /proc/sysrq-trigger

[Step 3] Verify notes count:
        readelf -n /proc/vmcore | grep -w CORE | wc -l
        4

Result: Crash hotplug automatically updates the headers upon CPU
        eviction; only 4 online CPUs are registered in the vmcore.

[1]: https://lore.kernel.org/all/20260601094805.2928614-1-ruanjinjie@huawei.com/
[2]: https://sashiko.dev/#/patchset/20260729031235.2840255-1-ruanjinjie%40huawei.com
[3]: https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2

Changs in v5:
- Rebased on v7.3-rc3.
- Fix several pre-existing code issues reported by Sashiko AI review. [5]
- Add an extra slot for memory hot-unplug.
- Add device_hotplug_lock_assert_held() helper.
- Rework to let the hotplug paths to skip CPU events entirely, which avoid
  the TOCTOU race of memory hotplug events and internal CPU offline path
  without holding device_hotplug_lock.
- Link to v4: https://lore.kernel.org/all/20260907125404.922123-1-ruanjinjie@huawei.com/

[5]: https://sashiko.dev/#/patchset/20260907125404.922123-1-ruanjinjie%40huawei.com

Changes in v4:
- Rebased on v7.3-rc1.
- Update the kexec_core code as Mike suggested.
- Update the LoongArch subject as Huacai suggested.
- Drop crash_dump_dm_crypt patch which will be fixed by Coiby in [4] as
  Sourabh suggested.
- Drop x86 related patches because of branch conflict, which will
  be done later.
- Drop the incorrect CRASH_MAX_MEMORY_RANGES patch.
- Handle elfcorehdr_index in arm64 arch code.
- Link to v3: https://lore.kernel.org/all/20260826092541.3905933-1-ruanjinjie@huawei.com/

[4] https://lore.kernel.org/all/20260828084900.1496839-2-coiby.xu@gmail.com/

Changes in v3:
- Handle "KEXEC_CRASH_HP_REMOVE_MEMORY" action.
- Fix several pre-existing code issues reported by Sashiko AI review [3].
- Introduce crash_extra_elfcorehdr_size() and elf64_phdr_size() helper.
- Rework related crash and arch code.
- Add test method.
- v2: https://lore.kernel.org/all/20260729031235.2840255-1-ruanjinjie@huawei.com/

Changes in v2:
- Split out Powerpc bugfix patch as Mike suggested.
- Use phys_to_virt() instead of __va() in update_crash_elfcorehdr().
- Convert pnum_hdr_sz() to a function.
- Only assign elfcorehdr_index after kexec_add_buffer succeeds, considering
  crash_handle_hotplug_event() already performs validity check on
  elfcorehdr_index:
  - We can safely remove the check for CPU hotplug
    in arch_crash_handle_hotplug_event().
  - The elfcorehdr_index's segment mem will be valid in
    update_crash_elfcorehdr(), so we can safely remove the NULL check.
- Simplify the commit message.
- v1: https://lore.kernel.org/all/20260723131242.1537633-1-ruanjinjie@huawei.com/#t

Jinjie Ruan (17):
  kexec: Fix CMA segment address translation with non-zero text_offset
  kexec: Record allocated CMA pages to fix release size mismatch
  kexec: Extract kexec_free_segment_cma() from kimage_free_cma()
  arm64: kexec_file: Fix CMA page leaks in segment placement retry loops
  arm64: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec_file: Fix CMA page leaks in segment placement retry
    loops
  LoongArch: kexec_file: Fix elf_headers memory leak in retry loop
  LoongArch: kexec_file: Fix a modified_cmdline leak
  x86/crash: Fix massive out-of-bounds write on 32-bit Highmem
  crash: Extract crash_get_memory_ranges() helper
  crash: Normalize the kexec_load elfcorehdr at load time
  crash: Fix TOCTOU race in crash memory range collection
  crash: Assert device_hotplug_lock in crash_get_memory_ranges_nolock()
  elf: Introduce elf64_phdr_size() helper
  crash: Introduce crash_extra_elfcorehdr_size() helper
  arm64: kexec_file: Simplify load_other_segments()
  arm64: crash: Add crash hotplug support

 arch/arm64/Kconfig                         |   3 +
 arch/arm64/include/asm/kexec.h             |  11 ++
 arch/arm64/kernel/Makefile                 |   2 +-
 arch/arm64/kernel/crash.c                  | 171 +++++++++++++++++++++
 arch/arm64/kernel/kexec_image.c            |   1 +
 arch/arm64/kernel/machine_kexec_file.c     |  63 +++-----
 arch/loongarch/kernel/kexec_efi.c          |   1 +
 arch/loongarch/kernel/machine_kexec.c      |   2 +
 arch/loongarch/kernel/machine_kexec_file.c |  10 +-
 arch/powerpc/kexec/crash.c                 |   3 +-
 arch/powerpc/kexec/file_load_64.c          |  15 +-
 arch/powerpc/platforms/powernv/opal-core.c |   3 +-
 arch/x86/kernel/crash.c                    |  43 +++---
 drivers/base/core.c                        |   5 +
 fs/proc/vmcore.c                           |   6 +-
 include/linux/crash_core.h                 |  22 +++
 include/linux/device.h                     |   1 +
 include/linux/elf.h                        |   4 +
 include/linux/kexec.h                      |   3 +
 kernel/crash_core.c                        | 115 +++++++++++---
 kernel/kexec.c                             |   4 +
 kernel/kexec_core.c                        |  42 +++--
 kernel/kexec_file.c                        |  13 +-
 23 files changed, 422 insertions(+), 121 deletions(-)
 create mode 100644 arch/arm64/kernel/crash.c

-- 
2.34.1


