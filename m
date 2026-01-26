Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1042DD13C0E
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zUyrsf7RrBDFWYGI9KCAX3IKjesWO0yJ5/FqS32bLYg=; b=p+B6sqKmpV4K6wXS/EUYeJCp2c
	+7LGlAzsnKHCPfYGvpRxeClPHBhDdiNE0RHpydTuM74pXElLJYxLNOTWvCjcTn5rLgJnwQawSudMV
	+zxVHW/M+s5otsnjo5vzQCpIi3z1DQRTIv9jmObLCvOuZXpVjxpKgV23eWwKI81iauBxki0DjB4qv
	beY72xkuiVw5Vz1bYqc0CIS8upq6tL6SxLinCDtzNohxhZ0NJnp6ucE0rNtUJw0r4hX6E0YMLgiDu
	0GL2mOusBwZ4XEOydqavd6eSbxuoqbbgRKQT7DvZc45JAiSeUsrCivAu3IM++913qSswwqaUWRveT
	DZHS5eDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMkJ-0000000Cd6I-0jKM;
	Mon, 26 Jan 2026 13:35:11 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMkH-0000000Cd5x-0c1N
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 13:35:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B827A41B4B;
	Mon, 26 Jan 2026 13:35:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05144C116C6;
	Mon, 26 Jan 2026 13:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769434508;
	bh=lBIMffzY+AoU7PgBcVkFtZWf5SUwXZYGLlR6MmjFL0I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ujPNyDAlvmvq1uH3VAd4uhLhXWSRnpoMj/JhFhOM6dOhkRkZ+oIJRfhA5OzcIiSAN
	 +pd7/+GMCZQDqdQh3l2OZ+xvcaTMePLQ3TlozpebC7q3WoEPrC1Gy8ZseQfjBoMdJ1
	 3mVShCMAnwfpRtPIOdTUntFgYHV5bpBiIPyu6HG30utiRcn/8Skq41nixqSwVk8f3y
	 RLoOW/ZbEIqly2xRmvM9JyROZtrdHpfmmBo9+O8htLanBmbQRN9J7e9LOe1ZV6K3lk
	 27v51ZExeMjOcmUUZ8/nMGmoAQDOfpwuQZ0+r8UIyOVsaBt0GF5d3J4WpGL6dQ95ca
	 LaPDpL/aTbRnw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com,
  SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
In-Reply-To: <20260121-kho-v4-1-5c8fe77b6804@debian.org> (Breno Leitao's
	message of "Wed, 21 Jan 2026 06:50:38 -0800")
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
Date: Mon, 26 Jan 2026 14:35:04 +0100
Message-ID: <2vxzecnca453.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_053509_231338_29FC16B4 
X-CRM114-Status: GOOD (  29.46  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Breno,

On Wed, Jan 21 2026, Breno Leitao wrote:

> Use Kexec Handover (KHO) to pass the previous kernel's version string
> and the number of kexec reboots since the last cold boot to the next
> kernel, and print it at boot time.
>
> Example output:
>     [    0.000000] KHO: exec from: 6.19.0-rc4-next-20260107 (count 1)
>
> Motivation
> ==========
>
> Bugs that only reproduce when kexecing from specific kernel versions
> are difficult to diagnose. These issues occur when a buggy kernel
> kexecs into a new kernel, with the bug manifesting only in the second
> kernel.
>
> Recent examples include the following commits:
>
>  * eb2266312507 ("x86/boot: Fix page table access in 5-level to 4-level paging transition")
>  * 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event log to avoid corruption")
>  * 64b45dd46e15 ("x86/efi: skip memattr table on kexec boot")
>
> As kexec-based reboots become more common, these version-dependent bugs
> are appearing more frequently. At scale, correlating crashes to the
> previous kernel version is challenging, especially when issues only
> occur in specific transition scenarios.
>
> Implementation
> ==============
>
> The kexec metadata is stored as a plain C struct (struct kho_kexec_metadata)
> rather than FDT format, for simplicity and direct field access. It is
> registered via kho_add_subtree() as a separate subtree, keeping it
> independent from the core KHO ABI. This design choice:
>
>  - Keeps the core KHO ABI minimal and stable
>  - Allows the metadata format to evolve independently
>  - Avoids requiring version bumps for all KHO consumers (LUO, etc.)
>    when the metadata format changes
>
> The struct kho_metadata contains two fields:
>  - previous_release: The kernel version that initiated the kexec
>  - kexec_count: Number of kexec boots since last cold boot
>
> On cold boot, kexec_count starts at 0 and increments with each kexec.
> The count helps identify issues that only manifest after multiple
> consecutive kexec reboots.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: SeongJae Park <sj@kernel.org>
[...]
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/abi/kexec_handover.h
> index 285eda8a36e45..e18022a4e664d 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -11,6 +11,7 @@
>  #define _LINUX_KHO_ABI_KEXEC_HANDOVER_H
>  
>  #include <linux/types.h>
> +#include <linux/utsname.h>
>  
>  /**
>   * DOC: Kexec Handover ABI
> @@ -84,6 +85,34 @@
>  /* The FDT property for sub-FDTs. */
>  #define KHO_FDT_SUB_TREE_PROP_NAME "fdt"
>  
> +/**
> + * DOC: Kexec Metadata ABI
> + *
> + * The "kexec-metadata" subtree stores optional metadata about the kexec chain.
> + * It is registered via kho_add_subtree(), keeping it independent from the core
> + * KHO ABI. This allows the metadata format to evolve without affecting other
> + * KHO consumers.
> + *
> + * The metadata is stored as a plain C struct rather than FDT format for
> + * simplicity and direct field access.
> + */
> +
> +/**
> + * struct kho_kexec_metadata - Kexec metadata passed between kernels
> + * @previous_release: Kernel version string that initiated the kexec

Other than Mike's comments, I only have a small nitpick. Please add a
comment here that using __NEW_UTS_LEN in the ABI is safe here since it
is a part of UAPI.

LGTM otherwise.

> + * @kexec_count: Number of kexec boots since last cold boot
> + *
> + * This structure is preserved across kexec and allows the new kernel to
> + * identify which kernel it was booted from and how many kexec reboots
> + * have occurred.
> + */
> +struct kho_kexec_metadata {
> +	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
> +} __packed;
> +
[...]

-- 
Regards,
Pratyush Yadav

