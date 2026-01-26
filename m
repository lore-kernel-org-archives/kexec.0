Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BACD13C00
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 13:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NWoqNlu1Snaz4A/LOpRb9Egp68rV/2sDGEDAJtkaYCQ=; b=a4LWj9ZenO/qSr/KVCl4wxrpgh
	SgHVk1ZkCaE31hyDWbuPkQJQtJVmsdrZ7ntn84UqlcFSLoeCpItKUv54lD7MAi81wK2ScSfvWZpD/
	18os7iTjhba3my6TMWwD+hTLtwhzoNjsUC8DTyH0hJ5tx3iUqPsqNhGu5hPkUc/dSF9JUwG8Ayan8
	929TkKjJIeyCEqzCi4g/4lrxUPxiagSWthetEtSDJ2pW8VSKEi9Ju8D231HtS1CVBnLywcn9KtlMx
	gKriSZu6yjkFY6LmhogRiQKSYgJjh2ZJkmPrDEOy+cZ2UfjqHDP3vFDco2Ym2LTQ4jcVmZfoz104j
	GnmuhlWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMdy-0000000CcUf-23oC;
	Mon, 26 Jan 2026 13:28:38 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMdx-0000000CcUT-0Cyl
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 13:28:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EBC7E6013D;
	Mon, 26 Jan 2026 13:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC11C116C6;
	Mon, 26 Jan 2026 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769434114;
	bh=H7OFhvg3HcLsfNokdY9oulWOfJXzLJ3YBmdWEdKruwg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LVEvzMkTJzhW/0E6Jyo967XIlN4poj6qVqU9YZm/d7y8No1fhZJrTE6HLyQ/TfNc6
	 heX4Cj8Q2JHNoiVb/sSJoXAhqM+esrNm5cJakXwombgHUJq0cjcoJtXoQqU+QSjfD1
	 qam3UrUjxY+C6162GL24CyWrAC9Ob2jMfWtyOTOnV6F1zQdnIT40i2XP5rUTtan6f6
	 ffss6B21TEBZS/vkiN6rBgJUnAFDyudF/bGvQi6lQQylvAsJppcr4yQdUGaPI6sGv6
	 epWPYf6hPs9wIdZftz9k9sJWLzzB0GYT1WO/32h6ylHsETeyp4z6DEqr7TzP9dk75O
	 vDtZNkbKmfeBg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com,
  SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
In-Reply-To: <aXdTEzsm88JKu9zY@gmail.com> (Breno Leitao's message of "Mon, 26
	Jan 2026 04:01:11 -0800")
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
	<aXdTEzsm88JKu9zY@gmail.com>
Date: Mon, 26 Jan 2026 14:28:30 +0100
Message-ID: <2vxzikcoa4g1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jan 26 2026, Breno Leitao wrote:

> On Wed, Jan 21, 2026 at 06:50:38AM -0800, Breno Leitao wrote:
>> +static __init int kho_populate_kexec_metadata(void)
>> +{
>> +	struct kho_kexec_metadata *metadata;
>> +	int err;
>> +
>> +	metadata = kho_alloc_preserve(sizeof(*metadata));
>> +	if (IS_ERR(metadata))
>> +		return PTR_ERR(metadata);
>> +
>> +	strscpy(metadata->previous_release, init_uts_ns.name.release,
>> +		sizeof(metadata->previous_release));
>> +	/* kho_in.kexec_count is set to 0 on cold boot */
>> +	metadata->kexec_count = kho_in.kexec_count + 1;
>> +
>> +	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata);
>
> There is a hidden bug in here when CONFIG_KEXEC_HANDOVER_DEBUGFS is set.

Good catch!

>
> kho_add_subtree() expects a fdt as the second argument, and we are
> passing a pure C struct. That works fine, except for debugfs, which
> does:
>
>  1. kho_add_subtree() calls kho_debugfs_fdt_add()
>  2. kho_debugfs_fdt_add() calls __kho_debugfs_fdt_add()
>  3. __kho_debugfs_fdt_add() executes fdt_totalsize(fdt)
>
> The fdt_totalsize() macro reads bytes 4-7 of the input as a big-endian u32, and
> this will hit struct kho_kexec_metadata, given I am passing a C struct instead
> of a FDT.
>
>   struct kho_kexec_metadata {
>       char previous_release[__NEW_UTS_LEN + 1];  // 65 bytes
>       u32 kexec_count;
>   } __packed;
>
> Bytes 4-7 would be characters from previous_release (e.g., "0-rc" from
> "6.19.0-rc4..."). Interpreted as big-endian u32, this gives a garbage size
> value.
>
> The alternatives I see here are:
>
>  1) Come back to FDT instead of plain C struct, similarly to the previous
>     version [1]
>  2) Created some helpers to treat C struct fields specially just for this
>     feature, and we can do it later if we have more users.
>  3) Move this kexec_metadata to work on top of LUO (similarly to memfd), but
>     that would be an unnecessary dependency just to have this kexec_metadata.
>
> That said, for the next version, I am coming back to to FDT.

Please, no. Don't go back to it just for the sake of this bug.

I think KHO's assumption that the subtree will always point to an FDT is
broken, and we should fix that. I think KHO should expose the blob of
serialized data and let userspace figure out what the format is and how
to decode it.

To do that, we would need to update kho_add_subtree() to take a size
parameter from callers, and pass that down to debugfs code. I count 3
callers of kho_add_subtree() - memblock, LUO, and test_kho. I think all
3 should be fairly easy to update, but I am happy to help out if you
need.

>
> Link: https://lore.kernel.org/all/20260108-kho-v3-0-b1d6b7a89342@debian.org/ [1]
>
> --breno

-- 
Regards,
Pratyush Yadav

