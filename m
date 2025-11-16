Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFC2CEBF8A
	for <kexec@archiver.kernel.org>; Sun, 16 Nov 2025 06:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9b8IJSYXtBsPcOc3zz//VewvB+A/HFTZrZRLMW1CFbA=; b=UamfFiJzAqE993UB4vU3YvZizn
	NTay0IN6eENaYgoCR4AdjgDdkAruwOmMA9IXBdFJZ+qdTYrnUu17rEm1q2xacudRg3r7WQ9gepn15
	dcjRBn5aQoHJXzy49gEhSMvdyvyymA2nZCB72u8hfB7zgzjyZijKiBR18xpN0+hgNapR7T3c8LXPj
	9urW2nKMPFUJTpSL7irG2o85yNRE40pOQU5XYJrZNcjFO51NbjqQgG1g7vT8IF2Q8ZZq6sNYjEr0/
	xm+cAOyKP3IfugHo7veJgpLUixqkCYKsSkzkhmSoos2C0QjkQH/cK/ZkIk1iH0q3V3vdGOJMWop69
	pwk6jZjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKWa0-0000000EQ7s-1Ukd;
	Sun, 16 Nov 2025 06:49:44 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKWZy-0000000EQ7S-07rt
	for kexec@lists.infradead.org;
	Sun, 16 Nov 2025 06:49:43 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7aad4823079so2911732b3a.0
        for <kexec@lists.infradead.org>; Sat, 15 Nov 2025 22:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763275781; x=1763880581; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9b8IJSYXtBsPcOc3zz//VewvB+A/HFTZrZRLMW1CFbA=;
        b=N/IIyJeLQ8VI7dId0y49cmGcsOLcdKlhn0epz64Bi8XuBE1hoRMQyIXGQAt5CyPAAA
         kDLm7+77Z7snQcu/C24Tr/vh6urUpznBomjbEj/d793AiK1dXSGxDce1gi0S0JZqx/Om
         zG2n917DfbrlMLNEdvh+fMVp3YAwP16XUDVlcBn2ojcYJoYZgJNcNwTRPjOIpUnb6rwg
         m/AsEKMFPFn5KYlBLGO2AuyQ6zHFUeO2ZHP6gQ7ukg2kqSaXdazSnLmvEQcddfBGDQCr
         DwvPXtL6D4MX1yydCwUOq6rEMSImly81KC8PlCyQY0uGOHiLLb6ynjAocXjxwzrP96fE
         Q4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763275781; x=1763880581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9b8IJSYXtBsPcOc3zz//VewvB+A/HFTZrZRLMW1CFbA=;
        b=db5EqrQEwp9q/2AZ+yy00rTHH78W+Th20eR7VhGigGVPaCS5cvCmItTbOhgyLkvLO6
         Xk9EY8hoPJjElEXQH/rIsPEHfeKtZ87rjVJOqL1uYmvKxouwGP3n1HCdwYHmgbVeHXgY
         OKFGEZ3vSVVQj/LkPKMWAFQJdTqbsCfWPG9fMnGp9BmMoUeoxuHvw0FPBrEgopdobTBJ
         6/olm60stPrxw1/SFjNVRWEcyjz8erEctjjmDMChPSn5A7VIHjI3GVEQ6m4lBCgQJfrb
         AnGoM9B09xTJQFnva2RruzFGl80IS5df2i6Ph1ApVLGmBxVCzzNL8eWaBTZHE1K/BMnQ
         s83g==
X-Forwarded-Encrypted: i=1; AJvYcCXEiXgDyWGZlb3NuHr2K37WkdBvVEpAJBWJq5sDONjq2d9XCu9MIn61wfF44R3glJzebE+e6Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxqRxJMW9MadqipxH9WLmnx4yCt01vBAfOaUjcqMAfi0M3txX9k
	umDvqFFCD/seh4yOpsIIC2rfBQe4XJNEvN46dF4lwlX2w6zegSIUnskI
