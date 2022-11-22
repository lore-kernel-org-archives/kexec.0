Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05228C433FE
	for <kexec@archiver.kernel.org>; Tue, 22 Nov 2022 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jdS44/8kp4oDPSLLaw+EAyjULeY2vpYz4tHRQiy3828=; b=z8bnZooeEBmSxD
	Vj5wR5NVyea+OHV/wJdrFF03QQjOZceOAdpr3ivjkAUcWw0UT5I2xFWQC3cHYJKsdOyrRge6/aLwt
	f6gcT13vNsFRhSCTA6DuVYqHZjZOmZg1KJcrdBaVx8MOUk9Dd1iysPUKPbbJnpExhqpzBFxHx8yR/
	SQ5iLbKxe4QSujV0xknmqFlCYe1HM/jJqrtS+6FwCUcn4lbsF3lgf/mtL6JvzSpv/GYgJXA1DYVDv
	V4N8hm6ADnsyq2eVnkHzcNJCPr/4bSQ55sHtRb5SDEDgDaljHQhVlX84mfiZhVLIszEmcacbjg35T
	tZTEbzkOgG6iV16wa0nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTP2-009fb8-SB; Tue, 22 Nov 2022 13:33:32 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxTOz-009fa1-Pu
	for kexec@lists.infradead.org; Tue, 22 Nov 2022 13:33:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wwK1w0+91VyguQf6bkuN05BbJdwqncc33oWAjgq88to=; b=cWFBDVu7Z4yOUp25p3/Rhx9Bdl
	jXtrRVKBSjhnWmi0UBLDnpAlDvXqGeWjL/lxbSKH+uqaeAwWzcbHIrtkhECJxYdDZpE4RliW2Gh4x
	0/f3g9/x1wbiB9QUTEvtOjTOqAUc4SO/040zHb8itMT2OK3t5HlVE3jD1cD2lrhtmpvhhnSLWJnbZ
	s/WcYjk5HX14UrkxoX6LpW5vikmrG3MVrL2vaLT0p8q7fLHd9kSpgnZPPaTI21DWwW9pUcTLSWM9E
	hoFQtO+kfOmLkrxuBnmDqqu6KrhXivaaMip3Jlygj/6+1rpd4WB4L9vQGppRnXC27E08J5D7zPV2w
	wG1mgrmQ==;
Received: from [177.102.6.147] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oxTOp-006y6v-Gr; Tue, 22 Nov 2022 14:33:19 +0100
Message-ID: <eaba1a1a-31cd-932f-277c-267699d7be30@igalia.com>
Date: Tue, 22 Nov 2022 10:33:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 08/11] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>,
 linux-edac@vger.kernel.org, bp@alien8.de
Cc: kexec@lists.infradead.org, pmladek@suse.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-9-gpiccoli@igalia.com>
 <742d2a7e-efee-e212-178e-ba642ec94e2a@igalia.com>
In-Reply-To: <742d2a7e-efee-e212-178e-ba642ec94e2a@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_053329_846466_EA17C803 
X-CRM114-Status: GOOD (  14.91  )
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

On 18/09/2022 11:10, Guilherme G. Piccoli wrote:
> On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
>> The altera_edac panic notifier performs some data collection with
>> regards errors detected; such code relies in the regmap layer to
>> perform reads/writes, so the code is abstracted and there is some
>> risk level to execute that, since the panic path runs in atomic
>> context, with interrupts/preemption and secondary CPUs disabled.
>>
>> Users want the information collected in this panic notifier though,
>> so in order to balance the risk/benefit, let's skip the altera panic
>> notifier if kdump is loaded. While at it, remove a useless header
>> and encompass a macro inside the sole ifdef block it is used.
>>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Petr Mladek <pmladek@suse.com>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>
>> ---
>>
>> V3:
>> - added the ack tag from Dinh - thanks!
>> - had a good discussion with Boris about that in V2 [0],
>> hopefully we can continue and reach a consensus in this V3.
>> [0] https://lore.kernel.org/lkml/46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com/
>>
>> V2:
>> - new patch, based on the discussion in [1].
>> [1] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
>>
>> [...]
> 
> Hi Dinh, Tony, Boris - sorry for the ping.
> 
> Appreciate reviews on this one - Dinh already ACKed the patch but Boris
> raised some points in the past version [0], so any opinions or
> discussions are welcome!


Hi folks, monthly ping heheh
Apologies for the re-pings, please let me know if there is anything
required to move on this patch.

Cheers,


Guilherme


P.S. I've been trimming the huge CC list in the series, done it here as
well.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
