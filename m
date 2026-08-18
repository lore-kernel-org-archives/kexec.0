Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B83EC5DF7E
	for <kexec@archiver.kernel.org>; Tue, 18 Aug 2026 12:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJN1XNbV1kVG2NQ3eF3Cz0aSxHqvy1o4DerQ17ykIz0=; b=DjvPNTlrkYrbdZC1/KbJua4iYt
	Hzz58pVbp4FiYnxABC491UUAlHMw+VAukhpjTqay6/el8LwQgKh+2xKe1Pw6gkOJxO5a2NT3lH3G+
	RlDoydkKCmX7S70uo2kkxz1Fh6zxY0HEe/0eMo1eWR42PPjYSyhqvp8f1T/+2S6vMHTmzeDDvFYTb
	tKJBJAjjU3c/zyb6I3JFpxpNK5ydBsD7ojnfRYA+yZCJWXSFUgovha8eRBpQX8o/pe7nuDDi0zvr1
	te3XXf5dgAv2xLgu6ijvZMXtPi0rTuuxWMv+f3U0y6/DjFYlCU2pr+UOPwPxEwAsLMjd8P2iGpyZN
	5dzPaEAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwIjq-00000007uYe-3IPY;
	Tue, 18 Aug 2026 12:16:18 +0000
Received: from canpmsgout06.his.huawei.com ([113.46.200.221])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwIjm-00000007uY2-1rQ8
	for kexec@lists.infradead.org;
	Tue, 18 Aug 2026 12:16:17 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YJN1XNbV1kVG2NQ3eF3Cz0aSxHqvy1o4DerQ17ykIz0=;
	b=CtkBOOzdgvQOOkYQfbKQ9+0f6okaXLJPPYPMqpbF8rpax8HOWbesMuK28GuLhRD77zlNyyGCc
	b1Rvju6IUfwQKh/prrn2V54H+ShXHIpbM34dNJzEFASE4P+GnwduddcihO2hS+GFEcb+eDFnQkh
	xK3Kz/K/Mlck3bzypEjgXFU=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hPT0x3MLnzRhQt;
	Tue, 18 Aug 2026 20:05:21 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 6B8D14057D;
	Tue, 18 Aug 2026 20:16:00 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Aug 2026 20:16:00 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Aug 2026 20:15:58 +0800
Subject: Re: [PATCH v6 2/2] kexec: keep the next kernel off hardware-poisoned
 pages
To: Breno Leitao <leitao@debian.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>, <rmikey@meta.com>, <riel@surriel.com>,
	<kernel-team@meta.com>, Kiryl Shutsemau <kas@kernel.org>, Bradley Morgan
	<include@grrlz.net>, Andrew Morton <akpm@linux-foundation.org>, "David
 Hildenbrand" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, "Naoya
 Horiguchi" <nao.horiguchi@gmail.com>
References: <20260812-kexec_posioned-v6-0-e477887086f0@debian.org>
 <20260812-kexec_posioned-v6-2-e477887086f0@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f794a7b8-ea8b-ef21-5bf7-de36f3210837@huawei.com>
Date: Tue, 18 Aug 2026 20:15:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20260812-kexec_posioned-v6-2-e477887086f0@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.124.160]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_051615_283027_BFFD345E 
X-CRM114-Status: GOOD (  18.38  )
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

On 2026/8/12 19:31, Breno Leitao wrote:
> Memory failures (such as unrecoverable ECCs errors) are getting more and
> more common. The kernel knows how to handle it while running, marking it
> as poisoned (and SIGBUS user tasks).
> 
> Poisoned memory is removed from the buddy allocator, but, not from
> other places. A current problem is that kexec will load new kernel
> on top of a bad/poisoned memory, which is undesirable.
> 
> If the next kernel's image, initrd or purgatory lands on a poisoned
> frame, the relocation copy puts it on memory that is known bad. The
> error happens on the first read from a bad page, and that is what we
> want to avoid.
> 
> Skip hardware-poisoned frames that were detected by the memory failure
> subsystem earlier when placing kexec segments.
> 
> To do so, add a helper that reports the first or the last poisoned page
> in a range: memory is walked top-down by locate_mem_hole_top_down() and
> bottom-up by locate_mem_hole_bottom_up(), so each direction needs a
> different answer to stay clear of the poison.
> 
> kexec_load() gets its destinations from userspace and cannot move them,
> so there sanity_check_segment_list() just rejects a segment that happens
> to have a poisoned page.
> 
> is_page_hwpoison() also covers hugetlb, so a poisoned hugetlb folio is
> skipped as a whole.
> 
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Bradley Morgan <include@grrlz.net>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

