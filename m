Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816D8CFC522
	for <kexec@archiver.kernel.org>; Sat, 22 Nov 2025 18:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SucK0S+LKL6mpkxIG0DfWO1PUYsxUTWbPD1dv9eG2K8=; b=yXUvKCG7qD1n4P6EhvIoFEQ6bp
	cRp7k6nh4ddPhVktCFR9EPjZd0uEWmeMAnNajwxLY8z4MJULWRtw8BwxrMEZxK7hzjmKoeATnNb29
	r8NtisXA/nijPTnVQA2mU65JRDHHSOakk0im+hHYcHWSbmE7nTMYCeAx7sJkMbvTk0tCHuP6bZczn
	f5RvaKPHFkTIfYGdDvEp2FL9w5lkPLEYrxZwaMloUZJMJTjvF0XjDbAFBtayil+zmXbCWg1vIAgxf
	7dLg5Y4B1/Ww81FUodCCCBXhWYMMXF68Kys1OUisGdP/x5zB5eDQ1Ue5pR+ptYbvGNsu2IO8gI2/r
	yAj1OZHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMs2D-00000009maC-0DLj;
	Sat, 22 Nov 2025 18:08:33 +0000
Received: from m16.mail.163.com ([117.135.210.4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMs2A-00000009mZq-2qv2
	for kexec@lists.infradead.org;
	Sat, 22 Nov 2025 18:08:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Su
	cK0S+LKL6mpkxIG0DfWO1PUYsxUTWbPD1dv9eG2K8=; b=E2PaWyGYDoh0W+vS1P
	aift3gSSw3zRpuYQmA5wSYUD3/Yvu2bLHJ+odg8PPIs0XKRnIlTQdXvDQT9oDwiG
	WydQgUADtC9wPaHZa7XHTznpZW2i04+DpY6bOItD7rnNxWWVHHhziZFF/ZB6Y0V6
	SHj5uV6CJBJipgoYQ45YjBpS8=
Received: from ubuntu24-z.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgCnRt3Z+yFp+yVmFA--.60796S2;
	Sun, 23 Nov 2025 02:07:21 +0800 (CST)
From: ranxiaokai627@163.com
To: rppt@kernel.org
Cc: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	changyuanl@google.com,
	graf@amazon.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com
Subject: Re: [PATCH 2/2] liveupdate: Fix boot failure due to kmemleak access to unmapped pages
Date: Sat, 22 Nov 2025 18:07:20 +0000
Message-ID: <20251122180720.92605-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aSBq8T8ETc3zjBf6@kernel.org>
References: <aSBq8T8ETc3zjBf6@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PSgvCgCnRt3Z+yFp+yVmFA--.60796S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry5ZrWrGw13XrWUGry3Jwb_yoW5Gr43pF
	yvkF1jyw4Dt34agF47t3W0ya4Sqw4Fkr47JFyjq343Ar9xXrn2qws5Z3y0vFWUXrZYkF4j
	vF4jq3yrWr48ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUrcTPUUUUU=
X-Originating-IP: [117.176.242.91]
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0h8OTGkh+d0vKgAAsm
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251122_100831_051070_760A8D25 
X-CRM114-Status: GOOD (  11.52  )
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

>On Thu, Nov 20, 2025 at 02:41:47PM +0000, ranxiaokai627@163.com wrote:
>> Subject: liveupdate: Fix boot failure due to kmemleak access to unmapped pages
>
>Please prefix kexec handover patches with kho: rather than liveupdate.

Thanks for your review, i will update the patch subject.

>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> When booting with debug_pagealloc=on while having:
>> CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT=y
>> CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF=n
>> the system fails to boot due to page faults during kmemleak scanning.
>> 
>> This occurs because:
>> With debug_pagealloc enabled, __free_pages() invokes
>> debug_pagealloc_unmap_pages(), clearing the _PAGE_PRESENT bit for
>> freed pages in the direct mapping.
>> Commit 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
>> releases the KHO scratch region via init_cma_reserved_pageblock(),
>> unmapping its physical pages. Subsequent kmemleak scanning accesses
>> these unmapped pages, triggering fatal page faults.
>> 
>> Call kmemleak_no_scan_phys() from kho_reserve_scratch() to
>> exclude the reserved region from scanning before
>> it is released to the buddy allocator.
>> 
>> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>  kernel/liveupdate/kexec_handover.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
>> index 224bdf5becb6..dd4942d1d76c 100644
>> --- a/kernel/liveupdate/kexec_handover.c
>> +++ b/kernel/liveupdate/kexec_handover.c
>> @@ -11,6 +11,7 @@
>>  
>>  #include <linux/cleanup.h>
>>  #include <linux/cma.h>
>> +#include <linux/kmemleak.h>
>>  #include <linux/count_zeros.h>
>>  #include <linux/kexec.h>
>>  #include <linux/kexec_handover.h>
>> @@ -654,6 +655,7 @@ static void __init kho_reserve_scratch(void)
>>  	if (!addr)
>>  		goto err_free_scratch_desc;
>>  
>> +	kmemleak_no_scan_phys(addr);
>
>There's kmemleak_ignore_phys() that can be called after the scratch areas
>allocated from memblock and with that kmemleak should not access them.
>
>Take a look at __cma_declare_contiguous_nid().

Thanks for catching this.
Since kmemleak_ignore_phys() perfectly handles this issue,
introducing another helper is unnecessary.
I'll post v2 shortly.

>>  	kho_scratch[i].addr = addr;
>>  	kho_scratch[i].size = size;
>>  	i++;
>
>-- 
>Sincerely yours,
>Mike.