X-Gm-Gg: ASbGncuiEjte/WnqtNUAS9nwESsOKFqZKKAV7p0IpvkQT0uJYLJk0IG93XKO+mXn11d
	3DYC9klHysWP/p0C4IfU+7ig7azICsC6IJuFmLOmoa8IsOHVqRrpkyQselLsImb7/pZD6d3fFaC
	KhqyrTkxhFQFJDipumsrq5+f/f8x444VUAJhSvEwY72F7dgctSZLTH1MIH4uJRWqteuRJdoB1AQ
	DantUJyH92efJv69afH6Uh0yxYo3TahIBlYMEBNDA2LWeRFyVhEUW+GjpXYLpbZB7/7qroeGxVb
	Q4bnzDDeC5XKdO18tQmKpNuJ0idbA3EoXeAkON+p9YmbR86+GwKMOaFkdk547Rhdr18GhH/3gBg
	+2xxe8+jWY8yZX6VFzH7xars9uyUn6RTcrSmbVOAmTE7Xgu47e0jxuiTly8KxO77UBl2Ie500Dw
	==
X-Google-Smtp-Source: AGHT+IFouFg86tnbEJBbixUeQQEONClEEPNYmTk01w9DMsSZyQU+lHf3REEj3Dr3gbQQjBDIKCsHKw==
X-Received: by 2002:a05:6a21:4ec5:10b0:35e:e604:f787 with SMTP id adf61e73a8af0-35ee61484ccmr465968637.39.1763275780537;
        Sat, 15 Nov 2025 22:49:40 -0800 (PST)
Received: from localhost.localdomain ([2403:2c80:17::10:4006])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250d2d16sm9578369b3a.22.2025.11.15.22.49.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Nov 2025 22:49:40 -0800 (PST)
From: Lance Yang <ioworker0@gmail.com>
To: pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	bhe@redhat.com,
	coxu@redhat.com,
	dave@vasilevsky.ca,
	ebiggers@google.com,
	graf@amazon.com,
	jasonmiu@google.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rppt@kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v2 03/13] kho: Introduce high-level memory allocation API
Date: Sun, 16 Nov 2025 14:49:18 +0800
Message-ID: <20251116064918.35549-1-ioworker0@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251114190002.3311679-4-pasha.tatashin@soleen.com>
References: <20251114190002.3311679-4-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_224942_105904_349BC110 
X-CRM114-Status: GOOD (  21.14  )
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

From: Lance Yang <lance.yang@linux.dev>


On Fri, 14 Nov 2025 13:59:52 -0500, Pasha Tatashin wrote:
> Currently, clients of KHO must manually allocate memory (e.g., via
> alloc_pages), calculate the page order, and explicitly call
> kho_preserve_folio(). Similarly, cleanup requires separate calls to
> unpreserve and free the memory.
> 
> Introduce a high-level API to streamline this common pattern:
> 
> - kho_alloc_preserve(size): Allocates physically contiguous, zeroed
>   memory and immediately marks it for preservation.
> - kho_unpreserve_free(ptr): Unpreserves and frees the memory
>   in the current kernel.
> - kho_restore_free(ptr): Restores the struct page state of
>   preserved memory in the new kernel and immediately frees it to the
>   page allocator.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/kexec_handover.h     | 22 +++++---
>  kernel/liveupdate/kexec_handover.c | 87 ++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
> index 80ece4232617..38a9487a1a00 100644
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -2,8 +2,9 @@
>  #ifndef LINUX_KEXEC_HANDOVER_H
>  #define LINUX_KEXEC_HANDOVER_H
>  
> -#include <linux/types.h>
> +#include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/types.h>
>  
>  struct kho_scratch {
>  	phys_addr_t addr;
> @@ -48,6 +49,9 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages);
>  int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
>  int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
>  int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
> +void *kho_alloc_preserve(size_t size);
> +void kho_unpreserve_free(void *mem);
> +void kho_restore_free(void *mem);
>  struct folio *kho_restore_folio(phys_addr_t phys);
>  struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
>  void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
> @@ -101,6 +105,14 @@ static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
>  	return -EOPNOTSUPP;
>  }
>  
> +void *kho_alloc_preserve(size_t size)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +void kho_unpreserve_free(void *mem) { }
> +void kho_restore_free(void *mem) { }

