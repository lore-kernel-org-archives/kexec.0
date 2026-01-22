Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B02C44500
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 10:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jcIwbPjjskvdEkIc3aDCzrypxtW93ZbELEpwBs0ihF4=; b=40AsDiXJquNFR31l3grIBTqZYo
	4bP07gOXQiYo0hEsaF08aIdx6c11LGFb9MMdytM3A+myAUi61x7etxOOER7cW5kKlpDqW1sb4ovH1
	yV01xZhY/PTHTMacWEbwIoMhU37F/+ycOMsavXaa59nLLzNMUzD2Meyn8m+GNn1+f+gXtFCM/hvMh
	c+lyo7nm5W1AmBlERRfe0c7vXfv/YwzBUrf9x/+RJA7L6GOAD0Iy3dfnTdSOk6Q5oxo22/F98ASBH
	gTc1O6a2lNYVCA4xJcLzQsLuSG4Tksdz8KxRfI/V6vOg8o7CI6TwkoLWneDl4+/GbRkddRBn4ifAZ
	30RRr1HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1visO2-00000006vOu-3Qsu;
	Thu, 22 Jan 2026 10:58:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1visNz-00000006vOV-1gs8
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 10:58:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4CA9743BF0;
	Thu, 22 Jan 2026 10:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0631C19423;
	Thu, 22 Jan 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769079478;
	bh=21xm7f0Mz2IMq1aSJDqBtT3vmDj0mwL9hRZ69a2vul8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sk36rrz1lHFTrwIzHYCFaYZmTlcopkOYJNutw9p7SwlvWgOwlo8LNwh7UGr/QrxGq
	 Y/4rC/JdWWhNb/lWg69SqV9OzHX8ORX4UrblhHVXBDholvSyGoUmtPHH9lkZTgF8uZ
	 zLiWOxTPx5zNMyeFxCuKfKD4qZ3A321buNLcNJo934wJUEbw1bCNe3tC6IOhUQI/F1
	 gS2xnR/9kUU1B5hZfNIr9fmHI/HP3m2c6PnC/iDDvZ1KQOqKmPpQFVhvqCd46WyTZ2
	 M0z+IqXjBFZcDdoma8BJwJZr8YekEnonRlLiO+L6RJLlPCwtUgV1H474XbPot4sZyu
	 7X9EBs2PB3Bqw==
Date: Thu, 22 Jan 2026 12:57:50 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com,
	riel@surriel.com, kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXICriRKbYB5f3li@kernel.org>
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_025759_486035_A28B6A73 
X-CRM114-Status: GOOD (  38.65  )
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

On Wed, Jan 21, 2026 at 06:50:38AM -0800, Breno Leitao wrote:
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
> ---
> Changes in v4:
> - Squashed everything in a single commit
> - Moved from FDT to C structs (Pratyush)
> - Usage of subtress intead of FDT directly (Pratyush)
> - Renamed a bunch of variables and functions.
> - Link to v3: https://patch.msgid.link/20260108-kho-v3-0-b1d6b7a89342@debian.org
> 
> Changes in v3:
> - Remove the extra CONFIG for this feature.
> - Reworded some identifiers, properties and printks.
> - Better documented the questions raised during v2.
> - Link to v2: https://patch.msgid.link/20260102-kho-v2-0-1747b1a3a1d6@debian.org
> 
> Changes from v2 to v1 (RFC)
> - Track the number of kexecs since cold boot (Pasha)
> - Change the printk() order compared to KHO
> - Rewording of the commit summary
> - Link to RFC: https://patch.msgid.link/20251230-kho-v1-1-4d795a24da9e@debian.org
> ---
>  include/linux/kho/abi/kexec_handover.h | 29 +++++++++++++++
>  kernel/liveupdate/kexec_handover.c     | 65 ++++++++++++++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
> 
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

It would be nice to link it from Documentation/ as well ;-)

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
> +#define KHO_METADATA_NODE_NAME "kexec-metadata"
> +
>  /**
>   * DOC: Kexec Handover ABI for vmalloc Preservation
>   *
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c

...

>  static __init int kho_init(void)
>  {
>  	const void *fdt = kho_get_fdt();
> @@ -1357,6 +1413,15 @@ static __init int kho_init(void)
>  	if (err)
>  		goto err_free_fdt;
>  
> +	if (fdt)
> +		kho_process_kexec_metadata();

Can't we move it into the existing if (fdt) below?
 
> +
> +	/* Populate kexec metadata for the possible next kexec */
> +	err = kho_populate_kexec_metadata();
> +	if (err)
> +		pr_warn("failed to initialize kexec-metadata subtree: %d\n",
> +			err);

Please follow if (err) goto err_ pattern.

kho_populate_kexec_metadata() failure essentially means that we failed to
allocate memory. This shouldn't happen that early in boot, but if it did,
then something is utterly wrong.

> +
>  	if (fdt) {
>  		kho_in_debugfs_init(&kho_in.dbg, fdt);
>  		return 0;

-- 
Sincerely yours,
Mike.

