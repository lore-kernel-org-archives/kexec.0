Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C57C982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 09:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:MIME-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gVJZTypgXfKJStNVi3R0a2JQB/tvx6NLIBfpEAfH+Ko=; b=kFU2tYAfT6Ihozvt36Fjz5ogG/
	xBn6R7tCo5Wob3LJ8Fu3XFAT+WrkG/iXUhp74S8bUDQPm4zTJgupwUDRQEKv1/Vp6IbizeuVarO4e
	g7wF5gzfI6fqW2x1JfyH5yFjltDGNyqksk8/oMSX6KSmzG6kkxBBnmNmdcjgS/MWnahG6e/5431P1
	uEVQVwFYTDrvMi3ic1d1ZAIDgx22/1P5XDo+i1mmDJbQxQObUHLVjHSNtyIQJ7o3Pwx3/ZCrK00bP
	/6c719V3i4XozNxYD5n+rPyKaPdwh4cWyYnT6l4n23Gi7GVQhRGRAngY1zgFyDxeUufDK35NJOee+
	v+6k9RPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wQx-00000004q4H-1Wuf;
	Tue, 22 Sep 2026 09:05:03 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8wQv-00000004q3D-47HY;
	Tue, 22 Sep 2026 09:05:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 589CE408F4;
	Tue, 22 Sep 2026 09:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5581F000FF;
	Tue, 22 Sep 2026 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790067901;
	bh=gVJZTypgXfKJStNVi3R0a2JQB/tvx6NLIBfpEAfH+Ko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9LHr2Wd4Rxx3+1boxWUT9I2oXWCmuvgxijo5nc6bPCgxtO998Rsh7NKemCZPMZ7q
	 jCqEgkFPjzxPK4mReOTTd/elY+ciGLQH0sdAs9Gj6meNVO4LfN2kzV+4LXR0oVx6SK
	 7ZH/T7Wv5A2AUNswlgh8q3cB2VzM3drCJ2lhSUow3TBR7t+5QqoSZi80Bp+U336otT
	 6+pWL7hrOojomJ2u753Enniueu6LZnlrBvU6X6vwp9prGtDnyfBK/IXM5CJdbxbR9Z
	 4Y6VvuOiSdy8+S0cHn5PGHelRvFyfDPZFS7siU3DaFG8DB1NQi0pi6gHzGpuQPP6oN
	 01swkhQ7UyoBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/9] of: reserved_mem: mark /memreserve/ entries as
 MEMBLOCK_NODUMP
To: robh@kernel.org, baoquan.he@linux.dev, "Wandun Chen" <chenwandun1@gmail.com>, rppt@kernel.org, m.szyprowski@samsung.com
Cc: saravanak@kernel.org, pjw@kernel.org, conor+dt@kernel.org, iommu@lists.linux.dev, ruirui.yang@linux.dev, linux-kernel@vger.kernel.org, mark.rutland@arm.com, loongarch@lists.linux.dev, tglx@kernel.org, bp@alien8.de, x86@kernel.org, pratyush@kernel.org, kexec@lists.infradead.org, chenhuacai@kernel.org, hpa@zytor.com, pasha.tatashin@soleen.com, mingo@redhat.com, linux-mm@kvack.org, robin.murphy@arm.com, linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu, linux-arm-kernel@lists.infradead.org, alex@ghiti.fr, catalin.marinas@arm.com, will@kernel.org, devicetree@vger.kernel.org, dave.hansen@linux.intel.com, akpm@linux-foundation.org, palmer@dabbelt.com, kernel@xen0n.name
In-Reply-To: <20260922084256.1515554-9-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
 <20260922084256.1515554-9-chenwandun1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:04:58 +0000
Message-Id: <20260922090459.2B5581F000FF@smtp.kernel.org>
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] of/fdt: silent u64 truncation in fdt_mark_memreserve_nodump caus=
es nodump false positives
--

commit 070ed699ada4d456618a640c6ad541abbec98f95
Author: Wandun Chen <chenwandun@lixiang.com>

of: reserved_mem: mark /memreserve/ entries as MEMBLOCK_NODUMP

The /memreserve/ entries are memory reservations made by the bootloader
or firmware, their contents are not needed for kernel crash analysis. This
commit marks them MEMBLOCK_NODUMP to omit them from the vmcore, while leavi=
ng
overlapping dumpable regions unmarked.

> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index f29a07e8fb23e..a42cf6eac55b5 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
[ ... ]
> @@ -251,6 +251,39 @@ static void __init __rmem_check_for_overlap(void)
>  	}
>  }
> =20
> +void __init fdt_mark_memreserve_nodump(void)
> +{
> +	u64 base, size;
> +	int n;
> +	const void *fdt =3D initial_boot_params;
[ ... ]
> +		for (i =3D 0; i < reserved_mem_count; i++) {
> +			struct reserved_mem *rmem =3D &reserved_mem[i];
> +
> +			if (rmem->dumpable &&
> +			    base < (u64)rmem->base + (u64)rmem->size &&
> +			    (u64)rmem->base < base + size)
> +				break;
> +		}
> +		if (i =3D=3D reserved_mem_count)
> +			memblock_mark_nodump(base, size);

[Severity: Medium]
Is there a risk of silent truncation here when passing u64 arguments to
memblock_mark_nodump() on 32-bit architectures?

The u64 base and size variables are passed directly to memblock_mark_nodump=
()
which takes phys_addr_t arguments. On a 32-bit architecture where phys_addr=
_t
is 32-bit, if the device tree contains a /memreserve/ entry with an address
greater than 4GB, fdt_mark_memreserve_nodump() reads it as a 64-bit value.

It performs a 64-bit overlap check against dumpable regions in reserved_mem.
Because the upper 32 bits differ, it concludes there is no overlap. It then
calls memblock_mark_nodump(), where the compiler silently truncates base to=
 32
bits.

Could this incorrectly mark the lower 32-bit address as MEMBLOCK_NODUMP,
mistakenly excluding any dumpable region located there that the overlap
check was intended to protect?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922084256.1515=
554-1-chenwandun1@gmail.com?part=3D8

