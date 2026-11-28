Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DF606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=RYKDHyOG;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=qeCgYRoi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:Cc
	:To:Subject:From:References:In-Reply-To:Message-ID:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yf5lFWivuM3/XS9YOi7vjzstZ6D4tWxpwOXiC4SyrQ0=; b=RYKDHyOGlQvTdYmNxsiusv3Pcf
	1W8nl3FsVao3QGB0P5jyvQ9bYg6JU+HlG9XbR0lon82ZWpMXAu85KiLI7IVGQfw6piX9eNwuVahXg
	twyWhGfrN1A+6bmIdvFFKsG50wM8bwy4Ug6e8/LXn278kBMDrOwTNhNzUhihneaQKJdlflj7MG1NX
	LdIXPDAWCqNTMUVT3fPPoY0kdS77VkNeoJrSMMTSZlu2UIV0flWIqisnd6M+ZA7OladPTZfftZ/eG
	Be9zXGA+t8MQAaAE3FKtXimNXUq32agbwrE7Y5hw3qxbIYNcoOsAA8mz+5Cs/M0gesyCHxXaUYYme
	5/a8PxpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEdB-00000000Zd9-2uxY;
	Sat, 28 Nov 2026 09:22:05 +0000
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXEd0-00000000Za9-0SXK
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 09:21:58 +0000
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-8b502b9b702so101499467b3.3
        for <kexec@lists.infradead.org>; Sat, 28 Nov 2026 01:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1795857713; x=1796462513; darn=lists.infradead.org;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yf5lFWivuM3/XS9YOi7vjzstZ6D4tWxpwOXiC4SyrQ0=;
        b=qeCgYRoiOTe/8CT0by3+x0JniRNsw0JzW0R8pN//hXiwMNqa9ec2poasm5SedIAo9g
         ZfRR6cf3pM+pDaZ+hR3NFmS+km8a/I59pM6BdMbSb6jsdQZjVHZr1M6I7SetTTv0ekd+
         n99/p0R2yErwHw4xHFFicYEbo5HXYZ4VWAFyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795857713; x=1796462513;
        h=user-agent:content-disposition:content-type:mime-version:cc:to
         :subject:from:references:in-reply-to:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yf5lFWivuM3/XS9YOi7vjzstZ6D4tWxpwOXiC4SyrQ0=;
        b=fqJ+VxFW9dtZ0Y3IVq6+yqMLtllCyH6OXAy4cXNTWYSTxoUiYbrsH2cPkqvzNzPN3d
         1Cquf2Y5tnjTQ+lzwJiok8tm/gRI86AjDhtXxV+FcMOH15CRc9d0+QtufwlK5sYWLc2s
         03VoZfhPIn/e5+Uuhx7ylqSv5C+mj+f+cGs3weNYi51OzuVTVPlZyrGAVYZUx0Dfd3ih
         P6OjfXJNmloP1fXHNT5HFnaA3i1ZMwrthQkqWkmvPMzTEfpkxmXCe3k5oQO2p6fO1rAA
         XOsZ8plo4JCfbJ7pibaY5WWlN1yrWod6wnP1zt0XxtFftWAdMgi/dfLeTsrF7vT3aGxu
         bKfg==
X-Forwarded-Encrypted: i=1; AL+hErHzSw+nEdOpvAE4PiNRSPDfM6jNSUjuSmMNtI4YaBrWrVjw+udfJf4AefuEGwydrr2OiZezqg==@lists.infradead.org
X-Gm-Message-State: APuU4Z+/Germ6k2Nv44F7B+Z3a0jwhGVz8gA2pkgzzWQcd+wCW+rWLfr
	hQPpPX5gKCbcDQzg/tepLL3wAE6ZIJWgeDl6a8PCyteJMrktuyPfTPQ7lN6jof+znII=
X-Gm-Gg: AZFdTZe8FiGb4uskMcShXbKrYDgvi/2ildIs5BM7Epe6NFVpOnN0YORBsIj94MtOAtx
	XAJnx26C/4po9gqXf5cllR/3RcylZSSM2ObrX8J97c0PRXy2h5A81tvjh5NEsJcMjEFpdRa8KDp
	CE0C52qHuV1RhkHa2WlNN4q9N5nv49IiWI8gr32k0fprckquLQvTebCXC/lPw7QJKQT2ysndw6s
	ZzaTSRr/RrZvonqZ0D92CLasDpSIO21+YFN7ZEr0MCQCbJlqblehjAuDjhGkXi56EGVc9LDjTCW
	MnXofIZZcabv9byy62zL3LXfl4CSwO6TbJKiIaP1NZjA+soErojdK5wW/4ScH7Y20QcpHcsILsd
	/iqCAHMnhinjECuJ9o6fcD9RQx0Ka0S/qOy+rWB2kitRipfxStjTj6gol6+zmLuC/cXYikuR3bY
	23FHFvJUfkhLlwgu5byMOWRODz0hOiZvYrhWwSMXZkECoHeFYF1HMFhqJkTJYHRo/GtFWEkAMB8
	O/c44luuo5NWeL3NBU8ZQfAakC3UnKT4aztVbSGsGpg4DYF2k9j2dn3tl5e/7FgrgEiOkOjmnCI
	iwtyZl2bm1R7hQ+3aLjeOuYxBk2lowAA0k+IH7Wk6RTjN3s3TtnU8M72bErPubddZZb76rZNyC7
	WuzDxOvoly1FVW3GYcXgGQg2I1UCOmSSYRiVEzEa0X5mEseCz71cOhC+RxZCOhs434Ztm1UDtwp
	s8Se2SO9P0Txf7NyVo8YngFsAWcSyXCjCIqq5G12/azmICRIlpBi+dL7HOnwt9wyM742Jqin8zR
	+UY87pxOPs9T7Vw3PsYkWo=
