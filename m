Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDD1C47258
	for <kexec@archiver.kernel.org>; Thu, 25 Jan 2024 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kqt0+arDBhrOWxn4xphoO/Lf7R9J3EkFuw9a/G0AeOs=; b=VYSULVliPH3M5c
	rIFbqc5aoqllNSVH0sj4RtBoH4w6Z8iZYj/uOGARqH9PrcbMHreALaQXPji1u/9Kb19e6174ICr3F
	H1A4QZDqa1nV0XN0CC+7m5gvpS/8hMhVjqsTbDSP6vVDanQ2a4MNmQoQjOp6WhBcCiC1RQnEpJhTf
	rvC8bCMIf4PkwlLmQvZupM3POMO9ojiDrXfxrgRiOlxMtaEaEQjOhmRtHAGGdQ3wspgukqINZ8vem
	RvXznnsLY8shP8nFwS/8X+dYAvAPhs+MqPgk+5D/wqbEHSuUmuhX2cKUmpsf6YQF3uTC/bbJ1otwk
	sa539tmFrO0UtkuZzi3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT50W-00000001TTB-3FN8;
	Thu, 25 Jan 2024 19:03:24 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT50U-00000001TSe-0hxR
	for kexec@lists.infradead.org;
	Thu, 25 Jan 2024 19:03:23 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4094A20E56B9;
	Thu, 25 Jan 2024 11:03:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4094A20E56B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706209396;
	bh=D1T7algiUcMPxXRP8Zi7lyeKEJFua9zPhLw3U+ranoI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lgb0GB5Weej/LzlBhwgz/XV56uxOR7xSl8LbRuN9OYn/eDkPnQbiPluMoGRIFd15Y
	 kO/Xs5V1q2UWK5SSBxOXolA+5Y3x+xcUZPdpmn2Z/6HWpuDeIwKDY+DIzCgrFTLrlI
	 uS0XOvfauMR4Dv5pETAM/ngtzzLwyVIuoPK/HfSU=
Message-ID: <7aec91f8-9284-4c66-bbcd-0d29a9e56881@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:03:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] ima: define and call ima_alloc_kexec_file_buf
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-2-tusharsu@linux.microsoft.com>
 <8f8b573a3dda6020972f359f9c54d03272afe852.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <8f8b573a3dda6020972f359f9c54d03272afe852.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_110322_352114_49F4BAAF 
X-CRM114-Status: GOOD (  22.20  )
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

Thanks Mimi.


On 1/24/24 05:33, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Mon, 2024-01-22 at 10:37 -0800, Tushar Sugandhi wrote:
> 
> Missing from this and the other patch descriptions is the problem
> description.  Please refer to the section titled  "Describe your changes" in
> https://docs.kernel.org/process/submitting-patches.html.
> 
> "Describe your problem.  Whether your patch is a one-line bug fix or 5000 lines
> of a new feature, there must be an underlying problem that motivated you to do
> this work.  Convince the reviewer that there is a problem worth fixing and that
> it makes sense for them to read past the first paragraph."
> 
> In this case, "why" you need to refactor ima_dump_measurement_list() is the
> problem.
> 
Thanks.  I will revisit all the patch descriptions in this series to 
take into account the 'why' specific to that particular patch.

> For example:
> 
> Carrying the IMA measurement list across kexec requires allocating a buffer and
> copying the measurement records.  Separate allocating the buffer and copying the
> measurement records into separate functions in order to allocate the buffer at
> kexec "load" and copy the measurements at kexec "execute".
> 
Appreciate you giving an example in this case.
I will try to follow it in other patches too.

> "Once the problem is established, describe what you are actually doing about it
> in technical detail.  It's important to describe the change in plain English for
> the reviewer to verify that the code is behaving as you intend it to."
> 
>> Refactor ima_dump_measurement_list() to move the memory allocation part
>> to a separate function ima_alloc_kexec_file_buf() which allocates buffer
>> of size 'kexec_segment_size' at kexec 'load'.  Make the local variable
>> ima_kexec_file in function ima_dump_measurement_list() as local static to
>> the file, so that it can be accessed from ima_alloc_kexec_file_buf().
>> Make necessary changes to the function ima_add_kexec_buffer() to call the
>> above two functions.
> 
> Please make this into an unordered list.
> 
Will do.

Thanks again.

~Tushar

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
