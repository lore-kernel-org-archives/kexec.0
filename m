Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6247C4332F
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2KYGJvSnsz+Hqm5V1aomrwfZ7lq9INWWSBD8hC6ePbw=; b=o5FwqAYrEsG7uK
	T9M4ZEyTKHI2C7f639R3aos3lvzb4+59dh4FwdwramZ/+JYSuRwHRdcUKQwBQivAhYCD7sQmLS1Qk
	IHPbf8rmUbPaAmdb6jECUprOceMa49HvcN83iT/KVQE7FINSyzFvxF+Kw/2OMwEzsgGfOgMfuPdyf
	nkdXYroKW7daT6a2nB/NAyqTzPfMVHfNQbSTC+1v1vTKJYktiyUW/VIMwA9iKXNvXkhmXRVkghy15
	Poz27/pm2Ns9wATrVohLSnHnAsEKYmqKP/4iq07C+hQ658EXCcOzv73Nc6FBlG6Ntrf0eE9CyPvBl
	IQehBXv+YFrF43FqUKMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTN-008JN6-32; Fri, 21 Oct 2022 13:54:05 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQkA-00CSIE-Jf
	for kexec@lists.infradead.org; Mon, 17 Oct 2022 14:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GbXz7tq7NKssUrzdAXnhJuuFnjt3brcW7Q8fQGb47u4=; b=eM47RKzF0IQwdt7hI0PEPj+40X
	caFLkkwVlwn5ckZgsjsUTCxLDHhGJF8xxp14yF4RilkN1gu3siZsXclb2GYrTdJi6w5EpqMz9tJQG
	91MLbhlIuBF9QNbj1ALRdyF5i44Clj48UPwEWKotTmIC6yGv2ckeS/OmqatBQ47zIFNLyhX2J7mMh
	GIg4UsmFp+0q1KpPCdUI3T2UhZsS/orgALxmq79TNa5b3g8tdfYwOcxoZcQjBVsXB78ZIOuUDdZwf
	/yrRFzXCLpviiaNU480fL+nNnu9B8/HFEPFo3xYRcc/csY+e5PB7ZHSoCxG8kNtHOPWszDFqvfJHi
	QazzIumQ==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okQjQ-000ONG-2j; Mon, 17 Oct 2022 16:04:39 +0200
Message-ID: <4fb9381a-72f3-4ef0-fca5-05f3a06c64f4@igalia.com>
Date: Mon, 17 Oct 2022 11:04:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 07/11] notifiers: Add tracepoints to the notifiers
 infrastructure
Content-Language: en-US
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 Xiaoming Ni <nixiaoming@huawei.com>, Arjan van de Ven <arjan@linux.intel.com>
Cc: pmladek@suse.com, bhe@redhat.com, linux-hyperv@vger.kernel.org,
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
 xuqiang36@huawei.com, Cong Wang <xiyou.wangcong@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Valentin Schneider <valentin.schneider@arm.com>, kexec@lists.infradead.org
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-8-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220819221731.480795-8-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_070526_699637_A72E07CF 
X-CRM114-Status: GOOD (  12.63  )
X-Mailman-Approved-At: Fri, 21 Oct 2022 06:53:58 -0700
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

On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
> Currently there is no way to show the callback names for registered,
> unregistered or executed notifiers. This is very useful for debug
> purposes, hence add this functionality here in the form of notifiers'
> tracepoints, one per operation.
> 
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V3:
> - Yet another major change - thanks to Arjan's great suggestion,
> refactored the code to make use of tracepoints instead of guarding
> the output with a Kconfig debug setting.
> 
> V2:
> - Major improvement thanks to the great idea from Xiaoming - changed
> all the ksym wheel reinvention to printk %ps modifier;
> 
> - Instead of ifdefs, using IS_ENABLED() - thanks Steven.
> 
> - Removed an unlikely() hint on debug path.
> 

Hi Arjan / all, apologies for the re-ping.
Did you have a chance to take a look in this one, is there anything else
I could improve?

Thanks in advance,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
