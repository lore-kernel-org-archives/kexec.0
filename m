Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47ED4D116F1
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 03:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qr0zpQpajQCRbG+sF+yGezyQgSmvvZvdStpi3agx6mY=; b=aOffIzuyExp4mZ3bZYOxhEcpWt
	d/pDfOtxN0faH0/iVzohNBZCMXVpZHtxZHoVBUKaIbOsJ4PoN/Tep/+QqxTARERlgP7dO4ywcTafK
	yBQp0IODIQGO9Hx8zHHxhtEiVGJm3v3ZtRasKuwPoVriBHTNzqkCn2ZOB1S8fhYmfyuEmk3f9WD4F
	MAWSrjcyp20r9TmG1ZWYGASu7hOvJ4Dv/g7vsce93dft8ijflvryPMQOMxNJaFtUS1MQNWN/0wcTl
	v18Som9M5D7rntqVbCi+wb8kpXjk8wbE3W5rmdtTIVjHFEZYpqy0J0HF+AVT3/+gNaM6DPFPYD8Ln
	5o46pD/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpF3-0000000HWWC-2dwB;
	Fri, 28 Nov 2025 03:33:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOpEx-0000000HWVT-41Hk
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 03:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764300825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qr0zpQpajQCRbG+sF+yGezyQgSmvvZvdStpi3agx6mY=;
	b=V0Q/G10KTIhaRrRvasS9nmweWBYTMNrTRYAq7vQ/H8RexTxRrIEHt80om7JsdkhwjmJDU1
	WM6KRVfoPEGK0sW3Et7xVVTMQ2FzXPcrI1+8gGXP1qMoTQNeUWxlFXEhEeWYAB32u7V/aT
	cGQ3UpW7xZh7EAJhzatd0UZTpeS6miw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-sE3kvIDuP_qIGMkVoeXVOw-1; Thu,
 27 Nov 2025 22:33:37 -0500
X-MC-Unique: sE3kvIDuP_qIGMkVoeXVOw-1
X-Mimecast-MFC-AGG-ID: sE3kvIDuP_qIGMkVoeXVOw_1764300815
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42F9F1956095;
	Fri, 28 Nov 2025 03:33:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1735A19560B0;
	Fri, 28 Nov 2025 03:33:23 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	elver@google.com,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 00/12] mm/kasan: make kasan=on|off work for all three modes
Date: Fri, 28 Nov 2025 11:33:08 +0800
Message-ID: <20251128033320.1349620-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_193348_416477_4AE34B59 
X-CRM114-Status: GOOD (  20.52  )
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

Currently only hw_tags mode of kasan can be enabled or disabled with
kernel parameter kasan=on|off for built kernel. For kasan generic and
sw_tags mode, there's no way to disable them once kernel is built.

This is not convenient sometime, e.g in system kdump is configured.
When the 1st kernel has KASAN enabled and crash triggered to switch to
kdump kernel, the generic or sw_tags mode will cost much extra memory
while in fact it's meaningless to have kasan in kdump kernel

There are two parts of big amount of memory requiring for kasan enabed
kernel. One is the direct memory mapping shadow of kasan, which is 1/8
of system RAM in generic mode and 1/16 of system RAM in sw_tags mode;
the other is the shadow meomry for vmalloc which causes big meomry
usage in kdump kernel because of lazy vmap freeing. By introducing
"kasan=off|on", if we specify 'kasan=off', the former is avoided by skipping
the kasan_init(), and the latter is avoided by not building the vmalloc
shadow for vmalloc.

So this patchset moves the kasan=on|off out of hw_tags scope and into
common code to make it visible in generic and sw_tags mode too. Then we
can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
kasan.

Testing:
========
- Testing on x86_64 and arm64 for generic mode passed when kasan=on or
  kasan=off.

- Testing on arm64 with sw_tags mode passed when kasan=off is set. But
  when I tried to test sw_tags on arm64, the system bootup failed. It's
  not introduced by my patchset, the original code has the bug. I have
  reported it to upstream.
  - System is broken in KASAN sw_tags mode during bootup
    - https://lore.kernel.org/all/aSXKqJTkZPNskFop@MiWiFi-R3L-srv/T/#u

