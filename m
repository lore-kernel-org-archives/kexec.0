Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7A5CCF9F8
	for <kexec@archiver.kernel.org>; Wed,  5 Nov 2025 03:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fz1i1LUkKPABBVeGFuF+90i9fD0TWAWKRpPjxlVqDQ8=; b=hzi1ZSQhn1BRyUSnME9LwHhXuv
	5XjNWWicAEoo+4CaTCc//k2uA4Gs4EYR505grwUC20Wx0B55oulKpjjVh+Q5M4vfu297hBMZkKBpx
	W85eU0Sa7YgNsB0qqpUjDzcO/apqA1N62vemKYjZFS7aKHMgWOUEd+Aejb9a10IaGXzIZgHbWXv8R
	g21rN70Tlw/YNwh96wqKlChNRuFwejSPrikhkxJWg/54PirhnF2Fz34QoM90ey3yTKjeC+ApUXAJd
	7KDXWx6PlMn7Fm1eBdo2SDUKl2dm0JG4X5lofkzouZcDFxWemHIIXs51XmdiboMNeKsJ7JNiPa6QL
	SKDG7+xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGUPJ-0000000Cy6G-42hI;
	Wed, 05 Nov 2025 03:42:01 +0000
Received: from smtpbgsg1.qq.com ([54.254.200.92])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGUPG-0000000Cy4D-3ej6
	for kexec@lists.infradead.org;
	Wed, 05 Nov 2025 03:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1762314078;
	bh=Fz1i1LUkKPABBVeGFuF+90i9fD0TWAWKRpPjxlVqDQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=p4Qfm/O8eUwmCkXyYb9QYb2gd6ZrMx9VQKIs9JVXvUr1DyYmU3EGHZarSoSBu3hy4
	 8vtQ7eU0+8XnSLN8/9qSHcsCNjerhX7tkfBjIwfy2Z3nSPnqG0VeyKnXIT42KxkvZu
	 y8OmLnt/xipiXrKigicZSrhoLlqMW1hm/HkE/AcQ=
X-QQ-mid: esmtpsz17t1762314071t04862f69
X-QQ-Originating-IP: VZ8hyRnddlbw0XyeY8Fe92+B5KFDCJfwg0xaIeEEtQg=
Received: from [10.10.74.117] ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 11:41:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4576968291990005006
Message-ID: <5FC4A8D79744B238+97288be4-6c1a-4c0d-ae7d-be2029ec87f3@uniontech.com>
Date: Wed, 5 Nov 2025 11:41:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] kexec: print out debugging message if required for
 kexec_load
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20251103063440.1681657-1-maqianga@uniontech.com>
 <20251103063440.1681657-4-maqianga@uniontech.com>
 <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
