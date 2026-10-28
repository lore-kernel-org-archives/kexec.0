Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942060A260B
	for <kexec@archiver.kernel.org>; Wed, 28 Oct 2026 16:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=15tMIBmY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UVcznA9A
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=; b=15tMIBmY4q31bo
	06M1ZCsramIs2CQAevKKi/IL4IGM0KKF2pgegKK0bhMlZI2N4wwjfXCpJYVXv2t3Gxlw6LQ6LJUnt
	cPFvg+tZeAmtajfYa1FLE9FLPLgf8s2gJOBC5OGvRgZrFqO5G1AJg+5yKPOmhyCrbp6Eiq0nC9khp
	qlxG5hUtcIuBaRD0Fpx847aN4bpJJp6nBKXpmkuQNSgMcEN55gxKuA/PnG150uTD9N4d0J4SHP2XL
	tiXCwLfc+3Hmq53UBwAxS4p9GPG3rVva3BuSV1hWyaGR3HFHj5PXwqi1YlJKiLd7/vSoBgz3ZRUbr
	Bo/UKZyR46r0OhtCd1Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6vF-00000007bM9-42yU;
	Wed, 28 Oct 2026 16:54:45 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM6vC-00000007bL6-3Lrp
	for kexec@lists.infradead.org;
	Wed, 28 Oct 2026 16:54:44 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so190649066b.3
        for <kexec@lists.infradead.org>; Wed, 28 Oct 2026 09:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793206480; cv=none;
        d=google.com; s=arc-20260327;
        b=jmjM6U9t+6RRIbbnv+awcNcDiRTj1nKYU09n69GzoglrEDa4CQFaEZ/FJLvDc4n0Xi
         0lNvEAKYM16PrnETYpQx2b1ZcoOd6VfvgebEf1qMCYzNEnN+uX7SRzk+5bmT4PmAOPZH
         hUhmrxxxdc0D+kcy/lMMvEDaxURZmuDlE7vs8WA1CQAyZkB5QE4SVsj/GsujAA0zlE+A
         EBTuKbW8a/onYGNc5tOmnVGukrknCVLJqZ7AlC2sEYGPWMjPuy7xVunIaQ/AcF9LZ2aW
         Z/45b24jnEQM+zaMXOKvzCiw681qL8Ur+l9O6YKsUPcz+BJwSYyd2IICEEQ61spboNeP
         sTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        fh=yhjDWp0DyxpAafR6sJ0r1MYA1KdKm0pmh5olePnTbPs=;
        b=Mhjd79y0hGrjQbIRq1+dcYEhu22snkzO7Co+CcTGaYEq2L2Fy4+MKuVfwJXMTmCbmu
         P0km6fSgKltYhrDABU4OgKzveNHZ76bdNmNVGifu/F5mc5HvGWh1cBaK31kKxNhFPTP2
         5N1ws4texrqvmJ/HLnZ3IPyhgivUZKYkNXIwQSYCIQ26qxkNxHaDztWbhwHksCw2622t
         OCuIvjC/2vi5pwZWmD9/RcPpoAZ55CamuGqFDiIT1/wGJvu3l4pjKjN7oLdO6g3ypX7U
         qY+zVc7/nQXsUmE2bj5KIKXZYob3Wr0A7CScR3zYIOJdyVwQuSPfd24GtoFJFJdM9lhP
         4lKw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793206480; x=1793811280; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=UVcznA9AEqIWLw+jXrGSc4sIFgBVo+es3uDjAxguQ7ZYdMm0/20+FZvZ+EtDTtKGA9
         rhCTxesGQz6lISMic/iITnSlTS2eQ6i5TuRCZqWxSEQbhaJ901S0VWbZtC5kc8N6exlD
         Q7ZXFTKd2GbtZr7gUr7Ulf7zj2Z+jTQuOE0UtfFhdo4JFc2rNjaA60eyoN+aFavTyC7/
         4j2DVMNaBDeTnaeWvk/iaQAe83OqNoXqBJlP0fTs+fizllmtKCew7HSSd4iZwfF2eEzg
         9udUTxDEAHqOseAv9+XrIuHF3pySeC3VMAMhCmFw7p5goRLWKVEA1zoFdckAc8a4ub6j
         /7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793206480; x=1793811280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3ystJhrkZfs4wDwVdxIpAnqZwF+5sjgEnOhfYS+4Ds=;
        b=ljfIGfTSr+U2TJbSKzdlnqnF3pHS8CmNUV+uaqwba5BvWZPJ4IS7MFJfZMuMtftmwr
         r6TcLocy1ovA+FYsVSl3uvA8j37SjostsU+8HRRLhBcvBMJJVmf8Dq/fDoVvD1Iq1udW
         hoQNRusiScTsaEHDPKQ+yMQqAzMmrLiJNNBDonD7sEfmYUY1MitXXJXfL8MHQKB0Ubvl
         jldh2eMVCoeRlUHArThlsA7psyatvyFP8+LEN5GdiDU1pZwtud7JASFVzhoKuD6hfJcv
         SxvN5yXhy3q+TqAvDp932hEevxE7DpPZeh4myj/TsdnAKnqiJ3gya0Ad7wFuWQFSXUZ1
         Rkzw==
