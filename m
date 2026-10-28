Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C9E606A31D
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dfemhVRz;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=ekiRgwTC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=; b=dfemhVRzYTqe516q9oN+x5eXdp
	a3ZPhWyBCLc+nE8wlH/k40C6Dx0I6uE51klGY/9JpFv3/pK3yG7BWV2icoeDFYLywXQMxhlqAwEo6
	hmC9j9elMeGURU3ZqGzuRhE4c+/NxuuOU+h2fcwZNS7zwZdNrqiWsN2A2F/TgNOAyPPfp4uxa3Dwk
	CCpa97+qtSza6sdcfd2R6qRFOaU6N4eEULPRbAuP1I4DCvtsFnV9H++ul2VDPTvIXGVpb6a19R/EM
	cudMSG3ys07mZ7PAle0Zp9BnvTbbEeQN1j6KE2AfHZG0UoErh6l4wBdWPvqg7sYCRgC5FSwHXscGb
	iC79o3XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6wa-00000007beR-2WQD;
	Wed, 28 Oct 2026 16:56:08 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6wY-00000007bdW-0sWg
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 16:56:07 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-990835cec4bso746200241.1
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793206564; x=1793811364; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
        b=ekiRgwTCOiTq0bXasCELZUrSs5IiIPMR6K+iLA+dKM6jNYhh1yx8Rhb1tPeEnuu3xU
         QJrKtpA3bwC/tQuDCw4Bj3rKQrvJZVSGHNDkAbtbhUJLSr3rzEA/FO6nkcROxDMkB7qR
         p60KKqWTo9zzhxyLn19OmA+NJaHu9AokJ+kqpnO9SaQ35567SwGyyhduVRoAntDsXZVL
         Wep6eda+LQxexUgAka3mmYqoWg+Ib+zBLhbKg8XOi9l/icB5iJ/U3dD2j29flpTXnwf1
         0CVOkzh2X+K7sxj4Sp0o0slxyO/s10/pUIRqiXOUQQMgLBqkMhGSTYeqvMt9kR8tPTA8
         E4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206564; x=1793811364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3C0d19m+/iHxVzVsZqZF5QMTPBWCH1ibPkdNy3hhyQ=;
        b=0yuCiav4AXO3e4qhrOnebi+BUbCY9H3nUs6AtUHjYCJv7ltoAnWbdZjvorzDFqUBdB
         LlpTLuKnIbybG+2yad09FQBS1wRBzwfht4Lru6RcNkQXTGT6Dtf6t498xeuFtiQfAf+g
         9W8zV9jTC4csadfPW9E1nPIsZ7vjmbKwTSyPPIy1r/uowqDRksc8dxbjznkLlfqOaVG6
         LOrZAbqb5y+RXPrmjBET52QL+DAvHi8A6dEwQApONQjIB61fZihbxiXL2dm8guMoOyt2
         pGPywEL7vqpFOfXNOUg21idyxiMgc8YKF2oG5X1dQBwNIWjNa8bUldIIUNv6ms3h2UwR
         NO4Q==
X-Forwarded-Encrypted: i=1; AKwUvBzQsuoJNYGAp/ydt0korDM16mkbfB1CURxR4qBEtDS72Tp8UAc6iMtSAE9Bu1tH2uL8PMwatg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJHw3tVPLjYpo15gKDGuk3QYDeNt8Hy3I3YOTW7g9yvqHNEznND
	dnLHL8NlYmui8QgIdoPqxuLcE6pSNdZ+mW04fr5AN9VJPK/tGMTTor6dNWH6cI7JfaI=
