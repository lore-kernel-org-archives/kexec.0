Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7E8C25B06
	for <kexec@archiver.kernel.org>; Mon,  1 Aug 2022 15:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yBuSMc68g2P4s3T4trZ/Q/cfmTXhLvWHewbtFKbfnu4=; b=0v+PM2zhbs8cj7
	k19rpessMUPDs5W9nNPVTnIyXX6iLANBxBT2fzVxMIQMrjWMpZFEhDNG3yyq19HYdQTG6yI3l9AAo
	9V4JVof0yr1q43zEOXFf1EzF/JE7JRoCg/mYSrA3QQrUZOpLyJ2vfmH4u8J6tBZ31aKQPRBeSx9xW
	1xFLBHTmVBmM9U3rTFrmZLXJSAObMDGMmN1q3nmQt1I1bv8WgU7Mvu/MZ2g2QrPV3MgS2NG6pCp6Z
	IclzQU9mhiEcnD0vBWw9XgPXPTc6QtmKnha49dcsyHZnEUG6gdxyCvkLNdfQcwevxPLkcbKZw9ZTK
	MBYfdB9vFteW7LX8l9OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIXaT-007XzI-Lf; Mon, 01 Aug 2022 15:44:09 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEW7B-006vN8-LY
	for kexec@lists.infradead.org; Thu, 21 Jul 2022 13:21:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BP2dOOHwiEAun/R1J+6SptcEzetpJVF1WfO8eYPtR2Q=; b=g/nP/ePQD9zM/JEZFMtXVfRuk6
	TLGToyIlywor5Yjzifz7Ur7IGyuGYwq80mZ8ia2tIOpKjpPEmvw1hHfBNLvhT7vVFE4M82OwpO6dE
	oUfwvPP/CYPwAlqUIYT3yd22R9kVIN92o2O4WaY0TgWtnYjs4lMys5M0RXuX2sX67wIU87HeULIww
	9I2vZqdvtgWQlbzhaP9FTDF4Z7lSRyIgRAZ9pASvZXer/YPWSnajQj95FuX1VSP3eyaAhx/AjSLLl
	45fOeJAYJZlBWsEX/BBWZAP3CMwP+2zfotvbfUHs4vpzODvRILsdmnQhssEcyFglMtIytO2QQGhKX
	Z7Q2mqZg==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oEW71-001ULd-Vs; Thu, 21 Jul 2022 15:21:08 +0200
Message-ID: <9974e738-6e3d-7d00-69b3-3aca37ea7cc1@igalia.com>
Date: Thu, 21 Jul 2022 10:20:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/13] notifier: Show function names on notifier
 routines if DEBUG_NOTIFIERS is set
Content-Language: en-US
To: Arjan van de Ven <arjan@linux.intel.com>, akpm@linux-foundation.org,
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
 Cong Wang <xiyou.wangcong@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Valentin Schneider <valentin.schneider@arm.com>,
 Xiaoming Ni <nixiaoming@huawei.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-10-gpiccoli@igalia.com>
 <e292e128-d732-e770-67d7-b6ed947cec7b@linux.intel.com>
 <8e201d99-78a8-d68c-6d33-676a1ba5a6ee@igalia.com>
 <c297ad10-fe5e-c2ee-5762-e037d051fe3b@linux.intel.com>
 <8ef53978-f26e-89e3-8b04-6f0eb183f200@igalia.com>
 <4a9d64b5-0fa4-8294-c78c-37394a156325@linux.intel.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <4a9d64b5-0fa4-8294-c78c-37394a156325@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_062117_771041_CDBBA52D 
X-CRM114-Status: UNSURE (   9.63  )
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

On 19/07/2022 19:04, Arjan van de Ven wrote:
> On 7/19/2022 2:00 PM, Guilherme G. Piccoli wrote:
>> On 19/07/2022 17:48, Arjan van de Ven wrote:
>>> [...]
>>> I would totally support an approach where instead of pr_info, there's a tracepoint
>>> for these events (and that shouldnt' need to be conditional on a config option)
>>>
>>> that's not what the patch does though.
>>
>> This is a good idea Arjan! We could use trace events or pr_debug() -
>> which one do you prefer?
>>
> 
> I'd go for a trace point to be honest
> 

ACK, I'll re-work it as a trace event then.
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
