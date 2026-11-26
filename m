Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEC606A323
	for <kexec@archiver.kernel.org>; Thu, 26 Nov 2026 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CblkEZ3x;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i5VpbuPf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gzjKwk0Le2x/UkisX7hnImUaEzdnPPlkkivbYquJqUY=; b=CblkEZ3xCNUvwZ
	T9WBNSD+yzZfghYYeRrdM45QLJJmPwzpE6roKT7fj4Dee1mYLyZzCP3dk6Pf1wB4Md68XrwAAk46J
	YJT/3KmPLdVVCSuP+JJ02Uo9PMaTztVfe78bzoY5QgLtYHD5lKGxp47LLa9BJNDXzDkPOyXNVJ+Zp
	zCwWS4Yto5aA1TPzC7rnIEKsbR3Wn7j4btRdzmet+kb7ymPqqOb2qVs8qUJmdIuC3Qwj5AsfQJQMo
	+b34VD8A5gW+8+GPsxbn7CWU+ABNCd5yH4ZXfPymPCidEZJUF6uV8Odg644tXQ0KcysF39/7puzXf
	RvxZ/98XHNt/zP0pPzSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbDo-0000000Di7Q-02PA;
	Thu, 26 Nov 2026 15:17:16 +0000
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWbDh-0000000Di6R-2LgH
	for kexec@lists.infradead.org;
	Thu, 26 Nov 2026 15:17:14 +0000
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-8b531cd9bbaso61621777b3.2
        for <kexec@lists.infradead.org>; Thu, 26 Nov 2026 07:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706228; cv=none;
        d=google.com; s=arc-20260327;
        b=feswycrU+Ga3K7thonpLm5yhtZF0U7Z1sm7muT5I5hjb5hDDaRFYjhVJd4sKiuJOrC
         hKFkY7yFClSdSrAmiji5EIY69ITZGIr3CrM6xpeV2Ypa/jJUxMxlo7nDes1cjCnfJ20I
         +WkPgt8wCTZsoa3Vhj3nyR91uveOu+pMR2JwbPNDepJw4NwKnjKtfZs/K93Rrg9+pwvG
         EdoCcOEGxma5Xaw04mw6Pg0y5uZ1zokggvs9aaV4SbvWr96Yjs65+EnOYT9fPPENod6G
         mcQJ2q7X8x6ZSvPQWlIgDptkmPSJdObN+fJ4daJ8+4ggmt2PSpXodad5loNyItfRkfXt
         nluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gzjKwk0Le2x/UkisX7hnImUaEzdnPPlkkivbYquJqUY=;
        fh=NLWBj23186OyoUz1jCp5b2/MHQ21WzKe5lmxD1CdXP8=;
        b=dsfH8tHxS4J2/YPwxnGHn1EK+mMJQgCMUsrEr3cGdaxvasdwQ46Yf+iXRgj4lr4Gje
         Xf/kFxisTSj+t0iu9G/QPd37Coj19W2L5zqufu8yULZphJghqcJYxiXb9/J4qJaJ0i/f
         3o0d4KZ5KzLVLxBgUh8hETyx03mM3GJHtHoZHpP6KNAQHTNmFCnLhl8DC1J7QXrSBTr2
         21+rAB2XXiTKqOGkqRo9qq8u8Q7sFw6oJ0t/t+cPF5MaLjNB0iwoAnuypBnPhISkxVb/
         MAmGHK8U5xwV0X1ymLyeXI4heGgIludTfaWPwU6OzMfehudPKDlef10zXBCx4/+6MvH8
         fa3w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795706228; x=1796311028; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gzjKwk0Le2x/UkisX7hnImUaEzdnPPlkkivbYquJqUY=;
        b=i5VpbuPfUcPjiJ6Ab3wPOx44F4ljozeR98v8LWDxhXXOByFASYXQpuDB/D5on9js6/
         r05AZT1srkPLNXPg7fLd5Y/wya7WP48oX4gnS5ORHQCD47Ii28Pf4uXT81oYOyBxpLKO
         CBNl0OltFUDZjOTJxfFza8OuTyKc6+U+TkengeLQjagPu3UhWyf/LNSMgCWah+ai8EXY
         u5UZNaU9YoS8GXvQ8eLrAHlZJIgLJzCbpGkV5ebiW0f1ZEqad5ip8F5lfcRiR19f0l1T
         hFx4pWMxotYuze9F20WqXGf6PH/G57zY+J3iagH2oMhDoW3nU90UgLEncFHcDSRAEEDu
         H7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706228; x=1796311028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gzjKwk0Le2x/UkisX7hnImUaEzdnPPlkkivbYquJqUY=;
        b=bRsTtxhQPZfXrPdTuE9EIZGMxKVpoSlxGLJMfiPGZzAljXX14i8VfugDrVx77zNFgk
         lwIY+4Mpe/iJPuMWYmnKqLz2aDgo80Aq8KTr03rL7/fl23UfoQxcq6QKndfkMS5xx51G
         LQ1+WAF3LZrTi+mh9ys8Qk6kTgj1wJr5F4EIIUJlr0ugc+XKiQzSAPHudRylMS9RHyBz
         WLFocDDtwrEXbGBNr+YP/FPeVjlaK1k7QliYNAHkzRjcVwP1aQjFG4cmdRlb2tFuCCA6
         CufMEeHjIESYUvTTX2+Fsq/F9tENyAXHidTVVMA8jIuEZ3f8gSigXJ87yAJCjOOC88j3
         sFaA==