Content-Language: en-US
From: Qiang Ma <maqianga@uniontech.com>
In-Reply-To: <aQq97iGeYvZdr3SX@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MAN6sKHDZ5xSrxCnFlhyBCwy/ehiSqR3NikowjD2bOoDld6ue6Uy8Xaf
	6rHdi0fmC/XUMGCb5sXYb5ugGOHCvVZ3AfojMH/LRyQ2IfcyVKN5LAfBl+MT3FNJPxavsVk
	U+wHM8A0pHk/zxojtc/m6LcPshKO0jV1zexHfq9ijIS0LLyek2n/d8B2yiE+++PDevh7+0e
	5noqa7UWvrRirb7B7hiqGB4vPephCZq+ZNbvZUFtfuBRklOZp3csPBGNpdU+sOSCXrlmhoL
	YrKjZd6LF8uBUxTwNLA+1CQHokTi2v5lfHOrrkjJ8HaZQNZtH5U1E2wweEi+sqA85vwC0OT
	UPbvNoG9PjTTwbKJ5itcokxlq05+U0fcahtSG0xPSm+mXnPmj7nGAhJYVv4O6chDvNMcQLU
	WPlUfrLRE3xRLMH5fx5Az3yPmSURCVTk8+jVhhNT8UzuC57lLfNzqlqi1gdDEfADLGBq3wq
	8DNStGIQdTJ8Lb5kiEKxKdmGHHjxvQoyZzvuaIOCi9H2mp07bvCd1aTikz0j0LuRgKc6ELr
	4H+b1KB+6E5p8t9LQq+DKdZSbDkE8w3xza8bLIEkZ1p+ltCanJoIVcufNLOTmaoBa9o98r6
	QHjZmjs812MaB4tppTnykahEo8mKj3e+2nbZ0daKR/c7PxocYv5QYHrxMmm7szOw5KDRrr7
	LP7pB9xjdpxcUSyGC2/CZiLKmb6lAACZOVJZpO9vRiB2DxV+T/QZdW564C/M0j3Ef6XEDvr
	hvLsH8nNrxFs93r2R7R8wRCHYd3eDImLbUSa/98NPs4cbfK3baaZy7spnTmnELClAEEuDuN
	/G/IlxWTQuq41fJgddNcfboBoDkQwvshM/GjMtHEe1Z1CasVyD9qU6qC+PlQ+7ZcCHJL/L0
	4S2p13z/oN5HKRRi9gsaV8F4MDdQyCZryYDnmz4XrrU7tX94+fx99y//VbH48nr9S/vmK6Q
	ut7bmaXpU+Ue1qCAY+otiD/MYoeaZBC86cquopZdlNNHmu5CuD2mUoLm8Fn4wocuhrCCBWC
	dwbmI9rR5QDxOwNa7kP5onO2C02GuyQzGexLzVKg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_194159_287372_6753FFD5 
X-CRM114-Status: GOOD (  16.00  )
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


在 2025/11/5 11:01, Baoquan He 写道:
> On 11/03/25 at 02:34pm, Qiang Ma wrote:
>> The commit a85ee18c7900 ("kexec_file: print out debugging message
>> if required") has added general code printing in kexec_file_load(),
>> but not in kexec_load().
>>
>> Especially in the RISC-V architecture, kexec_image_info() has been
>> removed(commit eb7622d908a0 ("kexec_file, riscv: print out debugging
>> message if required")). As a result, when using '-d' for the kexec_load
>> interface, print nothing in the kernel space. This might be helpful for
>> verifying the accuracy of the data passed to the kernel. Therefore,
>> refer to this commit a85ee18c7900 ("kexec_file: print out debugging
>> message if required"), debug print information has been added.
>>
>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202510310332.6XrLe70K-lkp@intel.com/
>> ---
>>   kernel/kexec.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index c7a869d32f87..9b433b972cc1 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -154,7 +154,15 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("nr_segments = %lu\n", nr_segments);
>>   	for (i = 0; i < nr_segments; i++) {
>> +		struct kexec_segment *ksegment;
>> +
>> +		ksegment = &image->segment[i];
>> +		kexec_dprintk("segment[%lu]: buf=0x%p bufsz=0x%zx mem=0x%lx memsz=0x%zx\n",
>> +			      i, ksegment->buf, ksegment->bufsz, ksegment->mem,
>> +			      ksegment->memsz);
> There has already been a print_segments() in kexec-tools/kexec/kexec.c,
> you will get duplicated printing. That sounds not good. Have you tested
> this?
I have tested it, kexec-tools is the debug message printed
in user space, while kexec_dprintk is printed
in kernel space.

This might be helpful for verifying the accuracy of
the data passed to the kernel.
>> +
>>   		ret = kimage_load_segment(image, i);
>>   		if (ret)
>>   			goto out;
>> @@ -166,6 +174,9 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>   	if (ret)
>>   		goto out;
>>   
>> +	kexec_dprintk("kexec_load: type:%u, start:0x%lx head:0x%lx flags:0x%lx\n",
>> +		      image->type, image->start, image->head, flags);
>> +
>>   	/* Install the new kernel and uninstall the old */
>>   	image = xchg(dest_image, image);
>>   
>> -- 
>> 2.20.1
>>
>


