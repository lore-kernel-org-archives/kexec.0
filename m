Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6EAFEE4ED
	for <kexec@archiver.kernel.org>; Sat, 28 Feb 2026 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1aKltuGD73YjisWVS6CLmrdjTwiXA9NrG9kYPekxkOw=; b=0lQr+oduH1uEUXJOGvpOPQ86tN
	CuWq7mninD6nUZw6fwkiUOetllMTVU1ey5irfoJrS13y9vEiTg7kauQMMSO7SOhDH+4zBFPDUCUKy
	pp146c/GoED+qJGsrjUGze2CujiuSl6xGFzCpGCoEodDAwq/DThpBq3Gxz0fCjf2e3+dq2xlUxCu0
	oq/MyrysHjeV+lCLNIbe93oMf8GkFpN5VSToOkMeTU1rkgZhP4msVwk9vuPDaKbJIYdyzfNGR394u
	JFOPw/gcrlQEmAg7I6zzVkPpZB3LRqkrzg4trM1DJEcT5t4t80Qnw/w7uU5pLrD/vhjbQmlu4cWex
	u8SAuN6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwKQG-00000009sGG-2fwj;
	Sat, 28 Feb 2026 13:31:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwKQD-00000009sFd-3K37
	for kexec@lists.infradead.org;
	Sat, 28 Feb 2026 13:31:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772285510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1aKltuGD73YjisWVS6CLmrdjTwiXA9NrG9kYPekxkOw=;
	b=inhGoeUZL+NhNgJETTTshDi7/DDCAYG2wgMDoIA+erg1dWO3QQMDVK8y4k81YxgYmxr/mr
	2ZyIlPTCAdY0KLawi28ky+lgTRcIofbv94NfomhF7pT5rhzU1Wx9s3lXZNzMnOKnt4qkPw
	MAbd5SH+XH3STOC44QHAPp+IwNsMiPw=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-qLo1PGOqOqKbVMixAg1qiQ-1; Sat, 28 Feb 2026 08:31:49 -0500
X-MC-Unique: qLo1PGOqOqKbVMixAg1qiQ-1
X-Mimecast-MFC-AGG-ID: qLo1PGOqOqKbVMixAg1qiQ_1772285508
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso2705678a91.0
        for <kexec@lists.infradead.org>; Sat, 28 Feb 2026 05:31:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285508; x=1772890308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aKltuGD73YjisWVS6CLmrdjTwiXA9NrG9kYPekxkOw=;
        b=nszKa5jitm4reGi5fjn95YRbz0Npb3/Le5NuV2Oyqra9flfQozE0aDP2ZYZ9oeGKMY
         p3mtBM7ye7tWblIdkI46wjvsmQklvcLaf/R+3UMLcWHgcONw7hg494RlHwuGH+GpWxon
         0JS2BJhmETlfPtAiixTOy4ExN7huShIsYq0piPdjFwe6hNLGFZv7cUf4nVniRJbVgh2n
         8EGwB3/aJaQC5stVqjlZTgIVCjnDd2ru7xWnOfwzeNUbOKLpcDSFQaV59gfn4Vq4M9Vq
         c8kRPsveyTG0/VRnlFfHVjlV/1i6b026HzKv57u9EheTBG5hVFnYK/aHG37+VFaUOFNu
         ZByA==
X-Forwarded-Encrypted: i=1; AJvYcCVCthgQIcn68bI1IRofPrOw5SryXz7pzMFSll8bz4BBH8zDoejjWK8wG0jzGoVdXYGYuIqjeg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzgZj4AmtNVn5NIQXOCm4Y3jZwi/zSGfgIvqK2uIBMuJhlnLWAQ
	62YPfAJkk5e+XW8fmZZ6qG5q2RE1+Sq9j+VYgbo5OR2WyP2c9jhkyJ3pErU1B+8Bw4wyDMujvhM
	co9yU9nsqaPHmocN4ugJCsvymu9x+5Y9BL3juCNHHLQqC0bMG8oIjOW70NZYTBQ==
X-Gm-Gg: ATEYQzwVD0KIsJ3F5BOekBYd9629Nac2ac8DKs6iY6lPQ9aENay2Dxfpi0QH6DOt/jC
	hD3aXMq63rMAkKBhgd4EioBRl80nWZHSu6EgNNiifNGfAPilmCxWhsQfRoh/rG9YLcyvlyxPxMx
	6wqq1OQFc5AeGz+1aLQH/8ykPEam+kPw/VnWvpEZo6zhZ+GejjnFoNyAkdn8s7wuLOCNF/BxBr5
	Jj1WCWwxk8IYyRpBdo/1wWiU6ADdXdGxMaG4BW/2YDpCPLHKFcZXBSyzgvnWonnmrT/l6KGmWFJ
	+CZn7oPs6wpLBmDxpm31Zp4goqtXHanEjSUH1pvCbbXWcm4Z3yI6/b5K9I30RdVL4Fq/iX8Xsdi
	VFrHdhU9STPXhVq8fd7zA1C4+d8eWj8i9AVE=
X-Received: by 2002:a17:90b:544b:b0:354:bd08:480c with SMTP id 98e67ed59e1d1-35965d029fcmr5533358a91.30.1772285507837;
        Sat, 28 Feb 2026 05:31:47 -0800 (PST)
