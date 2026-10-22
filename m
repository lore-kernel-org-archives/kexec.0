Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96625606A32A
	for <kexec@archiver.kernel.org>; Thu, 22 Oct 2026 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N+K/ptm9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TzHphjC1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VZdBy6i5lIJKyk5P4+SaXB0tFCu0VDYrKWVreM/8iH8=; b=N+K/ptm9qjFvvrjMiajuXodr7R
	mv3+LXsKkyjOKqLzMpM0597YOgHRngzJkr2sxlypMrKcB2Z2E/58zmrg1+1+wbW/lBHLQmzr6dwEf
	+IyKnjIZWY5puJHvA78yQ6Y8v03smqD1coYg+Xz7XjIiGZYZn0ol9n42tMkYC2ubp14x8dE1sztHG
	i+FF5fqr/HuCAicOQVL2WiwajGTWfdNXN0b9ZLKLV5dxYHQ/pqwoekgNGXM4zTkZ4AZsZJLMjINZI
	AsIzEty/U0lkdf8fl8YM/ibQf598WtT4vroMgy0Y/Zc8B8hdiWZjTVeZnYW+ju/TWcOHWTDVGRtfK
	kvTB0gRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEZ-0000000DfsW-0sZV;
	Thu, 22 Oct 2026 08:33:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJoEU-0000000Dfrw-2UCU
	for kexec@lists.infradead.org;
	Thu, 22 Oct 2026 08:33:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C3EA8601F1;
	Thu, 22 Oct 2026 08:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59491F000C6;
	Thu, 22 Oct 2026 08:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792657985;
	bh=VZdBy6i5lIJKyk5P4+SaXB0tFCu0VDYrKWVreM/8iH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TzHphjC1FEkvZqhiswdYWr5jyP0TvikruguwMkbG8zpZQ2ew3Hk1eCBX7+fdtyr35
	 rH0Sa9/d0EkqyIYxnB39bXt8ExAyqiStZmDnVEPCr62Gi1OlGQyxKhKAGkED4DlwTt
	 ELEJUvCZCzKF4zLx0MvE9/cDlASHaF6prVq2NWGn8jbPs7da8ByMWGetXp0PxFg/mG
	 a4Ne2QdM3EZhQhdzD6oWZXWWEF96zpWWyrMpho5ZIGzg5YIRzH7sQXTkQ7dVkR7ZlY
	 J1JSh2lnewfkwcbpRJ5/asIcWORIe92QA1HqtrV7aBhR2yu90yo6YaZ4r7eiqAOfRK
	 qsywaydXtLK0Q==
Message-ID: <sashiko-outbox-181177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/8] riscv: build crash_mem ranges from memblock
 instead of resource tree
To: "Wandun Chen" <chenwandun1@gmail.com>, robh@kernel.org, baoquan.he@linux.dev, rppt@kernel.org, m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, chenhuacai@kernel.org, kernel@xen0n.name, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, saravanak@kernel.org, akpm@linux-foundation.org, pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, robin.murphy@arm.com, kexec@lists.infradead.org
In-Reply-To: <20261021083011.2170525-2-chenwandun1@gmail.com>
References: <20261021083011.2170525-1-chenwandun1@gmail.com>
 <20261021083011.2170525-2-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:33:03 +0000
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

> From: Wandun Chen <chenwandun@lixiang.com>
>=20
> Replace walk_system_ram_res() with for_each_mem_range(). A later patch
> introduces MEMBLOCK_NODUMP in memblock, the reserved-memory regions
> marked with MEMBLOCK_NODUMP can be excluded from the vmcore by walking
> memblock.
>=20
> for_each_mem_range() iterates memblock.memory, which is freed after
> init unless ARCH_KEEP_MEMBLOCK is selected. riscv needs ARCH_KEEP_MEMBLOCK
> to filter reserved memory from the vmcore, so extend its condition
> (ACPI || KEXEC) with CRASH_DUMP. arm64 and loongarch already select
> ARCH_KEEP_MEMBLOCK unconditionally.
>=20
> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021083011.2170=
525-1-chenwandun1@gmail.com?part=3D1


