Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBCECC433EF
	for <kexec@archiver.kernel.org>; Mon, 27 Jun 2022 12:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yEE0U9gERTfhke7YbxINNcX9+7Ha0z+9UYzC484KVYk=; b=yBI9ef4oz2XdMA
	skTLlv6Y6d1MIWJ/3sDRZ/ISTeRSGv/H7o2LM6/L9kXgAIWeFAGghv+1PSNogsq6Ce7ru2YtHc7sZ
	9W39TNu3eVsRUG/MmqFAIroyzMXPsIsAxUssrkHHVCUh+Q5Rt0liMbU5dpY3OIyuvj5mJ4z6JR7+G
	fRi8n0FZ434HVWnnZTDZ2KcrBbRZEuho1WMFCo8n+BHabcCSvXsQkMLuXr23zgHchjkpHpiYTz7Yn
	uSUMqxrJGBRcFLoqG+hTFcLbCf+VQqGGgXV7bjJy9SZu4aWanoM6v9sddnTjehhizO8FkmLSrlPB7
	tM9gheUi/BAve03mekOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5o4e-000xo1-Ov; Mon, 27 Jun 2022 12:42:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5o4b-000xlC-1D
	for kexec@lists.infradead.org; Mon, 27 Jun 2022 12:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656333754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+n3Y/O+OmufE7x8Fqncdr2+EU4ZYCNX0XlR2Xu4Dqo=;
	b=HI0M7AXX/p4SU2VCblGzZFn7iuMlD4GrChXSz5c5AIUNglh6xPmK3My1gJQc5x4VdrSXdS
	NelivsYrez6NBl9RFjXnA15Vjswot47jMOSiwFRhFRbBzMKF5FVYANstRfqrYKv0vVRLTi
	GuRq3MvslTs9uCve6r2WezkwQbOhUp0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-6TWDIhw2M1mbnp5YWphPHw-1; Mon, 27 Jun 2022 08:42:25 -0400
X-MC-Unique: 6TWDIhw2M1mbnp5YWphPHw-1
Received: by mail-wm1-f70.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so3516817wma.4
        for <kexec@lists.infradead.org>; Mon, 27 Jun 2022 05:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E+n3Y/O+OmufE7x8Fqncdr2+EU4ZYCNX0XlR2Xu4Dqo=;
        b=tkLq481mmRq/3ykllAPMnDoHA2j03EXz3BmbQwt/wE9Xmq6RfGCV1BsovfMt3Rsy2T
         CSKP64ifKUA1AUsaP2TmPxM8OUnEVtW1a2S5KveFABQGnLQC3KARQnZNB0H414Gi106q
         yu6Tt771puEP9drbtce4vit/QTpM0B9kOzB/H3x6WWc3f3Q5V32wfv8kdT7N1MZPYq37
         rr+Vy9HTHkeaION0ssAFs8AA0tkzZ0N/WVk/Sk2FoYpW9XXs0l40YkSthfQm4yK26Hh/
         CDNmaNg5p+281tBdxfacYEcWD/fGJqWdottXbR9uVQxkA01iGtZsq0UyUXim4BpZewY4
         n6nw==
X-Gm-Message-State: AJIora/uG+HTpD5xNm0fI0MFOV2g4wFE+UxS5kuB+2ewCV7O/A5e5yUx
	j+U0e2uo5b02HKUAQqnp3JPD08r6d7SB8D1XKmW5GzItMdunfqJFQpX3ie3tnrxGprDrfOVuzmP
	6DgdfQAh0l5gzNSpepXxZ
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr11433068wrb.203.1656333744231;
        Mon, 27 Jun 2022 05:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sJQ27sm+aJCjHu6xlQQhyYlKZ+HBejyIkW+SlC/p31t1lmrQbyAqnkqUNfQtUZa+j6nj85CQ==
X-Received: by 2002:a05:6000:69c:b0:21b:9280:9b2d with SMTP id bo28-20020a056000069c00b0021b92809b2dmr11433043wrb.203.1656333743939;
        Mon, 27 Jun 2022 05:42:23 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id bk20-20020a0560001d9400b0021b8b998ca5sm9882182wrb.107.2022.06.27.05.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:42:23 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Petr Mladek
 <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
Date: Mon, 27 Jun 2022 13:42:22 +0100
Message-ID: <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_054237_201501_DF3CF49B 
X-CRM114-Status: GOOD (  23.96  )
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

On 25/06/22 12:04, Eric W. Biederman wrote:
> I am not particularly fond of this patch as it adds more complexity than
> is necessary to solve the problem.
>
> Calling a spade a spade PREEMPT_RT's mutex_trylock implementation is
> broken as it can not support the use cases of an ordinary mutex_trylock.
> I have not seen (possibly I skimmed too quickly) anywhere in the
> discussion why PREEMPT_RT is not being fixed.  Looking at the code
> there is enough going on in try_to_take_rt_mutex that I can imagine
> that some part of that code is not nmi safe.  So I can believe
> PREEMPT_RT may be unfix-ably broken.
>

AFAICT same goes for !PREEMPT_RT given the mutex_unlock(); it's a bit
convoluted but you can craft scenarios where the NMI ends up spinning on
mutex->wait_lock that is owned by the interrupted task, e.g.

  CPU0                    CPU1

                          crash_shrink_memory()
                            mutex_lock();
  crash_get_memory_size()
    mutex_lock()
      raw_spin_lock(&lock->wait_lock);
      // Lock acquired
  <NMI>
                            mutex_unlock()
                              <Release lock->owner>;

  // Owner is free at this point so this succeeds
  mutex_trylock();
  // No kexec_crash_image
  mutex_unlock()
    raw_spin_lock(&lock->wait_lock);

>
> At this point I recommend going back to being ``unconventional'' with
> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
> use a mutex for locking rather than xchg()").
>
> That would also mean that we don't have to worry about the lockdep code
> doing something weird in the future and breaking kexec.
>
> Your change starting to is atomic_cmpxchng is most halfway to a revert
> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
> xchg()").  So we might as well go the whole way and just document that
> the kexec on panic code can not use conventional kernel locking
> primitives and has to dig deep and build it's own.  At which point it
> makes no sense for the rest of the kexec code to use anything different.
>

Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
locking primitives to just where they are needed (loading & kexec'ing), but
I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.

> Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
