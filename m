Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49F4C6FA8E
	for <kexec@archiver.kernel.org>; Sun, 26 Feb 2023 16:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vDaUNpW46lE6vLW0AzmsXVyeYdWxipxizUi1IRXo+lA=; b=puB6a/6hu35bqq
	6957QpBnZxI69037hO6q0TO40L8JQ7/RKHxGgHtgt39+v5GDVtwjoNWwcFhW2MDaIsM0Ut4L8AOKM
	Yg+I1Ki/6qj529Fr5eIM20DDAcOKV8GHZ4pzK5UAdh8CmP2kzP8R1m3x2O5j6GxvpzMwq7UGzqiDJ
	g+vyq/vjqAOamk53xxatbMt3UFkeC1Ds1UgXKbm/Bo5IkIoy9wqcR8kaKo9BegRG8U4Re7mw/ELv5
	7UMNHG24er2bQZtIo+glfhziHSM2aYcm0j2epIMmh8mjsAz1zKVaITrU9hew3RVsvm9Sff/ET3Gh/
	WbSxRGlAQ/DPhChhG0gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWJcS-007YO7-N7; Sun, 26 Feb 2023 16:11:24 +0000
Received: from fanzine2.igalia.com ([213.97.179.56])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWJcQ-007YNC-0T
	for kexec@lists.infradead.org; Sun, 26 Feb 2023 16:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Dz6wvhhZodWOX7hNA0c1gSql4IyZN9lBKSgUgMAtsLA=; b=cg8mJ2QZHJeWo9G29AGtRwycwX
	gOYuitq/SEVfc5FOLq1a7unoogXL9+eZidG3CIuaCL3ap1LjNEshAouvpmKzaKZdhduDkvWZOaJJk
	8cx69rKdB+g7Jom9djfrvimbM9gA3qbv7gi9mekj7LlEzf4Cm34VWbUirMloZGjO6+XFmVT0eAwPT
	BCOsNDFUCejWpK+B3f9OHK+miLyscOKzkoSZRNmMJHtTlJmU3jjIDtPbSwKLs8i3Kz55FZQ92x1Lp
	tw6dCLIgGDtnUByB8aGBqk7dChnunJPgns7kub9/oP0vNavILiW5iSJg3Pzz37OxR+8gsfGOiS6Cq
	y6SiMo3Q==;
Received: from [152.254.196.162] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1pWJcJ-00FweO-SJ; Sun, 26 Feb 2023 17:11:16 +0100
Message-ID: <4753106d-b370-5393-2908-4067f3c306e5@igalia.com>
Date: Sun, 26 Feb 2023 13:11:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] panic: Fixes the panic_print NMI backtrace setting
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bhe@redhat.com, pmladek@suse.com, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, dyoung@redhat.com, d.hatayama@jp.fujitsu.com,
 feng.tang@intel.com, hidehiro.kawai.ez@hitachi.com, keescook@chromium.org,
 mikelley@microsoft.com, vgoyal@redhat.com, kernel-dev@igalia.com,
 kernel@gpiccoli.net, stable@vger.kernel.org
References: <20230210203510.1734835-1-gpiccoli@igalia.com>
 <20230225214454.5eb25ff8a937a99d357c44ad@linux-foundation.org>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20230225214454.5eb25ff8a937a99d357c44ad@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_081122_084411_016E7895 
X-CRM114-Status: GOOD (  15.01  )
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

On 26/02/2023 02:44, Andrew Morton wrote:
> On Fri, 10 Feb 2023 17:35:10 -0300 "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> [...] 
>> Notice that while at it, I got rid of the "crash_kexec_post_notifiers"
>> local copy in panic(). This was introduced by commit b26e27ddfd2a
>> ("kexec: use core_param for crash_kexec_post_notifiers boot option"),
>> but it is not clear from comments or commit message why this local copy
>> is required.
>>
>> My understanding is that it's a mechanism to prevent some concurrency,
>> in case some other CPU modify this variable while panic() is running.
>> I find it very unlikely, hence I removed it - but if people consider
>> this copy needed, I can respin this patch and keep it, even providing a
>> comment about that, in order to be explict about its need.
> 
> Only two sites change crash_kexec_post_notifiers, in
> arch/powerpc/kernel/fadump.c and drivers/hv/hv_common.c.  Yes, it's
> very unlikely that this will be altered while panic() is running and
> the consequences will be slight anyway.
> 
> But formally, we shouldn't do this, especially in a -stable
> backportable patch.  So please, let's have the minimal bugfix for now
> and we can look at removing that local at a later time?
> 

Thanks Andrew, I agree with you! I just sent a V5 with the bugfix alone,
not changing this local/global variable behavior.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
