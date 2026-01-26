Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202E6D13C0D
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 13:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3xMCDXBK98svIEGqHcH03JamawrF+kxK5yFNzprmhnA=; b=nhfrAxg0yrhDuYWU17OUgNvTpI
	du9ckPVEyyozp7o9n1CEhVKZ8d9jUktdD9LwaObKpWkjDLNGQdu1ofnnd0m+amRGw27YNnrOb85aV
	yhEhi3y0/7R10uBM1f7Vdl9KTPIUyhgNvcHvITYQHNRi6kFUjtQQ8mI298Dm5eXiTjqRw797yFh5x
	usq40Nen3lntrVIwZ1zS6Gqs729cbBqWyfQefvpHe77HR0J4yg2ROKj/qM/35lAJNbmQY03UtulMF
	hsxcLodutfEL8Ke3JQGtZMXBMIEf40cbdvTmGFqmdhfmQmvAI5dp3qenqCX12WDNxYMQ5Y36WGaal
	4/FFcnYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMu4-0000000CdlS-0M6w;
	Mon, 26 Jan 2026 13:45:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMu1-0000000Cdki-2IBo
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 13:45:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id CF5B543F3E;
	Mon, 26 Jan 2026 13:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4B5C116C6;
	Mon, 26 Jan 2026 13:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769435112;
	bh=xw/pUvk0u6PtIzlKi8yZZbG6CWAdPi59b0ZTMCQ7GRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TkAdyOGKRNfLrHFPNYnuEp0JpEW6/EaLKUJQJBigmpBHdQAGGppWEQnDahgzi2aM9
	 uXJJxPso/zn9Ve99t7pA9o8rSjNLOKFJB0jMkdkaqpjzrP9OV/9gAxNYVjF7EXeDTo
	 a95nQc92RLuYffzFjH0sj98HsI71PudpADIrTXuENU5arMt2gn5NasA7Xdk75IgSAH
	 iaSQ98xzLIRTRR5KoXrUqdTWiTzFTO1EYz+N14ywCdwb76dNzpaeMa3pFmPZ2Bt0VB
	 qOjfbtaJshhAiDiUtxiFKhvuQO57iNsft+yN35w+UoTSl01UK4ZsqpS0wTJ11n5EJO
	 2Du5t4HtuADxw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Breno Leitao <leitao@debian.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  rmikey@meta.com,  clm@fb.com,  riel@surriel.com,  kernel-team@meta.com,
  SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
In-Reply-To: <2vxzikcoa4g1.fsf@kernel.org> (Pratyush Yadav's message of "Mon,
	26 Jan 2026 14:28:30 +0100")
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
	<aXdTEzsm88JKu9zY@gmail.com> <2vxzikcoa4g1.fsf@kernel.org>
Date: Mon, 26 Jan 2026 14:45:08 +0100
Message-ID: <2vxza4y0a3ob.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_054513_632498_C2A747D4 
X-CRM114-Status: GOOD (  27.08  )
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

On Mon, Jan 26 2026, Pratyush Yadav wrote:

> Hi Breno,
>
> On Mon, Jan 26 2026, Breno Leitao wrote:
>
>> On Wed, Jan 21, 2026 at 06:50:38AM -0800, Breno Leitao wrote:
>>> +static __init int kho_populate_kexec_metadata(void)
>>> +{
>>> +	struct kho_kexec_metadata *metadata;
>>> +	int err;
>>> +
>>> +	metadata = kho_alloc_preserve(sizeof(*metadata));
>>> +	if (IS_ERR(metadata))
>>> +		return PTR_ERR(metadata);
>>> +
>>> +	strscpy(metadata->previous_release, init_uts_ns.name.release,
>>> +		sizeof(metadata->previous_release));
>>> +	/* kho_in.kexec_count is set to 0 on cold boot */
>>> +	metadata->kexec_count = kho_in.kexec_count + 1;
>>> +
>>> +	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata);
>>
>> There is a hidden bug in here when CONFIG_KEXEC_HANDOVER_DEBUGFS is set.
>
> Good catch!
>
>>
>> kho_add_subtree() expects a fdt as the second argument, and we are
>> passing a pure C struct. That works fine, except for debugfs, which
>> does:
>>
>>  1. kho_add_subtree() calls kho_debugfs_fdt_add()
>>  2. kho_debugfs_fdt_add() calls __kho_debugfs_fdt_add()
>>  3. __kho_debugfs_fdt_add() executes fdt_totalsize(fdt)
>>
>> The fdt_totalsize() macro reads bytes 4-7 of the input as a big-endian u32, and
>> this will hit struct kho_kexec_metadata, given I am passing a C struct instead
>> of a FDT.
>>
>>   struct kho_kexec_metadata {
>>       char previous_release[__NEW_UTS_LEN + 1];  // 65 bytes
>>       u32 kexec_count;
>>   } __packed;
>>
>> Bytes 4-7 would be characters from previous_release (e.g., "0-rc" from
>> "6.19.0-rc4..."). Interpreted as big-endian u32, this gives a garbage size
>> value.
>>
>> The alternatives I see here are:
>>
>>  1) Come back to FDT instead of plain C struct, similarly to the previous
>>     version [1]
>>  2) Created some helpers to treat C struct fields specially just for this
>>     feature, and we can do it later if we have more users.
>>  3) Move this kexec_metadata to work on top of LUO (similarly to memfd), but
>>     that would be an unnecessary dependency just to have this kexec_metadata.
>>
>> That said, for the next version, I am coming back to to FDT.
>
> Please, no. Don't go back to it just for the sake of this bug.
>
> I think KHO's assumption that the subtree will always point to an FDT is
> broken, and we should fix that. I think KHO should expose the blob of
> serialized data and let userspace figure out what the format is and how
> to decode it.
>
> To do that, we would need to update kho_add_subtree() to take a size
> parameter from callers, and pass that down to debugfs code. I count 3
> callers of kho_add_subtree() - memblock, LUO, and test_kho. I think all
> 3 should be fairly easy to update, but I am happy to help out if you
> need.

As an example, I'd do something along the lines of:

diff --git a/mm/memblock.c b/mm/memblock.c
index 905d06b16348..c06d6b9e390b 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2512,7 +2512,7 @@ static int __init prepare_kho_fdt(void)
 	if (err)
 		goto err_unpreserve_fdt;
 
-	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt);
+	err = kho_add_subtree(MEMBLOCK_KHO_FDT, fdt, fdt_totalsize(fdt));
 	if (err)
 		goto err_unpreserve_fdt;

-- 
Regards,
Pratyush Yadav

