Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53D27D3C52C
	for <kexec@archiver.kernel.org>; Thu, 17 Oct 2024 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qaucm3V/Ak375YKPKmtJD8Fr51Rh26ZRLfbnumx9XHU=; b=hq3s1yIkkcJYgY
	VHqIZPlz1QYLTO8q/4G3qJ1wuoeGhaiscaENBr+YaiAUfObjH6RLTWak2aS3H4v/IBGukuqyAdxtp
	VgtLnWaVFZ5pnGMyPQhC2X4Fujihxl4OA/MeKh8uHUCOBGDV2YnbSi2PaPF6/Jm4wOP6j1BV+b8Ge
	cT5w/zkHyMFEVyweepq6IB7N0xZ8Ar8gO6QwvfxNjSOP3aiA1M6xLBrwJYG0c6ysqsyxtg0x6D/Qn
	nh+oICvxKaiytB2SzLyiD4+fhlR3E96ohQDZlnTKdtJxOH5Wi/etb3OyR5A8BjiEt90xhjVup06LE
	k0ElYtt0lkw4bc6pWiyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Vn2-0000000FywG-2ARg;
	Thu, 17 Oct 2024 19:04:04 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1Vmw-0000000FyuF-0NpU
	for kexec@lists.infradead.org;
	Thu, 17 Oct 2024 19:04:02 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7b13ff3141aso89104385a.1
        for <kexec@lists.infradead.org>; Thu, 17 Oct 2024 12:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729191836; x=1729796636; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qH11hcxNbwY7wx+W/7cRdf6NRA7wQzbx43qz3yjVmc4=;
        b=VQ9IwbZ1C/T2Nfs5u5f0kp4toVN69L4bsTxngQpenH0mTyPEfXBCJADzaX4aw8gEf6
         uSvh8rxQSGnvmn/LhApIEgcTcWy5YPfJJh5mWv/BlDitfqwD58Oy73ILOc1BbFSM5+hx
         aCrxSuNK/KchH6cHttXhmO8RjWj3j7W37Zc+fjbg1UAB0Vfb+HQKV5n/rYHCQvPIPYa+
         XRv5yxMiK8vPLRhhw+6tYVLKVtaoEH1tBxJK/Ytd2BgFzMe4WqJmc4RDORiOc25imahV
         CU1C1HXKOTWs5mOdCnajkwp+KXQ6P65xIaLEkBOPIA+D6EIVLu9k4QePg59MgiYe0VrG
         5MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729191836; x=1729796636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qH11hcxNbwY7wx+W/7cRdf6NRA7wQzbx43qz3yjVmc4=;
        b=WKFgNYAmE+aMIwkSX3eZJyC0b1VbwZJNQ85ZUCxILrTzO54WkLxq6XmsWGYq2VEuzi
         JDuPZxm/LoRS+4w3WXCGsONJyaWc4eYjwNKYG8O230RUlFhfcoD3gMZOJIjCzMvIVEa8
         cbWvTDeWnATyVoDOlUB79cXkhsJoi7Dxsa1stlosKMjOaFWLYdYW85kWkKny4gYu85TM
         +5KXCz0gr6DCW/MJH7igMy6r0szcl2I+qfW8ee5uxXxkQd6uzgy3ZUejNjVtcoLE7zFp
         yCvZpo7BvSJLPGLIiKhcidCIbzvhmSd+HQfZOOWgU/razZtBjXlViuWDCIuuOxxTnRa6
         a52w==
X-Gm-Message-State: AOJu0YwgXvm9WmG03gLw8LYH9oDjiI5yCkFJ0g6GJY7ajM+7PBQoo9Uj
	Hcd49Hz2iwA9BqVtFrAf/HdNr873nau9yTrO9DyK064BWRGknT7mJVhNaFP/ML6a4OAGu34r0jN
	S
X-Google-Smtp-Source: AGHT+IHmvZWzsm6C2/haXl1uVw6bseyVtbDuR+pZu1yr4xkN1vYFqbrNK9ZkLR/bbOALsetjNvUchg==
X-Received: by 2002:a05:620a:2453:b0:7b1:4cc0:5e1f with SMTP id af79cd13be357-7b14cc05ec0mr590409285a.7.1729191836065;
        Thu, 17 Oct 2024 12:03:56 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4607b0e22dfsm30211241cf.35.2024.10.17.12.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 12:03:55 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	andriy.shevchenko@linux.intel.com,
	ilpo.jarvinen@linux.intel.com,
	mika.westerberg@linux.intel.com,
	ying.huang@intel.com,
	bhe@redhat.com,
	gourry@gourry.net,
	tglx@linutronix.de,
	takahiro.akashi@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH] resource,kexec: walk_system_ram_res_rev must retain resource flags
