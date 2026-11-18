Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D28606A32C
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QwbMddve;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=k+Nr5Ww+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9QrBc0w3KV6ChVNAVMzB1hWL9AMrXve7Stq4IEHc3B0=; b=QwbMddveO5hxEX
	RbAvik7eJIs94Hd7qnd9qbUBzq6oic6u3O0zaZ7nTIK/g/MOQT0hVN/itYdaE6QGNJg8gnBrV3uIa
	tPqEnBbXr6mP+Tb4N9JPnE8QcCTe4BtI4sgUUuQcr3oEcMz/NihJZbC4r++vqrYricyjsPTj03Nj3
	eCLmZkZ2BvHtU1a2ZAyvl8vkDHg8R0e+23um12b6h04PLrGOjwY4l+yx8dW5/nlWqueaTworcG96n
	nftcGcj1JlYHL/kskkYbCfjCbnL90zoPMxbU4ayjX3v9+Lclz9zAMD5+Fio5O87/z5OMh7uSVZfkJ
	5KjQ0ybs2qDqP913vZoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUU0-00000007S0R-3KDS;
	Wed, 18 Nov 2026 01:29:08 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTUTy-00000007Rzi-1NIV
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 01:29:07 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3b0b133f64fso39494a91.3
        for <kexec@lists.infradead.org>; Tue, 17 Nov 2026 17:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794965345; x=1795570145; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9QrBc0w3KV6ChVNAVMzB1hWL9AMrXve7Stq4IEHc3B0=;
        b=k+Nr5Ww+w3UAO6y+A6TqlAfyh0V61arEzmhMnmQO39AG7F/UJ25ZVQg1b6uRC0XZ2o
         ofdZ7xWQMi7d9HrVyovyj3MRyKuWJa7Mbs9p1h/Ps4DY2YCwhske7HrPZYm2YzNkm+g3
         LzCwqbFRbSl1FZirMICsHvcElihl0TSIL1s6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965345; x=1795570145;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9QrBc0w3KV6ChVNAVMzB1hWL9AMrXve7Stq4IEHc3B0=;
        b=XhEI2A3COwPuIPbX2pLp3GFapH3+aOh7BAQlTFdeuCI/Dy19/KVugYVlU1zOdt0uMZ
         sSglgzGrhjVDW74fErUcX6XRM95Gfdn9u9KetHOPebD74fcr3meJAVeWeNH0dl2YGYvj
         arzgfJ1xxu5EsEQ0qm0qRa47mHDLmsfYjXEEafpKcEFuybKA71DSpmrhP5VMfat9EyQV
         ZQGVUuFQA65fCt0VsM6y0pR7LLNkdGTFoInPieV8+ndhDl3d61Gumf8y+80mnEikk+M9
         oca5wc/C9s7tgLRtMI4nw+5/HwG36vDP96LrXIfUi3fpUERte6T5j2IUGx+yyxQLnlG4
         vKZw==
X-Forwarded-Encrypted: i=1; AL+hErFmyWURbhP/8TB0n4snr1umHdH1FIwNKMW+9bhYaSPfBhlUMqxfdglEM7ogodrhPHTBst3zOQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9YcN1iwA1sk2a+FQYJ10kW+VWpZWQAXWpqDkJ57kRMlS3PPedo
	Vau2IEoBaLPsn7DXtWTVXcJJRy8bX6/gaVpb6qGodT8ai3hU7fllNbiNWxTQVSSFAw==
X-Gm-Gg: AZFdTZeYRrU2zkq6z04vbpVNas0J1XClb85Uglz8Waxcj44I881S/u3RvDF1gj1iBrV
	x0KzR8nHUDyoURD/JwmQScS5ZZTGRILkx/Q9rHpzn+RbK55sYK3CB2X+xNb5QFFaAPKjjIe7XHU
	9OCzwy47zX/c2i8hJ82YItayg8ps5rYlBU6ZFXkIFywia5VvYHNW+c6qw/qVjWg/fG7hT1eEyhd
	X/sz0jc0Ph/Wgpl5mq5xo9fnx46NkDHyDs90YU1KFES2X2B79NcLNRXu8mv0lBi7lLH/3HZRSYI
	VCoW5SeddEfMQU7NbxSBIS/Sm1Lo1StF1XB1VNYvzkp1RfZr+yQhEh1j/HMnC1tWWxn1EuZTaqg
	8vNOpnrlDh/n5GEthn9Bkb3Vv9qP3D/RgUJGNSzNDRPgw20AtHSDwjIouiU266EjnklWrmyJO1m
	nov0JIQGrqDb66GU2gFcSOiXtWWmJgaYWsqKppj2OSTU9Hp+Km8n4oOjKjMKYWBbQB7sIs32EJM
	LA7C/RifJRK1f3hFyGYonQE0YKeydShT9MVLLtUAe8bPz2DaoSNXeG4fYQ4LptJQofA4AAjyQKJ
	PhiCXU9AJAPi7Wdd/bjg8u4L5vK9yXMAVfL6kqM4Tiak3jYC/j4vipL6p8Oc6zEBcb6vje0=
