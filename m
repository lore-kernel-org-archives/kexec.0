Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5163C3DA64
	for <kexec@archiver.kernel.org>; Mon,  5 Aug 2024 02:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Sfh8KA4YCtF3AOVXfuhGJTSeMnusaWC+S7JzeLtEc+M=; b=NqbASw+I2Fxi01
	1ASP5UNB1pEH7PjLtv6TMqmYg2y+RY4Nk1LTVcuemRqQ8ZThknJYyHCLtIEALdA3Nl1kDhc1/94Vu
	vkQby6cCUVe/9Qok8jUG1zhygpvpCcfh28zzm1wmPunP7l/tC8Smvg0j0pMEKRsOGkCIpDxDwxsC1
	Gr/54H7TWCJ9vEsgHpiW22/xEfLRbBILnI2vNDZSlI5vTKPXR0AnNDl2xSZGAJx7zAO7QE28Dry4/
	+1u+oVhtvS75DDrEua79KQliyKqqLruWjNMk5rq98s4LY0Qvvxt5JqsYOLkTLGkIxX3JjYfJEj5ex
	Afd0E4YJDXjFJpLfAzfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sanT6-0000000EO5m-2U4a;
	Mon, 05 Aug 2024 02:29:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sanT2-0000000EO58-013D
	for kexec@lists.infradead.org;
	Mon, 05 Aug 2024 02:29:02 +0000
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WcgMQ02pHzndJK;
	Mon,  5 Aug 2024 10:27:46 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 857C818009B;
	Mon,  5 Aug 2024 10:28:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 Aug 2024 10:28:51 +0800
Message-ID: <50498549-f6c1-ce2c-b190-e9eedd1eb9ee@huawei.com>
Date: Mon, 5 Aug 2024 10:28:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v18 0/6] powerpc/crash: Kernel handling of CPU and memory
 hotplug
Content-Language: en-US
To: Sourabh Jain <sourabhjain@linux.ibm.com>, <linuxppc-dev@ozlabs.org>
CC: Akhil Raj <lf32.dev@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>, Dave Hansen
	<dave.hansen@linux.intel.com>, Dave Young <dyoung@redhat.com>, David
 Hildenbrand <david@redhat.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Hari Bathini <hbathini@linux.ibm.com>, Laurent
 Dufour <laurent.dufour@fr.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Mimi Zohar <zohar@linux.ibm.com>,
	Naveen N Rao <naveen@kernel.org>, Oscar Salvador <osalvador@suse.de>, Thomas
 Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, <kexec@lists.infradead.org>,
	<x86@kernel.org>
