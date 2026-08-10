Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95BEC5AE49
	for <kexec@archiver.kernel.org>; Mon, 10 Aug 2026 14:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jU+XJZ0jzxykpOWo/z5wRNaLKZRKb5vErJqQ4ypS7Q4=; b=OgWN58mlQdJPlByqw1Nkt/NH03
	gxYGUxirbEVoOIYevu/H2Wknbw/l6KV7P/z1XKJkyK1fPGwt1wrytO0N4SsXzX1BwEFnXyXDsbv9Z
	SCCXLZvwQvbZ2zAcusGfN2RJpkj7BKQsfN0s8yStUzJ8upm+55tPQRPmtQD0q9CiFjvz+wY1+Aa6u
	V/70RzVrlk2tNsHcHdpPA+UhiUpJokwSF0Cm3L6/6dugKtL5NAOXhHXeFVCN8L+UzmbueJB9h30aY
	qYHG9UC95jpqFcSFakmwlc+hBbC9Jq4Ou8FCLy/hak0HmJBnSJQnQjvFVOtoWYhL7+imxid9woyHH
	twcVgLaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRTc-0000000C8DI-33Rd;
	Mon, 10 Aug 2026 14:59:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtRTb-0000000C8Cx-3cf9
	for kexec@lists.infradead.org;
	Mon, 10 Aug 2026 14:59:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 89FE1401CD;
	Mon, 10 Aug 2026 14:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B161F000E9;
	Mon, 10 Aug 2026 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373983;
	bh=jU+XJZ0jzxykpOWo/z5wRNaLKZRKb5vErJqQ4ypS7Q4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Q/ZyVb0aaIdzOuRTPaEONZ0hIH/63NdJi2ChPaqaUIBrPT/NxiG+VTIZybGqy96uc
	 /OKwpdNokPXJmApuJ97BKYJ/SR4vnb25oz44dUeVjBr5kAEh9E3IIq7sFA0ZxFSDgP
	 +Kn1jzRE9EJRGMRBrfvEXmwqxnbi1SBO81B9P2s1D00M3v8Nk3Vru4n1CGH/YqYuYJ
	 0PSkmhOHFaOvjmC6bMGd9NIws18Y2IFERa5gw/BRYiwWhg9dpqTfEDFDgvnefSbBBa
	 Vemihh6feqsDYbvifzM6d12Erne1DIMwIr4aj3XWqdOjE0IUkpliYk2WTzquXQIGxZ
	 Ol0bweetIAKwQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,
  skhawaja@google.com,  ackerleytng@google.com,  seanjc@google.com,
  kexec@lists.infradead.org
Subject: Re: Qns: LUO: Should luo_core throw warning for preserved resource
 under unregistered handlers
In-Reply-To: <9huzecg6ta6h.fsf@tarunix.c.googlers.com> (tarunsahu@google.com's
	message of "Mon, 10 Aug 2026 12:46:46 +0000")
References: <9huzh5l2taav.fsf@tarunix.c.googlers.com>
	<9huzecg6ta6h.fsf@tarunix.c.googlers.com>
Date: Mon, 10 Aug 2026 16:59:40 +0200
Message-ID: <2vxzzeyu58df.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10 2026, tarunsahu@google.com wrote:

> + kexec list.
>
> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Hi,
>>
>> I have a question. If a luo_handler is registered as part of the module
>> And In new kernel, the module isn't loaded so the handler will also not
>> be registered. And the resources/files preserved in older kernel will be
>> leaked after luo_finish in new kernel. Right now, Luo core does not
>> throw any warning. Should it throw a warning or prevent finish and let
>> the user re-attempt the finish with force if they want.
>>
>> Guest_memfd preservation is such an example. It gets registered during
>> kvm module load.

I went and took a look at the code. When you first open /dev/liveupdate
luo_session_deserialize() is called. It calls deserializes each session.
As part of that deserialization, for each session luo_file_deserialize()
walks the list of preserved files and calls luo_file_deserialize_one()
to try and find a handler for that file.

If no handler is found, it prints an error and returns -ENOENT.
Eventually that error bubbles up to luo_session_deserialize() and causes
the open of /dev/liveupdate to fail. It also saves the error code and
all future opens fail too.

So in this case, the end result will be that _all_ files will be leaked
and /dev/liveupdate will fail to open. You never even get to finish. The
system daemon will probably have to trigger a cold reboot, treating all
VMs as dead.

The kernel at least keeps itself safe here and won't crash or anything
like that. It prints an error too. And I think it isn't unreasonable to
expect userspace to load all modules needed by live update before
opening /dev/liveupdate. So I don't think the current state is all too
bad.

That said, perhaps we can improve this behaviour. For one, if one module
is missing and that module is only used by one session, that will still
DoS all other sessions. I guess we can move the call to
luo_session_deserialize_one() to luo_session_retrieve()? This way, you
only block the retrieval of sessions with missing handlers. All others
work fine. Perhaps we can also make the error on missing handler
retry-able. If we see a missing handler on session retrieve, we let
userspace retry, giving it a chance to load all its modules.

I don't know how useful the retrying will be in practice, but the
deserialize on retrieve can be fairly useful I think.

>>
>> I remember there was similar discussion raised by Samiullah for
>> resources not retrieved but their handler was registered.

For this one I think LUO should automatically retrieve the files and
then finish them. I don't think there is any point in leaking those when
we know how to clean up.

-- 
Regards,
Pratyush Yadav

