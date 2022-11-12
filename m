Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85344C4332F
	for <kexec@archiver.kernel.org>; Sat, 12 Nov 2022 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kN/7J3324Xj9bIvDa1qIvhufKwlSK8ZcLC/jnQIJo/c=; b=jqyDJ/ExVXxNFz
	UpN4myl3qIIJ460rLHQJf+lG/Q1QmMVgD2BFFAcLinFUJieSS/VgqM/ybl8lSdClLf4waDXCHrwWJ
	wyhDrofvFESTi4CHdHvKoV5vp+9ZjH1sqQJ9Y7rO82oKzE7kZy8PKxQVdy17+NlmEfQaxOOllbp1R
	jb5A0W9lNYK02ud9FmAPaCBTe2HBer9eFMoXKw9ISo8BYCqfBoVgfzeGhNPxfOnyZt021xbinhWVV
	Lp+SRpMWTxjNuZS/RjfvtBOkidUi1Ki2Z1Yi0/uaR/uy5ZldtK1yTvfNbZJxZmJVZvmMAeaaAcKbP
	uz3ILkFxD6FMENfCMMdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otySi-007zui-AD; Sat, 12 Nov 2022 21:54:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otySg-007zuW-Qh
	for kexec@bombadil.infradead.org; Sat, 12 Nov 2022 21:54:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=e69G3zk0gUdq0LcFy0TDryQ6kdaJ3PoKF9Rf2f2etP0=; b=m/owBRlwI/I9NjGIy4EAUYnh4k
	COAw2oAQhbwAs2yCnfy+kSu2iq8tlesBrVMCIzbgMdbu0psTwpbGxjnt/o8a3sCT04aFsVyjx+F/D
	RIRn+hcQsd9SWqKzdiRw8KGsrRlAs+JNYUE6oUPjKlBg4zPxsLXz1sEKO9r7qr/BfaYlvyWjrmzeR
	kYOL1knhIY2h6DyWY0RRsCy8lU3icp60MlINeRoPX+o9o941CMjXyC8gycwAnxVEq6jy2lFlIlpEH
	PcrFhDIj+ogCb7u7GYHKkhh8knJhK9GRz/FjXravV8IIumheoz+jufAEN1wS7a09ijCLwjst/T2qs
	dsRSrvUw==;
Received: from fanzine2.igalia.com ([213.97.179.56])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1otySc-000PmD-OU
	for kexec@lists.infradead.org; Sat, 12 Nov 2022 21:54:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=e69G3zk0gUdq0LcFy0TDryQ6kdaJ3PoKF9Rf2f2etP0=; b=qXouuoBOybLJuRlLwC/26K4W+j
	168l31Eg/PBKzgScJxE8deJ0PfWGEeNURIB3efMQfH+4/uOFuacUr+ectWhoMTpooMsL+6Yz/vP+B
	+oWQ9x3hOjDwBPHvZuvy+cQOENfrMoCpxYzeT0O8xTi4XKdVK+szjQTWlUlV6Q9zLj2WvGFeuKoq5
	DVdn1zNHfn62Dkj7AukFgTW/tAKwPzGeMIO6fG8c2OMLBM0fQZtM61Bd6kCMUvPGh55GtvgkXzQxJ
	xqiQFo49g4eovaqaBxGE+PXYlGdJi9moRQZEveVv5LUdWld3Um2dnmsi6p+Ej9mTLZtmfIBX0i1mo
	FFVuFKOQ==;
Received: from [179.232.147.2] (helo=[192.168.0.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1otyRy-00HHuA-IA; Sat, 12 Nov 2022 22:54:06 +0100
Message-ID: <44bce9f3-365b-9592-83a9-8608b0cba20b@igalia.com>
Date: Sat, 12 Nov 2022 18:53:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 10/11] drivers/hv/vmbus, video/hyperv_fb: Untangle and
 refactor Hyper-V panic notifiers
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>,
 "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "bhe@redhat.com" <bhe@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
 "pmladek@suse.com" <pmladek@suse.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 Andrea Parri <parri.andrea@gmail.com>, Dexuan Cui <decui@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Tianyu Lan <Tianyu.Lan@microsoft.com>
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-11-gpiccoli@igalia.com>
 <BYAPR21MB16880251FC59B60542D2D996D75A9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <ae0a1017-7ec6-9615-7154-ea34c7bd2248@igalia.com>
 <SN6PR2101MB1693BC627B22432BA42EEBC2D7299@SN6PR2101MB1693.namprd21.prod.outlook.com>
 <efdaf27e-753e-e84f-dd7d-965101563679@igalia.com>
 <Y27Q9SSM6WkGFwf5@liuwe-devbox-debian-v2>
 <Y27XsybzcgCQ3fzD@liuwe-devbox-debian-v2>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Y27XsybzcgCQ3fzD@liuwe-devbox-debian-v2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221112_215447_213563_352AB226 
X-CRM114-Status: UNSURE (   8.38  )
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

On 11/11/2022 20:16, Wei Liu wrote:
> On Fri, Nov 11, 2022 at 10:47:17PM +0000, Wei Liu wrote:
>> On Thu, Nov 10, 2022 at 06:32:54PM -0300, Guilherme G. Piccoli wrote:
>>> [Trimming long CC list]
>>>
>>> Hi Wei / Michael, just out of curiosity, did this (and patch 9) ended-up
>>> being queued in hyperv-next?
>>>
>>
>> No. They are not queued.
>>
>> I didn't notice Michael's email and thought they would be picked up by
>> someone else while dealing with the whole series.
>>
>> I will pick them up later.
> 
> They are now queued to hyperv-next. Thanks.

Thanks a lot Wei and Michael, much appreciated =)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