References: <20240326055413.186534-1-sourabhjain@linux.ibm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240326055413.186534-1-sourabhjain@linux.ibm.com>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_192900_393847_514B7574 
X-CRM114-Status: GOOD (  46.03  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2024/3/26 13:54, Sourabh Jain wrote:
> Commit 247262756121 ("crash: add generic infrastructure for crash
> hotplug support") added a generic infrastructure that allows
> architectures to selectively update the kdump image component during CPU
> or memory add/remove events within the kernel itself.
> 
> This patch series adds crash hotplug handler for PowerPC and enable
> support to update the kdump image on CPU/Memory add/remove events.
> 
> Among the 6 patches in this series, the first two patches make changes
> to the generic crash hotplug handler to assist PowerPC in adding support
> for this feature. The last four patches add support for this feature.
> 
> The following section outlines the problem addressed by this patch
> series, along with the current solution, its shortcomings, and the
> proposed resolution.
> 
> Problem:
> ========
> Due to CPU/Memory hotplug or online/offline events the elfcorehdr
> (which describes the CPUs and memory of the crashed kernel) and FDT
> (Flattened Device Tree) of kdump image becomes outdated. Consequently,
> attempting dump collection with an outdated elfcorehdr or FDT can lead
> to failed or inaccurate dump collection.

Hi, Sourabh, are there any specific methods to reproduce the scenarios
for this feature? I would like to port this feature to ARM64, but I
don't know how to reproduce the issue.

> 
> Going forward CPU hotplug or online/offline events are referred as
> CPU/Memory add/remove events.
> 
> Existing solution and its shortcoming:
> ======================================
> The current solution to address the above issue involves monitoring the
> CPU/memory add/remove events in userspace using udev rules and whenever
> there are changes in CPU and memory resources, the entire kdump image
> is loaded again. The kdump image includes kernel, initrd, elfcorehdr,
> FDT, purgatory. Given that only elfcorehdr and FDT get outdated due to
> CPU/Memory add/remove events, reloading the entire kdump image is
> inefficient. More importantly, kdump remains inactive for a substantial
> amount of time until the kdump reload completes.
> 
> Proposed solution:
> ==================
> Instead of initiating a full kdump image reload from userspace on
> CPU/Memory hotplug and online/offline events, the proposed solution aims
> to update only the necessary kdump image component within the kernel
> itself.
> 
> Git tree for testing:
> =====================
> https://github.com/sourabhjains/linux/tree/kdump-in-kernel-crash-update-v18
> 
> Above tree is rebased on top of powerpc/next branch.
> 
> To realize this feature, the kdump udev rule must be updated. On RHEL,
> add the following two lines at the top of the
> "/usr/lib/udev/rules.d/98-kexec.rules" file.
> 
> SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
> With the above change to the kdump udev rule, kdump reload is avoided
> during CPU/Memory add/remove events if this feature is enabled in the
> kernel.
> 
> Note: only kexec_file_load syscall will work. For kexec_load minor changes
> are required in kexec tool.
> 
> Changelog:
> ----------
> v18: [No functional changes]
>   - Update a comment in 2/6.
>   - Describe the clean-up done on x86 in patch description 2/6.
>   - Fix a minor typo in the patch description of 3/6.
> 
> v17: [https://lore.kernel.org/all/20240226084118.16310-1-sourabhjain@linux.ibm.com/]
>   - Rebase the patch series on top linux-next tree and below patch series
>     https://lore.kernel.org/all/20240213113150.1148276-1-hbathini@linux.ibm.com/
>   - Split 0003 patch from v16 into two patches
>        1. Move get_crash_memory_ranges() along with other *_memory_ranges()
>           functions to ranges.c and make them public.
>        2. Make update_cpus_node function public and take this function
>           out of file_load_64.c
>   - Keep arch_crash_hotplug_support in crash.c instead of core_64.c [05/06]
>   - Use CONFIG_CRASH_MAX_MEMORY_RANGES to find extra elfcorehdr size [06/06]
> 
> v16: [https://lore.kernel.org/all/20240217081452.164571-1-sourabhjain@linux.ibm.com/]
>   - Remove the unused #define `crash_hotplug_cpu_support`
>     and `crash_hotplug_memory_support` in `arch/x86/include/asm/kexec.h`.
>   - Document why two kexec flag bits are used in
>     `arch_crash_hotplug_memory_support` (x86).
>   - Use a switch case to handle different hotplug operations
>     in `arch_crash_handle_hotplug_event` for PowerPC.
>   - Fix a typo in 4/5.
> 
> v15:
>   - Remove the patch that adds a new kexec flag for FDT update.
>   - Introduce a generic kexec flag bit to share hotplug support
>     intent between the kexec tool and the kernel for the kexec_load
>     syscall. (2/5)
>   - Introduce an architecture-specific handler to process the kexec
>     flag for crash hotplug support. (2/5)
>   - Rename the @update_elfcorehdr member of the struct kimage to
>     @hotplug_support. (2/5)
>   - Use a common function to advertise hotplug support for both CPU
>     and Memory. (2/5)
> 
> v14:
>   - Fix build warnings by including necessary header files
>   - Rebase to v6.7-rc5
> 
> v13:
>   - Fix a build warning, take ranges.c out of CONFIG_KEXEC_FILE
>   - Rebase to v6.7-rc4
> 
> v12:
>   - A patch to add new kexec flags to support this feature on kexec_load
>     system call
>   - Change in the way this feature is advertise to userspace for both
>     kexec_load syscall
>   - Rebase to v6.6-rc7
> 
> v11:
>   - Rebase to v6.4-rc6
>   - The patch that introduced CONFIG_CRASH_HOTPLUG for PowerPC has been
>     removed. The config is now part of common configuration:
>     https://lore.kernel.org/all/87ilbpflsk.fsf@mail.lhotse/
> 
> v10:
>   - Drop the patch that adds fdt_index attribute to struct kimage_arch
>     Find the fdt segment index when needed.
>   - Added more details into commits messages.
>   - Rebased onto 6.3.0-rc5
> 
> v9:
>   - Removed patch to prepare elfcorehdr crash notes for possible CPUs.
>     The patch is moved to generic patch series that introduces generic
>     infrastructure for in kernel crash update.
>   - Removed patch to pass the hotplug action type to the arch crash
>     hotplug handler function. The generic patch series has introduced
>     the hotplug action type in kimage struct.
>   - Add detail commit message for better understanding.
> 
> v8:
>   - Restrict fdt_index initialization to machine_kexec_post_load
>     it work for both kexec_load and kexec_file_load.[3/8] Laurent Dufour
> 
>   - Updated the logic to find the number of offline core. [6/8]
> 
>   - Changed the logic to find the elfcore program header to accommodate
>     future memory ranges due memory hotplug events. [8/8]
> 
> v7
>   - added a new config to configure this feature
>   - pass hotplug action type to arch specific handler
> 
> v6
>   - Added crash memory hotplug support
> 
> v5:
>   - Replace COFNIG_CRASH_HOTPLUG with CONFIG_HOTPLUG_CPU.
>   - Move fdt segment identification for kexec_load case to load path
>     instead of crash hotplug handler
>   - Keep new attribute defined under kimage_arch to track FDT segment
>     under CONFIG_HOTPLUG_CPU config.
> 
> v4:
>   - Update the logic to find the additional space needed for hotadd CPUs
>     post kexec load. Refer "[RFC v4 PATCH 4/5] powerpc/crash hp: add crash
>     hotplug support for kexec_file_load" patch to know more about the
>     change.
>   - Fix a couple of typo.
>   - Replace pr_err to pr_info_once to warn user about memory hotplug
>     support.
>   - In crash hotplug handle exit the for loop if FDT segment is found.
> 
> v3
>   - Move fdt_index and fdt_index_vaild variables to kimage_arch struct.
>   - Rebase patche on top of
>     https://lore.kernel.org/lkml/20220303162725.49640-1-eric.devolder@oracle.com/
>   - Fixed warning reported by checpatch script
> 
> v2:
>   - Use generic hotplug handler introduced by
>     https://lore.kernel.org/lkml/20220209195706.51522-1-eric.devolder@oracle.com/
>     a significant change from v1.
> 
> Cc: Akhil Raj <lf32.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Laurent Dufour <laurent.dufour@fr.ibm.com>
> Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: kexec@lists.infradead.org
> Cc: x86@kernel.org
> 
> Sourabh Jain (6):
>   crash: forward memory_notify arg to arch crash hotplug handler
>   crash: add a new kexec flag for hotplug support
>   powerpc/kexec: move *_memory_ranges functions to ranges.c
>   PowerPC/kexec: make the update_cpus_node() function public
>   powerpc/crash: add crash CPU hotplug support
>   powerpc/crash: add crash memory hotplug support
> 
>  arch/powerpc/Kconfig                    |   4 +
>  arch/powerpc/include/asm/kexec.h        |  15 ++
>  arch/powerpc/include/asm/kexec_ranges.h |  20 +-
>  arch/powerpc/kexec/Makefile             |   4 +-
>  arch/powerpc/kexec/core_64.c            |  91 +++++++
>  arch/powerpc/kexec/crash.c              | 196 +++++++++++++++
>  arch/powerpc/kexec/elf_64.c             |   3 +-
>  arch/powerpc/kexec/file_load_64.c       | 314 +++---------------------
>  arch/powerpc/kexec/ranges.c             | 312 ++++++++++++++++++++++-
>  arch/x86/include/asm/kexec.h            |  13 +-
>  arch/x86/kernel/crash.c                 |  32 ++-
>  drivers/base/cpu.c                      |   2 +-
>  drivers/base/memory.c                   |   2 +-
>  include/linux/crash_core.h              |  15 +-
>  include/linux/kexec.h                   |  11 +-
>  include/uapi/linux/kexec.h              |   1 +
>  kernel/crash_core.c                     |  29 +--
>  kernel/kexec.c                          |   4 +-
>  kernel/kexec_file.c                     |   5 +
>  19 files changed, 714 insertions(+), 359 deletions(-)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
