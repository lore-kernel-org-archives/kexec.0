Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8FAD1D478
	for <kexec@archiver.kernel.org>; Thu,  8 Jan 2026 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9fTSUEElSptFXw5hcWOsyzyjnkoVvF+cCjmuU+D4lPc=; b=dsQgOt+7g3kcvHdpmsnM40DZ1R
	cu5WYt0+nJ56pdRTZpdmA/AurGv2KDKTE2cp4OQc2+nri+4Ef7zKXefE4s8QCPQNNBJfk+Y+OpXnW
	V/ebxg4Ourqq+L7M5mP0lFbTVX7iStbjcC0g/mwxHur8gmuBaZkH07P9t5Wja2BcT076Tc9cLV4QW
	rpnJAWyLy0ImyUd+ll0Nb+sFR159M5H9FXZLo+37HenK6k1ao9hpuDqb0VjPrGfBBzHu7ARkvOW8n
	AtB7QHGch+Eh1i3Vfbbef94jusWCGsUVamk9w8r8KuxkV3yWyxKdQ0NIP2LlXkKvrh885wKpAKbGC
	KjD977KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vduLw-00000000XyH-3fM3;
	Thu, 08 Jan 2026 18:03:20 +0000
Received: from mail-oa1-f47.google.com ([209.85.160.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vduLt-00000000Xwa-3CHy
	for kexec@lists.infradead.org;
	Thu, 08 Jan 2026 18:03:20 +0000
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3ece54945d9so1314902fac.0
        for <kexec@lists.infradead.org>; Thu, 08 Jan 2026 10:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895396; x=1768500196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fTSUEElSptFXw5hcWOsyzyjnkoVvF+cCjmuU+D4lPc=;
        b=V/ozO6u8engkjwTepfrgEzifbnT+1Hpz8mpWQZ0Z5hEhUO/BoeFOJKSEjfCNJDQEhj
         EkyRohHyYBsRB2w2Dw32pIUVaN1yv52aFL8OOjLt2X4ZMlsN92062TZknzhfJbsLVx14
         8ghidYFg/soHeHXQXvSeQ1Qx/v8Mc7NMHnYGJmoxk7hd7KmNUC7ptpc1AaEpFQp3xVtn
         eUv9JJMXiAt2K6fndM++er6Bctjns30s+kSQlis2ZzPWCjMYxWarKTOigbod6SHLIHCD
         r32IAydDSe1u5byo/wis/parBGyelzOiZ+g13NuIPntoqouIbmVIqtiype3/Kn74Hqy7
         SPLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHJI1YwVG379iErJjwtucuX3bzsqSv+CDphvaYKNFEJXq1j8G9Aw9s+T9J21pr3sUcpF/IUA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyp2bu2Wr3Hf7pOniFOsIdXWgZu/ZBskrkX/HAbFDtyPuFTYlvq
	Cf+3aD7ScvLtfpY+JaMrtGe3c7aAdi9bTZm3dB8ezKfSyaeXcTKPIy0w
X-Gm-Gg: AY/fxX7H/kS/PLTHHCMDqiKk3p372HDuerGQGRGYVfNAPYgYisWrUIm5jQ3diZENxcB
	cR8TmqQVrMPG6Fp6A4mWqbv/OqXMdXQaIeDaes59QgU2Bp6zF+QsjKXh9UtQYIXtdDpQ++3XPL8
	5pm6XPkcT2/vkKleC78RC+lZ6fWfZ6nsJZbVTfvImwLhzffMDqbBGX9L/vs3qHD2u7rZ9BzYz40
	Ccl/APAgglzc3iNUGl4odiNAoZ1vV2Wur8bDfnKECEddomFkhg37hmoDKKlvuwPrpK0TuEyjX4g
	HyYRtrc3ngx+lx/EyxCvdnRuwsQJcCdOPiIu04wExt3chwwq9iPtt5N6iaaHzUfnR9s9losXl/j
	XCgfwoUosYfHTuv21CBc8fEhRcqIHE4DxcSlz7uEsxU0WwtZ+i7DLDE8FIzGthMVhTF1nGEXzFc
	W7
X-Google-Smtp-Source: AGHT+IGB4UrTflumz8SI6ZENz32BgmOH5OCs08clFgtHXisIQW4hW+a27ip0KXG3pCc9DsjGk0gsGw==
X-Received: by 2002:a05:6870:7085:b0:3f5:4172:16 with SMTP id 586e51a60fabf-3ffc0c77c57mr3522771fac.59.1767895396170;
        Thu, 08 Jan 2026 10:03:16 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:3::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4e38b60sm5224549fac.6.2026.01.08.10.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:03:15 -0800 (PST)
Date: Thu, 8 Jan 2026 10:03:14 -0800
From: Breno Leitao <leitao@debian.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, rppt@kernel.org, graf@amazon.com, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	pratyush@kernel.org, ricardo.neri-calderon@linux.intel.com, kernel-team@meta.com
Subject: Re: [PATCH v4] kho: validate preserved memory map during population
Message-ID: <jixxiqeajngwox3nh2u3pwf2rivhmqxxmpyttqxu32pixshyde@4jdn5jvg5hvk>
References: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_100317_809562_6F2AACCE 
X-CRM114-Status: GOOD (  21.52  )
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

Hello Pasha,

On Tue, Dec 23, 2025 at 09:01:40AM -0500, Pasha Tatashin wrote:
> If the previous kernel enabled KHO but did not call kho_finalize()
> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> the 'preserved-memory-map' property in the FDT remains empty/zero.
> 
> Previously, kho_populate() would succeed regardless of the memory map's
> state, reserving the incoming scratch regions in memblock. However,
> kho_memory_init() would later fail to deserialize the empty map. By that
> time, the scratch regions were already registered, leading to partial
> initialization and subsequent list corruption (freeing scratch area
> twice) during kho_init().

While trying my new patchset [0] on top of this patch, I got the
following issue:

	[    0.000000] KHO: disabling KHO revival: -2

Trying to solve it, I come up with a change in kho_get_mem_map_phys() to
distinguish no memory and error, see the patch attached later.

This is what I used to test [0] on top of linux-next. Is this useful?

Link: https://lore.kernel.org/all/20260108-kho-v3-1-b1d6b7a89342@debian.org/ [0]

thanks
--breno

commit 5d7855fede8110d74942e1b67056ba589a1cb54a
Author: Breno Leitao <leitao@debian.org>
Date:   Thu Jan 8 07:44:08 2026 -0800

    kho: allow KHO to work when no memory is preserved
    
    Fix KHO initialization failing when no memory pages were preserved by
    the previous kernel.
    
    Commit eda79a683a0a ("kho: validate preserved memory map during
    population") introduced kho_get_mem_map_phys() which returns the physical
    address of the preserved memory map directly as its return value. The
    caller then validates it with:
    
        mem_map_phys = kho_get_mem_map_phys(fdt);
        if (!mem_map_phys) {
            err = -ENOENT;
            goto out;
        }
    
    This creates an ambiguity: physical address 0 is used both as an error
    indicator (property missing/malformed) and as a valid value (property
    exists with value 0, meaning no memory was preserved).
    
    "No memory preserved" is a legitimate state. KHO provides features beyond
    memory page preservation, such as previous kernel version tracking and
    kexec count tracking. When the previous kernel enables KHO but doesn't
    preserve any memory pages, it sets 'preserved-memory-map' to 0. This is
    semantically different from "KHO not initialized" - it means "KHO is
    active, there's just nothing in the memory map."
    
    Before eda79a683a0a, the code handled this gracefully in
    kho_mem_deserialize():
    
        chunk = mem ? phys_to_virt(mem) : NULL;
        if (!chunk)
            return false;  // No pages, but KHO could still work
    
    After eda79a683a0a, the early validation conflated "no property" with
    "property value is 0", causing KHO to be completely disabled in both
    cases.
    
    Fix this by changing kho_get_mem_map_phys() to return an error code and
    pass the physical address via pointer. This allows distinguishing between:
     - Property missing/malformed: return -ENOENT (KHO fails)
     - Property exists with value 0: return 0 (KHO succeeds, no memory to
       restore)
    
    Fixes: eda79a683a0a ("kho: validate preserved memory map during population")
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 271d90198a08..3cf2dc6840c9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -471,8 +471,8 @@ static void __init deserialize_bitmap(unsigned int order,
 	}
 }
 
-/* Returns physical address of the preserved memory map from FDT */
-static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
+/* Returns 0 on success and stores physical address in *phys_out */
+static int __init kho_get_mem_map_phys(const void *fdt, phys_addr_t *phys_out)
 {
 	const void *mem_ptr;
 	int len;
@@ -480,10 +480,11 @@ static phys_addr_t __init kho_get_mem_map_phys(const void *fdt)
 	mem_ptr = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
 	if (!mem_ptr || len != sizeof(u64)) {
 		pr_err("failed to get preserved memory bitmaps\n");
-		return 0;
+		return -ENOENT;
 	}
 
-	return get_unaligned((const u64 *)mem_ptr);
+	*phys_out = get_unaligned((const u64 *)mem_ptr);
+	return 0;
 }
 
 static void __init kho_mem_deserialize(struct khoser_mem_chunk *chunk)
@@ -1439,7 +1440,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 			 phys_addr_t scratch_phys, u64 scratch_len)
 {
 	struct kho_scratch *scratch = NULL;
-	phys_addr_t mem_map_phys;
+	phys_addr_t mem_map_phys = 0;
 	void *fdt = NULL;
 	int err = 0;
 	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
@@ -1466,11 +1467,9 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 		goto out;
 	}
 
-	mem_map_phys = kho_get_mem_map_phys(fdt);
-	if (!mem_map_phys) {
-		err = -ENOENT;
+	err = kho_get_mem_map_phys(fdt, &mem_map_phys);
+	if (err)
 		goto out;
-	}
 
 	scratch = early_memremap(scratch_phys, scratch_len);
 	if (!scratch) {