X-Forwarded-Encrypted: i=1; AL+hErEYWOelCTBL8WqPE1l8JZUqsuuUz4DtL6+rNKNwuqCxguY9fLBDtbOZj0g06gXbeS1mcx8Y7g==@lists.infradead.org
X-Gm-Message-State: APuU4Z9IPteaDavAjeHhA4Gtmz3Cz1HXaI7IG04gAOd+06wz6duuwh4v
	D9lmko/mw1e+BdPWhxVe1LDnDqCxrCtvq5H3AWS/xlF1QYa94/bytqvDaqLjBoaA1JzgEnGqL+4
	uIKH3BePVHB3RvM8PoAfwGfLCGZcgqvU=
X-Gm-Gg: AZFdTZe5vj9PZsXpiD+lbYFX+afQCYsLyhv9hNOVwmaFk30NAInzw5koLkhh3OZUR2+
	ydfiWVK53r794YgidTu717xpp8Zj6xws1Kpq5PJnDBkb655nWVbH3XQYOhGFbcGa0GNuV8xuFuo
	uEgbq7yhyLqP0An/h6a5vWq/k5Vu5ByNXHe2HYRX0EpBoa47rqRb7sZ9qDm72xo3XqZv91wxj9v
	T5Z8GOMpJssB0n/Cd85S1VCTOazdrLkzAhtjuBYjQOFUjlRmk2XdveUlGZ0J7NoRx10ly3d6cpx
	SrGzMX32oq7m+yhLUf+UNX7ylw0Oi1xtUriUMvu3NkqyvWM7qXtO89TX9oD98b4a0TfASqzV/oH
	It458zj0tLjQsusos3j2Vu5LnKAVOc1zoeIL5/xNZq1z9leFs9bv/CvXrO6V5T5pVjQ==
X-Received: by 2002:a05:690e:d50:b0:67d:a3f0:7d98 with SMTP id
 956f58d0204a3-67df4487e2amr8033601d50.81.1795706228153; Thu, 26 Nov 2026
 07:17:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125155108.24098-1-ekffu200098@gmail.com> <1b0242ef-49ad-4d7d-820e-d1e6569eacf8@linux.dev>
 <931acd3e-0689-4517-bbd2-d06109ac4a6e@kernel.org>
In-Reply-To: <931acd3e-0689-4517-bbd2-d06109ac4a6e@kernel.org>
From: Sang-Heon Jeon <ekffu200098@gmail.com>
Date: Fri, 27 Nov 2026 00:16:56 +0900
X-Gm-Features: Aa3M54onaw8MJYDddQT_3nYWVFohYsmtAwqNoqMbydwkYedoY5CvfFd6KJvm8zY
Message-ID: <CABFDxMGzXM2iQjv9hLVnrDTrXfxhJ5NHkXiiucciHo8eMGn2ag@mail.gmail.com>
Subject: Re: [PATCH] mm/cma: reject long-term pins of HugeTLB folios
 overlapping crashkernel CMA
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Frank van der Linden <fvdl@google.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Jiri Bohac <jbohac@suse.cz>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_071711_839878_B2D09759 
X-CRM114-Status: GOOD (  27.85  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi, Usama, David, Michal

2026=EB=85=84 11=EC=9B=94 26=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:07,=
 David Hildenbrand (Arm) <david@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> On 11/25/26 22:49, Usama Arif wrote:
> >
> >
> > On 25/11/2026 07:51, Sang-Heon Jeon wrote:
> >> crashkernel=3Dsize,cma uses existing hugetlb_cma memory, so
> >> crashk_cma_ranges[] may contain HugeTLB folios. HugeTLB folios allocat=
ed
> >> from hugetlb_cma can be long-term pinned without being migrated.
> >>
> >> After a crash, the crash kernel uses the memory in crashk_cma_ranges[]=
,
> >> but a device can still write to a long-term pinned folio.
> >>
> >> So reject long-term pins of HugeTLB folios overlapping
> >> crashk_cma_ranges[].
> >>
> >
> > Is spending the workload to protect the dump the right way round for th=
is
> > option?  kdump.rst describes it as
> >
> >       This reservation method is intended for systems that can't afford=
 to
> >       sacrifice enough memory for standard crashkernel reservation and =
where
> >       less reliable and possibly incomplete kdump is preferable to no k=
dump at
> >       all.
> >
> > so the dump is the part the admin has already agreed to give up.
>
> We have in there:
>
> "This option increases the risk of a kdump failure: DMA transfers configu=
red by
> the first kernel may end up corrupting the second kernel's memory."
>
> ... but I recall some discussions about short-term vs. long-term vs. cma
> discussions.
>
> Ah: https://lore.kernel.org/all/ZWJllXCN0SDIELrX@dwarf.suse.cz/
>
> "User pages for RDMA, should be pinned with FOLL_LONGTERM and that
> would migrate them away from the CMA area.
>
> But you're right that DMA to user pages pinned without
> FOLL_LONGTERM would still be possible. Would this be a problem in
> practice? Do you see any way around it?
> "
>
> And later (me):
>
> https://lore.kernel.org/all/04904e86-5b5f-4aa1-a120-428dac119189@redhat.c=
om/
>
> "What does "short" mean? At least in theory, long-term pinning is
> forbidden for MIGRATE_CMA, so we should not have such pages mapped into
> an iommu where DMA can happily keep going on for quite a while.
>
> But that assumes that our old kernel is not buggy, and doesn't end up
> mapping these pages into an IOMMU where DMA will just continue. I recall
> that DRM might currently be a problem, described here [1]."
>
>
> And in the end, we settled for the 10s wait, crossing our fingers that it=
 will
> be alright :)

Thanks for the explanation. So, the possibility of corruption of
CMA-based crashkernel is already well known, and should be taken care
of by administrators. I also agree that saving memory by reusing
hugetlb cma could be very helpful, and it's not a good idea to block
that.

Feel free to drop this patch. Sorry for the noise.

Best regards,
Sang-Heon Jeon

> --
> Cheers,
>
> David

