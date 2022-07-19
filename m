Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B34BC43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ivJVmI/AzVKrvUm4jfD1EuT88puTHavmBqYnK4nAbnA=; b=RJEh+AS49Favg4
	c/3nldz87v0X/YN+DsYr5cukDvAjbagZyMd2xv8lhSmEP7FXj1otTKqs0PC9hbpl6MyT+1WNkNsAb
	sWSxnwfUkrzmhBEpkP7aOQC1Ofcqlb76RMCojYMLyVyQ4il/dWHqZLAJl2e9M2sL0JwFZUzykDMUF
	xy3Jn1yES20bMUty7n4e1dcRYh7wwk5ozzjeo6Tb6whAbG6JXzbaJ6JHnXOfC5EzCRds89kSquNDF
	C/LWkwxPBotQTtIffG0/ARl7h9NxFDXvJf6/BQp7izAfZOMEtznolmpUcld7Vvgqp+vkr5oPHWemy
	rcIqmQGsQqY/TIl+KHqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2oT-000tOc-2X; Wed, 20 Jul 2022 06:04:01 +0000
Received: from mga05.intel.com ([192.55.52.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDvKx-00DYUB-D8
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 22:05:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658268303; x=1689804303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pvIxtNbWUdkbgcKb5Tspz0IgM/n/C0XFuT/gdjfEdHk=;
  b=lP0+6EkW8ApPxSBRhUHKuyv+ay9px4nMP3aOpb883/iWyTJ+iX0cRswH
   z8BtTmZX4SuVxI42OtoM+Cx4QIYqyF9C/9RvS5yQyfJel2565oLwEUwEN
   akHhhYe/8hdZEqkgjaT6y2C/DyRhutYNZBdwHZVcsBOIHlavAln8XzQn+
   6WGBG+M5mASGvGAalDgVFCOUoTAtAusD0u+12lS+ZuR1XrOkb5i/Xxweg
   3XnZbUe75yfLCMPAr9+lPGSNVHRsQj83C/dsARlv2q4+nWe0srBW8vn/t
   cx38kTqJsN5/C617M/z1DmbWq5ClVdOEeqa0Z3TUZv7OFiwuScb66ilRH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372920781"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="372920781"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:04:56 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="843817003"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.209.102.45]) ([10.209.102.45])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:04:53 -0700
Message-ID: <4a9d64b5-0fa4-8294-c78c-37394a156325@linux.intel.com>
Date: Tue, 19 Jul 2022 15:04:52 -0700
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
 <c297ad10-fe5e-c2ee-5762-e037d051fe3b@linux.intel.com>
 <8ef53978-f26e-89e3-8b04-6f0eb183f200@igalia.com>
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <8ef53978-f26e-89e3-8b04-6f0eb183f200@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_150503_471496_7B164010 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
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

On 7/19/2022 2:00 PM, Guilherme G. Piccoli wrote:
> On 19/07/2022 17:48, Arjan van de Ven wrote:
>> [...]
>> I would totally support an approach where instead of pr_info, there's a tracepoint
>> for these events (and that shouldnt' need to be conditional on a config option)
>>
>> that's not what the patch does though.
> 
> This is a good idea Arjan! We could use trace events or pr_debug() -
> which one do you prefer?
> 

I'd go for a trace point to be honest


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