X-Gm-Gg: AYBFou2RQjV21p3rimrhlr4Mx+2/BXrUN4BrFSPOBW8Gb4oQOlypC0BHxqYnIm6zSRK
	Hi4WkAb+D9GvnetR0b7Zf4mUNgLaiAN7DDgrzwanYNQQYfKHFoR3j1weg9HGBe1Ho6iomyZeZjc
	JiGrkqIHTud3m5nc2dOwWILEYzNgm8Rn4PD6ySZH+3n0lMBPqQ8jzjAGdp4equynZVP6ifxkh9n
	rp9zj3824Iux1eDMI3hIZ4ljEPRsJhCj2TqEJxuulRwwiAQo+r40LM7iCW+AucPTLSA+swryYl7
	V4kYl21SS27prkyxvPFSX31Pm2/AkKP7ChstGfe46umd+PA+HbNMsxvenmNeVFNLbwzYZNIbbI2
	kFEPqOICQ6HbQqlyCl+nKXpGslBnP2SzvBNfylmNIBNcbCc4ycUSDCZBJxtLco3tHY3IRRcUdJy
	mXx9ofiUInJHhtLt/OMHkgm3ZLoNqzF5bVNGgODokFdJofWXe26J/m4pRhoraykadKiCzNts2RI
	FJdQ7lX8fuxjkYcDqY11QZAkjtbE9D1xiAGx2oeQoIZfEc9PxfbXepSi1YNGIzsIIx03K4e4iqL
	1sz1QxqAr/SQ8Z5R5vzwq1adjI9YmoYNouLgsmbE7rMRExwzAbrEO9lu+wr9yljhvm6eEtB8kCG
	BfeNw6ZbAFFX0rkhw+KhTxlzPAfUW3IsrBtjfLhNJdpuEY4QOI4B5
X-Received: by 2002:a05:6102:370e:b0:7ce:a79e:75a9 with SMTP id ada2fe7eead31-7d03a59dbf7mr1528233137.36.1793206564343;
        Wed, 28 Oct 2026 09:56:04 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-991259fbcbfsm6525438241.10.2026.10.28.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:56:02 -0700 (PDT)
Date: Wed, 28 Oct 2026 12:56:01 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Hugh Dickins <hughd@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
Message-ID: <auIpGR1VG7lOxJ8P@google.com>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_095606_283835_B2050F92 
X-CRM114-Status: GOOD (  23.81  )
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10-27 00:17, David Hildenbrand (Arm) wrote:
> Each full scan resets ksm_nr_node_ids unstable tree roots. Enabling
> merge_across_nodes resets this count to 1, even if per-node roots were
> previously allocated.
> 
> So when toggling "merge_across_nodes" 0 -> 1 -> 0, a scan that starts
> while the setting is 1 and continues after switching back to 0 can
> encounter stale unstable tree roots, resulting in UAF.
> 
> Only root is allowed to change "merge_across_nodes", and the documented
> sequence is: "merge_across_nodes setting can be changed only when there
> are no ksm shared pages in the system: set run 2 to unmerge pages first,
> then to 1 after changing merge_across_nodes, to remerge according to the
> new setting."
> 
> Let's fix it by tracking in ksm_nr_node_ids the actual number of
> allocated tree roots.
> 
> remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
> more tree roots (skipping the empty ones), which is harmless.
> 
> Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
> Cc: stable@vger.kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/ksm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index dbfb8f98b1892..9c51925825cbf 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
>  #ifdef CONFIG_NUMA
>  /* Zeroed when merging across nodes is not allowed */
>  static unsigned int ksm_merge_across_nodes = 1;
> +/* Number of allocated stable and unstable tree roots. */
>  static int ksm_nr_node_ids = 1;
>  #else
>  #define ksm_merge_across_nodes	1U
> @@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
>  			else {
>  				root_stable_tree = buf;
>  				root_unstable_tree = buf + nr_node_ids;
> +				ksm_nr_node_ids = nr_node_ids;
>  				/* Stable tree is empty but not the unstable */
>  				root_unstable_tree[0] = one_unstable_tree[0];
>  			}
>  		}
> -		if (!err) {
> +		if (!err)
>  			ksm_merge_across_nodes = knob;
> -			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
> -		}

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

>  	}
>  	mutex_unlock(&ksm_thread_mutex);
>  
> 
> -- 
> 2.43.0
> 

