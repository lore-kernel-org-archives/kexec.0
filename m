Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62704606A31A
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fjXH3O4j;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RP3OBUQY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=; b=fjXH3O4jD7EZ/Q
	XU2xgwGP1QudS1Zj5otcMMXtMu3AALipjRlF2JTdUEQsjzsB0fzKNnpFCh9VoRU+EDH+aMA07tpqS
	8ocxi/xikce/k2ZjMAhd8hcgkyXqOGQKxFwA3HObN2Z+LjusyeJbCZmYHPkcFqfMNlRyiBytAyKOm
	8gRX829iQVQgEysnlyr+DYfMiF3+/IcSIyax+P3TgsTR0XQl14XXW/5vtfNltS/i5hpbrGFlmXEQs
	W44E5W9CReR9NwHeBDYZs1dpWaowS9zEsdx/bqw0fEYPntJ65TV6AgjM7IarvWWlWOiV6jZDb6UQx
	zZJKUEANJFCViQZvmuKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl8H-00000005Tvn-0VbE;
	Tue, 27 Oct 2026 17:38:45 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLl8E-00000005TuB-1IIP
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 17:38:43 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6afac79b3a3so632a12.1
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 10:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122719; cv=none;
        d=google.com; s=arc-20260327;
        b=c00ILR02CW28TK9wrjWO0myAK/mZ+InLXqlWaoAPTZHYlGiH2fnnd3mVStaiMQtSSh
         vKxbwczOaXk2nZ+nMqXw9SrtU7HQ0jMwy55w6dnVxVsm93d0ub4U+YXrfgZ9NLudiMX4
         /CS7xAuEsVHMIeVjs1iKmAFwVPi8MxXViPjJWPJDAMHej7w+ntiRSWgGmHa63toGImHm
         jhghk1bqF5Gn32zDsai1i5G8p6VmwANhTVUS/YGzTxHmALIOk2HZGQF0jUk0Vt90pUDF
         +80ESegggsABwhtY021BtRyuAGDbu6xfhViXURtzMz4A/J0rOndU0C0JIZpwwA6Wk5+f
         nNzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        fh=tntBR+FtY5EPiEG/K/oFRkyrvNkOa5nxpUUkyf7vlEw=;
        b=AkxMgyCsHEG3G3RpCM2tGbuzyaKF16ML0Jfm4CZIKjK4IjmGGDOfw1V1QTR5bqza9r
         x6JyQWlPAqbMbnLZo+YWnU3ZrNzoHult8ZOytFM5/q97LJF7yekokzGIzvq2FCtDod57
         4XnUu/8xtj1Kv+h/0eBJqSoc+WblGuNhxtPAWbT2V0Jqf56En24Oy5xFwpnexmKHvbY6
         acCI2qFdn9qA/UyVT71PEN/t2fREcYJ+y9sYGyiL0f8gRKPJ1wrKaaCsDWB1Rr+f4aNN
         NGd4uLHe8G0sxa8Iq726Doz3igkRUQbRjBUUX9w1iGCylLH9uSqHxDuYrUyhbapVl8Yd
         2Yew==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122719; x=1793727519; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=RP3OBUQYGffoRoEmloZcwj8aiOn0ZEy+MGkThph7GMoJoTJyntW1knoqvnq449JQlD
         zkGCxyR09LPnpEaEAKgAF8lf98hk9qoilidHO7LF+5KEw2KNsrylqh8VcVBNgEjhyYn9
         VwdQnhV50IIe9NQTqsV3pYTYNCT0HFu3JcOoEvM4SmPhbaG23ZHxppFJXHE4dYfHhK9o
         6+T56k/yByjSUh2o7PVunGEinVqpP2zko/YSipE2WUPTHIq4GjoFcUlcf3HmcXjQNRvQ
         J93rDtdsVc1sghW9apATD1yxTrcoohHM10iLdsPXG2Ws4+5mCaSQ1jXyqEvfMS+pXtTo
         XU+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122719; x=1793727519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AYi2YiR3kh+gzZk6CrM84tIidytqPHRNR76c45jsmXI=;
        b=qKqmKNVF3pj5bGxpbn2MdbWjlazUnNRuPXQDPNliMnxhfmcWU/hHE8KkZhMnco0jsT
         8s0sBUdZVoiC2YR8g092I4ss49jckc8udsV+iQ5hnZNAh93zF7D41b+ln/vCNyQPQpR/
         rhjf6NpGAKO5uvxsJtP/N944Ur3acuuD7iVlgD6DBjdTlffaOqmQWf3jsswi7BKMJz10
         rr+qz3ogDraIPs5q6TKWdSbNeFapqbubB9ozKE/IAsnXo0Om0186AArlhcYr6MjsQ0VG
         /uKPZNRkCYOYHbeleTVq+04hiOvASjyXbbK3m/s5vHJzXVGm8r72gRZ3VdU6QqlUNrGQ
         ffFg==
