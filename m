Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C337C43334
	for <kexec@archiver.kernel.org>; Fri, 17 Jun 2022 11:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FyAneQ5OXBFB4NRwyTxboWbcjbOAJu1DS9Oip8qxWZM=; b=slBwtwQhUB06SR
	LUmdsIuB64hp8J8X94itlZSsxnu3zIMHkPn54MCGaiRZ7FyQDeI3uu5+Kq4+LMZdp0YZxqy40IIr9
	O+1HhwQv/qqb1FSpx2SlaQtqdQjjv0Os3WTywGs9T04iU0WE10gh/G1QYOXdAyITqE61iVjt8OGRY
	g8oOGshzVsMN/Dplq8XbAowGpi8DRsAydbhvjLoyr4UNpGIxcrfkO9b2xc4rWIonSLNuJqtjG4OzM
	XGR1d9wJhK3ZPtFzX5YePEx/pRYLOYpD1gp6pyrigpgRA9gbChtuzf4ISwC946OlFOVEd7LI5Ur/j
	5QBPUg4+hl9Oe6bAJ5IQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2AWP-007SIg-Hf; Fri, 17 Jun 2022 11:52:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o2AWM-007SFk-IU
	for kexec@lists.infradead.org; Fri, 17 Jun 2022 11:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655466730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UtU3TCMnLtWdbUrXGHinm9uXWVLzhvaPtWr3iNWp5s=;
	b=YC7x49xX++ai1pSjUDqSoD8jo/0QkS1xNjP7GQtGy8UlHfOpogywA969flZ8p178b395+C
	/VwEWOzBu9g+Rt9EyselKe5xgfVUtkwnIgRkZk0n8pB2rYXxA6Ax+NdOAp5R3tdnVvn6Af
	0kxSftmCTCHaVyddsmpcxBWnrnYya94=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-xZsSuROtNgilIU7WktXhvQ-1; Fri, 17 Jun 2022 07:52:09 -0400
X-MC-Unique: xZsSuROtNgilIU7WktXhvQ-1
Received: by mail-wr1-f71.google.com with SMTP id n5-20020adf8b05000000b00219ece7272bso925333wra.8
        for <kexec@lists.infradead.org>; Fri, 17 Jun 2022 04:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3UtU3TCMnLtWdbUrXGHinm9uXWVLzhvaPtWr3iNWp5s=;
        b=J2mX5PUDlzcWLmfvvqhKuqaxdLnV1ksY73M5/satPEfx/BIsrguOg+ogpcom4uhKMn
         rc6HJ46ICIBUE78Dcnig15dXVqxSQkUj/CakpbDwbmOR0e9FNTJ+wfQDOHTWV+9B/Uus
         laugfy+/xN3jiJaElgYaEpTu9FTGz7mIb9LHckYMqMQNP5iuXG1FGlwriI0YdVXDk4vG
         wfTKvMa4jvaSx0hdm72c9mCY3Lu6qhDKRtPoc+XQ7gumrpDV5m2mv1OKlGZ1s/cH5Iyc
         HPY7XUmSW6NCd9nCo/mcLtqMMD0apFOrf7RW5LJZEDlQCrf7RC1N+jT6MvIRHScLa2m6
         RD2Q==
X-Gm-Message-State: AJIora/AtD3MdFTJn5aXXr5IGS53hALvVD1ETVKt2e5Xs2OygzurUuZS
	nod6U9dJBjpWvq5xkoOmMwkQNRftwbG4VwTy9cn/J53oC92/5Hc1Q7WfVNIhOgHqr7VXykTMR9I
	M5vWkr3IVRWCSE4EQPg4I
X-Received: by 2002:adf:db8e:0:b0:21b:4e5b:a438 with SMTP id u14-20020adfdb8e000000b0021b4e5ba438mr2129627wri.247.1655466728032;
        Fri, 17 Jun 2022 04:52:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s0ZXtp9VXtpkNSKsIxSAqZTxBymeFRvrwy1fhKey/Whqc3mgxQ2nRJeEfXi0zexEG1HEHPDg==
X-Received: by 2002:adf:db8e:0:b0:21b:4e5b:a438 with SMTP id u14-20020adfdb8e000000b0021b4e5ba438mr2129616wri.247.1655466727813;
        Fri, 17 Jun 2022 04:52:07 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b6-20020a5d4b86000000b0020cdcb0efa2sm4506890wrt.34.2022.06.17.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 04:52:07 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Tao Zhou <tao.zhou@linux.dev>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>, Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH] panic, kexec: Don't mutex_trylock() in __crash_kexec()
In-Reply-To: <Yqxaf6V+hvCSXQSM@geo.homenetwork>
References: <20220616123709.347053-1-vschneid@redhat.com>
 <Yqxaf6V+hvCSXQSM@geo.homenetwork>
