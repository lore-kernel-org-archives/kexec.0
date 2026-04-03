Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9752E7E378
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BjMlsWhY6jfzYb+mCsmE6mk1gxbFqx16MLVYx9pqxPo=; b=esb2n0FadOtC+cCEOY/fK4DdjZ
	jS775GhtuAxaQrNz75K6eRmXsb5LnswSe8xV+nWbAtzSpf1gWXoYThv5YhLZr5ryhpPVvWAOaBdtG
	alGkHTFOAil+4wrU2VBpkhl0unWr6tOqsAw7RAZ6BKGwRMocV+NYx7obtHGuLoTFVbQ5TGsLJczKe
	DCFuPcfqBJf6jaEtJXfQtee9265hGy1xdt7X/6rGSzxJRRSJWChpGmb1kU3oWavy/RPOnRo1/V33r
	Oaheaq/yom74NOA80rEk9Mc66Xp6CXi6GszasPuY5butrQzYs8K4rCgvmrlbLb2SKOoAtGW3Wt3mX
	R02t6f/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8cqX-00000001yFn-33JV;
	Fri, 03 Apr 2026 11:37:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8cqU-00000001yEC-3ocm
	for kexec@lists.infradead.org;
	Fri, 03 Apr 2026 11:37:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5065B4345A;
	Fri,  3 Apr 2026 11:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE964C4CEF7;
	Fri,  3 Apr 2026 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775216270;
	bh=vMKZ7un5FtqzmkKApMQD7+RG0CoGlZexiI3kSh6AhSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EF4VvpD3Kmcyx1KhggtAUGhgjtIw5v6tzk2xv79niXA5bmlH3LYJ3kaGdNHsQZ1Uh
	 jB6YxwxWbPghSDe+IRCLThjS8klKx5YLsuz/eiIuWzqDVsxj3fmWPjT25jTKv/CgpJ
	 BdqCh8N8na0fwP66eFQexPrB7QLIVN9YCaPAAipiZmxCUHm4onD5OQiyqLsN57AnxU
	 ZonVZemsLWRkZUUhgZQXQUDdHs+AaOFBhUpZZR4AonfiVrOc5nlbDxmYVyuxHt5sns
	 LvnnBsk6PY84Xn/SqUmukQe6kCcEYc52FYTMg1w7jp+LIapurVe7ssuL4+L0nIv/ar
	 j2h7Ya9bAE0Ug==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Alexander Graf <graf@amazon.com>,
  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 3/6] kho: persist blob size in KHO FDT
In-Reply-To: <abfkVOjq1ngZb-Nm@gmail.com> (Breno Leitao's message of "Mon, 16
	Mar 2026 04:09:43 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-3-c3abcf4ac750@debian.org> <2vxzbjgsgk41.fsf@kernel.org>
	<abfkVOjq1ngZb-Nm@gmail.com>
Date: Fri, 03 Apr 2026 11:37:46 +0000
Message-ID: <2vxza4vkcm0l.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_043750_990857_35F468D5 
X-CRM114-Status: GOOD (  26.57  )
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

On Mon, Mar 16 2026, Breno Leitao wrote:

> On Fri, Mar 13, 2026 at 09:21:50AM +0000, Pratyush Yadav wrote:
>> On Mon, Mar 09 2026, Breno Leitao wrote:
[...]
>> I noticed that the error handling here is a bit broken. We open the
>> subnode for the subtree, but then if we fail to add the "preserved-data"
>> property, we don't remove the subnode. So the next kernel gets an
>> invalid FDT (per KHO ABI) and might as well refuse to parse it.
>> 
>> Similarly here, the FDT might also be missing the size and then the next
>> kernel might reject the FDT.
>> 
>> Also, we directly return the FDT error code to the caller, which
>> wouldn't make sense since it probably expects -errno.
>> 
>> Not something this patchset has to fix, but I am pointing this out in
>> case someone (possibly also future me) is interested in fixing this up.
>
> That is a good point, do you mean a fix like the following? 
>
> commit 633d0cb01ed959676b60de8b1851dad1757d8fe5
> Author: Breno Leitao <leitao@debian.org>
> Date:   Mon Mar 16 04:03:51 2026 -0700
>
>     kho: fix error handling in kho_add_subtree()
>     
>     Fix two error handling issues in kho_add_subtree():
>     
>     1. If fdt_setprop() fails after the subnode has been created, the
>        subnode is not removed. This leaves an incomplete node in the FDT
>        (missing "preserved-data" or "blob-size" properties), which violates
>        the KHO ABI and may cause the next kernel to reject the FDT.
>     
>     2. The fdt_setprop() return value (an FDT error code) is stored
>        directly in err and returned to the caller, which expects -errno.
>     
>     Fix both by storing fdt_setprop() results in fdt_err, jumping to a new
>     out_del_node label that removes the subnode on failure, and only setting
>     err = 0 on the success path.
>     
>     Signed-off-by: Breno Leitao <leitao@debian.org>
>     Suggested-by: Pratyush Yadav <pratyush@kernel.org>
>
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 62b1b8a9aa337..8d2d30119f6d4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -787,19 +787,24 @@ int kho_add_subtree(const char *name, void *blob, size_t size)
>  		goto out_pack;
>  	}
>  
> -	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
> -			  &phys, sizeof(phys));
> -	if (err < 0)
> -		goto out_pack;
> +	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_PROP_NAME,
> +			      &phys, sizeof(phys));
> +	if (fdt_err < 0)
> +		goto out_del_node;
>  
> -	err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
> -			  &size_u64, sizeof(size_u64));
> -	if (err < 0)
> -		goto out_pack;
> +	fdt_err = fdt_setprop(root_fdt, off, KHO_SUB_TREE_SIZE_PROP_NAME,
> +			      &size_u64, sizeof(size_u64));
> +	if (fdt_err < 0)
> +		goto out_del_node;
>  
>  	WARN_ON_ONCE(kho_debugfs_blob_add(&kho_out.dbg, name, blob,
>  					  size, false));
>  
> +	err = 0;
> +	goto out_pack;
> +
> +out_del_node:
> +	fdt_del_node(root_fdt, off);
>  out_pack:
>  	fdt_pack(root_fdt);
>  
>
> Given this is not strictly related to this patchset, I am planning to
> send this fix separately.

Yep, looks good. Please send it out as an independent patch.

[...]

-- 
Regards,
Pratyush Yadav

