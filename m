Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65846CD1297
	for <kexec@archiver.kernel.org>; Thu,  4 Apr 2024 06:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:CC:To:MIME-Version:Date:
	Message-ID:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fVNDt30YrsbKW+wWBlB/nQvvlYg6s4fqkZfdv1o38xo=; b=IZTaStdvNBLyKBVYRaQCYGU5O/
	p1jE/38dxh+1KRxHkJ0LZfEe3CLbJVDkB12QLNTpVT+NyfxXyKiZL7LhwDVGtIwQIofPdoDISLXg+
	9DjGIfKRLQHQsAmpBZXXZOAVxYdCPh+fBT9kIbI5u0A5A/3+HR0+BAmCHQTTILg0XXXofJvA1yEP5
	FouN4IufbAXbCrmlLuPagGPbuakbt9nDFpC3Z/dJ47PeuJzjvHYjIvEpFBvDcAeBI5Qbj4gGwtjaz
	pd9O+ZQJhfdZsZChUtekmmdCVynfuSXIKnK3lP0A+mgqx04hYPhKogGaeKUWyq7IZcKsoU4HD0uSw
	fKJJU6yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsGzV-00000001Wzt-0NcU;
	Thu, 04 Apr 2024 06:54:29 +0000
Received: from smtp-fw-80008.amazon.com ([99.78.197.219])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsGzR-00000001Wz9-1BMn
	for kexec@lists.infradead.org;
	Thu, 04 Apr 2024 06:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712213665; x=1743749665;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=vyYehCtmuOnkDyiTVtISMV19OYydyeZiEvgBYOzKtdU=;
  b=dif2c9i9L36f0f6cnVTY1LcFgEf6gwuLciiNEmIhWFzZ8bP1Jmilb9V+
   Lx/u4J9d6w5bTAUhajGjxhlC2JEboF7L7UglLv0G2lcLl6HFQHfcj/86L
   xRBsPvr/Uwhh7DbPwkWUl/LV+mWkuEehWC0+DJi7UiPWen0zl8LcmISu1
   M=;
X-IronPort-AV: E=Sophos;i="6.07,178,1708387200"; 
   d="scan'208";a="78531287"
Subject: Re: Implementing .shutdown method for efa module
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 06:54:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:47413]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.28.213:2525] with esmtp (Farcaster)
 id bb37eac2-f65b-438a-83c5-656e83f2691d; Thu, 4 Apr 2024 06:54:19 +0000 (UTC)
X-Farcaster-Flow-ID: bb37eac2-f65b-438a-83c5-656e83f2691d
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 06:54:19 +0000
Received: from [192.168.84.64] (10.85.143.175) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 4 Apr 2024 06:54:15 +0000
Message-ID: <59c5dabd-c06e-4982-af68-bdee9b8174fd@amazon.com>
Date: Thu, 4 Apr 2024 09:54:10 +0300
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
 <0e7dddff-d7f3-4617-83e6-f255449a282b@amazon.com>
 <20240403154414.GD1363414@ziepe.ca>
From: "Margolin, Michael" <mrgolin@amazon.com>
In-Reply-To: <20240403154414.GD1363414@ziepe.ca>
X-Originating-IP: [10.85.143.175]
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D031EUB003.ant.amazon.com (10.252.61.88)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_235425_587889_A3AEE743 
X-CRM114-Status: UNSURE (   9.12  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thanks, I'll send a patch.


Michael

On 4/3/2024 6:44 PM, Jason Gunthorpe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Apr 01, 2024 at 04:23:32PM +0300, Margolin, Michael wrote:
>> Jason
>>
>> Thanks for your response, efa_remove() is performing reset to the device
>> which should stop all DMA from the device.
>>
>> Except skipping cleanups that are unnecessary for shutdown flow are there
>> any other reasons to prefer a separate function for shutdown?
> Yes you should skip "cleanups" like removing the IB device and
> otherwise as there is a risk of system hang/deadlock in a shutdown
> handler context.
>
> Jason
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