X-Forwarded-Encrypted: i=1; AKwUvBxea0kt7iSTVF7sJOc7itpUjRu+lgI075KlMADBg/O0hiGkxRUq9AspKi+H0JEXatPBE5hO1w==@lists.infradead.org
X-Gm-Message-State: AFq9FYIBH8qs0qK4CgR7RlVlPNzc0GeelH9+yFEuEpluBTyzPxeDeTBu
	3cStSPo3n5uvueuce/Qgzg7lSR6ZH5PSx98dpCcMCwCWqx5kCjqWkoriCs2asKXet4t8ThQ1gui
	4DEWlXineRtNxBUzhJFvHUZG5Q8ScpTg=
X-Gm-Gg: AYBFou0SSWVsdjVrBn+dBwRtiubt8yKLPWvt1TKLSqhOLTERM69rq5j92XuvdkMOCQ0
	2R7/EeESqXKPUiUDwAsm6ic5EfstLZpdV4bKe1jjswQ/+TOjaIjw1GeWsi/Jev3gi92xR/Ot87m
	rjmU/nuL33u6+Nuavlv0Li+MryoXRYvBF8G7Zto4AO3dDA9YbPUc31bF2LXQoR4iprtbQE3WmD4
	SmmOCmgGpRBuzb8ZC6HLKv/4Xi7lxDpSjvSqiaUvxXLOseIrdIt2dma0f3Psfb6LcmbJC3TlZSN
	i0bHXMfGaKskz1MeBkD0EcevdSixDXSYIiX+R9CdCncXRGZzwIyWQBfV/6Hta03cWfyxGnGZ6nD
	oqv3qCwoqk8a7POkdeV17yZgC7XweHR73ejGp4blJ6E1s20n50sc1RuMzHmpQiW1Rc2e3RQ==
X-Received: by 2002:a17:906:f586:b0:c46:5973:2a1c with SMTP id
 a640c23a62f3a-c49be00bf7amr248310266b.37.1793206479455; Wed, 28 Oct 2026
 09:54:39 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
 <20261027-fixes_core-v1-1-6f74bec9a5bb@kernel.org> <auBbKP8UNI9talDL@gremlin> <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
In-Reply-To: <e5766fe2-6cbb-45bc-bc57-87314c130de8@kernel.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 29 Oct 2026 00:54:01 +0800
X-Gm-Features: AclHuK9Ir5cjQUbkmvsMXXN1XNQvMKyhNeup0qo5sC4qB6sDOiJzphX3Pz6BQcc
Message-ID: <CAMgjq7DzLFcznTqVaRneoN+qa9StPTvcBwHMdLM52ZbfZ-ffEQ@mail.gmail.com>
Subject: Re: [PATCH 01/46] mm/mglru: don't use stack pointers when walking PUD
 and PMD tables
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
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
X-CRM114-CacheID: sfid-20261028_095442_866678_28309137 
X-CRM114-Status: GOOD (  22.44  )
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 3:07=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 10/27/26 09:06, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Oct 27, 2026 at 12:17:21AM +0100, David Hildenbrand (Arm) wrote=
:
> >> From: Josef Bacik <josef@toxicpanda.com>
> >>
> >> MGLRU passes stack copies of page-table entries in walk_pud_range() an=
d
> >> walk_pmd_range() when walking to the next level. These copies can beco=
me
> >> stale when khugepaged or MADV_DONTNEED (CONFIG_PT_RECLAIM) removes a P=
TE
> >> table concurrently.
> >>
> >> This pattern dates back to commit bd74fdaea146 ("mm: multi-gen LRU:
> >> support page table walks"). Likely, earlier locking masked the latent
> >> bug. Later changes exposed it: commit 1d65b771bc08 ("mm/khugepaged:
> >> retract_page_tables() without mmap or vma lock") allowed concurrent
> >> retraction, and commit cf4a65539c13 ("memcg-v1: no need for memcg lock=
ing
> >> for MGLRU") dropped the walker's outer RCU protection.
> >>
> >> The fix is simple, so just fix the original commit so we don't have to
> >> speculate. To fix it, pass the actual PMD/PUD pointers. This restores =
the
> >> RCU-protected lookup and validation against the live PMD. Note that th=
e PUD
> >> handling is required as well to handle folded page tables correctly in=
 all
> >> cases.
> >>
> >> Fix generated by an LLM and sent by Josef Bacik in private.
> >>
> >> Fixes: bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> [ david: handle walk_pud_range() as well, clarify+simplify description=
,
> >>          adjust Fixes: ]
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> ---
> >
> > God, terrible. And why does MGLRU feel it needs its own independent pag=
e
> > walking mechanism?...
>
> It's all a big mess. I think at LSF/MM there was some talk of using that =
also
> for traditional LRU, but I guess it might take a while ...

Right, there are reasons, MGLRU's page table walker uses a bloom
filter and have some zig-zag avoidance. It would be nice to fold that
into the generic walker eventually, but it=E2=80=99s not a high priority ri=
ght
now, but we=E2=80=99ll get there eventually. And using that for CLRU lacks
support for lazy promotion so I'm not very sure about that, but still
things are being unified bit by bit, so it will at least looks better
step by step. :)

