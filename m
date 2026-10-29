Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE751606A31E
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dqS7AOzV;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NyagxtlF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9LohosSmNI0EaSphEpGjYH9L23OvaCdilKiGHMtzl+I=; b=dqS7AOzVCk4hrZxyogfxarvaTl
	CbINuMxtydsIdCouf74bXT0DpzTiTdge9rljeyE8m0sdh71GcujYcPq3sx636LoCdl5AG9UNQJ+kq
	NG7pDE+8QOULV56Zx8Qt5//GY73t5iVgcF23OnwKEEOKLJrVwUzj+xC1ueTC3soCKJFl/UtjZp0G5
	hInNt81N9kvDNrhW/n7/rUAy9RjV+LSumeuRIguC7FhGVpWcrNRkAEcJYwKD3/OVk3A4TL2deyUmS
	zhK53omVL2NHyDn+J0epmgScYL0/GTtIMfYh+BP+OlN7wlAy10CLkw/Ax5B2VV59GFfv/6Rco3vNu
	A+aNyCCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSIY-00000009f4I-29Jb;
	Thu, 29 Oct 2026 15:44:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMSIX-00000009f4C-1Xir
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 15:44:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 83BFA60207;
	Thu, 29 Oct 2026 15:44:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7931F031E1;
	Thu, 29 Oct 2026 15:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288652;
	bh=9LohosSmNI0EaSphEpGjYH9L23OvaCdilKiGHMtzl+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyagxtlFRZCZ8laotq+zQX/nXLERa551dmYVok4IhbDxultx8Qv/zBxN54h8zWNFB
	 SU+tc74cj79XLWTEjRkwdxchX9I6BXRs21mLGib4aipJWDxDX/KvxW4iqXOSr7B0dx
	 eme5eSIcyy8lJJh/A0BknoG9D8uZig8XSMWsJd3rvw5Pdll/YBqlR/FyK0LWdIjic1
	 k0HXGV7jTLdAqFs6AdorrgNLNgGIvlSTjYkuzYdUXJsEGDCqm72UBjgUPtTCzdsqeP
	 CNAnKspdsy9k+rM2AVusw0R8k8/cc2GV8FBVCf9QtijcAoNWNqrIhMx9kys+i4sdhb
	 Qn/epeF6H3VQA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.ams.internal (Postfix) with ESMTP id B8741198003A;
	Thu, 29 Oct 2026 11:43:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 11:44:06 -0400
X-ME-Sender: <xms:vGnjaqXV_oXgY5WUohdr93Ik2ciaVdD-rppLtqYNFzseLbm9KSKfCA>
    <xme:vGnjavN8pBx64E9WcCMA8kFGqSS4xWegMAxVR_OBlfT1SxSA4n0In5x5lbogKKlBc
    2rRH2jGjWSLyr4Tyc9R7jhxaFX3yje0xka2R1JpP2wFHC9Wg3f8KVMj>
X-ME-Received: <xmr:vGnjaiVCXjTDRQFWtHXM2tH5Wgg-Aq7EBL6jORvsqxqYi7qv7dCvrGbSRIA>
X-ME-Proxy-Cause: dmFkZTGgJ834dc6Y2aLU8zitTP7wE/5Ai0JJcu2EEkyHN74nVjQguXnqD1o/giwxhWpS9o
    5GchtjMcZM/GimMO/oRY8cX+X5o2O14DaG/wHSoGgsePhNezpMMUR9hxfh+6ePbBrSONp8
    zUTDPK4YxRFB7PeD9qpcs33Dq2TJ1rCyaCFWQqXYaeQ5IfvhaG1aEgdU9FIBIbjxQyUEVO
    HUhgjEnLM/mcjpKXN3he8HzQsNkc6t66xTfzuNR3aFM/rpGhCVU4vnygjpenFdd7gimv9e
    MgBaDigPiYtn0obZd1xKf8xjo+9ygSAq03nBlObq0yoPRGrpSR1NmJKyzbHTEpvNJryhG2
    oPIKnzFB/jvoPqtSeTVcwgzvAxg1c5L48mEINcwempzZtumcmvHXasq/aFb81DhF1mCBpJ
    k0Wd876DP/lwDJqM2yLb9ejFBfSTZaL5p93eohaQGYpjoUKfReSmxvjtGjgIvo2rmBt7la
    FqiSPNMgdpRknAzIxxtHBZwUytDrApT3RG3uLkS298mLHFtCnBMbrOKOZH+PAxoBTWX2Pn
    9gF3ShCPlU6mXRgQPAvMj+FEowG2WQXnjXKfnerLhTADFznq+/TOvIONV4A3pqqDzDZrzC
    SzVIwowSHvm6FClF8On+525Eh2Tr7cnWddMWSEr16lkF2XGXutWYCuVCIvHg
