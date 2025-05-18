Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E17FC54756
	for <kexec@archiver.kernel.org>; Sun, 18 May 2025 14:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jT7mfe7LbtE5wHDmsO21gdSBNUHVNX5bvSxUgvXaBdw=; b=IMMxrIxti4rH+djI2q5+D1WHRs
	k6FHGTGbCdcDaObHqFLjewdHER2CqwgkDmcyHpQr6zoN1GsiHYwV1HHL/4MyPMVN5zl2ZQGsip0Uz
	XToR3xzrk05C3TE8Apw7eHbkS822VBknbxkmQbbNptE2GosGAUAmDg/19bJjEN9yVNN1wJcFEXk8w
	BZqI3HmFZKszbA502Qt+3Hxdxeuf0TTqbaEHhwjGNVfCN90rJ3yxqvMNyqs7TWswBra9mIgl6zD50
	pB2MQnwsKxDJBOMc5iXw627Yfu62ImfYFpG0ff61lnKP9ujI/KeTPn/U5R73yf5Z4/54/3oiL6ipS
	IjUnXk3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGevI-00000007BWb-1GPA;
	Sun, 18 May 2025 14:23:28 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGevF-00000007BVi-1Dxz
	for kexec@lists.infradead.org;
	Sun, 18 May 2025 14:23:26 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-231de0e1ca3so16961605ad.0
        for <kexec@lists.infradead.org>; Sun, 18 May 2025 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747578204; x=1748183004; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jT7mfe7LbtE5wHDmsO21gdSBNUHVNX5bvSxUgvXaBdw=;
        b=cSX0Sly7DAVLbK3D86vlrbV8brOQk9RqCNJtx+sdrBy6jf+VhJUPFUY4tDMIOvno0S
         Q44gbXoooi45WmgA+wBo2bkVTuXdQbvZ9dp62OkDHM8SMAYJwKYImZRe48f+5iV1c5Tg
         rNnXdEwFolE0eps2EdkqJylA+kSucEuRP5FVREcEihtLeJOpFQ2ozfUmyV2QjIsZ7iSM
         l05Naiw+55xWuUZK7fKKf/9T9hKOOCIWcRoBZJXmmM/1gPCgUIotXGXngkhLIpJuxrxF
         vs+fNdMDOlNLdAyC8wLRM+IpGAG5ryaTW4O0DXSAuvVYGQANitKvzUf4oAZZKriJovaU
         6VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747578204; x=1748183004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jT7mfe7LbtE5wHDmsO21gdSBNUHVNX5bvSxUgvXaBdw=;
        b=oCQwGPsHL6hIhfn24CtQixY8bSNeMzd65rO8OkvJXI5r4jVx52CkdNWhJI+XgKENW2
         rBSiEVCODXPqtO/ZwJBCSVHk4pdiGh4bf3/7YZMCVhRGLRk/xPsVER43hNkCthFEoDhi
         2XYFVfvf4Nx1cqu6zhaMasnWpAFnrOsklpL5Ved8/1K0do+Q1l8y3Jf5/2mNIZ2tZb9x
         zObXKSXOr7AQLDPQ5WClbc6Zd2WPFBTpQ5+i8VXyfnZjpMXu47En1Bw+MQXylBcWj/D3
         wk/+2ce5Wf56BQT5KZay0gPZIizSj+nxnpyxuOpGRoUGDvoN5teSLsVsKsdfrZS/1gs5
         7nXg==
X-Forwarded-Encrypted: i=1; AJvYcCXtz0yaM/0Cn2RC9mC8lvyZZ0iIrnZJ7F+5GbQ+pSxrgFwLIM32xh/qfKAUApHZvJRapyOcFg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9mbynHN7OqX31+HrNQIit6xAkpm+ZtprXg9rKmra+xqYqng45
	7rFP14NJJNllGVWK0bGtEjPc8sPeRZS1WTERM9puLCh0qAK/AtS66xbUcLdjkfrq349INsC/SiJ
	JQPRHelfA40O6XjEv28zYdg==
X-Google-Smtp-Source: AGHT+IGypgJXeP8ubYjhVjl0jk8L37IfHdOWll/4sSzsWQWyLqo/POjIy3VpEHrpZd9cWUYbykkM//Boenh7zHui
X-Received: from ploh6.prod.google.com ([2002:a17:902:f706:b0:22e:3312:15a5])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:94f:b0:220:ea90:191e with SMTP id d9443c01a7336-231d43d9ca1mr147409035ad.4.1747578203986;
 Sun, 18 May 2025 07:23:23 -0700 (PDT)
Date: Sun, 18 May 2025 07:23:14 -0700
In-Reply-To: <20250518142315.241670-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250518142315.241670-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250518142315.241670-2-changyuanl@google.com>
Subject: [PATCH 1/2] memblock: show a warning if allocation in KHO scratch fails
From: Changyuan Lyu <changyuanl@google.com>
To: rppt@kernel.org, akpm@linux-foundation.org
Cc: graf@amazon.com, bhe@redhat.com, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, chrisl@kernel.org, 
	pasha.tatashin@soleen.com, jasonmiu@google.com, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_072325_331764_FAAC3E59 
X-CRM114-Status: GOOD (  15.29  )
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

When we kexec into a new kernel from an old kernel with KHO
enabled, the new kernel allocates vmemmap in the scratch area.
If the KHO scratch size is too small, vmemmap allocation would
fail and cause kernel panic, like the following,

