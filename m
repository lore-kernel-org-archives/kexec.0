Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3F606A894
	for <kexec@archiver.kernel.org>; Mon, 16 Nov 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I81Ue4Et;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PnNhKLCb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jGcgw87oL+/aayCG1LZRiyRs5ahRDiLzP62eRx4RAEM=; b=I81Ue4EtUsshhe
	GQlkzxQGuCRxAo0/tuAVf0gXGSuwB58dYyEB/Ng9gWU4FWTohRgIKLoB2yISF76DnagWI033eubas
	JJIJRCJTuyG7Ob4/l1ma8VYtAWAhjrTF/9SShNyDTJC9YnFL6wEC90Q9dRqjIv+qG6Cs+Xv56zNnv
	zz6L89C2urUuySdxJFyXYzWuK1X+RiFGUa3wzdPFtZnaiuFsM1wGUjZx8E0AUk9AKCzGCUFcYVe0i
	at8jh3vKeiMV8vSLW5u8gbscQgEhobZhV4R/jAda83wgBNbw/sZYEXJ7Bo8BzPb7fuAq9s4OaTV8F
	GIYKjjQiQXVbc5vthHKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5mn-000000046bF-0R1a;
	Mon, 16 Nov 2026 23:06:53 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xT5mi-000000046Yf-3gbM
	for kexec@lists.infradead.org;
	Mon, 16 Nov 2026 23:06:51 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-cdda6625e2aso221897a12.1
        for <kexec@lists.infradead.org>; Mon, 16 Nov 2026 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870408; x=1795475208; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jGcgw87oL+/aayCG1LZRiyRs5ahRDiLzP62eRx4RAEM=;
        b=PnNhKLCbQDfb0gEYfDo4KAaZwmwggQaTISy9nPdeU+8XBi8Khk2bG+SkcCK+5vZsaZ
         dsr+rUAVmKKMHNksDFgEgomn+SuG6ViuWEnQvFCL4aVXBFlJfIAomY9jL4sLnIS34el2
         2Q4wJysKDM7JhpCcXUjm6J2GmdE/Zu9jgKzz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870408; x=1795475208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jGcgw87oL+/aayCG1LZRiyRs5ahRDiLzP62eRx4RAEM=;
        b=mejeo6bJppzzRmXZ9ywjDnWj/uhj5nVDuljwCjYHr8IrrhJeFR6c0iJR8HkX/TQPe3
         QVLzeN27NgG62v+499RRXmsHD/HuxD2nyan1w6gRUgf7ebW51JavyRhiWrz13RMcaI1t
         XDqq/slIUx1lxRWCQ1EyZy6qg3xY38RKm+ihGthbBl6/VnOl95mKe5zq0MHULqIQuo5c
         mgHPXaBnyrZn/njBxKmuS9jdFKCEqiZ7fAh1lHfhSx1j6GcjOcrmpL2pJ+D2VpbK6Dsn
         Il7l25oawAeTjza6ToaiB1CKM7hAtFpmh5c7E24mZz5X2lg8tWGmYeW7hCGx2q0X2gxX
         Ivtg==
X-Forwarded-Encrypted: i=1; AL+hErEa+ggOJ7keZ431XAW6HAyY93fpD/jPXn+ZE5CftPEOE+EVIh51qnUoyrS87H1NvZ6ezJk7Zg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/No0SjnUQvNCGILTxGl4+kOV/eQRDhSHkj3sB82oh+DOcG7uCX
	U0KGmqYUCVgEYbTb2rR2cOUiUjr8sBo+xflUOFi/FTPPUeCzkylg5Basy49EjxU7Jg==
X-Gm-Gg: AZFdTZdSuPJ7tPiX7sfJlroCWaJJNj0mcAfGz+AmjqooHBZloXQ56A6mgl5job/ixtf
	Y1cgWekvIuT1PML6EprVcjmDNcPCN0nbD+CJ94ElwY7xRRyMRo38Oo7vBzK3QBFZL/nUgdUvysm
	OcrBUe7ekkuzqQrjFpkvdP0oHhVX9IFYlyj7iA//3t7WTmP0w0HVweQ+U02c1+XV6TWfrUTDwM0
	ILzSAhmt8jqVQAYOVTlQ9lrmCzVRCqQBb6tVXGdq/w/se8F46LxG59EYxpzOQlKOLq64yPPcm25
	yEjDNr1YHS7onWPmaGoTsFo6tfXrCsfIv/EM4K7l4PCPTkWny8+MjvbBQGRSn3957VqBZ2hB4Kj
	RLc+aHUKA7F2TMTf8MQ9PNYBZGv9lEDCBGZvyWzq8nxEvYV55P8ItzaTk3VtQoZD0KqV1yfIicS
	yWoBsQZIqr9nNWiobEjFPF1+6YKFotyhLpIOB76oPE/cUaoKbwoKTcnuT03YciiQNXVspSdHb7P
	oCxk8AvJ86UM22OVh+y3Di5j8n1Jvzhzem6YtwIXLqsg6THwcQdDTnxgSFwP2MNzrAjkuFK5IYZ
	UgwGc/TYtYaNdZH7V9a68QfpgPWpPON6m3ejNSUiGknH5+/JBGI5JOwJL4EVWFlM/6DWbPw=
