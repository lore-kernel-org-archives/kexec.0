Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4305CC43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XVaIw1LEBWx9N163sfmYVakgvGqjy3P576C5M9qryVU=; b=g/XO9n83Piux4K
	NXlvqTJ5EaC+2c+K9/p7TbyY4EoKgamIQVy5lvi0xTmEARpCFppsOHSayx8IpnsGxx4j79Cm+0Qo5
	WbH2KT10YPAW0DXhKrTfcTxpGOBBbn2DMiCLv6xXQiplE+AbWjTMbm7uxkShjgKOAAjFrP8OxUdW3
	VE1/xgXcOKfp2sGOu+8ykJxSi5knPym7oO7CwZgBCgmlO0vVKqLE5lndPc8CBlwVNd3nMkL5RL5fy
	EeLNnsuDVQupAwiDLYgfTJ1RhoIlzVjqQrFdZwNH5So6bByGFNi7xztkgd8M5sgXYP1iC9oaKojGm
	O1CPoLRTQ5kXJZgrZrsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2o4-000syH-IT; Wed, 20 Jul 2022 06:03:36 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDu5Q-00CpTb-A8
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 20:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mm6gaIG3ulRS6bYmNbpjfA3sE2i3p2OSI7BJX/PQ87M=; b=NHRZ5ZOoSJvZ1rx0k+qAorgHi+
	ysh3vwi0PmqkJ+sGT7WvvQq42Iam55ZtfsYvuSe8jlWS3T5GO6WFTAJPoBvG8B0awkYvog91umeP9
	Uy9+z9l79ZNg4uOpd7S9OPocCVgkb02y0J3HsguQ5KVTAI49LNiEt9sPKWHn2I9cb6QoKgN6FB9Kg
	nC7EdVklSTsvadIYvBBICjf9v+16T5FuWpJnr1e48reVt+ocCZ9LYMX8lFiuwZHLqGO0dgF535kiv
	pv2Ma+2wbPCi1qg2RE2gqrjaTAHsDQjqblHKykFE7WpSED9UQK0QBFo9aHF9TjvED8BhtMx764WgT
	m/JB4MpQ==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oDu59-006j7M-DT; Tue, 19 Jul 2022 22:44:39 +0200
Message-ID: <8e201d99-78a8-d68c-6d33-676a1ba5a6ee@igalia.com>
Date: Tue, 19 Jul 2022 17:44:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
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
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <e292e128-d732-e770-67d7-b6ed947cec7b@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_134456_712769_736C3977 
X-CRM114-Status: GOOD (  15.89  )
X-Mailman-Approved-At: Tue, 19 Jul 2022 23:02:40 -0700
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

On 19/07/2022 17:33, Arjan van de Ven wrote:
> On 7/19/2022 12:53 PM, Guilherme G. Piccoli wrote:
>> Currently we have a debug infrastructure in the notifiers file, but
>> it's very simple/limited. Extend it by:
>>
>> (a) Showing all registered/unregistered notifiers' callback names;
> 
> 
> I'm not yet convinced that this is the right direction.
> The original intent for this "debug" feature was to be lightweight enough that it could run in production, since at the time, rootkits
> liked to clobber/hijack notifiers and there were also some other signs of corruption at the time.
> 
> By making something print (even at pr_info) for what are probably frequent non-error operations, you turn something that is light
> into something that's a lot more heavy and generally that's not a great idea... it'll be a performance surprise.
> 
> 

Is registering/un-registering notifiers a hot path, or performance
sensitive usually? For me, this patch proved to be very useful, and once
enabled, shows relatively few entries in dmesg, these operations aren't
so common thing it seems.

Also, if this Kconfig option was meant to run in production, maybe the
first thing would be have some sysfs tuning or anything able to turn it
on - I've worked with a variety of customers and the most terrifying
thing in servers is to install a new kernel and reboot heh

My understanding is that this debug infrastructure would be useful for
notifiers writers and people playing with the core notifiers
code...tracing would be much more useful in the context of checking if
some specific notifier got registered/executed in production environment
I guess.

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
