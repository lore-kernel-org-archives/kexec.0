Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F98606A31D
	for <kexec@archiver.kernel.org>; Tue, 27 Oct 2026 10:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FQesHFM2;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KSHdJQDi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=; b=FQesHFM2mFsLxD
	f3TfYE2sJpW3pt0TIwMLKX01lsZdobLotwBCXjtohPrMPBK0gLV0ZAz7Js3hrTp6jsoD/zQTrZU0+
	11vFUMaU+c4FpgjAC1IlNyTl7R5J/LuAoP8Lq8fp4FzdC8MB6b9IaQcLmXQzVPpOtgv+9mnlwJL8P
	ygfhWTEdS1Y3vzOJxC+VNb5/OOHV19x9Eyhah00S/Fiam+T6PGWomOWF5YNuMf7Ob9YEbeovVtBLq
	RdYhwxvNPXvUX7KWxAluouiOnQ8adxtB7vJiswUE9x0XGrHwcYyCvq/VEf0OoatbpLiUV9cr2gydD
	4uAtxdBcdQu9p9O42BNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLeKm-00000004I9R-2twS;
	Tue, 27 Oct 2026 10:23:12 +0000
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLeKk-00000004I8v-2VFh
	for kexec@lists.infradead.org;
	Tue, 27 Oct 2026 10:23:12 +0000
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-c34bff61551so580856666b.2
        for <kexec@lists.infradead.org>; Tue, 27 Oct 2026 03:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793096588; cv=none;
        d=google.com; s=arc-20260327;
        b=GEI4OPxAKfIzfvypj70K1GehGZtWoiYFJQ4/cuLWS+iAETsIQSSFK14u8wxF3h5QGt
         2FV/ChHEpS7x+4kwNnapROWwWlK9eVveCeFO9GTQ/rLpv+45Q1UN9OHxMYYlsUWshYGr
         B4ckJGRxWeepUYee79+blRnVJ/Yl02puKGuBuN/6JqJYXvqboamY8VE3y3v9ABJaIpA4
         0Ue5oHSce38jgi18sH3LS8rf97EccumbEBEEBkj0DOMrPiX246/bEDEPpCVhX9UezBVh
         1MtioEceQdW0MLOL7PzdA0ynGflnCJFy13KRfPSnSwTSb1TeAzejX0GxNsVVJTEnLJMz
         7e3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        fh=p8ytX6WhralnpZr8wxDnje19GH4Muon+vbzXA6A7uHU=;
        b=hrgwWLI5j+xNwoZ0rthlkkHi6xq1se2SZNQP97G6aeEYKsD+sVEVcChS/mKlTCBoEQ
         uxl6ai76P48JeQ5a9wK+Wzeb6L+4xH2i2/DcaWbMP4QChZsBwEf33pwOGQxyBGdijEBh
         VnbAbz3LWqf00Z/oc5bNEEHVlh3wt7e7GQMAzn+qDnwHE1V8js+azMRSGVXUS/FEBy9t
         1/5QAXMJVvUA61d84umbrH9LEkqn2W7hX9YRNcHHCn+BIthcJB+CM3Fnq7CPKIxuusmN
         OkkyTVHbU0WCSUPjFEmvEmVeBU4W5zY9LGCwpZ63aFzQTeLW86vcAa0zvz5lkmzu8pz1
         ioYg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793096588; x=1793701388; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=KSHdJQDi30FpwQr0SXlS9NocMXvYzGXVMczW2qfbAwIc1Kf+9y2+bp3cQ9n7MbhcDJ
         10+EnLlkHT2zAQ4WMF4ufgaF7T9JHfGQLhiGhqjVJIVkH27o6kXOY6aoRMNwMb2R3o0i
         TokCEmoIL/3hmqyfIihjqaW86epAa5USlKpzEB0Hr0HEVtkqBbEGF5wb1nQ/oPgViUuJ
         fQ7ixnfTzfnFyq5qv5pf00zr5jcfEwxyFbyq4QIOOCvq1M7d5dn6M+naGRBGfxVnDBdj
         jfYfaL1xvyvs92/DML7yGKnxdCIi2n+Zmn/Eo6OKE+VXEw4DfYCTw/RT8Ww5UtteEMoU
         dIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793096588; x=1793701388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuWBfUhRw2eXbrJVRrdIsgOVF/qwEOWqwz0sZ/JDeUA=;
        b=E0GaSATOCF5tBKQ+3hlpVgf2VjikCwJBQyq/ny7AWiA7esUDh8/H3AsOEIXN+Mx+4b
         hK/O8cyb6oaIXQanCrPqxR54OyHoYMwmXoNleJlM0CHEUOTW9gzXPuFVI+Yiqhx1qnj3
         oQ7YXvJfK3DXMzjA1Y9zGUTWhi9Lz+nNE9gRgaTdLyHoQivxjuJM14RN7lqTcP+CkerQ
         +emVYOcfKnQgCk6uh0kNSHeEw8erQkbXRlviqnUYRzhKl629LD/iFwAZ8E6sinAavxGX
         QhBoMzRR6wySS3ZwdAVo1R3KITFv2B38AhwYfwYD9SvqJTZxQiu98ddRSR+YewgQxMRM
         fhZA==
