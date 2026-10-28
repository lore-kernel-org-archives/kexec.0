Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C171606A31E
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UAv0tOva;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=tEm5XV3K;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3L4wVEOZ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NuxsBLoI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d7ad5oBI
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=; b=UAv0tOvaCVw91Z2B7keF4zp9zT
	jGdSABKUrBS0rsKrVMM99UGQgkj3ZILcm5BwQLVFmDGYdqVgK0yzc/62zHJHWm+e3bbtXuWe55eky
	z35mY5lcyeum75ynK9U7GsdlEFEyBfSu9QVDArKEL02MpZI2WgcrUcgD2ZoDSRVeUUe58A/vrny6t
	oVKYH/pQNjShWYrCfDf0EmbHvTebAGhlp5TgRzGGHHBut1EdkAgsDZ1kXqx+ZUiAxPDe24bdV4rL6
	1PNjuyihEdgCRQ7CNz+rufCS6QYIIjq6cjiDE25xHHaOxaCigtHLDDd75taipLMehXfA1Gk0ZcYLS
	+LWe02lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM3BT-00000006zS1-0BHY;
	Wed, 28 Oct 2026 12:55:15 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM3BP-00000006zRG-3Yrw
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 12:55:13 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D40FD2213F;
	Wed, 28 Oct 2026 12:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793192110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=tEm5XV3KjbEjA41ZoYQtFK15SnyJr/jro2kAD7VcJ5Nd+xXCeh4MOSDOSl4gs16gOuMj1n
	2xE3J3A8sl5Ltrq85nxbmFf18x515DUo74zEDgzkeO03pvq4GMkN0dvsQ2UQX/6VJbcXMi
	2SihNsvbiknM4tPeVmrkd8edOj2h7vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793192110;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=3L4wVEOZnbwLwpiT/6p/yUN1CGm8BCBGENEqGDXYvBfXN4ALX7tkweq+NQgRINIks9l6SY
	Oj9hq1SccSlw7FDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793192108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=NuxsBLoIZe0RCX6eCWMO4BBI2zD4MDPTwQN+oGb/8EVr6QFJtbQrfT5EbmRflQ0wO1Fq9+
	IiN60C3UHKnxFucRljWSZMNVNDbWigF0ESpMoTysxKkpo6/YVc07F+3JRBXFFVsBG8uZ8G
	IeyoyClDdnZWvRm7F4ix8zVnXzU760c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793192108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar7R9QMU32qAcY23nIeGRlAcN3VSNOddD17DmoDp+Wk=;
	b=d7ad5oBIDy9uyvYJSfVkcYBqi8kIr0BJCTIvUM3nFJwDeXTA5GEVesAI5PARxFiR78fYFd
	Yu8Y7PsZt+zW+8Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6B0113419;
	Wed, 28 Oct 2026 12:55:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UmP0JKjw4WpyFgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 28 Oct 2026 12:55:04 +0000
Date: Wed, 28 Oct 2026 12:55:03 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Barry Song <baohua@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
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
Subject: Re: [PATCH 02/46] fork: take mmap_lock before copying mm_struct
Message-ID: <auHve-G8bboW77IZ@pedro-suse.tail5790ac.ts.net>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-2-6f74bec9a5bb@kernel.org>
 <auB-3BQn_rR6IfY8@pedro-suse.tail5790ac.ts.net>
 <22b819a2-631d-468e-b724-770caf9f94e4@kernel.org>
 <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4z3qgCPBpCDitVTq+xiGsS=-yEhKSbEO4Lbdn9MVAHK0g@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,cmpxchg.org,linux.dev,tencent.com,google.com,linux.alibaba.com,infradead.org,suse.com,soleen.com,suse.cz,nvidia.com,surriel.com,arm.com,intel.com,redhat.com,gmail.com,suse.de,huaweicloud.com,lge.com,gourry.net,sk.com,ziepe.ca,kvack.org,vger.kernel.org,lists.infradead.org,toxicpanda.com];
	R_RATELIMIT(0.00)[to_ip_from(RL8d8xedm6iu8o66torxsk6bwd)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_GT_50(0.00)[65];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,toxicpanda.com:email]
X-Spam-Score: -11.80
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_055512_186180_ECC23EF1 
X-CRM114-Status: GOOD (  20.73  )
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 03:48:09AM +0800, Barry Song wrote:
> On Wed, Oct 28, 2026 at 3:07 AM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 10/27/26 11:38, Pedro Falcato wrote:
> > > On Tue, Oct 27, 2026 at 12:17:22AM +0100, David Hildenbrand (Arm) wrote:
> > >> dup_mm() copies the parent's mm_struct before dup_mmap() takes the
> > >> mmap_lock. A concurrent brk() can leave the child with a stale mm->brk
> > >> and newer heap mappings, causing later brk() requests to fail.
> > >>
> > >> Other operations (e.g., PR_SET_MM) on the parent's mm_struct can similarly
> > >> cause inconsistencies.
> > >>
> > >> As a simple and robust fix, grab the parent's mmap_lock earlier. This
> > >> way we don't need to update individual mm fields in dup_mmap() and
> > >> keep missing ones. Stop updating the 4 existing members (total_vm, data_vm,
> > >> exec_vm, stack_vm), as that is now no longer required.
> > >>
> > >> Keep releasing the parent's mmap_lock in dup_mmap(), before
> > >> userfaultfd completion, to avoid moving the userfaultfd handling into the
> > >> caller. This should get cleaned up later.
> > >>
> > >> Move uprobe_start_dup_mmap() to preserve the lock ordering.
> > >>
> > >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > >> Cc: stable@vger.kernel.org
> > >> Reported-by: Josef Bacik <josef@toxicpanda.com>
> > >> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > >
> > > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > >
> > > FWIW, strictly speaking malloc() isn't usable in a forked
> > > (multi-threaded) child, but glibc/musl provide this in a best-effort way.
> >
> > Yeah, I'm more concerned about other things that can race ... :)
> 
> Regarding the race with memcpy(mm, oldmm, sizeof(*mm)), we
> still have one [1] even after this patch.
> 
> That is, copying mm_struct can happen concurrently with
> lru_gen_del_mm(). However, this race doesn't seem harmful.
> I might be missing something here though.

I don't think it's harmful as well. mm_init() reinitializes those fields.

Though I hate that memcpy. I think that ideally we copy by member and
data_race() benign races, like what is done in vm_area_init_from().

Anyway, KCSAN reports aren't the most serious thing in the world, so this can
(should?) be cleaned up later.

-- 
Pedro

