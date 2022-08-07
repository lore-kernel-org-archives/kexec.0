Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA511C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CcMpr4Zcekl1ibUIjJl8fyXRLqzEihEZdC1sS3yGInk=; b=aeSlm9dedl24jF
	WTe2ej0L/E1Vkf/VqIzYw0Am2C6cRwb9XM3CuUDMa4buM1dwcumAtJp8cAD+/r8gYJTBec8KPM8ux
	RilzTYxIyJ8rFlKWjivGLjfIx+ryNH3XKgkkVHXzk3trjY+7Gv/7R1Dk3vLu9xdCri6qK7Pg/5fWC
	XaP6qjLdnaEn6VGDyymGLnIiqAikZ9AsxwboYb6stqzmN8+9M6g8eegv3OeY8SAq8hc5CNBOzRQMo
	IDGEPgNq8FTRclBpLUAb6BFo+PRwt1jFMPM85zDMAhX8tqPDb+cWtBA98/Oe8cCKWjIt5PGNfJDq/
	nXFv0of485t1WTJtjSRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdhr-00297w-50; Mon, 15 Aug 2022 17:16:52 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKiWW-00FkAN-Se
	for kexec@lists.infradead.org; Sun, 07 Aug 2022 15:49:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a5evKL0dxZts3vCV7sxGwPKkDHYfYVKHor4w3PAWq2c=; b=UgGUADWMWMdDX5W8sGGx3nbKJG
	AyM7ZqrY3yIDLwhLgALxOOJOECEOo5OQS5ih+S5YxzxuCBHGQDtjqOYnfuVd1QY/S0lbrTrxNFHpY
	Bro6Oe1QYCxHOwwuzSAMX9Ztw5K7CMBYUdkIG4k00taEVXehekd48/vX2B4Tt3rHc5cAKZ2ZdZyIq
	B0LQrO9dG7ieDm45SHEcp8eQHM3Q1AUmE1kS6N6hBmg2Dp3Fd5IgZJvoAIKWK9M8w/IR4wZ/aAAbo
	voQpoRP6X3DitgWapEOWxQp3OQv+ZQuNJbfakbxcntbmu5bBXwSsbnb9bgbIrl6WxIGEm7EI/J0Kt
	EqMN83vA==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oKiWT-001239-V7; Sun, 07 Aug 2022 17:49:02 +0200
Message-ID: <612c2d54-59db-9d2c-cea3-2ffcfcaffec9@igalia.com>
Date: Sun, 7 Aug 2022 12:48:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: kexec@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 Dinh Nguyen <dinguyen@kernel.org>, linux-edac@vger.kernel.org
Cc: akpm@linux-foundation.org, bhe@redhat.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, rostedt@goodmis.org, senozhatsky@chromium.org,
 stern@rowland.harvard.edu, tglx@linutronix.de, vgoyal@redhat.com,
 vkuznets@redhat.com, will@kernel.org, pmladek@suse.com
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-11-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_084904_955892_E8F2516C 
X-CRM114-Status: GOOD (  11.92  )
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:48 -0700
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

On 19/07/2022 16:53, Guilherme G. Piccoli wrote:
> The altera_edac panic notifier performs some data collection with
> regards errors detected; such code relies in the regmap layer to
> perform reads/writes, so the code is abstracted and there is some
> risk level to execute that, since the panic path runs in atomic
> context, with interrupts/preemption and secondary CPUs disabled.
> 
> Users want the information collected in this panic notifier though,
> so in order to balance the risk/benefit, let's skip the altera panic
> notifier if kdump is loaded. While at it, remove a useless header
> and encompass a macro inside the sole ifdef block it is used.
> 
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - new patch, based on the discussion in [0].
> [0] https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/
> 
>  drivers/edac/altera_edac.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> [...]

Hey Tony / Dinh, do you think this patch is good, based on the
discussion we had [0] last iteration?

Thanks in advance,


Guilherme


[0]
https://lore.kernel.org/lkml/599b72f6-76a4-8e6d-5432-56fb1ffd7e0b@igalia.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
