Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A4AEB5949
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+MnDmV5IQu/jnXX+pmPU4nJ4kwJNeE3fTXXAd2vIReY=; b=cYUGo0LOnMk7cD5KA/8WgP/Fp/
	Q7AkSsZF5gw2V2dyTHmxAOOYOg7FQAVUrDQYK3sn6Oo+g+HwNuH7l7CC8BZYiGqXM57X5KJG+7eGg
	kVu35YQ74fZ8Vgvk4uPXqupesHQXwIuP7p2uQr+ipKKAbeIvyvjRqFKVt3NhuNFm3geV/d3Pl7ioT
	8ovFFxyMal9AfUEukkKTZNF0fSc069j955a8Vajhmljxm9jHJ0l8lIALIL3CYDdXWhmSlzogwm6ZR
	rJiwNU9TdaVS8FyOgv0lkJTEh0CIDqFlshmjmmwcwPP+qwcwGUaclyUgWxCY6FeHO3/fR8B7YSbtz
	Y+HorPLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpyxx-000000005OV-1Vni;
	Wed, 11 Feb 2026 01:24:29 +0000
Received: from m16.mail.163.com ([220.197.31.2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpyxu-000000005N3-013L
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 01:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=+M
	nDmV5IQu/jnXX+pmPU4nJ4kwJNeE3fTXXAd2vIReY=; b=b86/g32+FT4tra5Zfh
	v4CunaMUZab3+RGQnBJb3CR5/vASUYw3wrGhdN0qoK7D2vF5R0A6MDTVxNYlug05
	XlObd8HIgY2u6o7KCIHbYwyeKPD0g5rFunf+hPlIDKU74f9KVBfFWmerb2yLH8gy
	cdIO0xn1JnPe0WP7LoitnFpMw=
Received: from ubuntu24-z.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wBHL1Yj2otp2VksLA--.37135S2;
	Wed, 11 Feb 2026 09:23:47 +0800 (CST)
From: ranxiaokai627@163.com
To: pratyush@kernel.org
Cc: akpm@linux-foundation.org,
	graf@amazon.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	rppt@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH -next 1/2] kho: fix missing early_memunmap() call in kho_populate()
Date: Wed, 11 Feb 2026 01:23:46 +0000
Message-ID: <20260211012346.208225-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2vxzv7g4sof5.fsf@kernel.org>
References: <2vxzv7g4sof5.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHL1Yj2otp2VksLA--.37135S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7try3tr18Gw45uFy5GF15urg_yoW8tr4kpF
	WrGa1jkw48tayjqa12gF12934Fgw4ktw1fta4UAa4fJF1DZrnaq3yxGa40vFnrXr1S93WS
	yF4vqayfW3WkCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUpVbDUUUUU=
X-Originating-IP: [117.176.243.201]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbC7gP7SGmL2iPjdwAA3R
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_172426_349757_A59DEF17 
X-CRM114-Status: GOOD (  13.82  )
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

>Hi Ran,
>
>Thanks for the fix.
>
>On Fri, Feb 06 2026, ranxiaokai627@163.com wrote:
>
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>
>> kho_populate() returns without calling early_memunmap() on success
>> path, this will cause early ioremap virtual address space leak.
>>
>> Fixes: b50634c5e84a ("kho: cleanup error handling in kho_populate()")
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>
>> b50634c5e84a ("kho: cleanup error handling in kho_populate()")
>> has not landed in upstream, so
>> Cc: <stable@vger.kernel.org> is unnecessary?
>>
>>  kernel/liveupdate/kexec_handover.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index fb3a7b67676e..76b714db175d 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -1463,6 +1463,7 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	struct kho_scratch *scratch = NULL;
>>  	phys_addr_t mem_map_phys;
>>  	void *fdt = NULL;
>> +	int populated = 0;
>
>Nit: Please use a bool and true/false. I think it reads much nicer.

yes.

>>  	int err;
>>  
>>  	/* Validate the input FDT */
>> @@ -1529,16 +1530,17 @@ void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
>>  	kho_in.scratch_phys = scratch_phys;
>>  	kho_in.mem_map_phys = mem_map_phys;
>>  	kho_scratch_cnt = scratch_cnt;
>> -	pr_info("found kexec handover data.\n");
>>  
>> -	return;
>> +	populated = 1;
>> +	pr_info("found kexec handover data.\n");
>>  
>>  err_unmap_scratch:
>>  	early_memunmap(scratch, scratch_len);
>>  err_unmap_fdt:
>>  	early_memunmap(fdt, fdt_len);
>>  err_report:
>
>Nit: now that this code can be reached by non-error paths, we should
>re-name the labels. I think dropping the "err_" prefix should be enough.

Thanks for your review.
Very helpful suggestion. I will send a v2.

>With these fixed,
>
>Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
>
>> -	pr_warn("disabling KHO revival\n");
>> +	if (!populated)
>> +		pr_warn("disabling KHO revival\n");
>>  }
>>  
>>  /* Helper functions for kexec_file_load */