Date: Fri, 17 Jun 2022 12:52:05 +0100
Message-ID: <xhsmhh74j7biy.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220617_045214_723229_464B54F8 
X-CRM114-Status: GOOD (  27.31  )
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

Hi Tao,

On 17/06/22 18:42, Tao Zhou wrote:
> Hi Valentin,
>
> On Thu, Jun 16, 2022 at 01:37:09PM +0100, Valentin Schneider wrote:
>> @@ -964,24 +966,31 @@ late_initcall(kexec_core_sysctl_init);
>>   */
>>  void __noclone __crash_kexec(struct pt_regs *regs)
>>  {
>> -	/* Take the kexec_mutex here to prevent sys_kexec_load
>> -	 * running on one cpu from replacing the crash kernel
>> -	 * we are using after a panic on a different cpu.
>> +	/*
>> +	 * This should be taking kexec_mutex before doing anything with the
>> +	 * kexec_crash_image, but this code can be run in NMI context which
>> +	 * means we can't even trylock.
>>  	 *
>> -	 * If the crash kernel was not located in a fixed area
>> -	 * of memory the xchg(&kexec_crash_image) would be
>> -	 * sufficient.  But since I reuse the memory...
>> +	 * Pairs with smp_mb() in do_kexec_load() and sys_kexec_file_load()
>>  	 */
>> -	if (mutex_trylock(&kexec_mutex)) {
>> -		if (kexec_crash_image) {
>> -			struct pt_regs fixed_regs;
>> -
>> -			crash_setup_regs(&fixed_regs, regs);
>> -			crash_save_vmcoreinfo();
>> -			machine_crash_shutdown(&fixed_regs);
>> -			machine_kexec(kexec_crash_image);
>> -		}
>> -		mutex_unlock(&kexec_mutex);
>> +	WRITE_ONCE(panic_wants_kexec, true);
>> +	smp_mb();
>> +	/*
>> +	 * If we're panic'ing while someone else is messing with the crash
>> +	 * kernel, this isn't going to end well.
>> +	 */
>> +	if (READ_ONCE(kexec_loading)) {
>> +		WRITE_ONCE(panic_wants_kexec, false);
>> +		return;
>> +	}
>
> So this is from NMI. The mutex guarantee that kexec_file_load() or 
> do_kexec_load() just one of them beat on cpu. NMI can happen on more
> than one cpu. That means that here be cumulativity here IMHO.
>

If you look at __crash_kexec() in isolation yes, but if you look at panic()
and nmi_panic() only a single NMI can get in there. I think that is also
true for invocations via crash_kexec().


> kexec_file_load()/                 NMI0                     NMI1..
> do_kexec_load()
>
> set kexec_loading=true     
> smp_mb()                set panic_wants_kexec=ture
>                         smp_mb()
>                         see kexec_loading=ture and
>                           conditionally set
>                           panic_wants_kexec=false;
>                                                  set panic_wants_kexec=ture
>                                                  smp_mb()
> see panic_wants_kexec=ture
>   conditionally set
>   kexec_loading=false
>                                                  see kexec_loading=false
>                                                  do kexec nmi things.
>
> You see conditionlly set kexec_loading or panic_wants_kexec there no barrier
> there and if the cumulativity to have the effect there should be a acquire-release,
> if I am not wrong.
>
> __crash_kexec():
>
> WRITE_ONCE(panic_wants_kexec, true);
> smp_mb();
> /*
>  * If we're panic'ing while someone else is messing with the crash
>  * kernel, this isn't going to end well.
>  */
> if (READ_ONCE(kexec_loading)) {
> 	smp_store_release(panic_wants_kexec, false);
> 	return;
> }
>
> kexec_file_load()/do_kexec_load():
>
> WRITE_ONCE(kexec_loading, true);
> smp_mb();
> if (smp_load_acquire(panic_wants_kexec)) {
>     WRITE_ONCE(kexec_loading, false);
>     ...
> }
>
> For those input, I'm sure I lost and feel hot..
> I thought that change the patten to load-store and set initial
> value but failed.
>

I'm not sure if further ordering is required here, the base case being

  WRITE_ONCE(panic_wants_kexec, true);         WRITE_ONCE(kexec_loading);
  smp_mb();                                    smp_mb();
  v0 = READ_ONCE(kexec_loading);               v1 = READ_ONCE(panic_wants_kexec);

  (see SB+fencembonceonces litmus test)

Wich ensures (!v0 && !v1) is never true. If modified to:

  WRITE_ONCE(panic_wants_kexec, true);         WRITE_ONCE(kexec_loading);
  smp_mb();                                    smp_mb();
  v0 = READ_ONCE(kexec_loading);               v1 = READ_ONCE(panic_wants_kexec);  
  if (v0)                                      if (v1)
          WRITE_ONCE(panic_wants_kexec, false);        WRITE_ONCE(kexec_loading, false);

then "(!v0 && !v1) is never true" still holds, so the exclusivity is
maintained AFAICT.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
