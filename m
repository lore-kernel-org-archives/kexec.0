Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABBEC7115B
	for <kexec@archiver.kernel.org>; Tue, 24 Jun 2025 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=XHef5Y5QUHyzQgQvSVIof0rO683+pe4CW4OipTCxGQ4=; b=iau+l+QolYvEJOclNNiySHo03Q
	4HDsVkhWDx09Y90+epqjYUzPSI7D84BSvbpaL1ttiG9fOTPsNx/P2thY7XpVW7I4eabAUGmeRWY4S
	Ar44MTtZAn+ObJx7ba1JLcIpmchmRU8X1AbLvs/NggztqhA0wn/4/SHnkRyyTIXKq289NVMbYXUHF
	yUXtdLmTQfq1ROLz5tttxku2IWfKp3jB8yRW2LTFUpS2VpldOGPuUkgbanCsjN5tAM2KkUcE1x3WR
	Virft8JGW8BvJGPIK2xu7uhXyjmiHmAQmMZZwv1diJWeXz8zF6tQJCXiVmpAflVkkIIYpXFqkLaaH
	iSkmmwvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTtBq-00000004Sa2-1k0R;
	Tue, 24 Jun 2025 02:15:14 +0000
Received: from [42.101.60.213] (helo=mail.nfschina.com)
	by bombadil.infradead.org with smtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTtBn-00000004SZH-1fD2
	for kexec@lists.infradead.org;
	Tue, 24 Jun 2025 02:15:13 +0000
Received: from [172.30.20.101] (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id 88D7860107F46;
	Tue, 24 Jun 2025 10:14:56 +0800 (CST)
Message-ID: <a90315db-e2d9-4a86-9be5-6ea88f5c94a2@nfschina.com>
Date: Tue, 24 Jun 2025 10:14:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Su Hui <suhui@nfschina.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
In-Reply-To: <d60db71a-0b4f-4e7d-8c06-7493934aa507@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_191511_639131_94152A86 
X-CRM114-Status: UNSURE (   8.95  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org


On 2025/6/23 23:22, Dan Carpenter wrote:
> On Mon, Jun 23, 2025 at 10:36:45PM +0800, Baoquan He wrote:
>> On 06/23/25 at 06:47pm, Su Hui wrote:
>>> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
>>> type from 'size_t' to 'unsigned int' for the consistency of data->size.
>> It's unclear to me why size_t is not suggested here. Isn't it assigned
>> a 'sizeof() + data->size' in which size_t should be used?

Oh, sorry for this, I missed some things.

1497         data_size = roundup(sizeof(struct vmcoredd_header) + 
data->size,
1498                             PAGE_SIZE);
1499
1500         /* Allocate buffer for driver's to write their dumps */
1501         buf = vmcore_alloc_buf(data_size);
             [...]
1515
1516         dump->buf = buf;
1517         dump->size = data_size;
                  ^^^^^^^^^^^^^^^^^^^^^
If data_size is 64 bit and assume data_size is bigger than 32bit, 
dump->size will overflow.
Should we adjust dump->size's type to size_t? Or maybe it's impossible 
for data_size bigger
than 32bit?
> Yeah...  That's a good point.  People should generally default to size_t
> for sizes.  It really does prevent a lot of integer overflow bugs.  In
> this case data->size is not controlled by the user, but if it were
> then that would be an integer overflow on 32bit systems and not on
> 64bit systems, until we start declaring sizes as unsigned int and
> then all the 32bit bugs start affecting everyone.
Agreed, sorry for my fault again.
I will remove the 'unsigned int' in v2 patch.
Thanks for your suggestions!

regards,
Su Hui