X-Received: by 2002:a05:690c:7486:b0:8b4:d84d:cb9c with SMTP id 00721157ae682-8b520519ae1mr103219017b3.66.1795857712909;
        Sat, 28 Nov 2026 01:21:52 -0800 (PST)
Received: from [172.20.0.3] (c-73-207-185-9.hsd1.ga.comcast.net. [73.207.185.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520309d3esm104901847b3.30.2026.11.28.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 01:21:51 -0800 (PST)
Date: Sat, 28 Nov 2026 01:21:49 -0800
Message-ID: <c9c7b0465b1b27312eaa170692836dd30541bba0.1795835884.git.chris@chrisdown.name>
In-Reply-To: <cover.1795835884.git.chris@chrisdown.name>
References: <cover.1795835884.git.chris@chrisdown.name>
From: Chris Down <chris@chrisdown.name>
Subject: [PATCH v2 1/2] kho: don't release incoming bootmem areas when
 kho_init() fails
To: rppt@kernel.org,
    pasha.tatashin@soleen.com,
    pratyush@kernel.org
Cc: graf@amazon.com,
    kexec@lists.infradead.org,
    linux-mm@kvack.org,
    linux-kernel@vger.kernel.org,
    kernel-team@meta.com
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261128_012154_264905_E09BCDA9 
X-CRM114-Status: GOOD (  16.36  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On a non-KHO boot, kho_reserve_bootmem() reserves the bootmem areas in
memblock, and they stay reserved until kho_init() releases them as CMA.

On a KHO boot, the bootmem areas are inherited from the previous kernel.
kexec loads the new kernel into them. kho_populate() adds them to
memblock as free memory, because early allocations are made from them.
Whatever is still free afterwards goes to the buddy allocator like any
other memory.

Unfortunately however, if kho_init() fails, err_free_bootmem currently
frees every area with free_reserved_area() on both kinds of boot. On a
KHO boot this frees pages that are still in use, the kernel image among
them, and frees buddy pages a second time.

With CONFIG_KEXEC_HANDOVER_DEBUGFS=y, kho_init() fails if debugfs is
disabled, so a KHO kexec into a kernel with debugfs=off added to its
command line is enough to hit this. In a VM, the new kernel then oopses
in kho_init() and panics.

    BUG: kernel NULL pointer dereference, address: 0000000000000008
    RIP: 0010:free_pcppages_bulk+0x10f/0x280
    Call Trace:
     free_frozen_page_commit+0x1fa/0x430
     __free_frozen_pages+0x205/0x600
     __free_reserved_area+0x7b/0x120
     free_reserved_area+0x89/0xe0
     kho_init+0x301/0x3e0
     do_one_initcall+0x89/0x260
     kernel_init_freeable+0x1e0/0x250
     kernel_init+0x1f/0x140
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

To fix this, let's only free the areas when this isn't a KHO boot,
because that's when kho_reserve_bootmem() reserved them.

With this applied, kho_init() still fails after the same kexec, but the
kernel boots and the bootmem areas are left alone. A non-KHO boot with
debugfs=off still frees the areas it reserved.

Fixes: c609c144b0e8 ("kexec: add KHO parsing support")
Cc: <stable@vger.kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 kernel/liveupdate/kexec_handover.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 42c6609a1766..663dd22e7172 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1899,11 +1899,13 @@ err_free_kho_radix_tree:
 	kho_radix_destroy_tree(tree);
 err_free_bootmem:
 	kho_out.fdt = NULL;
-	for (int i = 0; i < kho_bootmem_cnt; i++) {
-		void *start = __va(kho_bootmem[i].addr);
-		void *end = start + kho_bootmem[i].size;
+	if (!is_kho_boot()) {
+		for (int i = 0; i < kho_bootmem_cnt; i++) {
+			void *start = __va(kho_bootmem[i].addr);
+			void *end = start + kho_bootmem[i].size;
 
-		free_reserved_area(start, end, -1, "");
+			free_reserved_area(start, end, -1, "");
+		}
 	}
 	kho_enable = false;
 	return err;
-- 
2.56.1