The compile is unhapply here when CONFIG_KEXEC_HANDOVER is not set ...

```
ld: arch/x86/realmode/rm/video-mode.o: in function `kho_alloc_preserve':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: first defined here
ld: arch/x86/realmode/rm/video-mode.o: in function `kho_unpreserve_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: first defined here
ld: arch/x86/realmode/rm/video-mode.o: in function `kho_restore_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: first defined here
ld: arch/x86/realmode/rm/regs.o: in function `kho_alloc_preserve':
/home/runner/work/mm-test-robot/mm-test-robot/linux/arch/x86/realmode/rm/regs.c:102: multiple definition of `kho_alloc_preserve'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: first defined here
ld: arch/x86/realmode/rm/regs.o: in function `kho_unpreserve_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/arch/x86/realmode/rm/regs.c:104: multiple definition of `kho_unpreserve_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: first defined here
ld: arch/x86/realmode/rm/regs.o: in function `kho_restore_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/arch/x86/realmode/rm/regs.c:105: multiple definition of `kho_restore_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: first defined here
ld: arch/x86/realmode/rm/video-vga.o: in function `kho_alloc_preserve':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: first defined here
ld: arch/x86/realmode/rm/video-vga.o: in function `kho_unpreserve_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: first defined here
ld: arch/x86/realmode/rm/video-vga.o: in function `kho_restore_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: first defined here
ld: arch/x86/realmode/rm/video-vesa.o: in function `kho_alloc_preserve':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: first defined here
ld: arch/x86/realmode/rm/video-vesa.o: in function `kho_unpreserve_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: first defined here
ld: arch/x86/realmode/rm/video-vesa.o: in function `kho_restore_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: first defined here
ld: arch/x86/realmode/rm/video-bios.o: in function `kho_alloc_preserve':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: multiple definition of `kho_alloc_preserve'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:102: first defined here
ld: arch/x86/realmode/rm/video-bios.o: in function `kho_unpreserve_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: multiple definition of `kho_unpreserve_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:104: first defined here
ld: arch/x86/realmode/rm/video-bios.o: in function `kho_restore_free':
/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: multiple definition of `kho_restore_free'; arch/x86/realmode/rm/wakemain.o:/home/runner/work/mm-test-robot/mm-test-robot/linux/./include/linux/kexec_handover.h:105: first defined here
make[5]: *** [arch/x86/realmode/rm/Makefile:49: arch/x86/realmode/rm/realmode.elf] Error 1
make[4]: *** [arch/x86/realmode/Makefile:22: arch/x86/realmode/rm/realmode.bin] Error 2
make[3]: *** [scripts/Makefile.build:556: arch/x86/realmode] Error 2
```

Perhaps these stubs should be declared as static inline? That should make
the compiler happy and resolve the linking errors :)

----8<----
diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 6dd0dcdf0ec1..5f7b9de97e8d 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -96,13 +96,13 @@ static inline int kho_preserve_vmalloc(void *ptr,

 static inline void kho_unpreserve_vmalloc(struct kho_vmalloc *preservation) { }

-void *kho_alloc_preserve(size_t size)
+static inline void *kho_alloc_preserve(size_t size)
 {
        return ERR_PTR(-EOPNOTSUPP);
 }

-void kho_unpreserve_free(void *mem) { }
-void kho_restore_free(void *mem) { }
+static inline void kho_unpreserve_free(void *mem) { }
+static inline void kho_restore_free(void *mem) { }

 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
---

[...]

Cheers,
Lance

