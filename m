Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C25C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 12:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dfPuN5XK89i90iKP7N1UEg6cXPRSfGHauPrCcp91Soo=; b=HBjL0Cz40sCLSxFFFpRb6G2L0z
	lWGpeBpvk3jpMdlFEnUGucgK0qarKjRhPBeWVNAb86Dt2y0PrPUGjhpPj1hsVMBeLf+EpR1/1thGy
	+WUd6C3shYwkrLMmTbpbtXyaC+owotqjsgL7CJZiIbYrtIDiCjT043DT20Eoy4k5bIfs2tI1ILclF
	G7gcQEQzHBKln7meeE1zvf8mEIXIYKTyAMXWwj3b9qhkR1VdPt7QXIMxJejz1txYtip4DYo/lFRGG
	yFHONb5kfepqqw5bdl1WBZ0QX4AqUjkrXRmSiykOXsSzb83KxSXVbFNnFYfTd2VwiNoB0inY0Pt+W
	0FyNHuoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoM2-00000002UC3-0o2z;
	Thu, 09 Jul 2026 12:59:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whoM1-00000002UBk-1DQ7
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 12:59:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0850043651;
	Thu,  9 Jul 2026 12:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B3F1F000E9;
	Thu,  9 Jul 2026 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601988;
	bh=dfPuN5XK89i90iKP7N1UEg6cXPRSfGHauPrCcp91Soo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=J3lGK4Te1f4zzXGsuskTvVM2iBsyuSztXeOmCggDo36HjJ3cFV8/MZPAkLsLFQuzS
	 lNVmeEbnta9/P5w6O6w9uM+11NdtyZUs9hA3OafhOr/Q4UHG5Xyq70hDx3FmpkjRla
	 UHBbV04VVT4urrcAR4hxuiIPkP/cdxeSW3G65y+mOSwDdd9ogtDLl6pcH5//9D/KrN
	 zlupO5ofc9MYYuFPrlnmkEaVq8YXf+uicS8JLzLuThh9pdRXv4cN+Hddu9XJIwCiF5
	 4nMf33vBikptKw71xYxPVonYLUz/vsdC46ymFQu11EvLzSAapT1ixwKexH6HjjBnD6
	 1DSahxeZccbnA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@kernel.org>,  Alexander Graf <graf@amazon.com>,  Alexander
 Potapenko <glider@google.com>,  Brendan Jackman <jackmanb@google.com>,
  Christoph Lameter <cl@gentwo.org>,  Dennis Zhou <dennis@kernel.org>,
  Dmitry Vyukov <dvyukov@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Marco Elver <elver@google.com>,  Michal Hocko
 <mhocko@suse.com>,  Muchun Song <muchun.song@linux.dev>,  Oscar Salvador
 <osalvador@suse.de>,  Pasha Tatashin <pasha.tatashin@soleen.com>,
  Pratyush Yadav <pratyush@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Tejun Heo <tj@kernel.org>,  Uladzislau Rezki
 <urezki@gmail.com>,  Vlastimil Babka <vbabka@kernel.org>,  Zi Yan
 <ziy@nvidia.com>,  kasan-dev@googlegroups.com,  kexec@lists.infradead.org,
  linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: split a couple of headers from internal.h
In-Reply-To: <20260709-internal-h-v2-0-695631425968@kernel.org> (Mike
	Rapoport's message of "Thu, 09 Jul 2026 13:00:02 +0300")
References: <20260709-internal-h-v2-0-695631425968@kernel.org>
Date: Thu, 09 Jul 2026 14:59:43 +0200
Message-ID: <2vxzh5m8l3nk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Thu, Jul 09 2026, Mike Rapoport (Microsoft) wrote:

> mm/internal.h becomes more and more bloated.
>
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

