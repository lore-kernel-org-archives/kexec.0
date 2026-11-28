Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D06606A31C
	for <kexec@archiver.kernel.org>; Sat, 28 Nov 2026 08:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xJXj/ZJp;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LpyJiaT7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OZ9/FE4vJPIlp47UpWJlO7ZkMQSH+aShKYjbcCdHRVQ=; b=xJXj/ZJpQdy2ZVsRVRLjjOJf5c
	BvRGn/R+yLuqin6WNnDaYpAgZ1UaZdBO4gbPJIuByavDHbm9E8i6Xa6vP8K+mJ9m+fndG7dTzPMHS
	WOH79XN2O21qiGBgxV9X8ERORkO5sJ5NALyYBmimK58xDNM9Hp0uzkDaOE7OMGJgJ3tE3Oi7FAQdj
	SIl8GXSm0iXw769JZTgnuUGC/RoqLTnwfjCOHCz6F1M9IRYgEq5VziDrKm2EFruXlDOddNjH7NxaK
	wmDNVZ5xpL1n3xUbuv15nEwZU9kj/JuV5jKLdAcIvvNTqkr8m58CmyaCHNSi0iD1FBOIFYMQsOJmN
	SJKVmCkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXDuI-00000000YHd-0oe5;
	Sat, 28 Nov 2026 08:35:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xXDuG-00000000YHW-1zAo
	for kexec@lists.infradead.org;
	Sat, 28 Nov 2026 08:35:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CD7EF40BFD;
	Sat, 28 Nov 2026 08:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7471F00893;
	Sat, 28 Nov 2026 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795854939;
	bh=OZ9/FE4vJPIlp47UpWJlO7ZkMQSH+aShKYjbcCdHRVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LpyJiaT7enS6fpgPVBnLHRBchEfpbIM5Xnqbqdb6XKiuydVlJL/oQ4rgRYQsMHUVv
	 nn8ifxXn8di3B4EyurWAEy9DVTIDrVMaEe3n579MeAxjtdd+4xYbn5yPHooI2Qw8Wo
	 EzjCJEFONONEd5kCxaMxpDeiUPNwzVFkrvNSiHDCMDmW9kUy5pC3HBxWZGognmqKbH
	 vTlawNB/5J1fX9B0xFvJHXcn3UOv+h7lXR1yJLqLfhTrcvY2IkZWep91sdH+2mescu
	 zyupvNe+C2bExXeBoW6pPiBLuOU/mBHncIFDBrN72KqHyzPkJLSag8udRy/mm3Sgk+
	 Qb5zVdAIKyHmg==
Message-ID: <sashiko-outbox-238548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kexec: use phys_addr_t in generic
 crash_free_reserved_phys_range()
To: "Jingyi Sun" <1045704958@qq.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Shradha
 Gupta" <shradhagupta@linux.microsoft.com>, "Thomas Huth" <thuth@redhat.com>, "Sourabh
 Jain" <sourabhjain@linux.ibm.com>, "Pingfan Liu" <piliu@redhat.com>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>, "Anton Blanchard" <anton@samba.org>
Cc: kexec@lists.infradead.org, "Russell King" <linux@armlinux.org.uk>
In-Reply-To: <tencent_0EE98A1C2110785434DE9692533FF737DD07@qq.com>
References: <tencent_0EE98A1C2110785434DE9692533FF737DD07@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 28 Nov 2026 08:35:38 +0000
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

> The generic crash_free_reserved_phys_range() takes the range as
> unsigned long, but its only caller, __crash_shrink_memory(), passes
> resource_size_t values from crashk_res / crashk_low_res. On 32-bit
> architectures with a 64-bit phys_addr_t that do not provide their own
> helper (e.g. ARM with LPAE), a crash kernel region above 4GiB is then
> truncated to its low 32 bits when /sys/kernel/kexec_crash_size is
> shrunk: free_reserved_page() is called on unrelated low-memory pages,
> while the pages that were actually released from the reservation stay
> reserved forever.
>=20
> This was observed on QEMU (virt, cortex-a15, ARM_LPAE, 6G) with
> "mem=3D1G@0x40000000 mem=3D512M@0x140000000 crashkernel=3D64M@0x150000000=
":
> after "echo 0 > /sys/kernel/kexec_crash_size" the HighMem zone's
> managed page count stayed unchanged, while the low-memory zone grew by
> 16384 pages (64MiB), i.e. the pages at 0x50000000-0x53ffffff were
> "freed" instead of 0x150000000-0x153ffffff. x86_64 with the same layout
> behaves correctly.
>=20
> Use phys_addr_t for the range and the loop variable, and PHYS_PFN() to
> derive the PFN.
>=20
> Fixes: c0bb9e45f3a7 ("kdump: Allow shrinking of kdump region to be overri=
dden")
> Signed-off-by: Jingyi Sun <1045704958@qq.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_0EE98A1C211=
0785434DE9692533FF737DD07@qq.com?part=3D1

