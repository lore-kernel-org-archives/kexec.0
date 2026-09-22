Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC351606A320
	for <kexec@archiver.kernel.org>; Tue, 20 Oct 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TtdzGqha;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oxgbajWA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VFYj6sjedfWGEBuGl++9heS9zoD83sYWZIxoZFH52Mw=; b=TtdzGqhaiEISz67QMse+G3Ab1q
	S5Wbml4mfbDEe6iyPj2nDaGSs536LUTU2uL6LeEqKoNu/GG9h9JXJhCmYnRhTxLIXg4TVpDwTk3vG
	kIAS6IJtYpfrWx31ppUX8UQ54GJT7Lt6XMx4nMK7wP9H7pp8kc6SBxBCCuAgt/siQc+Zi6GU6v4aH
	73AxwrJt2LOMWW4YKqFaUtQm04n7UlMHoJtbRcj5HLU45uQeGM6KrIXSUOMh4hRDNOskZD3HCMwhZ
	iA2wwFizi+eCL6AUjcuupG8xYFVbDbvPo+P4cR/Fiwfmg7AGPp6KBuV97RK/1NiDsHvwsJtA2g6gl
	biLIRWMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ55u-000000098vS-2p8t;
	Tue, 20 Oct 2026 08:21:14 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92Sx-00000005qLc-0OHo;
	Tue, 22 Sep 2026 15:31:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 81B3D40DC1;
	Tue, 22 Sep 2026 15:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971F71F00893;
	Tue, 22 Sep 2026 15:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091090;
	bh=VFYj6sjedfWGEBuGl++9heS9zoD83sYWZIxoZFH52Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oxgbajWAx+ewgz3EYGgJPYtZfNNrVy2jiDvlrL0XB6QieOmgNe9oJ8tWYTAmWkd4E
	 40O1bShYyuGwabzOZg2yryGvTCOWVoLErNmP15TezU6CcK1+IP50a2puK4iDmaw6R3
	 PCwUfPw/jYwdSq8HtaOBJAU/3KQvk7VOfDVSLU+W6MZTQuGVG14os2s8QuaTXuRpZy
	 c1E7BQMp5Oh5V6N9yXEOXRU2Ns8Xz5BjaAREZfd68p1jzII0svn4YeEB6D4D+XgUXP
	 mn6RKCk0xuOhAtFCkmd48wAcJ6k5w8jrTIJhK2olCjTjtXsHqi1z/Ac++TcJ8CKg7E
	 LVSLUkJaZCs2w==
Date: Tue, 22 Sep 2026 15:31:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, Qi Zheng <qi.zheng@linux.dev>,
	Matthew Brost <matthew.brost@intel.com>,
	Alistair Popple <apopple@nvidia.com>, ceph-devel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>, xen-devel@lists.xenproject.org,
	Gregory Price <gourry@gourry.net>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-fscrypt@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, Nico Pache <nico.pache@linux.dev>,
	linux-perf-users@vger.kernel.org,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Byungchul Park <byungchul@sk.com>,
	linux-trace-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Barry Song <baohua@kernel.org>, Kairui Song <kasong@tencent.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>,
	Muchun Song <muchun.song@linux.dev>,
	linux-f2fs-devel@lists.sourceforge.net,
	Minchan Kim <minchan@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Thomas Gleixner <tglx@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alex Markuze <amarkuze@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-mtd@lists.infradead.org, Chunhai Guo <guochunhai@vivo.com>,
	Jonathan Corbet <corbet@lwn.net>, Dev Jain <dev.jain@arm.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Gao Xiang <xiang@kernel.org>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Borislav Petkov <bp@alien8.de>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tal Zussman <tz2294@columbia.edu>,
	Ilya Dryomov <idryomov@gmail.com>,
	Oscar Salvador <osalvador@suse.de>, linux-nfs@vger.kernel.org,
	linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
	Mike Rapoport <rppt@kernel.org>, Ian Rogers <irogers@google.com>,
	Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Yue Hu <zbestahu@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>, Richard Weinberger <richard@nod.at>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Usama Arif <usama.arif@linux.dev>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Namhyung Kim <namhyung@kernel.org>, Juergen Gross <jgross@suse.com>,
	kexec@lists.infradead.org, Adrian Hunter <adrian.hunter@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [f2fs-dev] [PATCH v5 00/17] Remove PG_private by using
 page/folio->private checks instead
Message-ID: <arKfTXizFeTeKYDx@google.com>
References: <20260920-remove-pg_private-v5-0-bb68b6a21869@nvidia.com>
 <20260922041600.1240429-1-zhaonanzhe@xiaomi.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922041600.1240429-1-zhaonanzhe@xiaomi.com>
X-Mailman-Approved-At: Tue, 20 Oct 2026 01:21:11 -0700
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 09/22, Nanzhe Zhao wrote:
> Hi Zi Yan,
> 
> Thanks for the series. The cleanup is a nice help for the f2fs
> large-folio work -- it removes the page-based private-flag plumbing that
> my series would otherwise have to carry itself.
> 
> My large-folio series v2 [1] can be rebased on top of this series. The
> only overlap is the PAGE_PRIVATE_* flag helpers, which I can re-express
> on top of the F2FS_FOLIO_PRIVATE_* names while keeping the
> f2fs_folio_state indirection.
> 
> Jaegeuk, do you have a preference on the ordering here? My personal
> suggestion would be to review and merge this series first, and I'll
> rebase on top of it.

Let's keep working on the f2fs tree, since we should not merge this in my tree.
Later, we'd need to prepare how to address the merge conflict.

> 
> [1] https://lore.kernel.org/linux-f2fs-devel/20260915041909.2903887-1-zhaonanzhe@xiaomi.com/
> 
> Thanks,
> Nanzhe
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

