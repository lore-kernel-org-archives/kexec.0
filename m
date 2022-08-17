Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D2AC32771
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hjLmtM1xGOal10xtX04R99N9hKt7KMjTzmuPnUF+3lw=; b=nmABCtZ31xHRCy
	yA//pSEn9u4EFTLybv5hfTxib/OmUP0slIDxqVIcfc8S6VvZY4l7bwBZaHiyuq/3MtO1xx2s/BBwX
	hG6Pq4Osurcv6pHji8RTGMx6YtXl75oLTyDH8F/unBHHGTMWfswHp1LuYrYprBswSjVAXXHYOREZf
	Q7f0IGp0YUkvH1eJL9K8CIchuuM9pbyipZaI6WwIC3B+Vtd7ZoAkOBK3w2Bbx4HweGUIHdmEz1zbt
	78LR6BgU9XIc0EsU7CT8qaQnr3qBIN4ZiqQn3fmRMFjy2pZcJ6L96bNQsYihuw1yvj5jn9QFe570N
	gI27Qsf1vVI6O+3nDtmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWd-0058Fc-70; Fri, 19 Aug 2022 09:42:47 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOO4k-005Ffh-Vt
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 18:47:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SkpJfRL2fEX0ZCrYY78UnGUy/KfqmdSThM2JF2kNt+A=; b=JMOw4iXvCN9lZfNf2OG/hB6Fo3
	9NwE+OWODeKClqBL344u7qYRnOYGt54O3+aa26nsaE/f63tGSMQLJWKHqOmdEKGd9HT/CkTyz+dR6
	r2dYvLK/Uaz3uD/r/hK40X6gA/3ZA85KA9wLfBiCi/F0U6bjBP/dRFr/WZ46adF+Qz28N/9b0nTQ5
	o1EF5Xp228F+r4TdaX5Bz8dl4MpW12VOlh6PVN7GCys5HyvOALccfGYLcM5rg4DZet7XGUH/ymOWa
	QGKvYg0ACpBZP/hJX1w8q8j6+HDvd4aLzmHbq+w1Z5n060anBDMvOsvu3LCP3w5qq/pwwsT7GDawh
	Pq/3eSGA==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oOO3y-00AsZm-UT; Wed, 17 Aug 2022 20:46:47 +0200
Message-ID: <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com>
Date: Wed, 17 Aug 2022 15:45:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, corbet@lwn.net,
 d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com, dyoung@redhat.com,
 feng.tang@intel.com, gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 linux-edac@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
 Tony Luck <tony.luck@intel.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com> <Yv0mCY04heUXsGiC@zn.tnic>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yv0mCY04heUXsGiC@zn.tnic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_114735_399193_30A91661 
X-CRM114-Status: GOOD (  10.33  )
X-Mailman-Approved-At: Fri, 19 Aug 2022 02:42:41 -0700
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

On 17/08/2022 14:31, Borislav Petkov wrote:
> [...]
> 
> How does the fact that kdump is loaded, obviate the need to print
> information about the errors?
> 
> Are you suggesting that people who have the whole vmcore would be able
> to piece together the error information?
> 

Hi Boris, thanks for chiming in.

So, this is part of an effort to clean-up the panic path. Currently, if
a kdump happens, *all* the panic notifiers are skipped by default,
including this one. In this scenario, this patch seems like a no-op.

But happens that in the refactor we are proposing [0], some notifiers
should run before the kdump. We are basically putting some ordering in
the way notifiers are executed, while documenting this properly and with
the goal of not increasing the failure risk for kdump.

This patch is useful so we can bring the altera EDAC notifier to run
earlier while not increasing the risk on kdump - this operation is a bit
"delicate" to happen in the panic scenario. The origin of this patch was
a discussion with Tony/Peter [1], guess we can call it a "compromise
solution".

Let me know if you disagree or have more questions, and in case you'd
like to check/participate in the whole panic notifiers refactor
discussion, it would be great =)
Cheers,


Guilherme


[0]
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/

[1]
https://lore.kernel.org/lkml/62a63fc2-346f-f375-043a-fa21385279df@igalia.com/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
