Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F103F606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2aiUcZpA;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=KbTnZ/nw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=M/AMFbjA9JAsBdCFWz1LANgAn0knNna+7jo0zCTOlPs=; b=2aiUcZpAIVcMyL
	w6Ew3qQoQCqvbAQsoqzj9Crodeqia0fVxRiS1AA8HXhd+r8Rg05i7QPuyYEKe3fQDxZ47Ru6RWxVr
	Y89Rel8FqszQ5X2XUHoLtRbjI+GDkWbUkfw8BYVPRPKfZ35kWKLe2fPBA0a26XEWFjO5sUMmw/Cax
	Pc3VyMdWsYoU6S5UsQbD0nw/pNo7iZK+PXaEtIQEmgoMiDWe/L5efSazifw+ObCezv0u9K4nv+ER3
	alw+N8cn3XC9GfrQwcaVAkdR7ALrN8b2t+1EZq8kcz/NjNCdgJ4YLpPlNNsUV/29hDcj8Y9RzzQM9
	T2qMDQaM6Oy2ZcQKaqhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEtO-000000088eZ-2UjK;
	Thu, 29 Oct 2026 01:25:22 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMEtL-000000088e8-0Cqw
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 01:25:21 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6b4bd3d98bfso3451a12.1
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 18:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793237116; x=1793841916; darn=lists.infradead.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M/AMFbjA9JAsBdCFWz1LANgAn0knNna+7jo0zCTOlPs=;
        b=KbTnZ/nwFMb/JEbrb/P6BHvTc2uprr0o+7R/2TRMVcN6hsQKT5iC3zvSq6+jqqXuxS
         4ol9/DcgLmqbqsbXdTlsCzBwhgLWU+ghAVyu387ngIqZoysSI4pabwf1ZnObDW79eWYL
         GWjQtJqvU170xQ2XpyEv+ZL7Y6ZL5EgzjkrcVfkF8gpWQFD6Z86z99U1i2k5UnDcG0nO
         M/kLZ9u6fardnxBrKuR+16BF0r9KJrcwZyMa8j3DtC4b61koao2JfL5buRQrNilPjQU+
         4GyazMo0CSWjmMAWKB1V2xZpRnyNCJzmYiU5MSuDSqz3AfpDtv9yk6bqXTQN9UuYBQlg
         A7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793237116; x=1793841916;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M/AMFbjA9JAsBdCFWz1LANgAn0knNna+7jo0zCTOlPs=;
        b=OY+J91r9OxzRmfkMz0jrRz9l89/YZ6hu+XsJRk7AV7IpxQTqOzAhVQ9Q05TAR9QPFf
         exZsjQQraT8SGDI76jFsDQZe48MRK3zerpcFZ0GrK+QqIRyFLck5ncYdQrK7a0nJ4Nd5
         pb4fwD5u+SSrsA+6Wb+xs2ZuPZ2Knl113qKDdqhBTTx9CUfKUY4g4VwOYzsaEk3kg4rQ
         pcIfCxsaa1xyEJXNhFL3Lj3vZp0EoHWvKSyPjgWsnKY4W2M3Gvz4n0QJeTLw0S8c2R70
         WQCX1TLFfUt/KlY3Fr5gvei+uIaLxszKrDBxwXGepTkydHLBzmQz+IDnhG/n0TXPc/IF
         MBhQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwljZKfGmDFhfs2O0dRbsnl9fydmB42MJIH1ksqfG9ueKgfmFsGSq8esaS6TKSAnFn5PG5rQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYLM842wGjk6SZNA+qA+uRZH0khp9c+MPgIRJiX8766p/eD/zVvy
	WRdGlcmct5ZrFQNenxGbs6Akxkbr7I7gW1zEdfDyWDm9BGm67jj5QCQUfJAb0qLl3Os=
X-Gm-Gg: AYBFou2LcyIRywGe7BQrUdkdPYz+G6ADLpK4mxLgEC33IHanUjnafmk2rB2fmJgDm6W
	fvwtxBnLWczH/qrYUAToAge4M/SOT5hCiOW9+0Tg8hJ3UVqtCvk99y0xwbiiPLgVDo61eqiC8zB
	+dgw3bw/JJV0Ag3db6Tyzw8Cp2UZGP8oKgytKuMAy1doE/rrWTIb4M40QOGzDafLDSs7OL2zmq4
	PtUu2uMMfl0ZJcj8eT93NlSgJ43ubqYFMTeWM6E59l6+R87t6FzRJMyLIiM3WziNWF0rjwbKZFH
	DqRr1JqpblN2SugrRxGSAxasroUDCkOGILe6sSI//6Z1xmv4gnydBymCW8WjrGXzo/0UwfMSDFa
	XGNW1X1hfO/2c6dG0JBC4IZ9KaQRZCoLQSqiBeGJGLBvizSQ3rlR0W9YySqr80HXbMxPJy7rptv
	BGO5BxVaqNhPFgOZi53N48mUR/oXScKFGWONaIOWUtpAaxYhp4mvXslSw5qhHg07oVYQqV8ZM7Z
	VO4iNBGaNtnR49F7ncOJNh/JXCACe0+QwpuLn7bq6N/OlVR6+/H3boZftUNlDA0mMq6gsrRzF+J
	bkqi1v7U8v5MgQNsbTYTEov8u9prmVpcJcj1Vcvq5g==
X-Received: by 2002:a05:6402:234a:b0:6b4:7b28:8588 with SMTP id 4fb4d7f45d1cf-6b49cb5a33dmr2836967a12.2.1793237116591;
        Wed, 28 Oct 2026 18:25:16 -0700 (PDT)
Received: from localhost ([2a03:2880:32ff:7d::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b49644bcd7sm2122970a12.33.2026.10.28.18.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:25:15 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 16/46] mm/khugepaged: fix PMD table lock leak in
 try_collapse_pte_mapped_thp()
From: Gregory Price <gourry@gourry.net>
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
 linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-fixes_core-v1-16-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-16-6f74bec9a5bb@kernel.org>
Date: Wed, 28 Oct 2026 18:25:13 -0700
Message-Id: <179323711320.453251.11778195785979033843.b4-reply@b4>
X-Mailer: b4 0.17-dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_182519_137719_1C713F29 
X-CRM114-Status: GOOD (  12.99  )
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
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-27 00:17 +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> For a private mapping with userfaultfd, try_collapse_pte_mapped_thp()
> takes the PMD table lock before it maps the page table for the second time.
> If that (pte_offset_map_rw_nolock) fails, because the page table vanished
> in the meantime due to concurrent page table reclaim, it leaves through
> the abort label, where the PMD table lock is unlocked if it differs from
> PTE table lock.
> 
> In case the PMD table lock and the PTE table lock match, which is the
> case without CONFIG_SPLIT_PTE_PTLOCKS after pte_offset_map_rw_nolock()
> failed, we miss to unlock the PMD table.
> 
> To fix it, forget the PTE table lock when we unmap+unlock the PTE table.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6375e95f381e ("mm: pgtable: reclaim empty PTE page in madvise(MADV_DONTNEED)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: move the ptl = NULL handling; rewrite description, drop wrong comments ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
Gregory Price (Meta) <gourry@gourry.net>

