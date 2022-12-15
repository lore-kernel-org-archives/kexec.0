Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A02C4332F
	for <kexec@archiver.kernel.org>; Thu, 15 Dec 2022 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4B26C+LLTlXK62NAVxE0teSqo+pOBPZYCFEcN6jlVyA=; b=bHukKj5+QbpKp5
	5NLbfB0wo1GNWvO2fmvzfi97bNua7upbcKfO3VnMg6XPbs2qBaELU+CbHRiL4kFgSZAC9fDq4lqbI
	BVfMbG5Qq6cJ4Yn9WwBPb1377YLKOD2gnKf4xkVEYVDnPcw2DMRQyCJuxAwwxy9P4tLouLTY5TqqK
	tRvpOQ9OS6bXo1X7X0M2xmwPKh1OtHpQtT48qU6+pOcyeR0ZB7qOfu9oGw3FAM3BqXvt+P4FF9UGP
	ZwZt21Fjxvad40bdTyzq8Ix4Ul/DPTjLGK95MgQbhZ9TyKAdV0Pw5WxeYbwR8Jb0nCbceHb3yUCSf
	KdC05UXgED382BXA0Wnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5vns-00BQQK-P4; Thu, 15 Dec 2022 21:30:08 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5vnp-00BQMw-QI
	for kexec@lists.infradead.org; Thu, 15 Dec 2022 21:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZzyB8e5kkmqwPLtfyxEmXXlcTt2YzzikfBkoxJrH/N8=; b=Zl0XC+nj6wJcd2brZ4qDma88Rr
	bkpBKPHJYFlupv845lzeDvNyatM+cwB313t/l6RXcZujuBXlk/nTS0e8758iuVzpHmSFekjljiy8U
	7vpx+RPpfT62MQy3MOGmNJKAToDv2eHKUU0RnEQsOtcsOqa/8JAhFUtihCz4RK3ff+5K45K+wDD0/
	ymKY6fVCJmh7pojuY3wiHbPw1I9RVEfYyKDE2z/2wSa2yykDyn/FtZIqLHokoBMKLiYyzZrzcXpUK
	DMlmA4sp0xpUVayt0ehJB/6kPoxuPEyrWdPXCfBOC4O/VazzJLM4yJMrar0K14IyPphImb+dHPRti
	+CPUprdQ==;
Received: from 200-158-226-94.dsl.telesp.net.br ([200.158.226.94] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1p5vnS-003ylO-If; Thu, 15 Dec 2022 22:29:43 +0100
Message-ID: <2aef3548-0565-3878-4226-ab6ca12d9eee@igalia.com>
Date: Thu, 15 Dec 2022 18:29:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/3] kexec: Introduce paramters load_limit_reboot and
 load_limit_panic
To: Ricardo Ribalda <ribalda@chromium.org>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-doc@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Eric Biederman <ebiederm@xmission.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
 <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_133005_888283_228DF8F6 
X-CRM114-Status: UNSURE (   9.25  )
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

On 08/12/2022 13:38, Ricardo Ribalda wrote:
> Add two parameter to specify how many times a kexec kernel can be loaded.
> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysfs, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---

Thanks for your patches Ricardo!

Small nit in the subject: s/paramters/parameters. Just observed that
after Joel's review anyway, so kudos to him heh

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
