Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3351FC6FD20
	for <kexec@archiver.kernel.org>; Tue, 21 Mar 2023 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lYhYR1yFOWjwvy9yi3ljufWhl+EfSM1FOU7ifkTEkVk=; b=kRCL8AyZO+Slsl
	P4MBM9jySI5eZx2/qhsEc4oMBB57RWzAeAd/cIwUDW4RrK5z0Vuun3Rut+z08j2+Fu/akJUHFzrCf
	nunUpe4kCjkaAm8US1gu+UQE9waXuugI+sp1IVBCB0gDQMtUvj9UgcOUYs5DCzm5f74qUr0aHPyAE
	3YtexNFAajCu1GRDAJYMXDMLzLag8Je9zvwWBVpbTP7nrVufsEkfFFb3BQDjbMsq5ZcA853ht8CPm
	8+cTVHDEVb6evLnZkof+8d5Q9y0voXGEDGcLrp1JV+4OyOaWllq3vBtRm9WlrzwclUJugszCp90JO
	XiqpcbVpd//5WeOft0lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pehT1-00DRq2-0W;
	Tue, 21 Mar 2023 19:16:19 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pehSw-00DRn0-2f
	for kexec@lists.infradead.org;
	Tue, 21 Mar 2023 19:16:16 +0000
Received: by mail-io1-xd31.google.com with SMTP id bl9so972707iob.8
        for <kexec@lists.infradead.org>; Tue, 21 Mar 2023 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679426171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68/H4+xam4m5wiaqKB4DLi8WxDgUwxT+IYkB5YBtOss=;
        b=Ch1bBNzmPQDbcLE1jy3YVa3GAf/t+fX97A2iSqvCLkaA7DQ1JECTOviq+QK2Zdpmxm
         97Utmb+f1Hb4NYius8BS1RYAYgMs2/4lHJ0/Yl7mTSaCJFNIFSaLgUiF6KxW8vAev61A
         MQfXTYGvQQ9b8gksZsjgy4w3Td4EcJlZsChRFgcf6K+QzlXkjlMFDY0Jbu9T28kh2weH
         +D41OHGXmcRcY92LAbzAn/T2qhxWyP+St10u+wBB17QWAdp5cdRHDAqssvtsGVlzAfJr
         2KJ1N8C4rCLx3pgXw6RteEqmXV7iDytshITlAZ6eKb0KuCInFjbC7Rto3Gx7mY+jq5rD
         HyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68/H4+xam4m5wiaqKB4DLi8WxDgUwxT+IYkB5YBtOss=;
        b=rY/T4CnXyO0L3tqI6b9F9IW/gbJL/BWHs2AxPUMGEC9V8gXlhy3sBghI0ZWJkwgKhu
         S6PUsMcvIWTYzh8W3/xCf5q7id5aZqd65/QFnndA3GH2zK7WzOmtalM5nSFfV/ruMkwV
         vrGNAXvkTIIZjJGgsddXSdsbF/ngV3ffGEQ80Fh6v2kBCSPcoShW6bzL7MENh98hxOnD
         yZNhl5tqnH2TuwDRu56U6Uobtc5PCO31VOCt0wu04A6lFMrfapMVCrtsW/iU907NrGZ0
         1wHZ9NFOD2oVQn916ld4tLWV11NSyWHXTZoAtp1jkOre5b6uVOJGlaLRXegSVY8/TofZ
         Iprg==
X-Gm-Message-State: AO0yUKUCpXEWoqqyICMg7Y5XQ9zS3AQnIeD/fxJXuRg/Tre9668Jk8VG
	EYiNF/Cfk8VgExMeksg6lj13GQ==
X-Google-Smtp-Source: AK7set+VXE0JqlJu/khih18+jA1dIbHsYYvLTbg2wtKzlalWn4L4Eqgy+q/HxDA9auS9TdmUks2B5w==
X-Received: by 2002:a6b:2ac2:0:b0:740:7d21:d96f with SMTP id q185-20020a6b2ac2000000b007407d21d96fmr2122857ioq.1.1679426171077;
        Tue, 21 Mar 2023 12:16:11 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s10-20020a6bdc0a000000b0074e7960e70dsm45058ioc.51.2023.03.21.12.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:16:10 -0700 (PDT)
Message-ID: <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
Date: Tue, 21 Mar 2023 13:16:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Bharath SM
 <bharathsm@microsoft.com>, Shyam Prasad N <nspmangalore@gmail.com>,
 Steve French <smfrench@gmail.com>, Robbie Harwood <rharwood@redhat.com>,
 Eric Biederman <ebiederm@xmission.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org,
 linux-cifs@vger.kernel.org, linux-crypto@vger.kernel.org,
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <2851036.1679417029@warthog.procyon.org.uk>
 <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_121615_091705_1A03BE20 
X-CRM114-Status: GOOD (  18.69  )
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

On 3/21/23 12:48?PM, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 9:43?AM David Howells <dhowells@redhat.com> wrote:
>>
>>  (1) Fix request_key() so that it doesn't cache a looked up key on the
>>      current thread if that thread is a kernel thread.  The cache is
>>      cleared during notify_resume - but that doesn't happen in kernel
>>      threads.  This is causing cifs DNS keys to be un-invalidateable.
> 
> I've pulled this, but I'd like people to look a bit more at this.
> 
> The issue with TIF_NOTIFY_RESUME is that it is only done on return to
> user space.
> 
> And these days, PF_KTHREAD isn't the only case that never returns to
> user space. PF_IO_WORKER has the exact same behaviour.
> 
> Now, to counteract this, as of this merge window (and marked for
> stable) IO threads do a fake "return to user mode" handling in
> io_run_task_work(), and so I think we're all good, but I'd like people
> to at least think about this.

I haven't seen the patch yet as it hasn't been pushed, but can imagine
what it looks like. It may make sense to add some debug check for
PF_KTHREAD having TIF_NOTIFY_RESUME set, or task_work pending for that
matter, as that is generally not workable without doing something to
handle it explicitly.

For PF_IO_WORKER, with the commit you mentioned, those threads should
deal with TIF_NOTIFY_RESUME just fine. Until something else gets added
that is also run from exit_to_user_mode...

-- 
Jens Axboe


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
