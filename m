Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDDBC43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 16:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2bar/+bK0gVkFATrwc2FDgUKbjRsSDCjrZ+F0d5XbgY=; b=nWzt0sPYNoe7L4
	V0aVnKUrtpjGQuXqllDE+u36hIKAB5mfzkEpFnbM9hl1ZxC2Y1xY9RiuSyiSJs9aZStu0UTm1Gyol
	obxTQY2iRASefeuf49sJAYeutJYRrCN5362vxmLf2RdUvHNry4OXbWwrxQYOFS4OBxoD9Mi1kbs4Z
	FR+Zzm0xwjFOnKmlchjUofmyp3my+G2Iz/C9Vd0krxgMBioDJRgxP4yiwI7G6Q76TwJhb3/9rwINW
	SmHAozXjH9t6KwXK+YSge4Nx++xW/jPUE6ZEKj6El6hlwuTdXqVWEBInzjK7071PSp9XeAh7ht+YW
	W1xSJo41/M5JT3TzIKeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2EXM-008DvB-RB; Fri, 17 Jun 2022 16:09:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2EXK-008Duh-7N
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 16:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655482168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IBPwk9nDoQIaL1wwpLaX0H/tPNhFrVWuXXlSyUu7t6s=;
	b=Q5FxoFQun0YZUNMt5jCDxzgtXQ1VDf9QKUc71SDvClKuNhrQsXIY/Fb/3oiMsqS5fApA29
	+i0YWmlg1+M5CholWPEVz5rDs8yfxCjOqiCL+OC24VDkplAkoRJUEwa09BEXaECJRqsJwF
	iQwIZ14bRptg9raYZ+VaIrqcLygzEVg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-O5lbgrlLPdysfRzFcX8jsA-1; Fri, 17 Jun 2022 12:09:27 -0400
X-MC-Unique: O5lbgrlLPdysfRzFcX8jsA-1
Received: by mail-wm1-f70.google.com with SMTP id p22-20020a05600c359600b0039c7b23a1c7so2906409wmq.2
        for <kexec@lists.infradead.org>; Fri, 17 Jun 2022 09:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IBPwk9nDoQIaL1wwpLaX0H/tPNhFrVWuXXlSyUu7t6s=;
        b=qX/E9v9aH/de7CgDrupRUKKf2z+y0corWouyM8ufKkAs30/mujxzr929LFXpCmROqf
         7Z8L4WoKevqny2GN01/Ke0RSIHzo2Fi+zilN+F8mVKub6JNHtlz+XPfbnTOqHyBNNMB1
         rzmhPS+EYZ5PsHqnHjD26GsmPN50WNUO6i4/WlxdlDLylHxeeixkbcgXjTgn5VXiHL4V
         XVXNWkce2GdiBkOHLVAy1QOJm1cgzkhXmgyjygzKO1cTnttTfk/y6XMyvTQg/Uv1puW6
         NUcgnDjcRpqniiptd8mGPBfxs4eQBxiLxgpm9eGvpXFMP3fXCSfvAQTYpE9dWP+Aadku
         f7jQ==
X-Gm-Message-State: AJIora/o0bVlGJ1Qifgbs0z5u2lPCleevnzRD5tf9MiG4vB2OQ5r/xVB
	xP1i7xA5KPojqRZNjcQIj6EvPdmsBBE1FRJeckFmJXeR3765gaHeytRZoe8jrVcmyz3mCNYI/Vp
	0huSQulY+Ub9PRUTd3i48
X-Received: by 2002:a05:600c:2e14:b0:39c:58c4:c6ed with SMTP id o20-20020a05600c2e1400b0039c58c4c6edmr10889827wmf.156.1655482166260;
        Fri, 17 Jun 2022 09:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u4uhRwDqd/FDNa9ffN3RJce9NoqdX8q9rlMvOtfDNVZYT0LfHesVUll3eMnh2rdM9bZbYJIA==
X-Received: by 2002:a05:600c:2e14:b0:39c:58c4:c6ed with SMTP id o20-20020a05600c2e1400b0039c58c4c6edmr10889813wmf.156.1655482166046;
        Fri, 17 Jun 2022 09:09:26 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c1c8600b0039c84c05d88sm11256071wms.23.2022.06.17.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 09:09:25 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>, Thomas
 Gleixner <tglx@linutronix.de>, Juri Lelli <jlelli@redhat.com>, "Luis
 Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <YqyZ/Uf14qkYtMDX@linutronix.de>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <YqyZ/Uf14qkYtMDX@linutronix.de>
Date: Fri, 17 Jun 2022 17:09:24 +0100
Message-ID: <xhsmha6ab6zm3.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_090930_380033_1F1CCE20 
X-CRM114-Status: GOOD (  18.82  )
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

On 17/06/22 17:13, Sebastian Andrzej Siewior wrote:
> On 2022-06-16 13:37:09 [+0100], Valentin Schneider wrote:
>> Regarding the original explanation for the WARN & return:
>> 
>> I don't get why 2) is a problem - if the lock is acquired by the trylock
>> then the critical section will be run without interruption since it
>> cannot sleep, the interrupted task may get boosted but that will not
>> have any actual impact AFAICT.
>
> boosting an unrelated task is considered wrong. I don't know how bad
> it gets in terms of lock chains since a task is set as owner which did
> not actually ask for the lock.
>
>> Regardless, even if this doesn't sleep, the ->wait_lock in the slowpath
>> isn't NMI safe so this needs changing.
>
> This includes the unlock path which may wake a waiter and deboost.
>

Both are good points, thank you for lighting my lantern :)

>> I've thought about trying to defer the kexec out of an NMI (or IRQ)
>> context, but that pretty much means deferring the panic() which I'm
>> not sure is such a great idea.
>
> If we could defer it out of NMI on RT then it would work non-RT, too. If
> the system is "stuck" and the NMI is the only to respond then I guess
> that it is not a great idea.
>

Those were pretty much my thoughts. I *think* panic() can be re-entrant on
the same CPU if the first entry was from NMI, but that still requires being
able to schedule a thread that panics which isn't a given after getting
that panic NMI. So for now actually doing the kexec in NMI (or IRQ) context
seems to be the less hazardous route. 

> Sebastian


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
