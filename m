Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EAAC3F6B0
	for <kexec@archiver.kernel.org>; Wed, 17 Aug 2022 14:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iz7GXyRygfBFDhCnCrA967RlhDrwPPo+8cloRyEuxpY=; b=BPDumLoHvi0M9C
	RzEHSpHfsIJpLJhjQErEBE11/7c451G713+aC76xdwKxWOQgFp+UwhLKMHEb1KxI1+embmVt0ozhg
	pWL3IEQp6QyIhT1GhqQqr1Z7It41N0Zg7tavOoMW91Tu60ZwuHef4dHdy5Sb0+iHMyyA3jKBIGMKI
	EuZcKuhKjfZdY1hqUlwnQtpk3q0FxoCz0lHGO3tEAKfoym5EIxhPIL/57M9X+dFqxK3ZZoRJ2PqVU
	bpkAON+6wXJ8/4YRpn4RGax667TOXfJdGw90C/WCC4DrARa6XoMmgOB/zgFsYn8P3jHlh4wQHWeg6
	bdDwQGprhjwN6IwPDHXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOJrV-002l8y-QL; Wed, 17 Aug 2022 14:17:37 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oO2wk-006gN9-CF
	for kexec@lists.infradead.org; Tue, 16 Aug 2022 20:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cIS73AGgJyieKU1tG/xZQvCqq8exnfGqB4TcWuZRJMk=; b=FkEUF2DP0ATjqek0UTg5E6KGpT
	SfZHe9fW2AONVfJAs/8IfzSTsTd9mdeX2lP+zLryIK+TSwQT+1+SxpL5mIvnqGUU7sIH02Ajg7mVy
	cq1l1k1lYSy/25TQp7wwpcyxMc/YnIrMfrkKANHUcMLPcvZWHteIFmJXOTqw+Xz+452175GKpCp65
	/o2iXSY0BqlMZDZ7rp14XcPmzP2uND+NNI5OzXGp5sTt1G5pHbYuWtYW1u5NTx0LKMb3euFHrYekU
	8GMjSivYRkcl6vjcbMV/VqJ5/blLDgs51BUCiyMhb+/tIiagsNphS1KpAJiMWO+NA6QVVx5/mrtdN
	nWdCvytQ==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oO2vr-00AHjX-Kj; Tue, 16 Aug 2022 22:12:59 +0200
Message-ID: <7181a47b-001c-0588-4102-1cfd8bead0ac@igalia.com>
Date: Tue, 16 Aug 2022 17:12:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 08/13] tracing: Improve panic/die notifiers
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: akpm@linux-foundation.org, bhe@redhat.com, pmladek@suse.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org,
 kernel-dev@igalia.com, kernel@gpiccoli.net, halves@canonical.com,
 fabiomirmar@gmail.com, alejandro.j.jimenez@oracle.com,
 andriy.shevchenko@linux.intel.com, arnd@arndb.de, bp@alien8.de,
 corbet@lwn.net, d.hatayama@jp.fujitsu.com, dave.hansen@linux.intel.com,
 dyoung@redhat.com, feng.tang@intel.com, gregkh@linuxfoundation.org,
 mikelley@microsoft.com, hidehiro.kawai.ez@hitachi.com, jgross@suse.com,
 john.ogness@linutronix.de, keescook@chromium.org, luto@kernel.org,
 mhiramat@kernel.org, mingo@redhat.com, paulmck@kernel.org,
 peterz@infradead.org, senozhatsky@chromium.org, tglx@linutronix.de,
 vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 Sergei Shtylyov <sergei.shtylyov@gmail.com>
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-9-gpiccoli@igalia.com>
 <20220816101445.184ebb7c@gandalf.local.home>
 <YvuwUAGi6PvY5kmR@rowland.harvard.edu>
 <20220816115249.66cf8f15@gandalf.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220816115249.66cf8f15@gandalf.local.home>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220816_131354_468279_5BE67FFB 
X-CRM114-Status: GOOD (  11.10  )
X-Mailman-Approved-At: Wed, 17 Aug 2022 07:17:28 -0700
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

On 16/08/2022 12:52, Steven Rostedt wrote:
> On Tue, 16 Aug 2022 10:57:20 -0400
> Alan Stern <stern@rowland.harvard.edu> wrote:
> 
>>> static int trace_die_panic_handler(struct notifier_block *self,
>>> 				unsigned long ev, void *unused)
>>> {
>>> 	if (!ftrace_dump_on_oops)
>>> 		return NOTIFY_DONE;
>>>
>>> 	/* The die notifier requires DIE_OOPS to trigger */
>>> 	if (self == &trace_die_notifier && ev != DIE_OOPS)
>>> 		return NOTIFY_DONE;
>>>
>>> 	ftrace_dump(ftrace_dump_on_oops);
>>>
>>> 	return NOTIFY_DONE;
>>> }  
>>
>> Or better yet:
>>
>> 	if (ftrace_dump_on_oops) {
>>
>> 		/* The die notifier requires DIE_OOPS to trigger */
>> 		if (self != &trace_die_notifier || ev == DIE_OOPS)
>> 			ftrace_dump(ftrace_dump_on_oops);
>> 	}
>> 	return NOTIFY_DONE;
>>
> 
> That may be more consolidated but less easy to read and follow. This is far
> from a fast path.
> 
> As I maintain this bike-shed, I prefer the one I suggested ;-)
> 
> -- Steve

Perfect Steve and Alan, appreciate your suggestions!
I'll submit V3 using your change Steve - honestly, I'm not sure why in
the heck I put a goto there, yours is basically the same code, modulo
the goto heheh

A braino from me, for sure!
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
