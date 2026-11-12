Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C1606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=X0EHRLtm;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mQ5/2+sk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rof6qakTny4U9oPC84/N1EPZJDTuRvqDL7jUCVf2QHY=; b=X0EHRLtmiimYaCd4F+knGw47Sz
	ns2/6vZNFXHt4dq/leAVOnm+jzOSzMsj9P+vKGrKFs4swmRYeuXWK6zhgDPrbzMHyxxcDE4b+b20l
	tyObiQDtMzG+siIHwq0RxXlxiYBZy0OP/wIh9yNghUiea5vBs7gt9BRrZl1QSv8FwUeXEd84Fk+2a
	UU8FZlO7bnlSfav6K137PDv2HKDPm5t85MEcUOLoQLqreDSRkCDo+qB4e0U7+Ch33h5Hncuxj/Jf/
	/js7wwujpUJZkoT/foKknnSXcBU2SEh8R5IoTTO7zktRYHnkhsNWhJ0GcpMvQsaY2KvktFVXjYPQI
	Kh4V73Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT8b-00000009kak-2x9u;
	Thu, 12 Nov 2026 11:38:41 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRT8a-00000009kaY-06Im
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 11:38:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 16FDD42E73;
	Thu, 12 Nov 2026 11:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305361F00A05;
	Thu, 12 Nov 2026 11:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483519;
	bh=rof6qakTny4U9oPC84/N1EPZJDTuRvqDL7jUCVf2QHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mQ5/2+skZQeYD56w/R1dVBqplzcSdXB0jF80GnBMnMTU8ip66wr7S7WqL8Vx22+J8
	 dxnV5eNcRWkpOgSBu4fzOxq1dKKg0oC+FRBOuNjN0dy3kPAhJMP12QdTe3r2zs9NIv
	 6DSzQFyWw1j4Yy8FdQ94/1N6Ai9n3U/808URSJ4GvceRWTwPXdcY8NBgQhoIHuQtaF
	 uK440MPahBRknwj15IwrB8uEOGlNT6vruPA/oeEfeX+MbOlN440prnFh7due9VCc/6
	 sd6+DvhwaEbAfMI69oZHkgFXXigLU9c0i/dAGN/281sP5lQ0Mv9cnmDAZeb6uNlpey
	 ELVvnQfJIelfw==
Message-ID: <sashiko-outbox-211034@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/8] s390/kdump: Reserve crashkernel CMA memory
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-3-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-3-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:38:37 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] s390/kdump: reserve_crashkernel() allows CMA allocation in
  [0, crash_size)
--

commit 8b228cd4036f52fccdf6ce96ff9330544194ef3d
Author: Mikhail Zaslonko <zaslonko@linux.ibm.com>

s390/kdump: Reserve crashkernel CMA memory

This commit parses the ",cma" suffix of the crashkernel=3D command-line
parameter on s390 and reserves the requested CMA memory via
reserve_crashkernel_cma() when not booting as a kdump kernel.

> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index b60284328fe3d..0251bd35954a8 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -598,12 +598,12 @@ static void __init reserve_pgtables(void)
>  static void __init reserve_crashkernel(void)
>  {
>  #ifdef CONFIG_CRASH_DUMP
> -	unsigned long long crash_base, crash_size;
> +	unsigned long long crash_base, crash_size, cma_size =3D 0;
>  	phys_addr_t low, high;
>  	int rc;
> =20
>  	rc =3D parse_crashkernel(boot_command_line, ident_map_size,
> -			       &crash_size, &crash_base, NULL, NULL, NULL);
> +			       &crash_size, &crash_base, NULL, &cma_size, NULL);
> =20
>  	crash_base =3D ALIGN(crash_base, KEXEC_CRASH_MEM_ALIGN);
>  	crash_size =3D ALIGN(crash_size, KEXEC_CRASH_MEM_ALIGN);
> @@ -658,6 +658,13 @@ static void __init reserve_crashkernel(void)
>  		crash_size >> 20, crash_base >> 20,
>  		(unsigned long)memblock.memory.total_size >> 20);
>  	os_info_crashkernel_add(crash_base, crash_size);
> +
> +	/*
> +	 * A kdump kernel is handed the CMA ranges of the crashed kernel
> +	 * instead of reserving its own.
> +	 */
> +	if (!oldmem_data.start)
> +		reserve_crashkernel_cma(cma_size);
>  #endif
>  }

[Severity: Medium]
Can reserve_crashkernel_cma() allocate CMA ranges inside [0, low),
overlapping the [0, crash_size) memory region that purgatory swaps with
[crash_base, crash_base + crash_size) on kdump (or the [0, sclp.hsa_size)
HSA region)?

Earlier in reserve_crashkernel(), crash_base is constrained to sit at or
above low:

arch/s390/kernel/setup.c:reserve_crashkernel() {
	...
		/* Find suitable area in free memory */
		low =3D max_t(unsigned long, crash_size, sclp.hsa_size);
		high =3D crash_base ? crash_base + crash_size : ULONG_MAX;
	...
		low =3D crash_base ?: low;
		crash_base =3D memblock_phys_alloc_range(crash_size,
						       KEXEC_CRASH_MEM_ALIGN,
						       low, high);
}

However, [0, low) is not reserved in memblock when
reserve_crashkernel_cma() runs, and reserve_crashkernel_cma() calls
cma_declare_contiguous() with base =3D 0.  When free memory above 4 GB (or
above low) is insufficient for cma_size, cma_alloc_mem() allocates from
[0, low).  In the kdump kernel, any CMA range inside [0, crash_size)
merges with the existing [0, oldmem_data.size) primary memory range
instead of providing the requested extra memory, and a CMA range
straddling crash_size corrupts the swapped memory layout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D2

