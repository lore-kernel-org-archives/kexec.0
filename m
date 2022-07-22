Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D7C433EF
	for <kexec@archiver.kernel.org>; Fri, 22 Jul 2022 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zYMdcNmLJLpxL8CdjjmE4RqriiM7ZAo+fi3D2z5Iz8E=; b=JLOAHJUMnjyZXp
	RIRUFwgDRi9CMSUrd+EsS8weYLzFdrMeCHMeMDgohQ4cSOq2LxJrBNXxmscxXxaTyQIdjB//qQu/G
	gkWMBBdkYtaoxIQMAYvBwqqNAI2k1M8HRoHeSiT5Kri/2BM/R4RwjFa4ey2tnVocF2Q9vSLrmk7ef
	SgLLgphUczTbqgyjpQUaGIH5xcHUGnMS3adGBZqN3PMlgoS1EDR1aOp2c1petQ6MflUDylNyXUg48
	uGmw26vM+GkkmjovZT4JdOeqHP5P7M2NyfYIhQGCQoapopCsGU/PciPy2iT5H/kQZ615vdOGkFkbk
	nyP4XunWj8j99dWp7GJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEqyM-003ZnB-CW; Fri, 22 Jul 2022 11:37:34 +0000
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEqyJ-003ZdS-BA
	for kexec@lists.infradead.org; Fri, 22 Jul 2022 11:37:33 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VK4wQdR_1658489841;
Received: from 30.97.56.201(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VK4wQdR_1658489841)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 19:37:21 +0800
Message-ID: <f01182c5-a19e-0f84-bcaa-102246fd5563@linux.alibaba.com>
Date: Fri, 22 Jul 2022 19:37:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] kexec: accumulate and release the size of crashkernel
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com
References: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
 <YsOaZ/IETqnWO2uI@MiWiFi-R3L-srv>
From: Carlo Bai <carlo.bai@linux.alibaba.com>
In-Reply-To: <YsOaZ/IETqnWO2uI@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_043731_595894_0F2C9E6D 
X-CRM114-Status: GOOD (  17.95  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2022/7/5 9:56, Baoquan He wrote:
> On 07/04/22 at 07:41pm, Kaihao Bai wrote:
>> Currently x86 and arm64 support to reserve low memory range for
>> crashkernel. When crashkernel=Y,low is defined, the main kernel would
>> reserve another memblock (instead of crashkernel=X,high, which stored
>> in crashk_res) for crashkernel and store it in crashk_low_res.
>>
>> The implementations of get_crash_size and crash_shrink_size do not
>> consider the extra reserved memory range if it exists. Thus, firstly
>> accumulate this range on the size of crashkernel and export the size
>> by /sys/kernel/kexec_crash_size.
>>
>> If getting the input of /sys/kernel/kexec_crash_size, both reserved ranges
>> might be released if the new size is smaller than current size. The order
>> of release is (crashk_res -> crashk_low_res). Only if the new size defined
>> by the user is smaller than the size of low memory range, continue to
>> release the reserved low memory range after completely releasing the high
>> memory range.
> 
> Sorry, I don't like this patchset.
> 
> I bet you don't encounter a real problem in your product environment.
> Regarding crashkernel=,high|low, the ,low memory is for DMA and
> requirement from memory under lower range. The ,high meomry is for
> kernel/initrd loading, kernel data, user space program running. When
> you configure crashkernel= in your system, you need evaluate what
> value is suitable. /sys/kernel/kexec_crash_size is an interface you
> can make use of to tune the memory usage. People are not suggested to
> free all crashkernel reservation via the interface.
> 
> So, please leave this as is, unless you have a real case where this
> change is needed.
> 
> Thanks
> Baoquan

Sorry for the late reply.

Sincerely thanks for your reviewing, I don't have a real problem which 
needs to release part/all of the reserved low memory range of 
crashkernel. All I think is to change the interface more compatible with 
the reserved low memory range.

Besides, I think it's still confusing if we have actually reserved low 
memory range of crashkernel, but it does not reflect by the size of 
kexec_crash_size.

Thanks,
Kaihao Bai



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
