Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A276C433EF
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u8BtFInbUM5kPbKPEke5nDNxiJfa+Nbj7Qx3z2EG7r4=; b=aJ9GqDCvNfmd2j
	c4QmuVO3OuAC4XjeL/M+qUNjTXIGYPN1RIFrChkEnn3cWI3uDJGieAA4JANujWLkV5YtYV2/Xk9Bx
	ZSKN3fcfPUPDi83kZ1Ekx0db5y/Pq13eDOjcbyoNNYlSRPIQEDtMSMYfAYHWGmsXtPKc3rB6X+XQo
	cWlceuhDDQCHu9b1/IZYL1HqnB9yllx9PtfR+4mrChSTHneH2/xBRFrnapsWQKF/iIraVGjCeE/sj
	LAyazqscwsE66+MAIfhkGItHR9EmepQPsf5AnqMHhi6YJUwTmBLxNpzGtE2dd+z5mlE/exZ5Va/da
	T/lTlsUKWqhqchkHWXAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2oB-000t68-FX; Wed, 20 Jul 2022 06:03:43 +0000
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDu9B-00Cr4x-BL
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 20:48:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658263729; x=1689799729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JKOoFo77x7jN/peLRtw+tsIV5rXzDnhY5iVySkXtvUo=;
  b=AR3S9ELrW2zJ0QLmVWynsavM2N/p9Cu+k+NQx4ymhpzp+LofcaBqn0Oo
   uE8kVVGYIBhpCfQBnPHlcUL5Rhg9qcweXvRwML6umN/PeUqllWf0j8CS0
   /fg5JTnXnOpIkofs3W7tKApJSQIZsUy5LBz7TiEc/MQaJj1DYTIGCxPRc
   MCfsl/aTa8bOGK2vFjKQLv6xwm30va9SYb38tb+pmcPfKSkKOuN8P0dQY
   wANGOewg/39KZ1JZNOY7VIrSUbKEAbn1MrwyaDp32D1uAZ1dG0f0MvtuP
   CaKD//DUEenFOzDZEwb7i87M2CSsMWD0mmIBFQLRSq+l0yeW7XRHfPoXQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="284158158"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="284158158"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:48:45 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="843788360"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.209.102.45]) ([10.209.102.45])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:48:43 -0700
Message-ID: <c297ad10-fe5e-c2ee-5762-e037d051fe3b@linux.intel.com>
Date: Tue, 19 Jul 2022 13:48:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/13] notifier: Show function names on notifier
 routines if DEBUG_NOTIFIERS is set
Content-Language: en-US
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>, akpm@linux-foundation.org,
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
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <8e201d99-78a8-d68c-6d33-676a1ba5a6ee@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_134849_583077_E4FDB0A1 
X-CRM114-Status: GOOD (  20.44  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 7/19/2022 1:44 PM, Guilherme G. Piccoli wrote:
> On 19/07/2022 17:33, Arjan van de Ven wrote:
>> On 7/19/2022 12:53 PM, Guilherme G. Piccoli wrote:
>>> Currently we have a debug infrastructure in the notifiers file, but
>>> it's very simple/limited. Extend it by:
>>>
>>> (a) Showing all registered/unregistered notifiers' callback names;
>>
>>
>> I'm not yet convinced that this is the right direction.
>> The original intent for this "debug" feature was to be lightweight enough that it could run in production, since at the time, rootkits
>> liked to clobber/hijack notifiers and there were also some other signs of corruption at the time.
>>
>> By making something print (even at pr_info) for what are probably frequent non-error operations, you turn something that is light
>> into something that's a lot more heavy and generally that's not a great idea... it'll be a performance surprise.
>>
>>
> 
> Is registering/un-registering notifiers a hot path, or performance
> sensitive usually? For me, this patch proved to be very useful, and once
> enabled, shows relatively few entries in dmesg, these operations aren't
> so common thing it seems.
> 
> Also, if this Kconfig option was meant to run in production, maybe the
> first thing would be have some sysfs tuning or anything able to turn it
> on - I've worked with a variety of customers and the most terrifying
> thing in servers is to install a new kernel and reboot heh
> 
> My understanding is that this debug infrastructure would be useful for
> notifiers writers and people playing with the core notifiers
> code...tracing would be much more useful in the context of checking if
> some specific notifier got registered/executed in production environment
> I guess.

I would totally support an approach where instead of pr_info, there's a tracepoint
for these events (and that shouldnt' need to be conditional on a config option)

that's not what the patch does though.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
