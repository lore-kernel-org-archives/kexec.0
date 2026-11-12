Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C8606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=toL5N+wR;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhlTASHM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=+4s6DPtHecaIws8OsEjwA4Nb5nI6DVYgPSkzZcGuLcM=; b=toL5N+wRn1M9UlM0vRSJShidVH
	6yRMfiwUy4S4EUIk7s1txnoWroLoMMG3mDYD2MLg8auG3bVB2TSURw/P9FJIdcFxnuH/bLr/Pq7hw
	SKSDvWH0b4Py+rbTMmW3Xi5wQE8wPdQCjUmygUo2Pv2Yr5X+8J+5zGgX7iExR8o+2kHHg+AqjChcG
	TgTP3XohNAyu9oPGqCIOuWv47+UCrbtvkrMCRgu+pv3uNICIurto+brM2q/LR1FxL7ml8ad0nUZot
	TRqP8cxhCL0X52nTyTaIHIGBx6ude/HaQe7+JxxDJ9OrMmo7ULbuoA+1CT7Dmwxde1z7JVQLoFI7b
	WU/F8LJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdL-00000008ymL-1aME;
	Thu, 12 Nov 2026 07:54:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRPdJ-00000008ylQ-0LIh
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 07:54:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8F3B242AE1;
	Thu, 12 Nov 2026 07:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD071F00A05;
	Thu, 12 Nov 2026 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470048;
	bh=+4s6DPtHecaIws8OsEjwA4Nb5nI6DVYgPSkzZcGuLcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RhlTASHMzabC8bj4fEMXxIGzC6N7xi791Bo2ze7sQ2rLOukIlIefeX4XbztTCvb/v
	 uF8pAVxBjc6hbq/CcfpuWdOdHCIOkv94Ht8jSgl5pc99Lo0sSknoA4gy86VoyBC4yA
	 SpbuQ/kKhUqSKaYDJi/qpv9f4PSf+sFPL7vncH64nf320YaYh1KuZn4Al4qOGQrzSU
	 PWypapSr5E6lhbdYWvxXJ2VtFjRDahrcUQYVvF2mV04MA1zVOpni8+OwnTOsNffHtY
	 YviIPXKVcFI0y5Nn7riJPzx9L4mfLDjYnFAm7lDJ6Kr6FPrGvDZIprK+SWvO2vXPpO
	 UDmKERlWLKYpQ==
Message-ID: <sashiko-outbox-210638@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] kho: Make bootmem reservations visible to fleet
 monitoring
To: "Chris Down" <chris@chrisdown.name>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>
Cc: "Alexander Graf" <graf@amazon.com>, "Baoquan He" <baoquan.he@linux.dev>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, kexec@lists.infradead.org, linux-mm@kvack.org, kernel-team@meta.com
In-Reply-To: <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
References: <cover.1794383544.git.chris@chrisdown.name>
 <c41c639fc5f453d60a265ba42a233f2ea5b48319.1794383544.git.chris@chrisdown.name>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 07:54:07 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] kho: scratch memory corruption on error path in kho_init()
  [1]
--

commit 96d77d1af62b4778bf7f34ac023280de65f57337
Author: Chris Down <chris@chrisdown.name>

kho: Make bootmem reservations visible to fleet monitoring

This commit exposes the total KHO bootmem reservation size in bytes via a
new read-only sysfs attribute at /sys/kernel/kexec/kho_bootmem_size.

> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec=
_handover.c
> index 3046b89e5db49..21d77e29d2bb8 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -942,6 +942,21 @@ static void __init kho_reserve_bootmem(void)
>  	kho_enable =3D false;
>  }
> =20
> +phys_addr_t kho_bootmem_size(void)
> +{
> +	phys_addr_t size =3D 0;
> +	unsigned int i;
> +
> +	/* kho_init() can disable KHO without clearing kho_bootmem_cnt. */
> +	if (!kho_enable)
> +		return 0;
> +
> +	for (i =3D 0; i < kho_bootmem_cnt; i++)
> +		size +=3D kho_bootmem[i].size;
> +
> +	return size;
> +}

[Severity: Critical]
This problem wasn't introduced by this patch, but on the kho_init() error
path referenced by this comment, can err_free_bootmem corrupt active memory
during a KHO kexec boot [1]?

During a KHO boot (when fdt is non-NULL), early memblock allocations are
served from the incoming kho_bootmem regions, and memblock_free_all()
releases the remaining unallocated bootmem pages to the buddy allocator.
While the normal path in kho_init() returns early when fdt is non-NULL
before converting kho_bootmem to CMA, the error path frees every
kho_bootmem region unconditionally:

kernel/liveupdate/kexec_handover.c:kho_init() {
    ...
	if (fdt)
		return 0;
    ...
err_free_bootmem:
	kho_out.fdt =3D NULL;
	for (int i =3D 0; i < kho_bootmem_cnt; i++) {
		void *start =3D __va(kho_bootmem[i].addr);
		void *end =3D start + kho_bootmem[i].size;

		free_reserved_area(start, end, -1, "");
	}
	kho_enable =3D false;
	return err;
}

If an initialization step such as kho_alloc_preserve() fails on a KHO boot,
free_reserved_area() runs on pages that are either in use by early-boot
allocations or already managed by the buddy allocator, causing
use-after-free and double free memory corruption.

[1] https://sashiko.dev/#/bug/linux-5ae80b0f-97ab-4112-a0a4-c767da72f4a8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794383544.gi=
t.chris@chrisdown.name?part=3D2

