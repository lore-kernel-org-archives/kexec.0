Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8B0C433FE
	for <kexec@archiver.kernel.org>; Mon,  3 Oct 2022 13:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iChFwYP4M1SwQVqekdKSwzzKqtvf3D7ZiCNjpHwk1y8=; b=Uaxh3/A/w5IKBF
	vltgLbrB0fTw1G7u9//WvSbqoZJdRIeq7w1Xz51X+qQSmix4mGYpCiYDznAc31Ut8IBzcMK+//49u
	8QWCf70ewReQndMOQCRB1i63r/fpr1u56NdgqZ1q7iFhioRC+J45cwe/698qNno1xCmsTeVdVVXDy
	iJRbgflm4KTNFYhOA9lm4AbUYOlyhlZCUKW6OSyYaj3B0GNOFFCOz4ZT5F/F9GLWn1jg/YcTRTbio
	bY9RaOA+KNypHBmEKBFRNhi2MJWAClX9vKCt1mw2Y6MRTBv1V4EnlYvGJgcmEdLbIZ0ewP6H7EEJO
	M2NdQV883x78qjcaBZKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofLNc-005wqP-Gb; Mon, 03 Oct 2022 13:21:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofLNW-005wnX-8V
	for kexec@lists.infradead.org; Mon, 03 Oct 2022 13:21:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664803257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hVXsJIBXalnx9DWAK2vGpTAO0XTeIS5m62mJRZPuaKk=;
	b=R7rBaolpV5uT/50GcXYwS0TZC5rwUI0hhOZvjRfbe/qBhtQQ0/q990jwa2gnNVFJUFW/It
	d0pVSA4WlnigjmHntM3BEpxf75le0TtCZENc7+6WlnVG4GVxvH7bdLr4zxHlCvFR9Y8Obo
	ytNpyVQYcwNV6vXPT0hzyKsZBKGnUbQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-275-eQDbdsPLMZWyzYjiMwnZow-1; Mon, 03 Oct 2022 09:20:54 -0400
X-MC-Unique: eQDbdsPLMZWyzYjiMwnZow-1
Received: by mail-wm1-f70.google.com with SMTP id p9-20020a05600c23c900b003b48dc0cef1so2885005wmb.1
        for <kexec@lists.infradead.org>; Mon, 03 Oct 2022 06:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=hVXsJIBXalnx9DWAK2vGpTAO0XTeIS5m62mJRZPuaKk=;
        b=rb54GjIS9z4c6vE8CSqYPfoKSp7cc9TVsT48V6O1QsxHkMK8gggr1BD3SQC3W6LVP1
         l0vOPd6ea6/PBVrSzBcOYvBk5JpFI8Foh+gFAIbytrW2qA8c7rRKhsOp75MnAjSQb6So
         Q1QMR6wskcd3uktYu6jQhEiNW+lTtcnfRe1tbXB6d3Z8LGdxC7pgAXD1uSGaFCJ3S951
         HlgnzyA0sCJmDY9RQdzVyqEay5v60P7obfZXNuB5BiZB9FtIaAEO7Y37LASKip0iYz5d
         Na0vOT4mhEpH3B7qPseZDRQP7ZFVY+iL+DtH7O+ePAQf2QxoeiiQdm5eeoOaA0WrAtk6
         87Cg==
X-Gm-Message-State: ACrzQf2Iv/5ezvboTdF9NW2rKEQ2O0Do9O9RDsxlnitOObHDx7z3Ypq4
	TSQW6nqzXlOKDd334DuQkQnKnbU2hi1lgDpFHkxA47TUHPgai6Qzaac+lu+rPaAqHwLl/zjznGP
	umUKcgIg1CLkgu9QBLkg2
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13557957wrd.510.1664803253421;
        Mon, 03 Oct 2022 06:20:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4yziT+A7H/8++Xkk8zqP5zDeXrH0j0Cz7+uAIJmoQRJ6TFWZ9Hd0AE6hLkuUVLVWF97tjM0g==
X-Received: by 2002:adf:d1e1:0:b0:22a:cd3e:e98b with SMTP id g1-20020adfd1e1000000b0022acd3ee98bmr13557945wrd.510.1664803253271;
        Mon, 03 Oct 2022 06:20:53 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id bh9-20020a05600005c900b0022ccbc7efb5sm9968291wrb.73.2022.10.03.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:20:52 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, Eric
 Biederman <ebiederm@xmission.com>, Arnd Bergmann <arnd@arndb.de>, Petr
 Mladek <pmladek@suse.com>, Miaohe Lin <linmiaohe@huawei.com>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Juri Lelli <jlelli@redhat.com>, "Luis Claudio R.
 Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 0/2] kexec, panic: Making crash_kexec() NMI safe
In-Reply-To: <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
References: <20220630223258.4144112-1-vschneid@redhat.com>
 <Yszgzwnk2Y+4ki58@MiWiFi-R3L-srv>
 <xhsmh35f68tz4.mognet@vschneid.remote.csb>
 <20220713103933.e7510daa1c1f6ccde32f4d42@linux-foundation.org>
Date: Mon, 03 Oct 2022 14:20:51 +0100
Message-ID: <xhsmho7ut2gcs.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_062102_411291_725A51B5 
X-CRM114-Status: GOOD (  11.87  )
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


Hi,

On 13/07/22 10:39, Andrew Morton wrote:
> On Tue, 12 Jul 2022 12:13:03 +0100 Valentin Schneider <vschneid@redhat.com> wrote:
>
>> On 12/07/22 10:47, Baoquan He wrote:
>> > Hi,
>> >
>> > This series looks good, has it been taken into any tree?
>> >
>>
>> I don't think so, briefly poked around git and haven't seen it anywhere.
>
> I'll stash it away for consideration after -rc1.

I've seen them in linux-next for a while, am I right in assuming they'll be
part of a 6.1 PR?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
