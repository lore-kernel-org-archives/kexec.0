Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24980CD1288
	for <kexec@archiver.kernel.org>; Mon,  1 Apr 2024 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:MIME-Version:Date:
	Message-ID:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/7g+3bGcTjNbMCPmc9mtCvDOsKsjlsoZ2pwOIoRWBRA=; b=uR0KOApK2gWT9a1CXy3UAi2pfA
	aOW76Y+pIG51FwDBmApTFNBG4+C2fwWM1ksqT9Nv01ip5UBveVcVm7FHd2LkAonEUjgu3qWkKb4RO
	NolLbdvwHiw1X+cyCVurxTHhceVoRGLyMbc33LRjZY2vhyBDFtLKpFk79rjpHkQPl+KAq8ns7DEfa
	ZCHFnQu6iSg454rYZSH8yI5918qw3sfHgguOiWG8iFCVi3OilkmfTuN4d47DPXnPNXxa8YmK2upVR
	Zg9o7xgFFWRl2pNwSSXYw8WZpsc9WcN0mXKyymUpCgmLL03GhCMGtEUiyXEAq5HdPW/9/VgTz5ton
	evaB3kwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrHe1-00000007tI7-2TmB;
	Mon, 01 Apr 2024 13:24:13 +0000
Received: from smtp-fw-9105.amazon.com ([207.171.188.204])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrHdy-00000007tH9-2TpZ
	for kexec@lists.infradead.org;
	Mon, 01 Apr 2024 13:24:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711977850; x=1743513850;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=/q5RUYrVO7lETbxfGo97Atx61q36lvWj5/xhBcLh7fk=;
  b=NJS136ki8hoKySzDmtYYGXCP68kEl3052YYIP/+zW6giJ6JN03uYMREM
   4ZRTt2z8jAAnc4TbmIlPNkxZUlVGMXfNOoJAKdL72DhZ45YqlAKUvjYzM
   FnsuZozog3gfM18sqyrJFZbqUK4RvGsSz26vT0Oe4Qv0rvs29GUS9OMFH
   M=;
X-IronPort-AV: E=Sophos;i="6.07,172,1708387200"; 
   d="scan'208";a="715783487"
Subject: Re: Implementing .shutdown method for efa module
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 13:23:44 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:63400]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.112:2525] with esmtp (Farcaster)
 id de5bc671-77f5-45f8-a682-175bf7ec8cfe; Mon, 1 Apr 2024 13:23:43 +0000 (UTC)
X-Farcaster-Flow-ID: de5bc671-77f5-45f8-a682-175bf7ec8cfe
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 13:23:41 +0000
Received: from [192.168.82.210] (10.85.143.172) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 1 Apr 2024 13:23:37 +0000
Message-ID: <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
Date: Mon, 1 Apr 2024 16:23:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	<sleybo@amazon.com>, <leon@kernel.org>, <kexec@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
 <20240326153223.GF8419@ziepe.ca>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240326153223.GF8419@ziepe.ca>
X-Originating-IP: [10.85.143.172]
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240401_062410_755346_9D5F9B25 
X-CRM114-Status: GOOD (  14.59  )
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

Jason

Thanks for your response, efa_remove() is performing reset to the device 
which should stop all DMA from the device.

Except skipping cleanups that are unnecessary for shutdown flow are 
there any other reasons to prefer a separate function for shutdown?


Michael

On 3/26/2024 5:32 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Tue, Mar 26, 2024 at 02:34:45PM +0200, Margolin, Michael wrote:
>> Hi Tao,
>>
>> Thanks for bringing this up.
>>
>> I've unsuccessfully tried to reproduce this kernel panic using production
>> Red Hat 9.3 AMI (5.14.0-362.18.1.el9_3.aarch64).
>>
>> Are there any related changes in the kernel you are testing?
>>
>> Anyways we do need to handle shutdown properly, please let know if calling
>> to efa_remove solves your issue.
> efa_remove should not be used for shutdown..
>
> If you have an iommu in your system (smmuv3 for this ARM64 case) then
> drivers must implement a shutdown handler or you will risk data
> corruption on ARM64 sytems during crash.
>
> The shutdown handler must stop all DMA from the device.
>
> If you don't have an iommu then the shutdown handler shouldn't be
> critical.
>
> Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
