Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE56EC369C2
	for <kexec@archiver.kernel.org>; Wed, 16 Apr 2025 02:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=axI6eu+AIGQM44eceq6impbOG7wsAxYOP6xmxx7jW50=; b=E17Ea30uKWsPLaCjG11UcFBoz7
	Hwuvt87BL9qjYIZR4h9nsjZYjK6HksOysQdMHNU7P/LqdQMccg7nn5FUHSVcpnd9sL6idv963Gwax
	DOm3JXOiExxy7QJIBSbVBlY9nOLrljfPV3HQcRICpVNfZxUmbzMulP1SHQH5mTadIvefXyuPXjUqM
	HjMXJRnq85bdkGI4yX8AVpeLl6wSR6av2iyPllcdEtRX1IyS0mF6wN+ChSESk4JGwMt0OVJQl7ONp
	DZJnUjh1iQW2VVhe0WmN9Ufp2s78fnmNzzlu1L+Agq1KxeQwt1szkZkHvcww21wG7R005ll06GOsr
	y/KFKXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4sH0-00000007uJb-1CBk;
	Wed, 16 Apr 2025 02:13:10 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4sEi-00000007tlU-0IWw
	for kexec@lists.infradead.org;
	Wed, 16 Apr 2025 02:10:49 +0000
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 22045210C452;
	Tue, 15 Apr 2025 19:10:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 22045210C452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744769445;
	bh=axI6eu+AIGQM44eceq6impbOG7wsAxYOP6xmxx7jW50=;
	h=From:To:Cc:Subject:Date:From;
	b=sW8aHv5E9HNGFFnWV7+khruzXpFnOSMvGsDIokwjdHKJtWuWJj8sFeX/DzF3hzQUQ
	 OyZW8L/tiT+JXk+aQ2zenxAU5D7GSU0tPLzr/p4jgO5M1NZ8xC2MYe9I6smauQMWJY
	 HH0re/es0rTH1IgbWgcKe8yNai4bgQsNBpe9GI+4=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com,
	vgoyal@redhat.com,
	dyoung@redhat.com
Subject: [PATCH v12 0/9] ima: kexec: measure events between kexec load and execute
Date: Tue, 15 Apr 2025 19:10:18 -0700
Message-ID: <20250416021028.1403-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_191048_174846_DE06E1F2 
X-CRM114-Status: GOOD (  34.61  )
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

From: Steven Chen <chenste@linux.microsoft.com>

The current kernel behavior is IMA measurements snapshot is taken at
kexec 'load' and not at kexec 'execute'.  IMA log is then carried
over to the new kernel after kexec 'execute'.

Currently, the kernel behavior during kexec load is to fetch the IMA
measurements log from TPM PCRs and store it in a buffer. When a kexec 
reboot is triggered, this stored log buffer is carried over to the second
kernel. However, the time gap between kexec load and kexec reboot can be
very long. During this time window, new events extended into TPM PCRs miss
the chance to be carried over to the second kernel. This results in 
mismatch between TPM PCR quotes and the actual IMA measurements list after 
kexec soft reboot, which in turn results in remote attestation failure.

To solve this problem - 
 - allocate the necessary buffer at kexec 'load' time,
 - populate the buffer with the IMA measurements at kexec 'execute' time, 
 - and measure two new IMA events 'kexec_load' and 'kexec_execute' as
   critical data to help detect missing events after kexec soft reboot.

The solution details include:
 - refactoring the existing code to allocate a buffer to hold IMA
   measurements at kexec 'load', and dump the measurements at kexec
   'execute'

 - kexec functionality for mapping the segments from the current kernel
   to the subsequent one, 

 - necessary changes to the kexec_file_load syscall, enabling it to call
   the ima functions,

 - registering a reboot notifier which gets called during kexec 'execute',

 - introducing a new Kconfig option to configure the extra memory to be
   allocated for passing IMA log from the current Kernel to the next,
   
 - introducing two new events to be measured by IMA during kexec, to
   help diagnose if the IMA log was copied fully or partially, from the
   current Kernel to the next, 

 - excluding IMA segment while calculating and storing digest in function
   kexec_calculate_store_digests(), since IMA segment can be modified
   after the digest is computed during kexec 'load'.  This will ensure
   that the segment is not added to the 'purgatory_sha_regions', and thus
   not verified by verify_sha256_digest().

The changes proposed in this series ensure the integrity of the IMA
measurements is preserved across kexec soft reboots, thus significantly
improving the security of the kernel post kexec soft reboots.