X-Received: by 2002:a17:90b:5390:b0:3ac:a11a:7c88 with SMTP id 98e67ed59e1d1-3b3d07af9f8mr1892178a91.3.1794965345247;
        Tue, 17 Nov 2026 17:29:05 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cde3b98c75bsm243073a12.10.2026.11.17.17.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 17:29:04 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>,
	Tomasz Figa <tfiga@chromium.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
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
Subject: Re: [PATCH v1 0/7] mm: kasan: skip KASAN for GFP_HIGHUSER
Date: Tue, 17 Nov 2026 17:28:58 -0800
Message-ID: <20261118012858.289236-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
In-Reply-To: <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com>
References: <20261116230627.3537051-1-jeffxu@chromium.org> <2066d131-f999-4747-beb8-520d5e0ce1db@kernel.org> <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_172906_404570_14F47361 
X-CRM114-Status: GOOD (  28.18  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 11:11 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> On Tue, Nov 17, 2026 at 7:10 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > I really don't want us to spread KASAN-related GFP flags in the kernel.
> >
> > There must be a proper way to abstract this.
> >
> > Why is GFP_HIGHUSER not sufficient? We were already told that this is memory to
> > be mapped into user space. Placing data structure on it and handing out pointers
> > to that would already be a bit questionable.
> >
> > So what are the ways to avoid GFP_HIGHUSER_KASAN?
>
> I think the idea behind GFP_HIGHUSER_KASAN is to make it possible to
> skip KASAN for GFP_HIGHUSER by default (for most of its users), but
> keep it for some of the users which today use GFP_HIGHUSER for their
> memory allocations, but could benefit from the added security. As per
> the other patches in the series:
>
>   pipe, fuse: use GFP_HIGHUSER_KASAN for pipe buffer pages
>   kexec: use GFP_HIGHUSER_KASAN for segment pages
>   net/rds: use GFP_HIGHUSER_KASAN for message pages
>
> That said, I'm not familiar with any of the code mentioned by those
> patches, so I can't really tell how much they would benefit from KASAN
> or if their choice of GFP_HIGHUSER to begin with is correct.

Thanks David and Tomasz for the feedback.

Tomasz is right about why I added GFP_HIGHUSER_KASAN in v1: out of
caution, I audited existing GFP_HIGHUSER callers to find any that never
map the pages to userspace and instead fill/drain them in the kernel via
kmap_local_page() (pipe, FUSE, kexec, rds). Since this series intends to
improve KASAN performance while preserving its security aspects, and the
performance impact on pipe/FUSE/kexec/rds was negligible in my testing,
v1 was optimized for minimum behavioral change.

Looking closer at both of your questions, I agree that the security
benefit of keeping those 4 under KASAN is minimal -- e.g., only linear
overflows out of the pipe/FUSE/kexec/rds page, since none of them store
kernel structures or pointers. That is the exact same trade-off we
already make for GFP_HIGHUSER_MOVABLE.

To avoid introducing GFP_HIGHUSER_KASAN, I see two options:

1) Simply keep those 4 cases under GFP_HIGHUSER (drop patches 1-4 and
   7), reducing the series to just the GFP_HIGHUSER change and its KUnit
   test.

2) Switch those 4 callers to GFP_USER. Since CONFIG_KASAN_HW_TAGS is
   64-bit arm64 only (!CONFIG_HIGHMEM), GFP_USER is identical to today's
   GFP_HIGHUSER on arm64 and all other 64-bit builds (and if 32-bit
   CONFIG_HIGHMEM=y builds still need ZONE_HIGHMEM, that could be gated
   on CONFIG_HIGHMEM, though that feels ugly at call sites).

(1) seems much cleaner to me. David, would (1) work for you?

Thanks,
Jeff

