Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B732606A324
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jsRP/li6;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FGZfE5gA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SXPkduc5HmvcD4JbyCflilxUkIbcOVZyKgcYfnLDPdM=; b=jsRP/li6pl4b/P
	8Y9ZwRsYHtkig299/n/V98J74zARStK4Wl+ws4mZeJl1zyf/C+42SqQOgKYys6AX5C6VrlqQk2wWG
	p7vD2/UPFV+lVDcmWnYzEidxVXnMkWAqv9r0VtIZgvbxVD7Z296oPVD+1oN0jjmtVgL1+brlM9txO
	krRFiBwfg981SpJP8R9QsV/nHp3mV0dbWlMyHrV3deI3yHx3Vfg+djQKhGiarypeiKGfMD7wEyMst
	lICOA7aqNxjHPZ/ukQJx9ZabmopJ3ep0bbbxKerUDL220zE3aoUwMYqwuRBPjvX37LjcJmO+Hx+Mo
	iSp4846Xsi2AEVS4MUig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNpRl-0000000GBu5-0J7b;
	Mon, 02 Nov 2026 10:39:25 +0000
Received: from out-147.mta1.migadu.com ([2001:41d0:203:375::93] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNpRf-0000000GBrh-38ZH
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 10:39:23 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=g/mOLxr73xiPzfSEauykXJcCVgHJm2aXb9jWqKek3jg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793615949; v=1; x=1794220749;
 b=FGZfE5gA8VQ7g0VPOa1555KztU9pXPoVqISm2zO/1Un7sNA9Xg8LXABcmO9akC2pKhNvb03u
 OMhftDY9uI3j6PJkrZ0A56Fdq6iSFCiG0sIeHgYo/vSTyrZBiJQMOUYn719ZAIgr64WcoOMM5tx
 U0sUKS5ZEyZxxKsOJRnLmU3I=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 8bbf69835e69a785;
	Mon, 02 Nov 2026 10:39:08 +0000
X-Mizu-Trace-ID: 8bbf69835e69a785
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	apopple@nvidia.com,
	axelrasmussen@google.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	baoquan.he@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	dev.jain@arm.com,
	gourry@gourry.net,
	hannes@cmpxchg.org,
	harry@kernel.org,
	hughd@google.com,
	jack@suse.cz,
	jannh@google.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	josef@toxicpanda.com,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	kasong@tencent.com,
	kees@kernel.org,
	kexec@lists.infradead.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@kernel.org,
	mhocko@suse.com,
	minchan@kernel.org,
	muchun.song@linux.dev,
	nico.pache@linux.dev,
	nphamcs@gmail.com,
	npiggin@gmail.com,
	osalvador@suse.de,
	pasha.tatashin@soleen.com,
	peterx@redhat.com,
	peterz@infradead.org,
	pfalcato@suse.de,
	pratyush@kernel.org,
	qi.zheng@linux.dev,
	rakie.kim@sk.com,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	shakeel.butt@linux.dev,
	shikemeng@huaweicloud.com,
	stable@vger.kernel.org,
	surenb@google.com,
	usama.anjum@arm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	weixugc@google.com,
	will@kernel.org,
	willy@infradead.org,
	xu.xin@linux.dev,
	ying.huang@linux.alibaba.com,
	youngjun.park@lge.com,
	yuanchu@google.com,
	ziy@nvidia.com
Subject: Re: [PATCH v3 39/47] mm/ksm: reset the unstable trees of all nodes
Date: Mon,  2 Nov 2026 18:38:39 +0800
Message-Id: <20261102103839.225014-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031-fixes_core-v3-39-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-39-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_023921_139288_C282381B 
X-CRM114-Status: GOOD (  20.76  )
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
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
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
>  	}
>  	mutex_unlock(&ksm_thread_mutex);

Reviewed-by: Xu Xin <xu.xin@linux.dev>

