Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2DEC3DA4A
	for <kexec@archiver.kernel.org>; Mon, 29 Jul 2024 11:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TJpJl/a+Brei68LS8/bb953SKsaKWhnbti728Kgz7Xg=; b=2qJ+OTXMmsUbDJ
	YGTlGFFrzEFrfRfuACjW6QAxFneh7Wf7iBiMFD8CbpjkGQEUVer1cDuyJX1myBmjRjHGzGujOtjUa
	TNX7eat88w0u/YwI5u5HHBLK9XYxiaf6qnH7ntkPOeggTHnVgDR8AIZgWnNmjWMPuqLKLorF5WJiU
	Gw3uX6+UxNXGo73Gfov0XGQGL4AunBd5T9QZYWqCMlp7m3jOQxAEbt7ztuMLxfBwGJXkPWVkpWvLD
	oz3mH0POPRsYkPZKjGiFxT5m6kYYONuaEOQLQLMXMlfAYy6f+PUVGKjRnpb1b9cb2xyyRBs1gW+gF
	HSJwjTADlL6CfAfvFNMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYOYq-0000000B3w4-3U7z;
	Mon, 29 Jul 2024 11:29:04 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYOYn-0000000B3uU-2esJ;
	Mon, 29 Jul 2024 11:29:03 +0000
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXbgv5hxKznbLP;
	Mon, 29 Jul 2024 19:27:55 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CF461800D0;
	Mon, 29 Jul 2024 19:28:52 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 19:28:51 +0800
Message-ID: <96aae430-1bbf-1274-d6d1-262e93b5fe7d@huawei.com>
Date: Mon, 29 Jul 2024 19:28:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v5] crash: Fix crash memory reserve exceed system memory
 bug
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
CC: <akpm@linux-foundation.org>, <vgoyal@redhat.com>, <dyoung@redhat.com>,
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<rppt@kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240723020746.3945016-1-ruanjinjie@huawei.com>
 <Zp8859QW+YV1KqQ9@MiWiFi-R3L-srv>
 <564e362d-5e8c-5d23-9c54-bfb811794169@huawei.com>
 <ZqcMqsMo8SYVv4Tl@MiWiFi-R3L-srv>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZqcMqsMo8SYVv4Tl@MiWiFi-R3L-srv>
X-Originating-IP: [10.67.109.254]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_042901_879683_0F74FD3C 
X-CRM114-Status: UNSURE (   7.53  )
X-CRM114-Notice: Please train this message.
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



On 2024/7/29 11:29, Baoquan He wrote:
> On 07/29/24 at 11:24am, Jinjie Ruan wrote:
>>
>>
>> On 2024/7/23 13:17, Baoquan He wrote:
>>> On 07/23/24 at 10:07am, Jinjie Ruan wrote:
>>>> On x86_32 Qemu machine with 1GB memory, the cmdline "crashkernel=4G" is ok
>>>> as below:
>>>> 	crashkernel reserved: 0x0000000020000000 - 0x0000000120000000 (4096 MB)
>>>>
>>>> It's similar on other architectures, such as ARM32 and RISCV32.
>>>>
>>>> The cause is that the crash_size is parsed and printed with "unsigned long
>>>> long" data type which is 8 bytes but allocated used with "phys_addr_t"
>>>> which is 4 bytes in memblock_phys_alloc_range().
>>>>
>>>> Fix it by checking if crash_size is greater than system RAM size and
>>>> return error if so.
>>>>
>>>> After this patch, there is no above confusing reserve success info.
>>>>
>>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>>> Suggested-by: Baoquan He <bhe@redhat.com>
>>>> Suggested-by: Mike Rapoport <rppt@kernel.org>
>>>
>>>
>>> My Suggested-by can be taken off because I suggested to check the parsed
>>> value after parse_crashkernel(), Mike's suggestion is better.
>>
>> Hi, Can the suggested-by be removed when this version is merged, or a
>> new version needs to be sent?
> 
> You can send a new one and CC Andrew.

Thank you!

> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