X-ME-Proxy: <xmx:vGnjamxjzn27rK0ySjsGRniUaql1tj51-3CqBDy-1H61hM2iCxkUaw>
    <xmx:vGnjaoXmMQI9KQwEfOjnXMm-rXDeB-wh8O3GucM8N1bOjv5Gsw38Gw>
    <xmx:vGnjatGq1k8tRzclx_X2jSCVi6_3zr7GTYrg3feqS3CvIxacixI4ig>
    <xmx:vGnjat54KicWAGKdQmUX9xn_FZnJU6qwkhTMCIjnw6EryTcAJne9EA>
    <xmx:vGnjagBJm-xLj-uOPmq8qxgdDdgBPjFXl8HGy9pVFnLZwZ7Eo94LuXNe>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 11:43:54 -0400 (EDT)
Date: Thu, 29 Oct 2026 15:43:53 +0000
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
	linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 05/46] mm/truncate: look again if a folio left the mapping
Message-ID: <auNprZJRad8r_xaY@thinkstation>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-5-6f74bec9a5bb@kernel.org>
 <auIniV8YSpA4_oxg@thinkstation>
 <2f2ef336-2186-4f20-b7f5-565e60471bda@kernel.org>
 <auMvYdTd_e9O9kDj@thinkstation>
 <7fab2115-6c44-43b1-b03b-8ce4a37ffe32@kernel.org>
 <auNaOMYUUpnzCofx@thinkstation>
 <957fc9ce-1789-41d7-a4cb-66acdf7fcecb@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <957fc9ce-1789-41d7-a4cb-66acdf7fcecb@kernel.org>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 04:21:54PM +0100, David Hildenbrand (Arm) wrote:
> On 10/29/26 15:38, Kiryl Shutsemau wrote:
> > On Thu, Oct 29, 2026 at 03:18:23PM +0100, David Hildenbrand (Arm) wrote:
> >> On 10/29/26 12:37, Kiryl Shutsemau wrote:
> >>>
> >>> Yes, I missed that the loop only goes back to start when a lookup
> >>> comes back empty below end. When the last batch reaches end, it exits
> >>> without another look. It doesn't need the split either: any punch hole
> >>> whose last page is in the page cache gets there.
> >>>
> >>> That exit looks unintended to me. b9a8a4195c7d ("truncate,shmem: Handle
> >>> truncates that split large folios") turned the "if (start >= end) goto
> >>> out" early exit into the loop condition. Before it, the loop went back
> >>> to start until a lookup from start found nothing; Hugh kept that on
> >>> purpose for hole punch in 792ceaefe621 ("mm/fs: fix pessimization in
> >>> hole-punching pagecache").
> >>>
> >>> Restoring it is enough, and makes the "restart to make sure all gone"
> >>> comment true again:
> >>>
> >>> +       if (start >= end)
> >>> +               return;
> >>> +
> >>>         index = start;
> >>> -       while (index < end) {
> >>> +       for (;;) {
> >>>
> >>> Then a replaced folio is found on the next round, and truncate needs no
> >>> special case for it.
> >>>
> >>
> >> But that's then another lookup even if not really required?
> >>
> >> Why do you thing that is that better?
> >>
> >> I agree that the code is simpler, but at least it's consistent with the other
> >> handling.
> > 
> > The extra lookup only happens when the second loop had work to do.
> > Normally the first pass removes everything, the first lookup from start
> > comes back empty, and both versions stop there. When the second loop did
> > run to end, it costs one more lookup over a range that is now empty.
> > 
> > What I like about it is one way to look again instead of two: the loop
> > already goes back to start when the last batch ends below end, and the
> > patch adds a second way for when it ends at end. truncate is not like
> > shmem here: shmem_undo_range() stops after one sweep on hole punch on
> > purpose, so it needs the rewind; truncate was meant to sweep until
> > nothing is left.
> > 
> > Your version fixes the bug too, so I'll leave the choice to you.
> > 
> 
> Can we just do:

LGTM!

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

