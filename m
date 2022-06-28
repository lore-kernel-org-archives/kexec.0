Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56611C433EF
	for <kexec@archiver.kernel.org>; Tue, 28 Jun 2022 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UI86Xif8APXi1V5AR+4WCpIEqHdE0hr3BLZfvZZd42g=; b=4I8GiLI3WUyqoh
	gbZAXCCCWrTyxiIcHnClsZ9Ntsjk5E6fVt1O6HCUkKtFZMd7tROwImJlY3aKM1R/RMf4h0DlMxOAH
	3vIZD3Fudoi01tiKq5y/CLsD6N/kindlnoJ8xjZrND0TWdG3OcYWe09wk+qC7sbUpMFGslKiu8154
	DwoJIP23CU+6DmtLsCyEUWjfKtr/NOubW1X9fc/WBpDdXjdHLq3Ie3iG9F/oaVTQoYgkG9VuvmjfN
	1yBEbhJyoMsVcfe9P8so7ay251zsJkUzbXZX+obuf4NZlTZQbGonhA9OjSWF61eLrerks401MVSoI
	deUzOuPr3gXnplteAtQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6F5T-007QVR-TA; Tue, 28 Jun 2022 17:33:19 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6F5R-007QTx-Ku
	for kexec@lists.infradead.org; Tue, 28 Jun 2022 17:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656437593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a7VE0tuK7nWwEOYtUcFLI6mabEeaSx3vxPSmkSS0cDM=;
	b=cH0snIUcPURQ1eGOZtA8e7U5+giPGpTtd4RvkH5Xfks92ZcAnw/0agPayutmT5CzAWoGgG
	hNtvhW7DTrKzZ2n9W+IUu/REa0hWuCU3tQi+i+Fmtlzvarqn6vOJJLQvg560j2YTx4nuy1
	E2Ny7q2eyg1P1qZPf7Tf3E278Ammoa0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-gtqdrbl6PYeKT5n3hXR64Q-1; Tue, 28 Jun 2022 13:33:12 -0400
X-MC-Unique: gtqdrbl6PYeKT5n3hXR64Q-1
Received: by mail-wm1-f70.google.com with SMTP id i184-20020a1c3bc1000000b003a026f48333so5369929wma.4
        for <kexec@lists.infradead.org>; Tue, 28 Jun 2022 10:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a7VE0tuK7nWwEOYtUcFLI6mabEeaSx3vxPSmkSS0cDM=;
        b=1kr5oVbh70jopb12sBlJFi/7RUueRVjrIAIoMZMIpaXa7YqLmdf6phYxfcnVEzPtvC
         kOh5GQLeh/HJutPSLhemkv0SDto6Q2kp8mrAoFGwr/oP5GgfPHQvVK9zG6VAQZhFbi/S
         h4TFd2Cy1hfPgQaQXw09q7D41nUytbB4aRNB/Tvl8bqEr8Jde56iyWk2X91HB1uWJ519
         KzXJr5HYCDOViim5qUJJtw4OmN7dl4oft/Uq2vDzFuXrWXQLLHuTn1IimeHnwqbgpmNV
         SVaZr6mpZTgj49Jy80UYWXfTAnz3eJRK5gjMM2YsNGABYIfmUpaDxObc/aCNdtVLIJM8
         vTVg==
X-Gm-Message-State: AJIora9tcQUIiYCejaxALJfMfE9SXyS9Y0kXlbpn+Gn8971UQ/52a2Wr
	iScXWMOB63HhqkN5hpaMW2jHGaOd5nOq7pR9dLNnxyh3GdECH2K0qnrlzcycpVY3bT8QUf6eL+I
	7k6QmM4dQ6JH/T17LpzRI
X-Received: by 2002:adf:e5cc:0:b0:21b:8bab:8e95 with SMTP id a12-20020adfe5cc000000b0021b8bab8e95mr19211058wrn.454.1656437590820;
        Tue, 28 Jun 2022 10:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uNa1HHSsL0XcWy6n2rjIDIIsOFT4WH5URrvmgY8hvsAi2gczAwVJVbvUfAU+CLisMd3Ks0BA==
X-Received: by 2002:adf:e5cc:0:b0:21b:8bab:8e95 with SMTP id a12-20020adfe5cc000000b0021b8bab8e95mr19211039wrn.454.1656437590549;
        Tue, 28 Jun 2022 10:33:10 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id u3-20020a05600c210300b003a044fe7fe7sm156300wml.9.2022.06.28.10.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:33:09 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Petr Mladek
 <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Sebastian
 Andrzej Siewior <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
Date: Tue, 28 Jun 2022 18:33:08 +0100
Message-ID: <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_103317_823114_1405B8B3 
X-CRM114-Status: GOOD (  17.13  )
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

On 27/06/22 13:42, Valentin Schneider wrote:
> On 25/06/22 12:04, Eric W. Biederman wrote:
>> At this point I recommend going back to being ``unconventional'' with
>> the kexec locking and effectively reverting commit 8c5a1cf0ad3a ("kexec:
>> use a mutex for locking rather than xchg()").
>>
>> That would also mean that we don't have to worry about the lockdep code
>> doing something weird in the future and breaking kexec.
>>
>> Your change starting to is atomic_cmpxchng is most halfway to a revert
>> of commit 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than
>> xchg()").  So we might as well go the whole way and just document that
>> the kexec on panic code can not use conventional kernel locking
>> primitives and has to dig deep and build it's own.  At which point it
>> makes no sense for the rest of the kexec code to use anything different.
>>
>
> Hm, I'm a bit torn about that one, ideally I'd prefer to keep "homegrown"
> locking primitives to just where they are needed (loading & kexec'ing), but
> I'm also not immensely fond of the "hybrid" mutex+cmpxchg approach.
>

8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
straightforward enough because it turned

        if (xchg(&lock, 1))
                return -EBUSY;

into

        if (!mutex_trylock(&lock))
                return -EBUSY;

Now, most of the kexec_mutex uses are trylocks, except for:
- crash_get_memory_size()
- crash_shrink_memory()

I really don't want to go down the route of turning those into cmpxchg
try-loops, would it be acceptable to make those use trylocks (i.e. return
-EBUSY if the cmpxchg fails)?

Otherwise, we keep the mutexes for functions like those which go nowhere
near an NMI.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
