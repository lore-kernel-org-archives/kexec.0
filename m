Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95071C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hQRipTqjIrDu2BX9dpHW0nJI7EvbNvG/DfNZP68c4no=; b=Pj38op6uQCCIJO
	HclSOmWiI8QqbFX6o4pNG6Z8TL6s/yFS204oU5VYhu8XAm/4ApKwK7yKKfYYRIslub3t6QQF+mLv5
	+C/4kqi2C7XzpCR8/a5ZRoInqDpKT1kicTqbDDy+MWWOne1LBDn7tAynYRhbx2pmRRv/r6P2U6xJ5
	zI1Ej7XFA+XnE2EOWmcprFbad0dmmI6nUfySYCGAR/11eElIQh9Ba4eO7Z9XVa1M2Cap0ZjzVvAv/
	3e8v+OJeWG5mp3vMVqARwFeR+7XSXsk+0CQgaMK0zvCU5SgI1qobA3FEYjH85wttU/nvo4DONFyHl
	m7osNN1ZJiN2gld8lnnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdhf-0028zq-M4; Mon, 15 Aug 2022 17:16:39 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKiU7-00Fd8x-Hl
	for kexec@lists.infradead.org; Sun, 07 Aug 2022 15:46:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QTm0Fa5NeO4gV5vsXv44jv3ky+1FUP2v92+IAnY2Isk=; b=ZfGufmrMNpOaMMyfdbmknIovK0
	9A5ObDAO9/kVZt1QjWBzJY3Q5sGqgh8UyJfw7KQdIsFchs3Si5FjA7eQcSCo71vIV8fzSTuBpos5/
	NOCpj/xDga4jklJZ6Lgzz8epXtBC4P6bQfRPlPAYAdU9Cp2CuyIFnlkGYjAz3KmloqV65NScgB0Ju
	TjetD1WQmN1+2iD4Khd9Ije00UbMDoRdQWt3mnIgZQgPooY75UmIiVZipdhv4IfTIojgTwiRpCSKh
	cBpFqFREyvjGzwNZhn7R2QUuxnXXbqIjxRNXOqh19IC1a7TrE/r+H/TTqGAX6SO61pBm/FROU7Fg3
	B21CCzSw==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oKiU1-0011yy-S9; Sun, 07 Aug 2022 17:46:29 +0200
Message-ID: <ff7a314e-c9f9-bb28-7a33-0a884188c530@igalia.com>
Date: Sun, 7 Aug 2022 12:46:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Content-Language: en-US
To: kexec@lists.infradead.org, rostedt@goodmis.org,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: pmladek@suse.com, bhe@redhat.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 akpm@linux-foundation.org
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-9-gpiccoli@igalia.com>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220719195325.402745-9-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_084635_667895_9524A84C 
X-CRM114-Status: GOOD (  11.37  )
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
> Currently the tracing dump_on_oops feature is implemented
> through separate notifiers, one for die/oops and the other
> for panic - given they have the same functionality, let's
> unify them.
> 
> Also improve the function comment and change the priority of
> the notifier to make it execute earlier, avoiding showing useless
> trace data (like the callback names for the other notifiers);
> finally, we also removed an unnecessary header inclusion.
> 
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2:
> - Different approach; instead of using IDs to distinguish die and
> panic events, rely on address comparison like other notifiers do
> and as per Petr's suggestion;
> 
> - Removed ACK from Steven since the code changed.
> 
>  kernel/trace/trace.c | 55 ++++++++++++++++++++++----------------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
> [...]

Hi Sergei / Steve, do you think this version is good now, after your
last round of reviews?

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
