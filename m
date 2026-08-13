Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EB9C5CFCF
	for <kexec@archiver.kernel.org>; Thu, 13 Aug 2026 16:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hz4biOvRgNuFda4LA0X5Y+ky3s3LWtizWjSf/l2wN/4=; b=gQbEQ87qei6NHuJH/JG4BS4qMV
	9jlkm+QtWve3XYVtWYYRm4kYZBTZs7KuT6lyh5FLV0CdnMbCg2HuuwJSMhp8HBuxXtJKmicjYCjcy
	uWDRT7cS45w5ZTnrlDS1UHjbOtEZ005ptjDQzZvByg06/51RfXi8g/eHrVl6l1xi+kbWCAeUsuWas
	yKnE2lq6V7DlYym2r+c4uizmrn8qXQOP+eVBGef7R6aQ5z+/a3Behn1aA/xQn7Dh55AV++uJNPNtY
	j1EUklHFc3o4b5q1b+zwC1J46bG7hqC8mJ9jtxszUfVoA80fntmDiEgWu7GyAS7hDG0L4uN/GqbAx
	nkxqBirQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuXwC-000000016o0-2S63;
	Thu, 13 Aug 2026 16:05:48 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuXwA-000000016mE-0ogI;
	Thu, 13 Aug 2026 16:05:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 539FC1576;
	Thu, 13 Aug 2026 09:05:40 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815B43F66F;
	Thu, 13 Aug 2026 09:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786637144; bh=GdOVLavtixtz+bwc773F7iXmbQhbVm7TNS88fVv9av4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NvzpgAY1Qf9f/5pkj2ip0dskQnm1FKdRNqgDA2KzDQwfoIxhbdoZ2807TR5WYZ1IT
	 9ms3QyyBXSoensTxvyvQMH8eGt5xKglWWxw74Ab4YnC9jgNv2p1XDtMn/4aFB0Wfeg
	 gLO3nGrAGuMfrvC9hd/oTCG3w5V710ykuOrhfJUA=
Date: Thu, 13 Aug 2026 17:05:37 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: will@kernel.org, akpm@linux-foundation.org, baoquan.he@linux.dev,
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org,
	thuth@redhat.com, mark.rutland@arm.com, jic23@kernel.org,
	james.morse@arm.com, ardb@kernel.org, leitao@debian.org,
	yeoreum.yun@arm.com, sourabhjain@linux.ibm.com, robh@kernel.org,
	kees@kernel.org, coxu@redhat.com, makb@juniper.net,
	piliu@redhat.com, graf@amazon.com, ebiggers@kernel.org,
	jbouron@amazon.com, bgwin@google.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v2 5/5] arm64: crash: Add crash hotplug support
Message-ID: <an3rUZ7rd1mQH0Gz@arm.com>
References: <20260729031235.2840255-1-ruanjinjie@huawei.com>
 <20260729031235.2840255-6-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729031235.2840255-6-ruanjinjie@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_090546_336874_EA19EFB2 
X-CRM114-Status: GOOD (  19.08  )
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

Hi Jinjie,

On Wed, Jul 29, 2026 at 11:12:35AM +0800, Jinjie Ruan wrote:
> +/**
> + * update_crash_elfcorehdr() - Recreate the elfcorehdr and replace it with old
> + *			       elfcorehdr in the kexec segment array.
> + * @image: the active struct kimage
> + */
> +static void update_crash_elfcorehdr(struct kimage *image)
> +{
> +	void *elfbuf = NULL, *old_elfcorehdr;
> +	unsigned long mem, memsz;
> +	unsigned long elfsz = 0;
> +
> +	/*
> +	 * Create the new elfcorehdr reflecting the changes to CPU and/or
> +	 * memory resources.
> +	 */
> +	if (crash_prepare_headers(true, &elfbuf, &elfsz, NULL)) {
> +		pr_err("unable to create new elfcorehdr");
> +		goto out;
> +	}
> +
> +	/*
> +	 * Obtain address and size of the elfcorehdr segment, and
> +	 * check it against the new elfcorehdr buffer.
> +	 */
> +	mem = image->segment[image->elfcorehdr_index].mem;
> +	memsz = image->segment[image->elfcorehdr_index].memsz;
> +	if (elfsz > memsz) {
> +		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
> +			elfsz, memsz);
> +		goto out;
> +	}
> +
> +	/*
> +	 * Copy new elfcorehdr over the old elfcorehdr at destination.
> +	 */
> +	old_elfcorehdr = phys_to_virt(mem);
> +
> +	/*
> +	 * Temporarily invalidate the crash image while the
> +	 * elfcorehdr is updated.
> +	 */
> +	xchg(&kexec_crash_image, NULL);
> +	memcpy(old_elfcorehdr, elfbuf, elfsz);
> +	dcache_clean_inval_poc((unsigned long)old_elfcorehdr,
> +			       (unsigned long)(old_elfcorehdr + elfsz));
> +	xchg(&kexec_crash_image, image);
> +	pr_debug("updated elfcorehdr\n");
> +
> +out:
> +	vfree(elfbuf);
> +}
> +
> +/**
> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
> + * @image: a pointer to kexec_crash_image
> + * @arg: struct memory_notify handler for memory hotplug case and
> + *       NULL for CPU hotplug case.
> + *
> + * Update the kdump image based on the type of hotplug event:
> + * - CPU add and remove: No action is needed.
> + * - Memory add/remove: Update the elfcorehdr to reflect the current memory layout.
> + *
> + * Prepare the new elfcorehdr and replace the existing elfcorehdr.
> + */
> +void arch_crash_handle_hotplug_event(struct kimage *image, void *arg)
> +{
> +	if (image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +	    image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +		return;
> +
> +	update_crash_elfcorehdr(image);
> +}

Looking at powerpc, they pass the arg down to update_crash_elfcorehdr()
to handle the memory hot-unplug case. It looks like the notifier is
called before the memblock_remove(), so the update above will still
count the memory being removed.

There are a few Sashiko comments as well, though some might be about
existing issues (it would be nice to have them fixed ;)).

-- 
Catalin

