Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8544CFD314
	for <kexec@archiver.kernel.org>; Sun, 14 Dec 2025 11:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PnzroKdZa6spdIoO0lW5g/YUrILKLYNyROC9r3+3pLg=; b=YJIAT5C09QrLzn0i8deaF2FQEf
	AtNO3DrNK7wH54pt4v/ALnDkubn3hXP4yhEYCiqlcniVAMONuav03fnoYfAoC9gxI/XGAWmoTPm33
	sddiI+OSPDkpbsvxhiTUEe43P9+D+2xTfHaoMMW9T6mh/cqWvQK1kikvd5rWsJLExqhNpxaBYvd9h
	PIJ3j/0X/NwdM22oItfl3pGvvzddVJrR1Rv+/aiUr3y0MzLodUPT2tn5Lhhl8xQZ87FmEeSKJLLEO
	xShP4b4DI3gR5NuExxsDe72M0I15mwsCuPTyfYkskUovp3v4c41TNzKIrXHDo2iAXjxlcfXKQnBPM
	Mfk9ouYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUkOC-00000002Q2y-3VIk;
	Sun, 14 Dec 2025 11:35:48 +0000
Received: from smtpbgsg2.qq.com ([54.254.200.128])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUkO9-00000002Q2G-32Dt
	for kexec@lists.infradead.org;
	Sun, 14 Dec 2025 11:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1765712108;
	bh=PnzroKdZa6spdIoO0lW5g/YUrILKLYNyROC9r3+3pLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=lijgg5ZnHavn6I28N5BiOmaG0g6h9gqsdHvEu6T38i4ThYEeQE9OQgZKKj7i/x9i1
	 CIqfOzKkhYPN9kF3xABj9uvNAV7WgLlhmelZiKobJZCB8xUGhVNi4mavYbRMMyUPPx
	 EeS8nTi9vVzlkzWsnjg0sANOWTCKAcSRIYfMxAZI=
X-QQ-mid: zesmtpsz4t1765712105tcf42a4b1
X-QQ-Originating-IP: i9DlRywtOV40hEw/1DC0sderlRa56ThaZiqqbvbg9VU=
Received: from [192.168.31.204] ( [223.72.87.253])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 14 Dec 2025 19:35:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6951542398570356216
Message-ID: <84FB6FCADDAE5EBE+e11782ba-7483-40f4-8a40-a5e26f51183d@uniontech.com>
Date: Sun, 14 Dec 2025 19:35:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kexec: Fix uninitialized struct kimage *image pointer
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251212071656.834079-1-maqianga@uniontech.com>
 <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aTv0G4BYQv9J8ytY@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: ODcDgdcDagQK8cyhv655dvoULjOrwK7c8SAiCaV5fVdux87r6YYIEja/
	d5dwOHxNBgc6Eifc+UX4NOlPtYh1hR41lKORSdCYf6LXOe0+C/G20/BeVYDk5dSWqN6jLhE
	G1vZh7R7VbcgWMnYugrsn1pBetl/YWijF4cLRE+lYxW5oJ3BY/a8jr5QVgeyIgz2+eYbySa
	3OkDdmE5o01rKhMdyAYTIhDYojGV5Yb/vD2E9gKX98++fpY1t2XvsFDT9z4mYSQ6AG9e9LJ
	nHo3/pEWTKgjD2CJeXkiKOPPdNK5q3XLcJe/LWqncgtNvm9XgWSyX6xRtS7Y6sREuu93pnU
	nBeSsk3AOw2Y8/9WBQTjvmSaBZOy6wf3R6UbWBK9EcDj2wHXna5XLi8WNngExA+k1PcLv4G
	o2OGfjqnQFPLgInMYHJwMqVJGc7tW3ylH5Rb5V4pkINquYCR1ibYHWIT5ukcll5x+jqARwC
	3LuT7eUdHD6D5QUmpA85f9NXJqC02OeR9gvQBkQhAnZ26MHDbvlbwpzraXdNuxhZOtSEwth
	52e6oKNxcxmQRXX6tALpp1u5NiOQEOGa/Agj29/Dupk2oIQGh1gxEvrTvOdPKvQwRx3ImOX
	mmhlysL8L7QkInXdSP8EdLlU2cwsSva028pVA7jsQxCWNjjQtVUFH3UN6hkmSHVLDtZjrsZ
	Dx98AvEQqWY9G84hIJ7NI1KzAK1JmoKQQU2hr/Ovy4LjqjH+3tDC2IAlveVl4C+8p2UKqxE
	eW3qcvCWF8U6JdnDHl3tr6w0lyTq9RaA+FtcgtFssgXumWk/f9m81ygsdI7oej+qz27/+o3
	jAwg6uLj+cun8HKFYSdEhDfb6ojU/igYFHyWRK68X4vYvAV+0iVtoliW8ghBBFEUgasMLSY
	VOQ6rtE5XzUuxwRJjlb2IswwHJnfrNw6JRpJoPAdKGzWsDMeNkASdFdQvlKtH58ovY6OzKE
	jdzQkSs8WNGOrHxDL8PZ+6NnVpgOHIUYEmJVkjPgNa7cH58gLagVwrqthlawyLlUy8ubExb
	6WnAfVs+TdQhJr7VOw
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251214_033546_419614_5CBC0D8E 
X-CRM114-Status: GOOD (  12.47  )
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


在 2025/12/12 18:53, Baoquan He 写道:
> On 12/12/25 at 03:16pm, Qiang Ma wrote:
>> The image is initialized to NULL. Then, after calling kimage_alloc_init,
>> we can directly goto 'out' because at this time, the kimage_free will
>> determine whether image is a NULL pointer.
> Rechecked the code flow, in kimage_alloc_init(), if anything wrong, the
> allocated memory are all freed via out_free_control_pages and
> out_free_image accordingly, any place missed? If no, I think the current
> code is correctly handled.
I rechecked the code and found no omissions.
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> ---
>>   kernel/kexec.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> Acked-by: Baoquan He <bhe@redhat.com>
>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index 28008e3d462e..9bb1f2b6b268 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -95,6 +95,8 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	unsigned long i;
>>   	int ret;
>>   
>> +	image = NULL;
>> +
>>   	/*
>>   	 * Because we write directly to the reserved memory region when loading
>>   	 * crash kernels we need a serialization here to prevent multiple crash
>> @@ -129,7 +131,7 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   
>>   	ret = kimage_alloc_init(&image, entry, nr_segments, segments, flags);
>>   	if (ret)
>> -		goto out_unlock;
>> +		goto out;
>>   
>>   	if (flags & KEXEC_PRESERVE_CONTEXT)
>>   		image->preserve_context = 1;
>> -- 
>> 2.20.1
>>
>