There were previous attempts to fix this issue [1], [2], [3].  But they
were not merged into the mainline kernel.

We took inspiration from the past work [1] and [2] while working on this
patch series.

V4 of this series is available here[6] for reference.

V5 of this series is available here[7] for reference.

V6 of this series is available here[8] for reference.

V7 of this series is available here[9] for reference.

V8 of this series is available here[10] for reference.

V9 of this series is available here[11] for reference.

V10 of this series is available here[12] for reference.

References:
-----------

[1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/

[2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
https://lkml.org/lkml/2016/8/16/577

[3] [PATCH 1/6] kexec_file: Add buffer hand-over support
https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/

[4] [PATCH v2 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20231005182602.634615-1-tusharsu@linux.microsoft.com/

[5] [PATCH v3 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20231216010729.2904751-1-tusharsu@linux.microsoft.com/

[6] [PATCH v4 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20240122183804.3293904-1-tusharsu@linux.microsoft.com/

[7] [PATCH v5 0/8] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20240214153827.1087657-1-tusharsu@linux.microsoft.com/

[8] [PATCH v6 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20250124225547.22684-1-chenste@linux.microsoft.com/

[9] [PATCH v7 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20250203232033.64123-1-chenste@linux.microsoft.com/

[10] [PATCH v8 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20250218225502.747963-1-chenste@linux.microsoft.com/

[11] [PATCH v9 0/7] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20250304190351.96975-1-chenste@linux.microsoft.com/

[12] [PATCH v10 0/8] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20250318010448.954-1-chenste@linux.microsoft.com/

[13] [PATCH v11 0/9] ima: kexec: measure events between kexec load and execute
https://lore.kernel.org/all/20250402124725.5601-1-chenste@linux.microsoft.com/

Change Log v12:
 - Incorporated feedback from the community (Mimi Zohar and Baoquan He) on
   v11 of this series[13].
 - Add range to config IMA_KEXEC_EXTRA_MEMORY_KB 
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.
 - Updated patch descriptions as necessary.

Change Log v11:
 - Incorporated feedback from the community (Mimi Zohar and Baoquan He) on
   v10 of this series[12].
 - [PATCH V10 2/8] was splited into two [PATCH V11 2/9] and [PATCH V11 7/9]. 
   Per Mimi comment on [PATCH V10 2/8].
 - Don't call ima_kexec_post_load() on KEXEC_FILE_ON_CRASH
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.
 - Updated patch descriptions as necessary.

Change Log v10:
 - Incorporated feedback from the community (Mimi Zohar, Baoquan He, and 
   kernel test robot) on v9 of this series[11].
 - [PATCH V9 1/7] was splited into two [PATCH V10 1/8] and [PATCH V10 2/8]. 
   Per Mimi comment on [PATCH V9 1/7].
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.

Change Log v9:
 - Incorporated feedback from the community (Stefan Berger, Mimi Zohar, 
   and kernel test robot) on v8 of this series[10].
 - Rebased the patch series to mainline 6.14.0-rc3.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.

Change Log v8:
 - Incorporated feedback from the community (Stefan Berger, Mimi Zohar) 
   on v7 of this series[9].
 - Rebased the patch series to mainline 6.14.0-rc1.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.

Change Log v7:
 - Incorporated feedback from the community (Stefan Berger, Tyler Hicks) 
   on v6 of this series[8].
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.

Change Log v6:
 - Incorporated feedback from the community (Stefan Berger, Mimi Zohar,
   and Petr Tesařík) on v5 of this series[7].
 - Rebased the patch series to mainline 6.12.0.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.
 - Compared the memory size allocated with memory size of the entire 
   measurement record. If there is not enough memory, it will copy as many
   IMA measurement records as possible, and this situation will result
   in a failure of remote attestation.
 - [PATCH V5 6/8] was removed. Per petr comment on [PATCH V5 6/8], during
   the handover, other CPUs are taken offline (look for
   migrate_to_reboot_cpu() in kernel/kexec_core.c) and even the reboot CPU
   will be sufficiently shut down as not to be able to add any more
   measurements.

Change Log v5:
 - Incorporated feedback from the community (Stefan Berger and
   Mimi Zohar) on v4 of this series[6].
 - Rebased the patch series to mainline 6.8.0-rc1.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying multiple kexec 'load' operations work,
   and also verifying kexec soft reboot works, and IMA log gets
   carried over for each patch.
 - Divided the patch #4 in the v4 of the series[6] into two separate
   patches. One to setup the infrastructure/stub functions to prepare
   the IMA log copy from Kexec 'load' to 'execute', and another one
   to actually copy the log.
 - Updated the config description for IMA_KEXEC_EXTRA_MEMORY_KB
   to remove unnecessary references related to backwards compatibility.
 - Fixed a typo in log message/removed an extra line etc.
 - Updated patch descriptions as necessary.

Change Log v4:
 - Incorporated feedback from the community (Stefan Berger and
   Mimi Zohar) on v3 of this series[5].
 - Rearranged patches so that they remain bisect-safe i.e. the
   system can go through kexec soft reboot, and IMA log is carried
   over after each patch.
 - Verified all the patches are bisect-safe by booting into each
   patch and verifying kexec soft reboot works, and IMA log gets
   carried over.
 - Suspend-resume measurements is now a separate patch (patch #5)
   and all the relevant code is part of the same patch.
 - Excluding IMA segment from segment digest verification is now a
   separate patch. (patch #3).
 - Registering reboot notifier and functions related to move ima 
   log copy from kexec load to execute are now part of the same
   patch (patch #4) to protect bisect-safeness of the series.
 - Updated the title of patch #6 as per the feedback.
 - The default value of kexec extra memory for IMA measurements
   is set to half the PAGESIZE to maintain backwards compatibility.
 - Added number of IMA measurement records as part of 'kexec_load' 
   and 'kexec_execute' IMA critical data events.
 - Updated patch descriptions as necessary.

Change Log v3:
 - Incorporated feedback from the community (Stefan Berger and
   Mimi Zohar) on v2 of this series[4].
 - Renamed functions and removed extraneous checks and code comments.
 - Updated patch descriptions and titles as necessary.
 - Updated kexec_calculate_store_digests() in patch 2/7 to exclude ima
   segment from calculating and storing digest.
 - Updated patch 3/7 to use kmalloc_array instead of kmalloc and freed
   memory early to avoid potential memory leak.
 - Updated patch 6/7 to change Kconfig option IMA_KEXEC_EXTRA_PAGES to
   IMA_KEXEC_EXTRA_MEMORY_KB to allocate the memory in kb rather than
   in number of pages.
 - Optimized patch 7/7 not to free and alloc memory if the buffer size
   hasn't changed during multiple kexec 'load' operations.
 - Fixed a bug in patch 7/7 to measure multiple 'kexec_load' events even
   if buffer size hasn't changed.
 - Verified the patches are bisect-safe by compiling and booting into
   each patch individually.


Change Log v2:
 - Incorporated feedback from the community on v1 series.
 - Refactored the existing ima_dump_measurement_list to move buffer
   allocation functionality to ima_alloc_kexec_buf() function.
 - Introduced a new Kconfig option to configure the memory.
 - Updated the logic to copy the IMA log only in case of kexec soft 
   reboot, and not on kexec crash.
 - Updated the logic to copy as many IMA events as possible in case of
   memory constraint, rather than just bailing out.
 - Introduced two new events to be measured by IMA during kexec, to
   help diagnose if the IMA log was copied fully or partially from the
   current Kernel to the next.
 - Refactored patches to ensure no warnings during individual patch
   compilation.
 - Used virt_to_page instead of phys_to_page.
 - Updated patch descriptions as necessary.


Steven Chen (9):
  ima: rename variable the seq_file "file" to "ima_kexec_file"
  ima: define and call ima_alloc_kexec_file_buf()
  kexec: define functions to map and unmap segments
  ima: kexec: skip IMA segment validation after kexec soft reboot
  ima: kexec: define functions to copy IMA log at soft boot
  ima: kexec: move IMA log copy from kexec load to execute
  ima: verify if the segment size has changed
  ima: make the kexec extra memory configurable
  ima: measure kexec load and exec events as critical data

 include/linux/ima.h                |   3 +
 include/linux/kexec.h              |   9 ++
 kernel/kexec_core.c                |  54 ++++++++
 kernel/kexec_file.c                |  33 ++++-
 security/integrity/ima/Kconfig     |  11 ++
 security/integrity/ima/ima.h       |   6 +
 security/integrity/ima/ima_kexec.c | 193 ++++++++++++++++++++++++-----
 security/integrity/ima/ima_queue.c |   5 +
 8 files changed, 280 insertions(+), 34 deletions(-)

-- 
2.43.0