X-Forwarded-Encrypted: i=1; AKwUvBwfxQNiN39aLkTnTY4eJFfj7fAxU3jlTOfAcMYDlbvhmNOCF88QkTPfr9rhZRqd7F6UPfOkYg==@lists.infradead.org
X-Gm-Message-State: AFq9FYIpo2CLET+JhVSfzLRyv+TtCguANG+6lChnf0Xjjh2qe5b6hsr8
	7dllGVi7mesOy9ebuYnJhxvQIQj1XsyKOmeZWqrR2YdA+ABWYkFbMApipUBo6hd4yIq54HHuNKM
	Q0+xGchZoCvZryDK8MoVSC/BBh0m1D5Dcm4JGZhxo
X-Gm-Gg: AYBFou3mZSvFo1mpdamIgVUvor80x8zKgli046ASfT+NEKaN6kRu20bqvxPiII9xhdA
	jNEEeBzLyiSWOvR8LA0z3dDUEC8LOsrCfwm8gxb9z80/0zzCF8B9aB+Tg+zIFPEqGkmTsa07CNy
	vqtvtYGCku4hQ9djMGlVAsV1vKCD8NqIVD59sc5sVuOpJqSpgEgf5/Isdcc2lE7SWZead6/5xS+
	EvHPl1tTSKqV7QIH4vtyEJSRVZYdhJxynTu92ob7AV160Y8jOy2nywe3srEXQIgHIGaU52snAtU
	YPzqT87fNrTPjCtnYKHt+aAB2WFJ/AkZfI58Herk8WGffSNHKMDfou0QeSFmKtD8xgzXARN76ir
	/k0Q9quzN/qRqN2iurrE+jQn8GqiBZNgg0FxqGDksHRUwoxr5v33hk2IcTxgJXxKEfQ==
X-Received: by 2002:a05:6402:a2cf:10b0:6b4:597f:50ed with SMTP id
 4fb4d7f45d1cf-6b4994c5b30mr2214a12.5.1793122718174; Tue, 27 Oct 2026 10:38:38
 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-23-6f74bec9a5bb@kernel.org> <auBityGTDQjXURWg@gremlin>
In-Reply-To: <auBityGTDQjXURWg@gremlin>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 27 Oct 2026 10:38:22 -0700
X-Gm-Features: AclHuK8I8xcfhrxH9JH4rYz28CrMoohsxda9QortkIHbiI93aH5ozWron9iLPAM
Message-ID: <CAJuCfpHEHPNj9DKOGbVHYCUsmLf==-XkhzBAR94gNt_ErhdnnA@mail.gmail.com>
Subject: Re: [PATCH 23/46] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kairui Song <kasong@tencent.com>, 
	Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Lance Yang <lance.yang@linux.dev>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Minchan Kim <minchan@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Youngjun Park <youngjun.park@lge.com>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-cxl@vger.kernel.org, stable@vger.kernel.org, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_103842_386484_B1850909 
X-CRM114-Status: GOOD (  19.18  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 1:43=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> On Tue, Oct 27, 2026 at 12:17:43AM +0100, David Hildenbrand (Arm) wrote:
> > userfaultfd_unregister() wakes pending missing faults before clearing t=
he
> > VMA's userfaultfd registration. With per-VMA fault locking, holding
> > mmap_lock for write does not prevent another fault from queuing after
> > the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
> > waiter can then remain asleep indefinitely.
>
> Oof.
>
> I guess userfaultfd_clear_vma() only implicitly takes the VMA write lock =
via
> vma_modify_flags_uffd().
>
> >
> > Call vma_start_write() before waking waiters. Existing fault handlers
> > queue themselves before dropping the VMA read lock, and new readers are
> > excluded until mmap_write_unlock().
>
> Clearly an oversight from the VMA locks work. I guess was always a Hercul=
ean
> task to catch every single point at which there is an implicit assumption=
 that
> mmap write lock ~ readers (esp. faults) excluded.
>
> >
> > Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
> > Cc: stable@vger.kernel.org
> > Reported-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks!

>
> > ---
> >  mm/userfaultfd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index 669f71d485d02..7e30b5ff17be1 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaul=
tfd_ctx *ctx,
> >                       start =3D vma->vm_start;
> >               vma_end =3D min(end, vma->vm_end);
> >
> > +             /* Prevent new userfaults from being queued after the wak=
eup. */
> > +             vma_start_write(vma);
> > +
> >               if (userfaultfd_missing(vma)) {
> >                       /*
> >                        * Wake any concurrent pending userfault while
> >
> > --
> > 2.43.0
> >
>
> --
> Cheers, Lorenzo

