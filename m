Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA25C00140
	for <kexec@archiver.kernel.org>; Mon, 15 Aug 2022 17:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=N3+yHyP7ciVAAX7h1YrwkH781Ixk7joKQ6jUOgMkI1Q=; b=qN3TZiahqAOl//
	9rodpH7+thnxVlBiiDHhd035d3IEy2SchdUzbEwU+SqYjCMzJYEOIKwXtuVtQ0yjYmxMQE+cNo8cW
	OM4+nn+Ul8fYiT0xN+LrMedp0HXFohvMIkojn4bn61uTtr/ozvpIJ8XFgAcyDD9hDmH/SJC+KjEC0
	gjQkgluy1mbBf6DuNkCrS7tQvJ6Uoeqs7ZSEm8MAOU7p1XPhqVSrPS56SE/pcVQdP8ViMCggXwbDu
	CY8y+VATLSvM2YTtR4uxhfdGuBrUrhSOcgHSBsaUq1UFf5fhps1Oaox/3CKsZ+Iudna62Rl5yFjaR
	eOpiiXKzeyQEnmSuJaJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oNdjd-002AGQ-FA; Mon, 15 Aug 2022 17:18:41 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLUXA-005iok-85; Tue, 09 Aug 2022 19:04:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6RIQ0lsH7SzTIzVp99WDyc0D2gkpsha+DsfnlWOGmVM=; b=LbwWnCn7YGFZiUHtA5VIw6zpjm
	AI4mTSD37n0b+CjaKxm9C1z3JcyfcJa1xhHSXDPMhZurSkjfeBvuXCIVD/SZflQ49goPyxACJsmk4
	Dve4XzeAnEBNetq25XCzE1veKxNwbMWFW+GqNs2gPkQS+A2YDL8lqgY20qLY6DJMYqY5qt1iIye1L
	w93yio6Gi+O8OzmpdNqTFBOanaijVaqR/f2QxYUcY5Ud7iO1du5dwk6YpZ/gEzvGMAAoybCw5fLlE
	c8X+2yQ2cyaRreWixWoiOwgjg2500HTd/KjIo0JJ24feOWMpq3WKTu1dac5fHfXnhgAifAi6cJoKB
	BZyKmvhw==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oLUWY-003lox-0k; Tue, 09 Aug 2022 21:04:18 +0200
Message-ID: <15188cf2-a510-2725-0c6e-3c4b264714c5@igalia.com>
Date: Tue, 9 Aug 2022 16:03:51 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 06/13] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, kexec@lists.infradead.org,
 linux-um@lists.infradead.org
Cc: pmladek@suse.com, bhe@redhat.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
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
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Richard Weinberger <richard@nod.at>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-7-gpiccoli@igalia.com>
 <5bbc4296-4858-d01c-0c76-09d942377ddf@igalia.com>
 <54cd8c11428db4c419edf2267db00ca10da7a178.camel@sipsolutions.net>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <54cd8c11428db4c419edf2267db00ca10da7a178.camel@sipsolutions.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220809_120458_581790_031BEAC5 
X-CRM114-Status: UNSURE (   8.57  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 15 Aug 2022 10:10:49 -0700
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

On 09/08/2022 15:09, Johannes Berg wrote:
> [...]
>>> V2:
>>> - Kept the notifier header to avoid implicit usage - thanks
>>> Johannes for the suggestion!
>>>
>>>  arch/um/drivers/mconsole_kern.c | 7 +++----
>>>  arch/um/kernel/um_arch.c        | 8 ++++----
>>>  2 files changed, 7 insertions(+), 8 deletions(-)
>>> [...]
>>
>> Hi Johannes, do you feel this one is good now, after your last review?
>> Thanks in advance,
>>
> 
> Yeah, no objections, my previous comment was just a minor almost style
> issue anyway.
> 
> johannes

Perfect, thank you! Let me take the opportunity to ask you something I'm
asking all the maintainers involved here - do you prefer taking the
patch through your tree, or to get it landed with the whole series, at
once, from some maintainer?

Cheers!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