Date: Thu, 17 Oct 2024 15:03:47 -0400
Message-ID: <20241017190347.5578-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_120358_258054_09FFDAF0 
X-CRM114-Status: GOOD (  10.70  )
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

walk_system_ram_res_rev() erroneously discards resource flags when
passing the information to the callback.

This causes systems with IORESOURCE_SYSRAM_DRIVER_MANAGED memory to
have these resources selected during kexec to store kexec buffers
if that memory happens to be at placed above normal system ram.

This leads to undefined behavior after reboot. If the kexec buffer
is never touched, nothing happens. If the kexec buffer is touched,
it could lead to a crash (like below) or undefined behavior.

Tested on a system with CXL memory expanders with driver managed
memory, TPM enabled, and CONFIG_IMA_KEXEC=y. Adding printk's
showed the flags were being discarded and as a result the check
for IORESOURCE_SYSRAM_DRIVER_MANAGED passes.

find_next_iomem_res: name(System RAM (kmem))
		     start(10000000000)
		     end(1034fffffff)
		     flags(83000200)

locate_mem_hole_top_down: start(10000000000) end(1034fffffff) flags(0)

[.] BUG: unable to handle page fault for address: ffff89834ffff000
[.] #PF: supervisor read access in kernel mode
[.] #PF: error_code(0x0000) - not-present page
[.] PGD c04c8bf067 P4D c04c8bf067 PUD c04c8be067 PMD 0
[.] Oops: 0000 [#1] SMP
[.] RIP: 0010:ima_restore_measurement_list+0x95/0x4b0
[.] RSP: 0018:ffffc900000d3a80 EFLAGS: 00010286
[.] RAX: 0000000000001000 RBX: 0000000000000000 RCX: ffff89834ffff000
[.] RDX: 0000000000000018 RSI: ffff89834ffff000 RDI: ffff89834ffff018
[.] RBP: ffffc900000d3ba0 R08: 0000000000000020 R09: ffff888132b8a900
[.] R10: 4000000000000000 R11: 000000003a616d69 R12: 0000000000000000
[.] R13: ffffffff8404ac28 R14: 0000000000000000 R15: ffff89834ffff000
[.] FS:  0000000000000000(0000) GS:ffff893d44640000(0000) knlGS:0000000000000000
[.] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[.] ata5: SATA link down (SStatus 0 SControl 300)
[.] CR2: ffff89834ffff000 CR3: 000001034d00f001 CR4: 0000000000770ef0
[.] PKRU: 55555554
[.] Call Trace:
[.]  <TASK>
[.]  ? __die+0x78/0xc0
[.]  ? page_fault_oops+0x2a8/0x3a0
[.]  ? exc_page_fault+0x84/0x130
[.]  ? asm_exc_page_fault+0x22/0x30
[.]  ? ima_restore_measurement_list+0x95/0x4b0
[.]  ? template_desc_init_fields+0x317/0x410
[.]  ? crypto_alloc_tfm_node+0x9c/0xc0
[.]  ? init_ima_lsm+0x30/0x30
[.]  ima_load_kexec_buffer+0x72/0xa0
[.]  ima_init+0x44/0xa0
[.]  __initstub__kmod_ima__373_1201_init_ima7+0x1e/0xb0
[.]  ? init_ima_lsm+0x30/0x30
[.]  do_one_initcall+0xad/0x200
[.]  ? idr_alloc_cyclic+0xaa/0x110
[.]  ? new_slab+0x12c/0x420
[.]  ? new_slab+0x12c/0x420
[.]  ? number+0x12a/0x430
[.]  ? sysvec_apic_timer_interrupt+0xa/0x80
[.]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[.]  ? parse_args+0xd4/0x380
[.]  ? parse_args+0x14b/0x380
[.]  kernel_init_freeable+0x1c1/0x2b0
[.]  ? rest_init+0xb0/0xb0
[.]  kernel_init+0x16/0x1a0
[.]  ret_from_fork+0x2f/0x40
[.]  ? rest_init+0xb0/0xb0
[.]  ret_from_fork_asm+0x11/0x20
[.]  </TASK>

Link: https://lore.kernel.org/all/20231114091658.228030-1-bhe@redhat.com/
Fixes: 7acf164b259d ("resource: add walk_system_ram_res_rev()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 kernel/resource.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b730bd28b422..4101016e8b20 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -459,9 +459,7 @@ int walk_system_ram_res_rev(u64 start, u64 end, void *arg,
 			rams_size += 16;
 		}
 
-		rams[i].start = res.start;
-		rams[i++].end = res.end;
-
+		rams[i++] = res;
 		start = res.end + 1;
 	}
 
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
