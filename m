Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400FFC3F6B0
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I+/VE/jFdokBvHzXj5R0n4x/wu2ecZs507bJdaVfI6A=; b=crzPN40VhcdJhc
	NbgvfYTE5wne9aWH9BCtImd0hmQRWBpxFUZKwKNmsTSidmMVuzK1pB7IC5vFGFqDTFrtmPpzPmzG4
	2XBx4VihbaNAeX0/+7TAzErBBXjxAyv0oNeMeJH74WOjHJSQOYoAY/D/5p2SzeV4sCEwif7sSQTmo
	7/fqZLhWGBKN7bOE/BzJukySmWGPgJiqd1+iVRjCJeXmXMFX7x4d4UgV32Qu0Ecsn7y8ESB6hjqCT
	WnOmJ1fze9jD302FTjsA+Nb+E1U3N9bHHdnlSJgpvDcZdqR9eSOwaG0guGdkn8wTjYjvdLTtIgn68
	oplIPxpWkkzEkyLi29LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIXaP-007Xy8-99; Mon, 01 Aug 2022 15:44:05 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEW4g-006t1E-7V
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 13:18:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EhWcWfbhv9nEoWrIjYVp9DqpCcdMz+PUQQozGn2KheY=; b=giItKgd6wvCs3BDkeINniObKTc
	CeHEjDJ58dT7M1nCbsCw166d42VASgHXPV143OBJu0Vs+E/vqom0rLMx29isjOsh/0+wbpM4jMxCE
	2hO8q8AabrVuw4vRyHWHo+yY1zS1qVtrJ2RPdM/jr0DkEVoZ7UZbFC+f/UEcETwzamEcMKKFlRRgG
	/Zx/oBSph+Ox1u+GFKdG+fdNSCrTEqXJ5LuOMnrK43kaQv3HeoBligMAIIoeWIUfq3vD8R49RXCVr
	YrvUYr3xDDYMEgJGtTVYRYHytdArtbrkNJgeQC2HNdHoEyCxWAYXNgP8TN7Qq6zABWOyFjlZ85+QZ
	CqmKt2vw==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oEW3w-001UDx-KO; Thu, 21 Jul 2022 15:17:56 +0200
Message-ID: <104364ae-ff8f-5657-0185-6b28ff9fbfcf@igalia.com>
Date: Thu, 21 Jul 2022 10:17:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 04/13] soc: bcm: brcmstb: Document panic notifier
 action and remove useless header
Content-Language: en-US
To: Florian Fainelli <f.fainelli@gmail.com>,
 bcm-kernel-feedback-list@broadcom.com, akpm@linux-foundation.org,
 bhe@redhat.com, pmladek@suse.com, kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, bp@alien8.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 Brian Norris <computersforpeace@gmail.com>, Doug Berger <opendmb@gmail.com>,
 Justin Chen <justinpopo6@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 Markus Mayer <mmayer@broadcom.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-5-gpiccoli@igalia.com>
 <20220720230009.2478166-1-f.fainelli@gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220720230009.2478166-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_061842_284004_0E1D81F9 
X-CRM114-Status: UNSURE (   5.74  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 01 Aug 2022 08:44:02 -0700
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

On 20/07/2022 20:00, Florian Fainelli wrote:
> [...]
> 
> Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
> --
> Florian

Thanks Florian =)

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