X-Forwarded-Encrypted: i=1; AKwUvBy2a/LZT3FDdAAjb9wxKa15MxSdyndivy49KKKfajqhwGC/uzmaB4YpNwnfxOKFQz8NXqShlg==@lists.infradead.org
X-Gm-Message-State: AFq9FYJKDiTpCmnVpKhXxHhxgz2T+VPUH5Jgv0e8J4G+ieqGb0wVviij
	kAPjcjXIzMFEAcZyIIuTosxn0xcm34tsALO/dv9DSR5HVIIQaIPGRVkOoVMfs6vnUs4FBSKB5up
	qmNaPl6d4OtA6+keujwPSzMHKvNbeyRQ=
X-Gm-Gg: AYBFou3MtwVsadLhanTeVoLa2jKNBcbqf5RzNGwpFteWxQCYhu6H477Dkrmwrgk/MOV
	QqWUGHl/lI7Hl0HKUdN2b/vnh++pg434MO9vsyLmVwjoaGHrYEN+7rPWYuflu2osziQ6MQtQvKN
	AeHHhCJ802lDwOJLYRL5fBXxSVza7U4sMaAkBifSB9amSAc30vwJFSP9rAeLIj8LtCUTM0eHtbv
	INymmuU9vp6tOt/z1pAdSTz6Kzj3iqS3HG1cDT9oUt6NIFp1A0yN8cfn3QvKgV/rcKGo0GLvD9O
	8ghYOO/N5CJpUdx+M7p+DT4nt2kf0AKgl5UOX0ais9o5hA2qNQ+g0/NylW2dvnnJTrFweX9YRFk
	z4FpuP5hxenroUPk6ZdG+7Bh0nd9CQbP6uQzWnjzhATIVWf/rzMBICnxumZO9lncYyDl9Kw==
X-Received: by 2002:a17:907:86a3:b0:c31:5bb8:4b3b with SMTP id
 a640c23a62f3a-c46bdaf85e3mr1028439166b.2.1793096587718; Tue, 27 Oct 2026
 03:23:07 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org> <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 27 Oct 2026 18:22:29 +0800
X-Gm-Features: AclHuK-sc-Sst_xgCP0rWexz2ICrmdMlmxE50eDjh8zWXXtcyxqz8s5Avp5yS-o
Message-ID: <CAMgjq7CgeA5OYUuXAQF-PQ_LkmsLw2V3VzRwPUdMYTcGCmYCbA@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
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
	linux-cxl@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_032310_666821_9807DBC8 
X-CRM114-Status: GOOD (  17.17  )
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 7:18=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> From: Josef Bacik <josef@toxicpanda.com>
>
> MGLRU passes stack copies of page-table entries in walk_pud_range() and
> walk_pmd_range() when walking to the next level. These copies can become
> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a PTE
> table concurrently.
>
> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> support page table walks"). Likely, earlier locking masked the latent
> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> retract_page_tables() without mmap or vma lock") allowed concurrent
> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg locking
> for MGLRU") dropped the walker's outer RCU protection.
>
> The fix is simple, so just fix the original commit so we don't have to
> speculate. To fix it, pass the actual PMD/PUD pointers. This restores the
> RCU-protected lookup and validation against the live PMD. Note that the P=
UD
> handling is required as well to handle folded page tables correctly in al=
l
> cases.
>
> Fix generated by an LLM and sent by Josef Bacik in private.
>
> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: handle walk_pud_range() as well, clarify+simplify description,
>          adjust Fixes: ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Kairui Song <kasong@tencent.com>

