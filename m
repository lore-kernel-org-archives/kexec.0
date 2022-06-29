Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26748C43334
	for <kexec@archiver.kernel.org>; Wed, 29 Jun 2022 12:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1vGNy0kMGDOf1is+3Q6ZjILvcp6EtkJZrx4G8/bMni4=; b=COy/xjRv+rWt/a
	OjZDmqfgNCCp63qCemeB7NfCKzxtDJdpHNuicnMk8M9JQs63gNU3RmZpTBfVOQcihv0HTbEKtJEgG
	hsip5AcnF1eVJauWmTsvfPlSsm7CKZcALb3SkPzU5JWClEetuPcMv4DuRCKIIffqTEEcOdB1Jk9sr
	YXZw3G25EQKcTG6LFJIqqUTvMCR8+FBXtd3ioi14AuClA1SecLNypxBzpS95N/q1IkVvHVxW1bop/
	B4iHUfXE8gM6ZhC4B7yh9DYNvLZ2jvNQ+CG/l9FihGWPdm46+L49+YG7pOAYFTNjCJr44yX0zJntM
	PD4T5NptFAUD96rWlahw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6WlH-00BnZm-5G; Wed, 29 Jun 2022 12:25:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6WjB-00BmTC-Bl
	for kexec@lists.infradead.org; Wed, 29 Jun 2022 12:23:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656505408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4xckCgJ4Bw0w9xbbVbINWepGBRVBzb5aJNwu4HG9GY=;
	b=GZemZxqZMnJF9RJQYewXP64f3io+7VajIogHffvmn6aPLULDcPK2q4tWUvS2zUonQ6OSl9
	KMv8mRrSZ1FOJWCfKqOWiUbmwFcl8BoFEWIKMf3tVTSYmSsm3vtBHoxzvE14cxdJIrh/vd
	xugwIGY52MqMH0zxk+vSyaJVBtzqBjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-NcK1mfPUNLi8gOnIrpS6fA-1; Wed, 29 Jun 2022 08:23:26 -0400
X-MC-Unique: NcK1mfPUNLi8gOnIrpS6fA-1
Received: by mail-wr1-f72.google.com with SMTP id q6-20020adfea06000000b0021bad47edaeso2405335wrm.20
        for <kexec@lists.infradead.org>; Wed, 29 Jun 2022 05:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D4xckCgJ4Bw0w9xbbVbINWepGBRVBzb5aJNwu4HG9GY=;
        b=yU32/pBX6ZgRzoA3y8E8k6g+PnRn84rsw4h7IX9KTo6SZDM+nDlVAvqpoLwJjvpEL5
         FucEJ2BSlg7on36tFjd5toxY5X6PA6veCeH8uZrKltqvVNw/bQ7MB1fkXcI8spfVljDH
         OLcKh8g4c0LcNffOizslit7acvJ4iESJV1Nr+3aK1IotZuZd4oSqFmrQha1xBN3soShj
         F3k6uBU9hMPEkm0xX0dWlCZy7rJSTKSHk5Yp1OuRpT3guSJ22YGwYB5rwjQw6Y1LxF08
         HSaXI5bKssVw2FLQVK5yBzNWr1ozevTrx28PFWJ09kC0yuGXzS3RCGsfu8jtF/bfKZqC
         Ih7g==
X-Gm-Message-State: AJIora/PKPTNOtWuxi8Hx/17RW8+5zExsd3r+91vu5e6z2tshW+np25G
	1gqBqnIzA0tRszmvpi4arWiTjbAwPvwVfoBPstmp4jWNfLNxyGgzEoXI0CZZexAckzib1x76fVm
	Nnn/v0jO/7k3bebVNQOkc
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr2793324wrx.563.1656505405767;
        Wed, 29 Jun 2022 05:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9pJO/EqSfuHhWYEuTzIM+Ml0Cf5xYU+IXYXEoEGJo5PASFAvTCOcpNz8z35DuzQpGGt5rXw==
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr2793306wrx.563.1656505405591;
        Wed, 29 Jun 2022 05:23:25 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o12-20020a1c750c000000b003a04b248896sm2888552wmc.35.2022.06.29.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:23:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <20220629115539.GB12720@pathway.suse.cz>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
 <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
 <20220629115539.GB12720@pathway.suse.cz>
Date: Wed, 29 Jun 2022 13:23:08 +0100
Message-ID: <xhsmhk08z64lv.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vschneid@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_052329_514887_B0101E62 
X-CRM114-Status: GOOD (  14.86  )
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

On 29/06/22 13:55, Petr Mladek wrote:
> On Tue 2022-06-28 18:33:08, Valentin Schneider wrote:
>>
>> 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
>> straightforward enough because it turned
>>
>>         if (xchg(&lock, 1))
>>                 return -EBUSY;
>>
>> into
>>
>>         if (!mutex_trylock(&lock))
>>                 return -EBUSY;
>>
>> Now, most of the kexec_mutex uses are trylocks, except for:
>> - crash_get_memory_size()
>> - crash_shrink_memory()
>>
>> I really don't want to go down the route of turning those into cmpxchg
>> try-loops, would it be acceptable to make those use trylocks (i.e. return
>> -EBUSY if the cmpxchg fails)?
>
> IMHO, -EBUSY is acceptable for both crash_get_memory_size()
> and crash_shrink_memory(). They are used in the sysfs interface.
>
>> Otherwise, we keep the mutexes for functions like those which go nowhere
>> near an NMI.
>
> If we go this way then I would hide the locking into some wrappers,
> like crash_kexec_trylock()/unlock() that would do both mutex
> and xchg. The xchg part might be hidden in a separate wrapper
> __crash_kexec_trylock()/unlock() or
> crash_kexec_atomic_trylock()/unlock().
>

Makes sense, thanks. I've started playing with the trylock/-EBUSY approach,
I'll toss it out if I don't end up hating it.

> Best Regards,
> Petr


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