- Haven't found hardware to test hw_tags. If anybody has the system,
  please help take a test.

Changelog:
====
v3->v4:
- Rebase code to the latest linux-next/master to make the whole patchset
  set on top of 
  [PATCH 0/2] kasan: cleanups for kasan_enabled() checks
  [PATCH v6 0/2] kasan: unify kasan_enabled() and remove arch-specific implementations

v2->v3:
- Fix a building error on UML ARCH when CONFIG_KASAN is not set. The
  change of fixing is appended into patch patch 11. This is reported
  by LKP, thanks to them.

v1->v2:
- Add __ro_after_init for kasan_arg_disabled, and remove redundant blank
  lines in mm/kasan/common.c. Thanks to Marco.
- Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
  this is found out by SeongJae and Lorenzo, and also reported by LKP
  report, thanks to them.
- Add a missing kasan_enabled() checking in kasan_report(). This will
  cause below KASAN report info even though kasan=off is set:
     ==================================================================
     BUG: KASAN: stack-out-of-bounds in tick_program_event+0x130/0x150
     Read of size 4 at addr ffff00005f747778 by task swapper/0/1

     CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #8 PREEMPT(voluntary)
     Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
     Call trace:
      show_stack+0x30/0x90 (C)
      dump_stack_lvl+0x7c/0xa0
      print_address_description.constprop.0+0x90/0x310
      print_report+0x104/0x1f0
      kasan_report+0xc8/0x110
      __asan_report_load4_noabort+0x20/0x30
      tick_program_event+0x130/0x150
      ......snip...
     ==================================================================

- Add jump_label_init() calling before kasan_init() in setup_arch() in these
  architectures: xtensa, arm. Because they currenly rely on
  jump_label_init() in main() which is a little late. Then the early static
  key kasan_flag_enabled in kasan_init() won't work.

- In UML architecture, change to enable kasan_flag_enabled in arch_mm_preinit()
  because kasan_init() is enabled before main(), there's no chance to operate
  on static key in kasan_init().

Baoquan He (12):
  mm/kasan: add conditional checks in functions to return directly if
    kasan is disabled
  mm/kasan: move kasan= code to common place
  mm/kasan/sw_tags: don't initialize kasan if it's disabled
  arch/arm: don't initialize kasan if it's disabled
  arch/arm64: don't initialize kasan if it's disabled
  arch/loongarch: don't initialize kasan if it's disabled
  arch/powerpc: don't initialize kasan if it's disabled
  arch/riscv: don't initialize kasan if it's disabled
  arch/x86: don't initialize kasan if it's disabled
  arch/xtensa: don't initialize kasan if it's disabled
  arch/um: don't initialize kasan if it's disabled
  mm/kasan: make kasan=on|off take effect for all three modes

 arch/arm/kernel/setup.c                |  6 ++++++
 arch/arm/mm/kasan_init.c               |  2 ++
 arch/arm64/mm/kasan_init.c             |  6 ++++++
 arch/loongarch/mm/kasan_init.c         |  2 ++
 arch/powerpc/mm/kasan/init_32.c        |  5 ++++-
 arch/powerpc/mm/kasan/init_book3e_64.c |  3 +++
 arch/powerpc/mm/kasan/init_book3s_64.c |  3 +++
 arch/riscv/mm/kasan_init.c             |  3 +++
 arch/um/kernel/mem.c                   |  5 ++++-
 arch/x86/mm/kasan_init_64.c            |  3 +++
 arch/xtensa/kernel/setup.c             |  1 +
 arch/xtensa/mm/kasan_init.c            |  3 +++
 include/linux/kasan-enabled.h          |  6 ++++--
 mm/kasan/common.c                      | 20 ++++++++++++++++--
 mm/kasan/generic.c                     | 17 ++++++++++++++--
 mm/kasan/hw_tags.c                     | 28 ++------------------------
 mm/kasan/init.c                        |  6 ++++++
 mm/kasan/quarantine.c                  |  3 +++
 mm/kasan/report.c                      |  4 +++-
 mm/kasan/shadow.c                      | 11 +++++++++-
 mm/kasan/sw_tags.c                     |  6 ++++++
 21 files changed, 107 insertions(+), 36 deletions(-)

-- 
2.41.0


