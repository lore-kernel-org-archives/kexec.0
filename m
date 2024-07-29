Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C8CFC3DA64
	for <kexec@archiver.kernel.org>; Mon, 29 Jul 2024 03:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=e6wdYsSRWI+XGTESWV9auB2W+U98vVjWt4bv2Pym2d0=; b=C3kF1E+//CnVSS
	UsjNlj1Bpv9EgQqoE3A5xonRvU2yVF0Or7Qs3qLAlr4gkork6roQJHwkaJKExLefV1FjfvqszlqYq
	33FKwo0378mx9z+9LZAIVPudAYa2FtVkzLLVtChXTX6AzSFv7TBJwBnXdyGsrcGw1GG8StwCkdoJJ
	Q8zyExce+ABbBTRZiuNazIdsA0sPP2567AUPDxao0lW7Y4alUzsFXJnfZuPmPvRkMdQ3T+v22qfU4
	dF+kTfK6PhdAr+4/z2w+DVUGyY9fuzbGwjFnDDzZcd4ZxamqOHCAxoR4CGpwKb1xqS6dLxUt5QfBE
	ibxkfuOuLz/1fQGxcL3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYH03-00000009q4x-2NZE;
	Mon, 29 Jul 2024 03:24:39 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYGzy-00000009q3t-3fP3;
	Mon, 29 Jul 2024 03:24:37 +0000
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXNvs6QshzdkLj;
	Mon, 29 Jul 2024 11:22:33 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 482851800D0;
	Mon, 29 Jul 2024 11:24:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 11:24:22 +0800
Message-ID: <564e362d-5e8c-5d23-9c54-bfb811794169@huawei.com>
Date: Mon, 29 Jul 2024 11:24:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <vgoyal@redhat.com>, <dyoung@redhat.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <rppt@kernel.org>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
 <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240728_202435_128043_4350E939 
X-CRM114-Status: GOOD (  16.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org



On 2024/7/23 13:17, Baoquan He wrote:
> On 07/23/24 at 10:07am, Jinjie Ruan wrote:
>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>> as below:
>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>
>> It's similar on other architectures, such as ARM32 and RISCV32.
>>
>> The cause is that the crash_size is parsed and printed with "unsigned long
>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>> which is 4 bytes in memblock_phys_alloc_range().
>>
>> Fix it by checking if crash_size is greater than system RAM size and
>> return error if so.
>>
>> After this patch, there is no above confusing reserve success info.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> Suggested-by: Baoquan He <bhe@redhat.com>
>> Suggested-by: Mike Rapoport <rppt@kernel.org>
> 
> 
> My Suggested-by can be taken off because I suggested to check the parsed
> value after parse_crashkernel(), Mike's suggestion is better.

Hi, Can the suggested-by be removed when this version is merged, or a
new version needs to be sent?

> 
> For this version,
> 
> Acked-by: Baoquan He <bhe@redhat.com>
> 
>> ---
>> v5:
>> - Fix it in common parse_crashkernel() instead of per-arch.
>> - Add suggested-by.
>>
>> v4:
>> - Update the warn info to align with parse_crashkernel_mem().
>> - Rebased on the "ARM: Use generic interface to simplify crashkernel
>>   reservation" patch.
>> - Also fix for riscv32.
>> - Update the commit message.
>>
>> v3:
>> - Handle the check in reserve_crashkernel() Baoquan suggested.
>> - Split x86_32 and arm32.
>> - Add Suggested-by.
>> - Drop the wrong fix tag.
>>
>> v2:
>> - Also fix for x86_32.
>> - Update the fix method.
>> - Peel off the other two patches.
>> - Update the commit message.
>> ---
>>  kernel/crash_reserve.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>> index ad5b3f2c5487..5387269114f6 100644
>> --- a/kernel/crash_reserve.c
>> +++ b/kernel/crash_reserve.c
>> @@ -335,6 +335,9 @@ int __init parse_crashkernel(char *cmdline,
>>  	if (!*crash_size)
>>  		ret = -EINVAL;
>>  
>> +	if (*crash_size >= system_ram)
>> +		ret = -EINVAL;
>> +
>>  	return ret;
>>  }
>>  
>> -- 
>> 2.34.1
>>
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