X-Received: by 2002:a17:90a:9f98:b0:3b3:b15f:eb89 with SMTP id 98e67ed59e1d1-3b3b15feeb1mr321766a91.1.1794870408006;
        Mon, 16 Nov 2026 15:06:48 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3ab9f3c5dsm1108222a91.0.2026.11.16.15.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:47 -0800 (PST)
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
Subject: [PATCH v1 1/7] mm: add GFP_HIGHUSER_KASAN
Date: Mon, 16 Nov 2026 15:06:21 -0800
Message-ID: <20261116230627.3537051-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_150649_691260_636C979B 
X-CRM114-Status: GOOD (  18.68  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A later patch in this series adds __GFP_SKIP_KASAN to GFP_HIGHUSER, so
that with CONFIG_KASAN_HW_TAGS its pages are neither tagged on
allocation nor poisoned on free. That suits pages whose contents belong
to userspace and are mapped there.

Some GFP_HIGHUSER users allocate buffers that the kernel itself fills
and drains through kmap_local_page(), such as pipe buffers. While such
pages are tagged, KASAN can report a linear overflow out of the page
and an access to it while it is free.

Add GFP_HIGHUSER_KASAN for these users, so that they can be converted
before GFP_HIGHUSER changes. It has the value GFP_HIGHUSER has today
and will not gain __GFP_SKIP_KASAN. The two stay identical without
CONFIG_KASAN_HW_TAGS, where __GFP_SKIP_KASAN is 0.

GFP_HIGHUSER_KASAN must not be used for memory that userspace can map
with PROT_MTE (anonymous, shmem and hugetlb pages). Userspace sets the
memory tags of such a page, while the kernel keeps accessing it through
page_address() with the KASAN tag from page->flags. The two do not
match, and kernel accesses are reported as KASAN faults. arm64 does not
reset the tag in page->flags when the page is mapped; it relies on the
page having been allocated with __GFP_SKIP_KASAN. Nothing checks for
misuse at allocation or mapping time.

No functional change. The kernel-doc describes GFP_HIGHUSER as it will
be once it skips KASAN tagging.

Assisted-by: LLM
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 include/linux/gfp_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index c1331bf0b239..567c93fc1cfb 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -356,6 +356,16 @@ enum {
  * move once in use. An example may be a hardware allocation that maps
  * data directly into userspace but has no addressing limitations.
  *
+ * %GFP_HIGHUSER_KASAN is %GFP_HIGHUSER for pages that the kernel itself reads
+ * and writes, such as pipe buffers. Unlike %GFP_HIGHUSER it does not skip
+ * KASAN tagging: with CONFIG_KASAN_HW_TAGS the pages get a KASAN tag, which
+ * page_address() and kmap_local_page() return in the pointer. It must not be
+ * used for memory that userspace can map with PROT_MTE (anonymous, shmem and
+ * hugetlb pages). Userspace sets the memory tags of such a page, so the
+ * kernel's tagged pointer no longer matches them and kernel accesses to the
+ * page are reported as KASAN faults. Nothing checks for this at allocation
+ * or mapping time; those reports are the only sign of misuse.
+ *
  * %GFP_HIGHUSER_MOVABLE is for userspace allocations that the kernel does not
  * need direct access to but can use kmap() when access is required. They
  * are expected to be movable via page reclaim or page migration. Typically,
@@ -377,6 +387,7 @@ enum {
 #define GFP_DMA		__GFP_DMA
 #define GFP_DMA32	__GFP_DMA32
 #define GFP_HIGHUSER	(GFP_USER | __GFP_HIGHMEM)
+#define GFP_HIGHUSER_KASAN	(GFP_USER | __GFP_HIGHMEM)
 #define GFP_HIGHUSER_MOVABLE	(GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)

base-commit: 4b028d0cedf95f66b8c5294fde2d7d698bf830da
-- 
2.56.0.611.g1030f0b940-goog


