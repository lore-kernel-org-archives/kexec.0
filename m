Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFCDCC43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=j20qjWkWuvsX3BASlx5bO4XyOQ2Ft+NUSCzKqsARDwY=; b=PnAUMpLzEOZjIY
	FHNXT1zGG74ZVmPk3RtQuniwsojMillXOH5ZgwhobQMedKrgDh8FfVpGx8ZDVhwp7L/FQD68Ybvuk
	KZqCJTQ0FDGIQKca7MdEblPyLwQ9BDorKxIRF/AaNX3n1Eh8YwA5dwKa/y/rWsbBr1esTM40ckwh1
	0SgtAVihqEOE4e36an3iSMOM2p4DC6HFQD4plRIQJBNGoV4pALik4pPyUXErZX2fadSyGVQ0WiTu5
	UIsFe2nQ+79eWgzYi1LWy1zKI33clm98gzTqaseFZmBQ0kNHGG1L/f+2vDbnLPuKlcMcHIj0dJ1bX
	B861COVl2iiCqmk0cahA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2DF3-0083FK-7E; Fri, 17 Jun 2022 14:46:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2DF0-0083EP-Tw
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 14:46:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655477189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9WJ3fcpXL0f2WOS1lh4X7CDZ3Ewdk0gaVvZYQvOA7jA=;
	b=d+rJIo9fNstpU1X52hJPrUAmMGTnhuVSTgZJxHx5yiPtBQ4cisIRDhWuE1pnzCV7bC7GWh
	tx1aWNFGVWyWWluaLAdj8+BPtU1wjIVqOBmxhMtMVlCyCpZmnU2bPvxYTfXV2xiDtIRST2
	4NA1TwnLZMfj1U5+T1d5YTWoCAbdJuI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-kbNWdrqwMqCkFkpgaYaCnQ-1; Fri, 17 Jun 2022 10:46:28 -0400
X-MC-Unique: kbNWdrqwMqCkFkpgaYaCnQ-1
Received: by mail-qk1-f198.google.com with SMTP id y8-20020a05620a44c800b006a6f8cd53cbso5206144qkp.5
        for <kexec@lists.infradead.org>; Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9WJ3fcpXL0f2WOS1lh4X7CDZ3Ewdk0gaVvZYQvOA7jA=;
        b=zQpp+6XF1+mLVsO/SB2hnSrcs87FRPkaSqw3y6I7GPpYdd86wQ6X2nDYwdnZ3UuPzk
         hKnQKxBfkay76emZ/GIqul8X/H0sIUrfs3+qnCMl2p8W0HD7woVpo1NYXeU0WXNnCIkR
         XhnrUvPIaP0cbjJpWI7RsMRzmpQWPaQgdcrVu1rsdrgmGHJqcNHosT0RT3FmwtGahyfs
         JoquReca7IwFUoD/XG6geaXonID69gocawTudcZapH+L8Q99QpU5RKVH+e2cRgsisv8G
         /OwCnWz3ULHpRYw+2l9m4K1Wr8p9mnMDADXps5aA4QHDdFnOKR2LfrDznASuE4SPK2EE
         BWfw==
X-Gm-Message-State: AJIora8F9hVKwk7n+latntCVm+ryVfkxeHQwfFzQTRoZlsa1jklomtSN
	QACtA40zXCt1AdDBYHfCS9tk6ggt1bfNAzY3YVtVHfbo5BgLNP0r/XnLDuroXqBCCmA5+z/6ses
	4gXfk3L6pl6ORhk7qkXv7
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr8736678qva.58.1655477188331;
        Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tAXwW2mpsUavrlypnLTFvGbZu5tQk5+gn1Z1EAvySMi1FHasDEGVadg1bRJOm3lqNdYXoCAg==
X-Received: by 2002:ad4:5c4a:0:b0:464:5920:7c1a with SMTP id a10-20020ad45c4a000000b0046459207c1amr8736646qva.58.1655477188058;
        Fri, 17 Jun 2022 07:46:28 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id a15-20020ac85b8f000000b00304e38fb3dasm4813173qta.35.2022.06.17.07.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:46:27 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Tao Zhou <tao.zhou@linux.dev>, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, linux-rt-users@vger.kernel.org, Eric Biederman
 <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Juri Lelli <jlelli@redhat.com>, "Luis Claudio R. Goncalves"
 <lgoncalv@redhat.com>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <YqyHGxPCgiXuep3/@alley>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
 <xhsmhh74j7biy.mognet@vschneid.remote.csb> <YqyHGxPCgiXuep3/@alley>
Date: Fri, 17 Jun 2022 15:46:23 +0100
Message-ID: <xhsmhczf773gg.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_074631_081229_E5A67123 
X-CRM114-Status: GOOD (  14.94  )
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

On 17/06/22 15:52, Petr Mladek wrote:
> On Fri 2022-06-17 12:52:05, Valentin Schneider wrote:
>> If you look at __crash_kexec() in isolation yes, but if you look at panic()
>> and nmi_panic() only a single NMI can get in there. I think that is also
>> true for invocations via crash_kexec().
>
> It is true that panic() could be called only once, see this code
> in panic():
>
> 	 * Only one CPU is allowed to execute the panic code from here. For
> 	this_cpu = raw_smp_processor_id();
> 	old_cpu  = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
>
> 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
> 		panic_smp_self_stop();
>
>
> One the other hand, the aproach with two variables is strage
> and brings exactly these questions.
>
> If a trylock is enough that the mutex can be replaced by two
> simple atomic operations. The mutex would be needed only
> when a user really would need to wait for another one.
>
>
> 	atomic_t crash_kexec_lock;
>
> 	/* trylock part */
> 	if (atomic_cmpxchg_acquire(&crash_kexec_lock, 0, 1) != 0)
> 		return -EBUSY;
>
> 	/* do anything guarded by crash_kexec_lock */
>
> 	/* release lock */
> 	atomic_set_release(&crash_kexec_lock, 0);
>
> The _acquire, _release variants will do the barriers correctly.
>

Looks saner! I can't think of anything wrong with it so I'll shove that in
v2. Thanks!

> Best Regards,
> Petr


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
