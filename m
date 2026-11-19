Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25314606A325
	for <kexec@archiver.kernel.org>; Thu, 19 Nov 2026 02:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oKPCIiEc;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F0ZZMP8D
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kC+uhz3Afjp9Cqz8zh23wNboDVMQQa75pZ1niNRa9cE=; b=oKPCIiEcitJjDi
	6PpON/OM9/vguVaz1fBnaUm6fioc8qhPHlGXnt99jIC7MFOCH1BdL9Gxv5bZOo4dMHeQdpUr3frtC
	uneQ2fPsi6TC1RGeP1TXbAXne+Yp0L7J28sKd5tmHJ3TzYhl22wnie1dsSXw6GAt20pv3GCHmPz4/
	XR8Dqt79iLreA+SiU2c+T2/uukTEd390XQ4ALxj5sUaL9Iyh0qnkiCD+nZA+2ADoK1MpJ3nCDr3FT
	rE/AW0IinJJSbv7oB2Sj78ef/xcKRP0AZvL5Pps+gxD0qR4INZQc2qwrZDG5IJFzIMrbzYo25QjzD
	k8sLWlheslXjWK6nwazw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTrWE-0000000AfZ3-2wAi;
	Thu, 19 Nov 2026 02:04:58 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTrWA-0000000AfYH-48BI
	for kexec@lists.infradead.org;
	Thu, 19 Nov 2026 02:04:56 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-3b1bb072438so144419a91.1
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 18:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795053893; x=1795658693; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kC+uhz3Afjp9Cqz8zh23wNboDVMQQa75pZ1niNRa9cE=;
        b=F0ZZMP8DAK0DaHoQ68+b4pnrcLVqpDiqbhrsEjKtgERh4qM7RkZuAPz4xySNY8Wpj4
         SPo4ZMY0J7fjDtCBoxV1ZG+gs62HzkEoxBsjtBKPqcHdOZ4m0P18nwB2c4UFe2HvfrLp
         3zVL+qsu5YKLWDyYGjuNZinXDTE0BE9jzpJjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795053893; x=1795658693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kC+uhz3Afjp9Cqz8zh23wNboDVMQQa75pZ1niNRa9cE=;
        b=pwbDblHcJix3rIEmLHV7Hw9ovFuVfyZiaNroKt9dFVAKDrvqfKRxYvukdqx2sAQ61Y
         sEs+7p6Jn9pcW+bN+L+Yun8w3ix8sjmu9IpeKKpZl+kWev66dfYEKixmXzf/S1CRAFRp
         fII6nUln55LI5va+eSbJw+AB/VhwhDgAVuZRSPTAXs6Xh3jkNhQswYdne4ULZc9vQp5Z
         dq4WufCt56pYEdet0UEMfFfFltlY1pzGMNycCpJXtFw1bFTQDGMH8Q/7Z+mfe3jmMC+r
         j62Bz6s+D8d7HAF9gbl+K6TDvGPfoC6AWrAXhDHzxFu2IZj9v8uNUey8kR+FYd7Bbiqt
         AgPA==
X-Forwarded-Encrypted: i=1; AL+hErHvFZARVhRSED6LxkM0rmK1lJNKPhHT5P0gSg6YuLmrtYZOuHsS0CQwKuq95WOjLoTtb8ua7w==@lists.infradead.org
X-Gm-Message-State: APuU4Z8Sr0hEhWDoAmzKusWrV8sB33SgLVcHtXStw3m7BUwg0KJ3e1zq
	5o1ozi1BUKzV6iERI8ku7pVysijMhVm3ysgtgO4tpbsdm2FaluqfGlGXMLC/g5CLJQ==
X-Gm-Gg: AZFdTZcxc4yu0PdRuhs6ACR2AMS6KcCGrTNKk9Fd/g6D8EHsE15k1XoTgGHiEUtF5Lc
	O/Bp2AxZvElrfVNxTH3hGVsBYHqovN0/VrJLQBuSoTSegSc2oqHOYha9Qt6Vxq+GwtNNikBzVMu
	v5kVnc3zAk5O31cX7hjej2sWRL/rys0kUxQH9E8TxvrJNu3JweosiXimM/4DGuhU64erLgIRRSQ
	yWJra6xZOGTwGYLWWURDxKd/5vcVGbg7iHceB5wOaj2frn0ig/js9tnx1r4HPbjT6G9PA8IcfRr
	L3U6YEEdchiOnsUivJxPcATQvimcMaFLVXg6rQfworfP/iZNXhTb7o2B+b3Xri0QUSAJoD5MKgT
	39RNlOJF1lB/ecL9EUfluVSbhu4Yjg/XC2v7j0oC8DTWfI1g6AFJAPEFf5lTJMYmNNT9hh4yVZv
	7MHHIEg3DOgM5QoOXDX13xLg2x0Sxw3Em31AlCi+nh7CrDf/MNDnR2+Siylkk+wqvCuk92HBUGD
	+vb1zIBiQ46ut7lyLpIG7341J0YCQ4/39V6amqVjlKRsO5GURz/0ImNW+Gw0DDxb9GrtPLUelsB
	LXzTcrV2cVHxthQPevmgLrSVvAwyeT4gQdLW8g0UNJZvG7pBWmaTvxGsOYJpkaCKsfFegw==
X-Received: by 2002:a17:90b:2805:b0:3b3:c92e:f523 with SMTP id 98e67ed59e1d1-3b3d0764320mr7560562a91.3.1795053893354;
        Wed, 18 Nov 2026 18:04:53 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3fe0e5bd4sm772079a91.17.2026.11.18.18.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 18:04:52 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: David Hildenbrand <david@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>,
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
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?utf-8?q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
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
Date: Wed, 18 Nov 2026 18:04:45 -0800
Message-ID: <20261119020445.1096831-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <332f315d-ea27-488a-9a3c-28cdfdcd5f27@kernel.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org> <2066d131-f999-4747-beb8-520d5e0ce1db@kernel.org> <CAAFQd5DzTmyeVQxNdhdy8pPi+ts1cCgbztVJiMoNBeJWBzjdQQ@mail.gmail.com> <20261118012858.289236-1-jeffxu@chromium.org> <332f315d-ea27-488a-9a3c-28cdfdcd5f27@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_180455_057978_1627D2AB 
X-CRM114-Status: GOOD (  11.49  )
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

On Wed, Nov 18, 2026 at 10:46 AM David Hildenbrand (Arm) <david@kernel.org> wrote:
> > 1) Simply keep those 4 cases under GFP_HIGHUSER (drop patches 1-4 and
> >    7), reducing the series to just the GFP_HIGHUSER change and its KUnit
> >    test.
>
> That's what I would look into first.

Thanks David. I'll wait a few days in case there is more feedback, for
example from the KASAN side, and then send v2 with approach (1).

Jeff

