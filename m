Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1437C433EF
	for <kexec@archiver.kernel.org>; Fri, 24 Jun 2022 13:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GLu2Nlf9/Zb7wotEJr2tUUDOU16GoYlCx8eYeVeP3ZA=; b=fvwOSH8lvbyn2t
	lX3C/WOaZqkdXicMj7UpUD9YDY8hKLPgGq1xgmhYKV89SZz0G+KChcVdFwwNsgv2DyWB7Q1sU95ar
	+naHbHZwsvfF0OPdRj4SxWv9+Hu+4XKYzC3vJQ5V7gVz/eLadc4Rs7StI0oJ3an3bH6MN6ZyIqith
	spfyDHtURKAVk7ThMG1SV/y3IOuB0GKJ7WGwwSaTywLeNR8qvL+FOFw8ajfIwMgXYSHGhXjL82UmA
	ftPDEyZH2XZ3Se+ItmgqJguFq42dVfmf0O7afvxNCBFyCzFeUdtGWzwvpmayd36hiQ18yqe02HH3m
	AfiaanFOQC3RLP/vLrdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4jVR-002QCY-Sd; Fri, 24 Jun 2022 13:37:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4jVP-002Q9I-4U
	for kexec@lists.infradead.org; Fri, 24 Jun 2022 13:37:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656077858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iihGsDJaCfgB0U9H9bTk3P+5uHXU2Udgo4mdhsEY1hk=;
	b=Royy/kYSZQmbA8kjAokE+eg67UWwe37hREQM4pAAKdvjOxKJdJ/Nc/7waUVv9pfXgk0qWq
	mBO+ZUUq3HLE9NYqMiI3JUiglLRwiSwLwSkl494rV9mXJ+nffqdlipTAHZHO8eL9Sp4N4V
	QRNoHE2e3XrD9PjIfqJASy/GpWvrJ6g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-SteCV7aSPk-xSnZpcAOZPA-1; Fri, 24 Jun 2022 09:37:36 -0400
X-MC-Unique: SteCV7aSPk-xSnZpcAOZPA-1
Received: by mail-wr1-f70.google.com with SMTP id z11-20020a056000110b00b0021b9c009d09so340245wrw.17
        for <kexec@lists.infradead.org>; Fri, 24 Jun 2022 06:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iihGsDJaCfgB0U9H9bTk3P+5uHXU2Udgo4mdhsEY1hk=;
        b=yL2WwJLTnW5ePLiFsYi3etorw3Al+YFcRJAoVCWr9mpXR/gyhRvWLRH5Dv6Q3i+3NK
         jBFT7PKj+nI50uKk1yQODMnY+kJTXm+3VhPj/fBbGg9PRuoUuD+zhhECal8CfKOuZKyB
         IrcaNcLrFr7yBotS6a4e/R/1Iq8coBo5WfHUN9kDOaqSSnQVUgxVF0zasX09yO10PHjY
         slpLK9d2BL6ReRyZT0PKse9Fdkw3+2+cFT9ZP90ZR/Zov4OQ/T8xOS5xmAJ9z5/gfTuG
         zk4HnPkcidXx5lZrD8/lfZ999g9qs5DFF7LPOzzs4d1rMVZvdCzEvMRBPvPfAh6fbko1
         FiRQ==
X-Gm-Message-State: AJIora/JlkmYbZy1h6gduKf5dJfwKYPCSFyeR4evK04G/voNsNbQesCv
	cC7YBjJooa5Jnb/JZQUjSLeOLraVTMCr0PptuY+9XXcEMrBc9VTyC/BFKW46+9Vm8aw2mmZLGAW
	7GD2c7oXkagHbgzh699l1
X-Received: by 2002:a05:6000:1373:b0:21b:ae65:cd38 with SMTP id q19-20020a056000137300b0021bae65cd38mr5758330wrz.323.1656077855326;
        Fri, 24 Jun 2022 06:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5kxEQLYP7f2/L7To0n1AeI7/BBSZOapMMFe+ZmhaXEaq7njP/DHXIEAivdtbuhzGRbNBfxw==
X-Received: by 2002:a05:6000:1373:b0:21b:ae65:cd38 with SMTP id q19-20020a056000137300b0021bae65cd38mr5758301wrz.323.1656077855110;
        Fri, 24 Jun 2022 06:37:35 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h6-20020adffd46000000b0021b96cdf68fsm2300843wrs.97.2022.06.24.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:37:34 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
Date: Fri, 24 Jun 2022 14:37:33 +0100
Message-ID: <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220624_063751_291529_32531EFE 
X-CRM114-Status: UNSURE (   9.77  )
X-CRM114-Notice: Please train this message.
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

On 24/06/22 09:30, Baoquan He wrote:
> On 06/20/22 at 12:15pm, Valentin Schneider wrote:
>> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>  	/*
>>  	 * Because we write directly to the reserved memory region when loading
>>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
>> -	 * from attempting to load simultaneously, and to prevent a crash kernel
>> -	 * from loading over the top of a in use crash kernel.
>> -	 *
>> -	 * KISS: always take the mutex.
>> +	 * from attempting to load simultaneously.
>>  	 */
>>  	if (!mutex_trylock(&kexec_mutex))
>>  		return -EBUSY;
>
> So kexec_mutex is degenerated to only avoid simultaneous loading,
> should we rename to reflect that?, e.g kexec_load_mutex.
>

It's also serializing crash_get_memory_size() and crash_shrink_memory();
more generally it should still be the preferred serialization mechanism as
it's a "proper" lock visible by instrumentation, the atomic variable is a
side character for the NMI case.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