X-Received: by 2002:a17:90b:544b:b0:354:bd08:480c with SMTP id 98e67ed59e1d1-35965d029fcmr5533334a91.30.1772285507391;
        Sat, 28 Feb 2026 05:31:47 -0800 (PST)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dab1sm6844448a12.27.2026.02.28.05.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 05:31:46 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH] i915: Fix NULL pointer dereference in intel_dmc_update_dc6_allowed_count()
Date: Sun,  1 Mar 2026 02:09:47 +1300
Message-ID: <20260228130946.50919-2-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iR3p4icEngsqc3k4NPl-NGYTuptUvY-mOmLddvAHLnk_1772285508
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260228_053153_909525_5112A501 
X-CRM114-Status: GOOD (  12.93  )
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

There is a NULL pointer dereference issue noticed in i915 when 2nd kernel
bootup during kdump. This will panic 2nd kernel and lead to no vmcore
generation. The issue is observed in Meteorlake CPU(cpuid: 0xA06A2):

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0 P4D 0
    Oops: Oops: 0000 [#1] SMP NOPTI
    ...
    RIP: 0010:intel_dmc_update_dc6_allowed_count+0x16/0xa0 [i915]
    ...

It is easy to locate the NULL pointer dereference by disassembly:

    00000000001171e0 <intel_dmc_update_dc6_allowed_count>:
      1171e0:       f3 0f 1e fa             endbr64
      1171e4:       e8 00 00 00 00          call   1171e9
      1171e9:       41 55                   push   %r13
      1171eb:       41 54                   push   %r12
      1171ed:       55                      push   %rbp
      1171ee:       53                      push   %rbx
      1171ef:       4c 8b a7 18 03 00 00    mov    0x318(%rdi),%r12
      1171f6:       49 8b 2c 24             mov    (%r12),%rbp

To fix this, add a NULL pointer check before dereferencing.

Signed-off-by: Tao Liu <ltao@redhat.com>
---

The issue doesn't happen in 1st kernel, but in 2nd kernel of kdump. I'm not
an expert to i915 and unsure what lead to the NULL pointer. To help further
analysis, here is the full stack:

[    8.608520]  <TASK> 
[    8.610652]  gen9_set_dc_state.part.0+0x25d/0x2f0 [i915] 
[    8.616096]  icl_display_core_init+0x2d/0x620 [i915] 
[    8.621266]  intel_power_domains_init_hw+0x1b2/0x500 [i915] 
[    8.627047]  intel_display_driver_probe_noirq+0x87/0x300 [i915] 
[    8.633188]  i915_driver_probe+0x207/0x5d0 [i915] 
[    8.637977]  ? drm_privacy_screen_get+0x198/0x1c0 
[    8.642832]  local_pci_probe+0x41/0x90 
[    8.646646]  pci_call_probe+0x58/0x160 
[    8.650458]  ? pci_assign_irq+0x2f/0x160 
[    8.654447]  ? pci_match_device+0xf8/0x120 
[    8.658522]  pci_device_probe+0x95/0x140 
[    8.662582]  call_driver_probe+0x27/0x110 
[    8.666570]  really_probe+0xcc/0x2c0 
[    8.670190]  __driver_probe_device+0x78/0x120 
[    8.674692]  driver_probe_device+0x1f/0xa0 
[    8.678857]  __driver_attach+0xfa/0x230 
[    8.682757]  ? __pfx___driver_attach+0x10/0x10 
[    8.687185]  bus_for_each_dev+0x8e/0xe0 
[    8.691159]  bus_add_driver+0x11f/0x200 
[    8.694970]  driver_register+0x72/0xd0 
[    8.698853]  i915_init+0x26/0x90 [i915] 
[    8.702837]  ? __pfx_i915_init+0x10/0x10 [i915] 
[    8.707433]  do_one_initcall+0x5c/0x320 
[    8.711409]  do_init_module+0x60/0x240 
[    8.715132]  init_module_from_file+0xd6/0x130 
[    8.719634]  idempotent_init_module+0x114/0x310 
[    8.724241]  __x64_sys_finit_module+0x71/0xe0 
[    8.728671]  do_syscall_64+0x11b/0x6d0 
[    8.732483]  ? ksys_read+0x6b/0xe0 
[    8.735854]  ? arch_exit_to_user_mode_prepare.isra.0+0xa2/0xd0 
[    8.741768]  ? do_syscall_64+0x153/0x6d0 
[    8.745828]  ? do_syscall_64+0x153/0x6d0 
[    8.749814]  ? do_syscall_64+0x153/0x6d0 
[    8.753800]  ? clear_bhb_loop+0x30/0x80 
[    8.757700]  entry_SYSCALL_64_after_hwframe+0x76/0x7e 

---
 drivers/gpu/drm/i915/display/intel_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 1006b060c3f3..fd2756badc0c 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -1578,7 +1578,7 @@ void intel_dmc_update_dc6_allowed_count(struct intel_display *display,
 	struct intel_dmc *dmc = display_to_dmc(display);
 	u32 dc5_cur_count;
 
-	if (DISPLAY_VER(dmc->display) < 14)
+	if (!dmc || DISPLAY_VER(dmc->display) < 14)
 		return;
 
 	dc5_cur_count = intel_de_read(dmc->display, DG1_DMC_DEBUG_DC5_COUNT);
-- 
2.47.0


