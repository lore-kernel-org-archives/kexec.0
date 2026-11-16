Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CE560A5BE6
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cpUh/Hv8;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UQGMxyc1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AjhVL/tzJIhPQa9pnWiA/Lzn5A7WcpHhkbmWbBd9Z/A=; b=cpUh/Hv8bW8Raj
	j1D8FNXyS0ZTQ+CbvQf9NQYiPH/yMqtCCU4wr+oL5WZlnHpn/vbcGinL6MG9lkIX2kOja4/xz3MbL
	ujHo1U71ad6eGHfjCeeHMav8/Zm9f2/E8zkpygQ+mnopMiH4bHD5wt/a7XE0Tg1dZQARytNUl3I15
	jrrYr9DnYeAJKiKZB/7a9kUhipO7GO1WJuVB9rohBSF9fawjHXQzT8nk2JC1ZwfrledKRoNw8ssbz
	J+gXq3cjJ8Z/p88t4ZIhjbGKW3uz7g98Bd7caWjIsNTc5I7eU9eEncOH2V4sWhbx/VZvcKjEplI7R
	/+5sYP+FRGFSLYy24pug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5my-000000046nI-3xTA;
	Mon, 16 Nov 2026 23:07:04 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5mo-000000046c7-0oMB
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:06:56 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3ac847f9d78so469188a91.1
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 15:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870413; x=1795475213; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AjhVL/tzJIhPQa9pnWiA/Lzn5A7WcpHhkbmWbBd9Z/A=;
        b=UQGMxyc16gPcVXUc93CIEm/Qf7tN+zsu+z1MSQE7DzXQ7XiCTtwY/hiQETL6hvfQk7
         ALq1gADFxJPhqbcBus5Icx4ozZcSh4xgTzMSpTAjc1AoRvlwiffQ6iIt+owEVLYOPgZ8
         J3DIEDCDag59jmM8j6d1JWgbafYW7gmVDBib0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870413; x=1795475213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AjhVL/tzJIhPQa9pnWiA/Lzn5A7WcpHhkbmWbBd9Z/A=;
        b=LB4qEtg2w77ybyXim79zc81OCiPopBAvQxRX/Y+vrLwuztLhlMmvYQDCO936t6iWgv
         8QRR7iyB0WZ5XgLmRHMIkm1pHt3eGi0JaO/8LDLXaBZjlwY3e2j5/miiC3ws0ZENG9ev
         bvUNRZW1yZhC+nW0smB8UovAR/JV+sQ8ArXWSB3rtakNg1KuV7vfURbGwAbDXfMY1oMa
         vsj8R+2fS6RWZyIehYcEE/G7TGIj97z7BIYbSNbIqHny5unM9HmNhh1rtlNJp4Vkxxur
         DiwTUFlaE+BBdNqwgIDacUOuE/C4FP8VPJfcD8ppakK01fzfx66ioqXXeE3Mznnd9q8m
         p35A==
X-Forwarded-Encrypted: i=1; AL+hErGPw8sqbPnQWrjlDONeQoJenIJjytzKpauK8vn9PQ3P/jcHHV+0YVI8kaJZ3TJuVAVBmazJ5A==@lists.infradead.org
X-Gm-Message-State: APuU4Z/3nw/bFABzFiCvx/tvR93pUppeayX0pkgYBIXeWSndMWNeh1Te
	Z24Ieccfk6bzfKoXuv2AD2dBx25F2RYbLZPH9lbS5rX2kkJSIPWtjn1N+7+tsRsnYw==
X-Gm-Gg: AZFdTZcH6Ek16K2akbP4LLonXOj3q0KM24yW+YFfJuSnqIpOsHTFJGP7Eb5D5xmS5TG
	sg1ayP8o2Rl11eM4nnDqlQgtiBzaX6NrAU7ZYy60vq0PXb5qN4rWM40cSLlqkq/nr+ucxAILUP8
	ar6fJtvoyampsV3SKvks1+6HNsMo2tDWiPqSG+oVo59ebw7pRkuLT1fUAoPV5yzn9T7qVUv5VG6
	yiOCVCo7wf5JOsmEZTOJoZ6NgLGZzbb+SalM5Tt7an4xK+mmimhtcoPnh7k83r3A7QZyVg1G2jx
	l0jgeHUG5r9EyDINBsu5OhLqtmXZ1fFgEagEDIr3P9phkPVUWiOL21SncECziKkBIi6XXLLvsjP
	FDPQzOUEhdYVvxwbXZssUJTsqvLFwvcKz3y/caPdglX3B54C5O7sUN7z0hG9DE4vufLSCX7OHhH
	BQt7pTgoge/2akum406bd2uQXlbl4L/OP0R/VHSvFKgzcnO37N5DDJ8fxIRm6j00NPxcGse2GJQ
	9XdUb6dfDH1sC0V5HHDi2Yc64YQ9WS+YB5QtP8Pm8aGaeTWB9YpoNkhOcdx7sGasSsUgp9iQyN9
	//y1PSYwDGQM4DZHulXpRHu/U+NCy7fP7pmVtvU7cMH0GauReq0Cq6yM61o5l6tFqqJ58nQ=
X-Received: by 2002:a17:90a:9f98:b0:3b3:b15f:eb89 with SMTP id 98e67ed59e1d1-3b3b15feeb1mr322004a91.1.1794870413060;
        Mon, 16 Nov 2026 15:06:53 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3abe8b263sm1120450a91.13.2026.11.16.15.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:52 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/7] kexec: use GFP_HIGHUSER_KASAN for segment pages
Date: Mon, 16 Nov 2026 15:06:23 -0800
Message-ID: <20261116230627.3537051-4-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_150654_247286_5CA87319 
X-CRM114-Status: GOOD (  13.82  )
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

kimage_load_normal_segment() allocates the pages that hold the segments
of the next kernel. The kernel clears and fills them through
kmap_local_page(), and they are never mapped into userspace.

Allocate them with GFP_HIGHUSER_KASAN, so that they keep their KASAN
tagging when GFP_HIGHUSER starts to skip it later in this series.

No functional change: GFP_HIGHUSER_KASAN has the same value as
GFP_HIGHUSER at this point. Build tested only.

Assisted-by: LLM
Cc: Baoquan He <baoquan.he@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>
Cc: kexec@lists.infradead.org
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index f4a31565c447..a3abbb6a2d75 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -839,7 +839,7 @@ static int kimage_load_normal_segment(struct kimage *image, int idx)
 		char *ptr;
 		size_t uchunk, mchunk;
 
-		page = kimage_alloc_page(image, GFP_HIGHUSER, maddr);
+		page = kimage_alloc_page(image, GFP_HIGHUSER_KASAN, maddr);
 		if (!page) {
 			result  = -ENOMEM;
 			goto out;
-- 
2.56.0.611.g1030f0b940-goog


