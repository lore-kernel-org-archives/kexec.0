Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E98C43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UcwaBA5oTzv8+E4Rj0s77dtre7jiwU/pp4UYDfwoH/g=; b=PdzNL0RtLsgIjF
	7eW13csY2/vx9UuPB0WpnYsMSYKLixwzWIoD5jAzu2vfxVr9afYOda/8F6Nelhp+1u7YfNs9IC7cy
	jBFcoWU1UzcH3g5PDGVnPtP90g2cQmHrk6FvBjOgFZYqmdeQUYCFmxAAfMhF+DgmkOYl9bJIWZz8/
	S3mE8Vsh/QES40P4oFS5JZShFMmxoV45Pr2CQrHVAlPpyAWECvT+yI+bb4mIy0q+oK1MuYnqJCtGz
	CCp1bslU+b65pVliKs+2JdG5yJtinjrT6Pde3AIAb9gaLA68zMkbR+ug/DoHxT4Poxbs2kG72VqvL
	+rJfkhisp/32aa4H4Y4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nq-000sms-Rx; Wed, 20 Jul 2022 06:03:22 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtuB-00ChwY-8m
	for kexec@lists.infradead.org; Tue, 19 Jul 2022 20:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658262799; x=1689798799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=20RPDLm8Al5aPVJySa70I/GMs19LDvZGqa/P5oQG5pU=;
  b=Ek5GYUiKEs3sj0eIE/xOSgBRbeBHW2lnE65CNmQdepBIdYIulTlHWs4Q
   TL9faDUomnM5sK157k4RUOGZkCDLF5hcwDevZMIWwQSkAtUEQAVppeYqV
   OkHx1tHcSIXG4KfjwoXaQYnAMlQV8a8OZZkenXBnfu6XgRcQ6ivHY2b7z
   bZt0d6yqieW8CAeLPf4L7QKpENnu+LEe3WqcFT+eNfd7ARKFLGTm7iWvd
   XbE1ty8IgGb63derOdoI8CKwW2U2mo2k6873UlSlCST9uUN45j1bHVyHk
   x9SaUO6wETDBQI+FO/DeAkZ5d9blgaYfZydmInI1rEbh/B5UB9Q8r7qYN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="273427712"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="273427712"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:33:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="843784574"
Received: from avandeve-mobl.amr.corp.intel.com (HELO [10.209.102.45]) ([10.209.102.45])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 13:33:13 -0700
Message-ID: <e292e128-d732-e770-67d7-b6ed947cec7b@linux.intel.com>
Date: Tue, 19 Jul 2022 13:33:13 -0700
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
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <20220719195325.402745-10-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_133319_436913_A4D351E3 
X-CRM114-Status: UNSURE (   9.85  )
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

On 7/19/2022 12:53 PM, Guilherme G. Piccoli wrote:
> Currently we have a debug infrastructure in the notifiers file, but
> it's very simple/limited. Extend it by:
> 
> (a) Showing all registered/unregistered notifiers' callback names;


I'm not yet convinced that this is the right direction.
The original intent for this "debug" feature was to be lightweight enough that it could run in production, since at the time, rootkits
liked to clobber/hijack notifiers and there were also some other signs of corruption at the time.

By making something print (even at pr_info) for what are probably frequent non-error operations, you turn something that is light
into something that's a lot more heavy and generally that's not a great idea... it'll be a performance surprise.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
