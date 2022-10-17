Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B25C433FE
	for <kexec@archiver.kernel.org>; Fri, 21 Oct 2022 13:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yv1oCFwOcA+7/MBQG65fjNBDEwJt4V4FpRzzY2QPh4I=; b=HZtpqKW7Oopzzo
	tQDEm9wT2NBoEu/cOQyXm955dzuFJp2M2w7wCTDb9RG8o1eQyrBz0i2arfLYcKQwNYqn/9miZvdZj
	VWBDjQ0r1Mf/QIHxwKDuP0pd4rKvY9sCcXnL9qY9WW6eFq9+TQnl9YAweq86F+pyzqEaYPVa4H3lM
	0NESPcDKtLpU+nsKCG22OqCZmGBPc6wyAQhdjc1Srars1dfHlvmTULw2z8++GjzkQfhwyZuW5vhnX
	Fb+Sbdv3yw9Ar4ppcnacq4TI0d3F4SycnPj73vU1R9UwVUEJXvzqxebmtuJ4j2R4cvsNnVUoc2IHV
	KDhnt8Y3qltNuCjouadQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olsTH-008Iw2-Fg; Fri, 21 Oct 2022 13:53:59 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQgn-00CQzn-4k; Mon, 17 Oct 2022 14:01:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ccNFH8oqnQs0DDOD5l2+8QhyjoRsBFYdAqg8ytBphUI=; b=oE8vLPxK9isTmTE8r4fCiWVZlM
	TSNd9Ttokv0OcU3WpogrEnpqMIWo+btpSQYm68i5MqeSBOMeZ7f2gncGNjZ0dDeAMMZ28t74kFs1u
	Lq5hpJIPPTUyIrSMVtIjdRbEyw/8fYk3tk3ER+LXa3TdMdN3C9+CkioZGRdlG2g6y4SGAi1fqeM8n
	RIy3TKQNMSvTdf2SqdIJiGP0NHPGnZRm6HGEP6QUMwkXhHHu7P+hKyzOlHtoa074vR1nG6aF6zMYV
	9090sDEKredFKyak5RKp67fKgmkBez06Tbvnnz7dhNsszQvdw5sfkzkqlkeQKYVpW/CjJRlWMBncz
	Dp4bVR5g==;
Received: from [179.113.159.85] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1okQg7-000Nwb-57; Mon, 17 Oct 2022 16:01:15 +0200
Message-ID: <8e30b99e-70ed-7d5a-ea1f-3b0fadb644bc@igalia.com>
Date: Mon, 17 Oct 2022 11:00:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 01/11] ARM: Disable FIQs (but not IRQs) on CPUs
 shutdown paths
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: Russell King <linux@armlinux.org.uk>, Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org, will@kernel.org,
 Mark Rutland <mark.rutland@arm.com>, arnd@arndb.de,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: kexec@lists.infradead.org, pmladek@suse.com, bhe@redhat.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, bp@alien8.de, corbet@lwn.net,
 d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com,
 feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com,
 xuqiang36@huawei.com
References: <20220819221731.480795-1-gpiccoli@igalia.com>
 <20220819221731.480795-2-gpiccoli@igalia.com>
 <a25cb242-7c85-867c-8a61-f3119458dcdb@igalia.com>
In-Reply-To: <a25cb242-7c85-867c-8a61-f3119458dcdb@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_070157_210842_CBE72922 
X-CRM114-Status: GOOD (  11.21  )
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

On 18/09/2022 10:58, Guilherme G. Piccoli wrote:
> On 19/08/2022 19:17, Guilherme G. Piccoli wrote:
>> Currently the regular CPU shutdown path for ARM disables IRQs/FIQs
>> in the secondary CPUs - smp_send_stop() calls ipi_cpu_stop(), which
>> is responsible for that. IRQs are architecturally masked when we
>> take an interrupt, but FIQs are high priority than IRQs, hence they
>> aren't masked. With that said, it makes sense to disable FIQs here,
>> but there's no need for (re-)disabling IRQs.
>>
>> More than that: there is an alternative path for disabling CPUs,
>> in the form of function crash_smp_send_stop(), which is used for
>> kexec/panic path. This function relies on a SMP call that also
>> triggers a busy-wait loop [at machine_crash_nonpanic_core()], but
>> without disabling FIQs. This might lead to odd scenarios, like
>> early interrupts in the boot of kexec'd kernel or even interrupts
>> in secondary "disabled" CPUs while the main one still works in the
>> panic path and assumes all secondary CPUs are (really!) off.
>>
>> So, let's disable FIQs in both paths and *not* disable IRQs a second
>> time, since they are already masked in both paths by the architecture.
>> This way, we keep both CPU quiesce paths consistent and safe.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Michael Kelley <mikelley@microsoft.com>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
>>

Monthly ping - let me know if there's something I should improve in
order this fix is considered!
Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
