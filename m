Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A284C32771
	for <kexec@archiver.kernel.org>; Fri, 19 Aug 2022 09:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qSRSimzi7lPibD02+2efg1MygT7ZD9SJHdxH2PXt1Bo=; b=Ctl+n587yFp/QG
	kSpP7PpArxFW7mAptiXSv1pfnmR3efzNbRctXBaJhrmHUlUEhc8KaMPeqMMbV19hDvvdkJMa9DdgG
	u8jyHKxQ8JAKL+K1aDeL7Z06UpZ/PPlD9nP8H9hs1X7SHIKozEY2QGt5VXN9dgiwpKCflJC4t3pnI
	FWLGLwpYUa4CEQPtbp4Iga01w+wW6fw5rPnZIuyyVSrCsExlOhnI6l1nJoTLAAo4pKjKB5JMNKjYc
	MFOTDqCk75tav9nly9CXItyvVQrKA87B+46glvEmLpvs6XY1xWOPDV/26kcmkEjqp9nF8XYwPeN6y
	GCbKYOcNzDmfyX5L5xbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOyWj-0058YP-Ck; Fri, 19 Aug 2022 09:42:53 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oOQlu-00776I-Mw
	for kexec@lists.infradead.org; Wed, 17 Aug 2022 21:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Yb08U+n4Pko/rjKY9WxgXaG1dGWDv/+eoZWbzofjewc=; b=fDyOq8wY0X9n5uFhdxcg912LeC
	Ep90b17TEg9NOJw8M4fQOGkQ69tZLrNvCWegUUhY2XdyIMvZOo1nV1jzYl/wAaNR0lG//tuUH0w2j
	9v/5JPIGLtz9b44F+iLguiwWSQrbk1lfy+M3CWn5eqgaxcvQTjUUSQVyOOPWXYQXaKm6jjiSWEQ3N
	Rn0QVv8hi9qDjXATTJF8XnpWzaRj95K/sAaus3u1NU7meLe9CbOwQaWGYZ4RXi4l39L4AWE1d3zf3
	Sdy7DBnpfz63PWTEwm9IyfiCiWn2SNfGqtPNoyTxl7yQnLbTB9EQN1POKvjX566hKfuB88X9XWU1z
	TBPSDBnQ==;
Received: from [179.232.144.59] (helo=[192.168.0.5])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1oOQlU-00AxTG-AY; Wed, 17 Aug 2022 23:39:52 +0200
Message-ID: <c0250075-ec87-189f-52c5-e0520325a015@igalia.com>
Date: Wed, 17 Aug 2022 18:39:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 10/13] EDAC/altera: Skip the panic notifier if kdump is
 loaded
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, pmladek@suse.com,
 Dinh Nguyen <dinguyen@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, x86@kernel.org, kernel-dev@igalia.com,
 kernel@gpiccoli.net, halves@canonical.com, fabiomirmar@gmail.com,
 alejandro.j.jimenez@oracle.com, andriy.shevchenko@linux.intel.com,
 arnd@arndb.de, corbet@lwn.net, d.hatayama@jp.fujitsu.com,
 dave.hansen@linux.intel.com, dyoung@redhat.com, feng.tang@intel.com,
 gregkh@linuxfoundation.org, mikelley@microsoft.com,
 hidehiro.kawai.ez@hitachi.com, jgross@suse.com, john.ogness@linutronix.de,
 keescook@chromium.org, luto@kernel.org, mhiramat@kernel.org,
 mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
 rostedt@goodmis.org, senozhatsky@chromium.org, stern@rowland.harvard.edu,
 tglx@linutronix.de, vgoyal@redhat.com, vkuznets@redhat.com, will@kernel.org,
 linux-edac@vger.kernel.org
References: <20220719195325.402745-1-gpiccoli@igalia.com>
 <20220719195325.402745-11-gpiccoli@igalia.com> <Yv0mCY04heUXsGiC@zn.tnic>
 <46137c67-25b4-6657-33b7-cffdc7afc0d7@igalia.com> <Yv1C0Y25u2IB7PCs@zn.tnic>
 <7f016d7f-a546-a45d-c65c-bc35269b4faa@igalia.com> <Yv1XVRmTXHLhOkER@zn.tnic>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <Yv1XVRmTXHLhOkER@zn.tnic>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220817_144019_113701_078936D5 
X-CRM114-Status: GOOD (  20.18  )
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

On 17/08/2022 18:02, Borislav Petkov wrote:
> On Wed, Aug 17, 2022 at 05:28:34PM -0300, Guilherme G. Piccoli wrote:
>> My understanding is the same as yours, i.e., this is not possible to
>> collect from vmcore, it requires register reading. But again: if you
>> kdump your machine today, you won't collect this information, patch
>> changed nothing in that regard.
> 
> Why won't you be able to collect it? You can certainly access dmesg in
> the vmcore and see those errors logged there.

Sorry for the confusion, let me try to be a bit more clear:

(1) if we kdump but we *didn't run* s10_edac_dberr_handler() before
kdump, the information is lost, since s10_edac_dberr_handler() performs
register readings. That information is not contained inside the vmcore.

(2) If for some reason the function s10_edac_dberr_handler() *was
executed prior to kdump*, of course the registers information would be
on dmesg, easy to collect in the vmcore.

Makes sense?


> 
>> The one thing it changes is that you'd skip the altera register dump if
>> kdump is set AND you managed to also set "crash_kexec_post_notifiers".
> 
> What your patch changes is, it prevents s10_edac_dberr_handler() from
> logging potentially important fatal hw errors when kdump is loaded.

Agreed. If kdump is loaded, we cannot log that information (modulo that
we do not collect it today by default on kdump as well).
The other part of story (the reason of the patch) is that we plan to
start running this panic notifier a bit earlier, being able to collect
such edac logs with pstore, for example.


> 
> If Dinh is fine with that, I'll take the patch. But it looks like a bad
> idea to me.
> 

I think we should seek what the majority of the folks consider the best,
in order to converge to some well-accepted solution. I'm completely OK
in dropping this one and rework with some other idea, or we can leave
this panic notifier as is, continue running that a bit later.

Tony / Petr (when back), suggestions are welcome =)
Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
