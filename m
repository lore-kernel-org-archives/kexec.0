Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36D606A32F
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a5gV0+Tt;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Clt9BGFA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3q7TO+ZwaEbqoqmLKPrIUPjIISzIPUN3/sJr3wevERg=; b=a5gV0+TtL2W/baoA0oSrybWONG
	EJZvh/BAD0XP6V1KME46MU+vySvEHUeLEmO7jXODcUTE5mNUEfK6HA0U4MJ4IIG+/Fo60wgsScRf2
	xN+aqTkaSZzewQeAl9wX04hm5QKDVNwqJ5IePjbXB19zDrG5l/PuDTcNKz5nNC+4KRZcggHM2wVcL
	G75Tt8KL1zO5+MK4H5KMLH7L15ADWYzdyFTCxVyfcso91qXirE/AI2rsUtv8QzclCuRr5W7EIoRz/
	ncYBOvwyP9PFlCW64QSgOGvo0FVJlUMf0K/8XDgmZZbWTgLf7gf4nu4oJa03CcrkUeC9jUb//U5xZ
	ih8HMHVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6hd-00000007Z3c-0ofD;
	Wed, 28 Oct 2026 16:40:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6hc-00000007Z30-1SZH
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 16:40:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89FAC43C48;
	Wed, 28 Oct 2026 16:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8D41F01828;
	Wed, 28 Oct 2026 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205639;
	bh=3q7TO+ZwaEbqoqmLKPrIUPjIISzIPUN3/sJr3wevERg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Clt9BGFAO6FunMnG3BktqQdCWJrcPnaMDWug57IQu444FcIO+Jk+rveBxyGhwgcTq
	 sBOr66NhkV9nYwgROWEZ0mlY6J7+pQkg7Zsne2F/vz44/MxN3CvAW2PIi5rSBpKIOS
	 LSOJGTlaNQGXZ48QsIltE3WLaCBNWItqzRFpDVlGuy7ix7rcKILXHjG5maKOQa579O
	 BhjCM8yRzBr283z+Yttr5p9uT46dg0TS02/dNtFYcql+WCjF1s7+hs2FOZxTWYL7o1
	 crnMsIepwqcSwXVN/RXEosxQ20ps8dJRqSSXL6Azj7qm77DtFK3P76ygvhEVUyHjt6
	 uUGwz6hpLFJNg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8F8CF198003A;
	Wed, 28 Oct 2026 12:40:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Oct 2026 12:40:34 -0400
X-ME-Sender: <xms:eCXiaqiN7uW55pdnDLmQfMCpgqKssyEAlbg2kEo-5uT2EnxoO4ZuSw>
    <xme:eCXialQiwOxUKOiOgRbMVzuCX901N_ygNZZlIGwGmhUSPEOO024OPL_frpYc5UvRF
    ufzO0DZbg79qizqZNu3oZPsAJjfr-Rc3mcV7MSCwYMa2c4GY3IOmUfF>
X-ME-Received: <xmr:eCXiakFBqwymY7_RFYo0Ad-7d64WPxU19dNbSVic6uXNgnkcXdts2JTSFpw>
X-ME-Proxy-Cause: dmFkZTF9BSIUpdbqdcQtRDBoZ6omZu6gkWuOLh6CEtsiN9GCwL96yShYRR0sGWUfB/BAqE
    WZ64unNfK3Oe0Pmq84aQBKzz6U4bNLPGOt0L+3it1u7lBgkGfJBxf+KgimcC8ODml/Bvs4
    tVarhMXUh7RcWdDG/2JFwnscmJK43/IZh/RFjzDX4hQQAHQgOtEMpiD/6x6mNoabLgV1Uh
    8N833SkC9jtVG28yAz+w/Ea9Sw7TZ1VqhdC4+mQnrllda/7izabJuHYqT4SfvoZvONJ4j5
    MPW1Gk8oi9Trgp5oDcZSI4Pe9o74RJVHkS7lxxR8lsEZd8CIgsegB1KiHE2T7Z5xehGBqQ
    3UynFVkTFHQUjTSucs9dm2AKKwGlYfQ+KZouD3lwtJq+CNgLVrRX8hnysY6WtAmZYn+2FA
    UMKoGHv2nyQcjhytg8JcnhDM5D5FH8oTePRRudgezShXdD3VQZaIwdMFryvIDXfmNdG+xS
    x3FgXxCpjM1Dnx36WNsJr9NZywtGtqeBnpNa2CcH7uZItXr/EJtDkKFaLLDYrmrMYoRZy6
    9WMgAdXyW/auCalGZ898cnS6rzXymDqGbDfabqdqvexVbud3Xyfh83yzVJNAJb/KZJB0Dr
    RwkvxvaWvVMVXraC6fhht0GDpCcItQ8xXgQ8CizyTFww+xm1P2qA5dskCNwg
X-ME-Proxy: <xmx:eCXial92jNgSBQTxWlBjZMWgmR6TBvKzWaFSBoP-VAqjL0ukcNqioQ>
    <xmx:eCXiaiF9yjc9digKd5Ya1GDuxp2814mB5aHgvCvd4OHzLNuho0A7Aw>
    <xmx:eCXiarjoMRi8d9X-XM92nD_cnaj5ysHGPELtUq4mL-3Vs4NwrN19_g>
    <xmx:eCXiauHvY_LuyMcaATsWdR4V2wsHPU2Pnegr0ayYJWcc1st6zamU_g>
    <xmx:eCXiav1OXfLSRm-Vd5XTlOvlVQyXslpANnXfV-qVihMApMQBeiD5C2MX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:40:22 -0400 (EDT)
Date: Wed, 28 Oct 2026 16:40:21 +0000
From: Kiryl Shutsemau <kas@kernel.org>
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
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 04/46] mm/memfd: make f_pos accesses atomic
Message-ID: <auIlVgNRuGsBrRso@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027-fixes_core-v1-4-6f74bec9a5bb@kernel.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 12:17:24AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX") made
> read(), write() and lseek() on a shared open file description of a regular
> file serialize on ->f_pos_lock.  The flag that asks for it,
> FMODE_ATOMIC_POS, is set in do_dentry_open().  A memfd is a regular file
> too, but its struct file comes from alloc_file_pseudo() and never passes
> through do_dentry_open(), so it does not get the flag:
> 
>   CPU0                                CPU1
>   write(memfd, "a", 1)                write(memfd, "b", 1)
>     pos = file->f_pos  (= 0)
>                                         pos = file->f_pos  (= 0)
>     vfs_write(..., &pos)
>                                         vfs_write(..., &pos)
>     file->f_pos = pos  (= 1)
>                                         file->f_pos = pos  (= 1)
> 
> One of the two bytes is overwritten.  Two threads writing 100000 bytes
> each, one at a time, to a memfd end up with a file that is far shorter than
> 200000 bytes, while the same program on a tmpfs file never loses a byte.
> 
> Set the flag when the memfd is created.  As for any other regular file the
> lock is only taken if the file is reachable in more than one way, and
> nothing a memfd does in read or write waits for another operation on the
> same file.  This cannot be done for all alloc_file_pseudo() files: anon
> inode files such as eventfd are S_IFREG as well, and a blocked read holding
> ->f_pos_lock would lock out the write that is supposed to wake it.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 9183df25fe7b ("shm: add memfd_create() syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: minor description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