[    0.027133] Faking a node at [mem 0x0000000000000000-0x00000004ffffffff]
[    0.027877] NODE_DATA(0) allocated [mem 0x4e4bd5a00-0x4e4bfffff]
[    0.029696] sparse_init_nid: node[0] memory map backing failed. Some memory will not be available.
[    0.029698] Zone ranges:
[    0.030974]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.031627]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.032281]   Normal   [mem 0x0000000100000000-0x00000004ffffffff]
[    0.032930]   Device   empty
[    0.033251] Movable zone start for each node
[    0.033710] Early memory node ranges
[    0.034108]   node   0: [mem 0x0000000000001000-0x000000000007ffff]
[    0.034801]   node   0: [mem 0x0000000000100000-0x00000000773fffff]
[    0.035461]   node   0: [mem 0x0000000077400000-0x00000000775fffff]
[    0.036116]   node   0: [mem 0x0000000077600000-0x000000007fffffff]
[    0.036768]   node   0: [mem 0x0000000100000000-0x00000004ccbfffff]
[    0.037423]   node   0: [mem 0x00000004ccc00000-0x00000004e4bfffff]
[    0.038111] BUG: kernel NULL pointer dereference, address: 0000000000000010
[    0.038880] #PF: supervisor write access in kernel mode
[    0.039474] #PF: error_code(0x0002) - not-present page
[    0.040056] PGD 0 P4D 0
[    0.040335] Oops: Oops: 0002 [#1] SMP
[    0.040745] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc4+ #275 NONE
[    0.041541] RIP: 0010:__bitmap_set+0x2b/0x80
[    0.041992] Code: 0f 1e fa 55 48 89 e5 89 f1 89 f0 c1 e8 06 48 8d 04 c7 48 c7 c7 ff ff ff ff 48 d3 e7 41 89 f0 41 83 c8 c0 44 89 c6 01 d6 78 43 <48> 09 38 48 83 c0 08 83 fe 40 72 1a 41 8d 3c 10 83 c7 40 48 c7 00
[    0.043986] RSP: 0000:ffffffff96203df0 EFLAGS: 00010047
[    0.044546] RAX: 0000000000000010 RBX: 000000000000cc00 RCX: 0000000000000000
[    0.045311] RDX: 0000000000000040 RSI: 0000000000000000 RDI: ffffffffffffffff
[    0.046075] RBP: ffffffff96203df0 R08: 00000000ffffffc0 R09: ffffffff9626c950
[    0.046830] R10: 000000000002fffd R11: 0000000000000004 R12: 0000000000008000
[    0.047574] R13: 0000000000000000 R14: 000000000000003f R15: 000000000000009b
[    0.048313] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    0.049151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.049751] CR2: 0000000000000010 CR3: 00000004d123e000 CR4: 00000000000200b0
[    0.050494] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.051238] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.051978] Call Trace:
[    0.052235]  <TASK>
[    0.052455]  subsection_map_init+0xe4/0x130
[    0.052891]  free_area_init+0x217/0x3d0
[    0.053290]  zone_sizes_init+0x5e/0x80
[    0.053682]  paging_init+0x27/0x30
[    0.054046]  setup_arch+0x307/0x3e0
[    0.054422]  start_kernel+0x59/0x390
[    0.054820]  x86_64_start_reservations+0x28/0x30
[    0.055307]  x86_64_start_kernel+0x70/0x80
[    0.055736]  common_startup_64+0x13b/0x140
[    0.056165]  </TASK>
[    0.056392] CR2: 0000000000000010
[    0.056737] ---[ end trace 0000000000000000 ]---
[    0.057218] RIP: 0010:__bitmap_set+0x2b/0x80
[    0.057667] Code: 0f 1e fa 55 48 89 e5 89 f1 89 f0 c1 e8 06 48 8d 04 c7 48 c7 c7 ff ff ff ff 48 d3 e7 41 89 f0 41 83 c8 c0 44 89 c6 01 d6 78 43 <48> 09 38 48 83 c0 08 83 fe 40 72 1a 41 8d 3c 10 83 c7 40 48 c7 00
[    0.059650] RSP: 0000:ffffffff96203df0 EFLAGS: 00010047
[    0.060218] RAX: 0000000000000010 RBX: 000000000000cc00 RCX: 0000000000000000
[    0.060985] RDX: 0000000000000040 RSI: 0000000000000000 RDI: ffffffffffffffff
[    0.061728] RBP: ffffffff96203df0 R08: 00000000ffffffc0 R09: ffffffff9626c950
[    0.062486] R10: 000000000002fffd R11: 0000000000000004 R12: 0000000000008000
[    0.063228] R13: 0000000000000000 R14: 000000000000003f R15: 000000000000009b
[    0.063968] FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
[    0.064812] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.065423] CR2: 0000000000000010 CR3: 00000004d123e000 CR4: 00000000000200b0
[    0.066175] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.066926] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.067678] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.068403] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

The panic above can be easily reproduced by the following steps,

1.  boot a VM with 20GiB physical memory (or larger) and kernel command
    line "kho=on kho_scratch=2m,256m,128m"
2.  echo 1 > /sys/kernel/debug/kho/out/finalize
3.  kexec to a new kernel

The current panic log above is confusing and it's hard to find the
root cause.

Add an error log to make it easier to debug such kind of panics.

Fixes: d59f43b57480 ("memblock: add support for scratch memory")
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 154f1d73b61f..ed886bfd3de7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1573,6 +1573,9 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		goto again;
 	}

+	if (flags & MEMBLOCK_KHO_SCRATCH)
+		pr_err_once("Could not allocate %pap bytes in KHO scratch\n", &size);
+
 	return 0;

 done:
--
2.49.0.1101.gccaa498523-goog

