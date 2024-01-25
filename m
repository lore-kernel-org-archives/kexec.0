Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28732C47258
	for <kexec@archiver.kernel.org>; Thu, 25 Jan 2024 19:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l6rgjN5leV8vpB8H/lntqvXz0ZKmzyftxefb+yjYbMc=; b=QOqCfDZp8cMtrp
	/+6TkbjzfONnYXyH/7yxr68kYTM67XKN8er0P6U01SwIi+0lEgt9Ei0zDHhON42dARJBcG4cISTd6
	TijMlpTTKJb7U6RbksxJzrhYDtleiB7bbqPOAmCl+H+Lxl+TVwrqAVGtoLJFGteaUN2bz3p5T+1Hp
	ZWGVboGXKUQeN5/p3jUJzFdvEV+NfyKf1SlDf4ZyeJitMhg1+9RYTnQiLdW67awXInIy1OxuNSQ8l
	4f+sBgx3hW8xCGx1cs8u5ESoNqsZhmEPPDqd3mny7mzHdLSINyRdKQ50wqrys4VrMomdN6aB5Q+eF
	N+jRWgthjV2aOr4U0Qnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT53h-00000001U5k-2TGf;
	Thu, 25 Jan 2024 19:06:41 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT53e-00000001U4f-1OeT
	for kexec@lists.infradead.org;
	Thu, 25 Jan 2024 19:06:39 +0000
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id AFAF920E56BC;
	Thu, 25 Jan 2024 11:06:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFAF920E56BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706209596;
	bh=ye950e0unO0+Ln8d/jDNryrh84eW8VyNikpbfZLuGzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LQM31NQbess+W8mxY2a3ZUu69AZIfqYp9kqSOZA0kGQhORFiihNtiKoJ2TTgjdRHT
	 +omHYAM+wQgrToP8AMh+1TlLHqpj5lK43GsskAc6AVNoHGM96OeuauwNd+40mIV3Dh
	 P/0q4HnzOXmvn7IhzJQCGMYuouzYhDG7nAsx+ywc=
Message-ID: <8eee667e-9e97-409f-864f-b4b25710d1ca@linux.microsoft.com>
Date: Thu, 25 Jan 2024 11:06:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] ima: kexec: move ima log copy from kexec load to
 execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-5-tusharsu@linux.microsoft.com>
 <871a808d902bd6f1133b092a7b1924bcbba2ca6e.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <871a808d902bd6f1133b092a7b1924bcbba2ca6e.camel@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_110638_509742_98C291A1 
X-CRM114-Status: GOOD (  17.87  )
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



On 1/24/24 08:11, Mimi Zohar wrote:
> On Mon, 2024-01-22 at 10:38 -0800, Tushar Sugandhi wrote:
>> ima_dump_measurement_list() is called during kexec 'load', which may
>> result in loss of IMA measurements during kexec soft reboot.  It needs
>> to be called during kexec 'execute'.
>>
>> The below changes need to be part of the same patch to ensure this
>> patch series remains bisect-safe by ensuring the IMA log gets copied over
>> during kexec soft reboot both before and after this patch.
>>
>> Implement ima_update_kexec_buffer() to be called during kexec 'execute'.
>> Move ima_dump_measurement_list() from ima_add_kexec_buffer() to
>> ima_update_kexec_buffer().  Make the necessary variables local static to
>> the file, so that they are accessible during both kexec 'load' - where
>> the memory is allocated and mapped to a segment in the new Kernel, and
>> during 'execute' - where the IMA log gets copied over.
>>
>> Implement kimage_file_post_load() and ima_kexec_post_load() to be invoked
>> after the new Kernel image has been loaded for kexec.
>> ima_kexec_post_load() will map the IMA buffer to a segment in the newly
>> loaded Kernel.  It will also register the reboot notifier_block to trigger
>> ima_update_kexec_buffer() at exec 'execute'.
> 
> This defines two new IMA hooks - ima_kexec_post_load() and
> ima_update_kexec_buffer().  They shouldn't be hidden here in the move of copying
> the measurement list from kexec load to execute.
> 
> If "ima_update_kexec_buffer()" was initially defined as a stub function, the
> infrastructure could be set up ahead of time.  This patch could then be limited
> to just moving the copy from kexec "load" to "execute", by replacing the stub
> function with the real function.
> 
Agreed.  Making ima_kexec_post_load() and ima_update_kexec_buffer() as 
stubs/hooks did cross my mind.  Thanks for confirming that.

I will split this patch (4/7) into two.

First will define the stubs, setup the infrastructure.
And second will move the copy from 'load' to 'execute'.

~Tushar
>> Modify kexec_file_load() syscall to call kimage_file_post_load() after the
>> image has been loaded and prepared for kexec.  Call it only on kexec soft
>> reboot and not for KEXEC_FILE_ON_CRASH.
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
