Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17970E9272B
	for <kexec@archiver.kernel.org>; Thu,  5 Oct 2023 18:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=/jQOkp8tVUYzvL+xBD3dERL7cst3zJaq5+1pDiZJinQ=; b=okRyUjI9omm9fo
	dOgsIuDS4sHHlE6hwCyKXNSd6HvmEySOBxIc7Hye32StzjvEcFYms8psviGamfS9ggenp6kRF+iuU
	3He0tE9jpZ/JUaTvzDhWPJIpAQ3IYpl1R/1j6tUiqOdkV5Rp2+UMb9wdzXnzF6lhSsfAMcANjdrV8
	OFNypgdnUsuCYZ6r/0tl4qF//JzM5DyJ0hi5jFqyvIbmMo/0F8zeZPkMimfp1D5KfOmD6ksQi8q0K
	FqsyTKD5xG0ARUCCKh8YncUNXeh1AWvFXYcN2QBrPmKVj1lsqJBtC1OjaQ5vCSb8mKxugBKx35pRh
	orkFxdr85ecDXA4+a66w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT3B-004HRx-0i;
	Thu, 05 Oct 2023 18:26:17 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoT37-004HPs-2F
	for kexec@lists.infradead.org;
	Thu, 05 Oct 2023 18:26:15 +0000
Received: from tushar-HP-Pavilion-Laptop-15-eg0xxx.lan (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6558220B74C0;
	Thu,  5 Oct 2023 11:26:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6558220B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696530371;
	bh=N5vQ184H6G3MuIeE4MfuKAUvX0Io9ATVvdzb7uoPAhw=;
	h=From:To:Cc:Subject:Date:From;
	b=Tk6lwQRiVpJJ7bBszNrAQJ0k3BifqUqjighblZYn/uvp0X9b5hofdwbprE/YdFr8q
	 fd3RleDD6KJvfX8xGza5UKtD92c+LwmiMtr4KJwApuw237FaGZtKZEO/rs3i6AAoTt
	 8acz2tj+Xw0dBP0zRQi3Xjr3/avSLHFlaXT0R7UA=
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: zohar@linux.ibm.com,
	ebiederm@xmission.com,
	noodles@fb.com,
	bauermann@kolabnow.com,
	kexec@lists.infradead.org,
	linux-integrity@vger.kernel.org
Cc: code@tyhicks.com,
	nramas@linux.microsoft.com,
	paul@paul-moore.com
Subject: [PATCH v2 0/7] ima: kexec: measure events between kexec load and execute
Date: Thu,  5 Oct 2023 11:25:55 -0700
Message-Id: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_112613_806288_11DA334C 
X-CRM114-Status: GOOD (  21.32  )
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

The current Kernel behavior is IMA measurements snapshot is taken at
kexec 'load' and not at kexec 'execute'.  IMA log is then carried
over to the new Kernel after kexec 'execute'.

Some systems can be configured to call kexec 'load' first, and followed
by kexec 'execute' after some time.  (as opposed to calling 'load' and
'execute' in one single kexec command).  In such scenario, if new IMA
measurements are added between kexec 'load' and kexec 'execute', the
TPM PCRs are extended with the IMA events between 'load' and 'execute'.
But those IMA events are not carried over to the new Kernel after kexec
soft reboot.  This results in mismatch between TPM PCR quotes, and the
actual IMA measurements list, after the system boots into the new kexec
image.  This mismatch results in the remote attestation failing for that
system.

This patch series proposes a solution to solve this problem by allocating
the necessary buffer at kexec 'load' time, and populating the buffer
with the IMA measurements at kexec 'execute' time. 

The solution includes:
 - refactoring the existing code to allocate a buffer to hold IMA
   measurements at kexec 'load', and dump the measurements at kexec
   'execute'

 - ima functionality to suspend and resume measurements as needed during
   buffer copy at kexec 'execute',

 - ima functionality for mapping the measurement list from the current
   Kernel to the subsequent one, 

 - necessary changes to the kexec_file_load syscall, enabling it to call
   the ima functions,

 - registering a reboot notifier which gets called during kexec 
   'execute',

 - introducing a new Kconfig option to configure the amount of memory
   to be allocated for passing IMA log from the current Kernel to the
   next,
   
 - introducing two new events to be measured by IMA during kexec, to
   help diagnose if the IMA log was copied fully or partially, from the
   current Kernel to the next,

The modifications proposed in this series ensure the integrity of the ima
measurements is preserved across kexec soft reboots, thus significantly
improving the security of the Kernel post kexec soft reboots.

There were previous attempts to fix this issue [1], [2], [3].  But they
were not merged into the mainline Kernel.

We took inspiration from the past work [1] and [2] while working on this
patch series.

References:
-----------

[1] [PATHC v2 5/9] ima: on soft reboot, save the measurement list
https://lore.kernel.org/lkml/1472596811-9596-6-git-send-email-zohar@linux.vnet.ibm.com/

[2] PATCH v2 4/6] kexec_file: Add mechanism to update kexec segments.
https://lkml.org/lkml/2016/8/16/577

[3] [PATCH 1/6] kexec_file: Add buffer hand-over support
https://lore.kernel.org/linuxppc-dev/1466473476-10104-6-git-send-email-bauerman@linux.vnet.ibm.com/T/

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

Tushar Sugandhi (7):
  ima: refactor ima_dump_measurement_list to move memory allocation to a
    separate function
  ima: move ima_dump_measurement_list call from kexec load to execute
  ima: kexec: map source pages containing IMA buffer to image post kexec
    load
  kexec: update kexec_file_load syscall to call ima_kexec_post_load
  ima: suspend measurements while the buffer is being copied during
    kexec reboot
  ima: make the memory for events between kexec load and exec
    configurable
  ima: record log size at kexec load and execute

 include/linux/ima.h                |   3 +
 include/linux/kexec.h              |  13 ++
 kernel/kexec_core.c                |  73 ++++++++-
 kernel/kexec_file.c                |   8 +
 security/integrity/ima/Kconfig     |   9 ++
 security/integrity/ima/ima.h       |   2 +
 security/integrity/ima/ima_kexec.c | 246 ++++++++++++++++++++++++-----
 security/integrity/ima/ima_queue.c |  31 ++++
 8 files changed, 341 insertions(+), 44 deletions(-)

-- 
2.25.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
