Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F960A2606
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JP+Xt0l9;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=qTZyVsu9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=; b=JP+Xt0l9ajfCjB
	sPUSdDdyw/4DEKvgndnHoXWlm8cK6+5vw9/zrbK6+UcBgT5SK1+dsoPvUhXsBAshwDafdhnvW/aoN
	5vLyUiNemSXXaW9pn6MxyM/QKK7GS0kZG++7p1LxhRihiGr9U2ShwvzVyCLtVGI87KRHlskI7BLXt
	5k2krFDbZBLSNYM+DwD0quhRrF+xudCdjiO1hDYeKoMnh2wNzMuqOi/gvZVbMlBgxpSGzS9hdg3wS
	z34qOKZndfI6uolhnAAWaLDDMvdQlATvfwbugqeL+R9Q4HYRpzxs1DlkPSFMg2Ha2zu8S7LhvlVUI
	b9ZsTfODujquyZAM+anw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMYkb-0000000AU9M-2Hlf;
	Thu, 29 Oct 2026 22:37:37 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMYkY-0000000AU8K-3fjE
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 22:37:36 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-91c847584b8so1697296d6.0
        for <kexec@lists.infradead.org>; Thu, 29 Oct 2026 15:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793313453; x=1793918253; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=qTZyVsu9HSK8qYJAhGK/4+A3nC43wM+9a5VT2rQejkAZFwJ/SA7pV5DtbOkOEC//QT
         E+1tCkgonmaAW1TbEf3Ty3g0EWitYK0gWzYWsau7zzf3M2NJhS9l6A8jXKJpDqNUCz09
         p7AK32kAgUaJT3HtOkriaOYmYJMjJE7J9LNxutTOmzWLpZPwDPwZN5q5e4uYBkYnBFLT
         fznRU3vfabXHpANhl4+JD8XvelypZXLv72ONxVsN4g6Awk0M4hysYWqk2+l9sn2ISMz4
         D843xIN7dJY7v+akGtW9nUvr3dTH27VH7Lz0E1w7sCCmtmiU3ejHhzjIPuiwN8J1lvHj
         SBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793313453; x=1793918253;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QsPG26s54J59UedVlJRCxJXndkzu8TR98XKtjA3+1AU=;
        b=DgX8a+J7QEeqLI0PJXOJX5NJiZPuFjJiagpejKmqURgxHzrWxyj2SCiQLHHLYZBCiR
         PLIPvcw9J9W54QQyLKmka5CvtO5vVqa8O7+Xnq4LF+mY3mV0Uh3ApKRtxY6rvvpkhMGe
         KXTRhKcOzwcnYqpVKzzNbMMjiSHcE5K27Bfoni0u2UkETS+HCpINw6ERnu9Xa3qd98fx
         DQSbo8SslolENHr19fgTogirL/9Vq2eVMBuabzT/hJU0EoljWjTRfCVIUpKnlIBBaqrQ
         VunAOa6sM8UkzdGV3lmzNNsey3aBWXlFUbYmZSpI93fcgLz16ua4hGnWYBVcQIXCZu2+
         XtZw==
X-Forwarded-Encrypted: i=1; AKwUvBw+rArsLIo2D5rfKmm/t1CAb3qqyjHpByuWbj53rtfMufARiTCT7T0EAMx61u6M5XvwbwYf+A==@lists.infradead.org
X-Gm-Message-State: AFq9FYJer/vT65emDuQgOSLYfBVsv1dZJmXVT/Wmg3RMFU8HzxgJMR3b
	dE8Y0ifhjrg6qrsgCEndnXS3ZWc5ZvatQJrrehWdUNUUHdezNezjYy8/bL/7H4/rw4Q=
X-Gm-Gg: AYBFou1P+YpoG1bV4D4LCwvWpxqN11q1yQ6b8bN0W61EuUZLIIIme493Qf128I62+ew
	K/BAPo5AOnJBpXIFieAD06ZTWUMUA1UH09I+0/0IJKC5QaZMLhOfObKntYieG/fQR9FMj2qWUqm
	yZFdQQfO7HlerrHvesxNQ9zaixXCFkrNDW/jMxmrK+n0uz8PYX/ouaRqyEeYYXmYqKKw1qAOLXz
	0XTw4Xmer7zF6eYUNyJsXvzccFTQjE88/UXFV4evJz38/OSXHhlLdd8y1M4t23huh5RCQJweJc7
	hnLeEOqXvaG7E7MFBHdZXOusPC+Adx7Fp8y2bIsbce3heSotD3Wyqxx/GZNGJGfsQ2S09QI17A0
	rslFQX5vHfKyfeBIOk33gnXDKdNUVZdiP+eSyhVewC6dhRLDlXGegPSnoIWlz4yB07+Nvj7fX4l
	ULKBVap+wjdOhv0AtbC1R1lwopl3xmJ7Ei680nfV3V8FW9Oceazj+F5O5AgJpnCg/YoeTzuwMh0
	wwpK3gX2HT+lT0BEDwiM9diS1N2YCIQMZA9T8KRoLF8WY5etNmw9v4G+AOdQ5OphQSOaroy8IIW
	90r1cndA5JEE4a9+FUDbKWF1kmRGDxVtvWDd7jZXKHNGJXMDVU8TI/V5gVUT1/xEHE6CNcHk92g
	Vmot8S3vDeWQEDZ74Z6941g==
X-Received: by 2002:a05:6214:401e:b0:917:c073:1b98 with SMTP id 6a1803df08f44-91c90686fc8mr65881526d6.15.1793313453118;
        Thu, 29 Oct 2026 15:37:33 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca6855ea1sm646896d6.8.2026.10.29.15.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 15:37:32 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 13/47] mm/huge_memory: fix truncate racing with PMD
 zapping
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Chris Mason <mason@kernel.org>, 
 stable@vger.kernel.org
In-Reply-To: <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
 <20261029-fixes_core-v2-13-a64ce7f83abb@kernel.org>
Date: Thu, 29 Oct 2026 18:37:31 -0400
Message-Id: <179331345102.2127828.8211829708894165734.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_153734_968580_AEAF0BCD 
X-CRM114-Status: GOOD (  13.93  )
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29 21:33 +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
> If this was the last mapping, truncation can skip unmapping the folio
> and proceed without waiting for the PMD lock, racing with dirtying.
> 
> ifs_set_range_dirty() can oops if MADV_DONTNEED races with
> ftruncate() on XFS, when we get the folio set dirty after it was found
> to not be mapped anymore.
> 
> Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
> matching the PTE zap path. This keeps the folio mapped while updating
> its state, so truncation must wait for the page table lock.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comment and description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

didn't have time to run tests, but this looks trivially correct.

Might be some backport ordering issues between this and commit 14.
Hard to say, didn't look into the history too deeply.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory


