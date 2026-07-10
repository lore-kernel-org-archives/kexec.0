Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4D5C43458
	for <kexec@archiver.kernel.org>; Fri, 10 Jul 2026 00:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gjBmaqSneqTuRoIZKmkOm++Q8E0rqDqKSQfqW/IN64=; b=LimS9TcNAdQCDbNpwBvtKz7Ebs
	yBCDACUvLxAfrHJ1uves11k1iuVjvgr2vPXdgHOmosF9wQ0q3AWaLNSv4mN8CeTOfpcYGYDsj7UVT
	x+xrQ9hKm5XQsoEvDlWZGRbGcxzA0vI9WUF89kkQIVB3jE0AXtc+R1d67b/fanNmHQrQk7F1UBd1o
	ZcDOuNAE3mej+edpt+wkf/WJUl39uUdd/7Gb4DqAUKIMsy1s7gdIXmP+hUicUH6rhJkhLa0PgYRhp
	LBF5bL+8MoYese399kgjJC6TB3aIZFSQa8qvWvvDJC3KEMHQADN96WkO0aH9poqV9ouOKUEZbozoa
	cIdd8nug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whys6-00000003s4G-3pqz;
	Fri, 10 Jul 2026 00:13:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whys5-00000003s43-0b0Q
	for kexec@lists.infradead.org;
	Fri, 10 Jul 2026 00:13:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3738060EEF;
	Fri, 10 Jul 2026 00:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63B81F000E9;
	Fri, 10 Jul 2026 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783642414;
	bh=9gjBmaqSneqTuRoIZKmkOm++Q8E0rqDqKSQfqW/IN64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KUyXaCZAaX3ttnttEEVV/zT4iS+V7t0wzxg+ALl7LU7XP+H5rZ4vcZ9K0mwASjdKd
	 98z37XWKnBN3JSgoRN8caw4/S9K98lzFFehmZjq9hOo8rkQC1uWXYXsMekk0zkxVyQ
	 WWFZTcox/X8ToOmCS2e+ev/feYTtU9T7ZM5kWBL7cVK4UoLTJmb/h42Di5LXTKuGO2
	 aOwnamxhd2bD3iLH4hZxQEjnK+q7zhlp3YR8tnI87sXVHbk4+EvMQgfR+GNtxsXtTL
	 OmsHiyPSmTfaqxdRILAtu/Jd2JjEf3B7kN/V6xOkOqU4bWdgGxZsCJPMt+IfVu+eUt
	 RRuJtj2DMafnw==
From: SJ Park <sj@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Alexander Potapenko <glider@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Christoph Lameter <cl@gentwo.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Marco Elver <elver@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	kasan-dev@googlegroups.com,
	kexec@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] mm: split a couple of headers from internal.h
Date: Thu,  9 Jul 2026 17:13:25 -0700
Message-ID: <20260710001326.110758-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260709-internal-h-v2-0-695631425968@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, 09 Jul 2026 13:00:02 +0300 "Mike Rapoport (Microsoft)" <rppt@kernel.org> wrote:

> mm/internal.h becomes more and more bloated.
> 
> Split declarations related to mm_init, memblock, vmalloc and sparse into
> new headers.

Nice.  I also confirmed I can successfully build mm/ for my main test setup
after applying this series.

For the series,

Acked-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]

