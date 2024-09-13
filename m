Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CDBFA374A
	for <kexec@archiver.kernel.org>; Fri, 13 Sep 2024 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ToaetrcqOcd8+jagDwxFMGM+Fny2BuX72hvtoWjlysA=; b=11womWbguNxtjx
	BMiGEF8bzOCjOCeRkMpZ8uACymxCKRLjDW4mnEPkx6rZU7IIkgPqU4FKvjlAyylsJvxnAFieapPiw
	sy88XamHEir7ifF1LjfZHo5XAjXIti5k7Oc2pFa4SMajSiHmGTOjWZi9B6v3NL73ha91INsxKhDCa
	daPg7/k5PXT64Vd2z9JafBFAy/1Qp3+YEhQJb1pfSfkPgCQb0yvRC1uci+zg7sQ1zLRL1PNoaEo1f
	YXKPOksH6KxhsVmsQcnEbmb4bCRhG+bCANFoQI/lmjyGHj0r7T7E4zBOZwr3czQLXTMkhC0rdXQ9W
	8bpJT1Ao0WsKAxddG0gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5ns-0000000Fxsi-3wRC;
	Fri, 13 Sep 2024 12:53:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp5n1-0000000FxiP-2iMp
	for kexec@lists.infradead.org;
	Fri, 13 Sep 2024 12:52:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726231961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl05HquAsncJfGKJSFBrSFOKrrN2t2JKKgtLUktSM2A=;
	b=iv8pPh5fm7vYBEJBF4t7P07/GwC9HSV588A8tx0AgQ7d7kwaUA77kTXepqUfyxGLVQ3URR
	6OhVVWX9LXbY8HGuSotrnZ39Y2FzTBon9qi1sk+7DoyH9+NhwKpJniUrtFcGxVVFQWzika
	CHQKJy6RTywCp4q7XQeBtEcAv6YQE2M=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-pdsA0JdCMfqZnrXpR9ckCA-1; Fri, 13 Sep 2024 08:52:40 -0400
X-MC-Unique: pdsA0JdCMfqZnrXpR9ckCA-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f5328fd5eso19987275ab.2
        for <kexec@lists.infradead.org>; Fri, 13 Sep 2024 05:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231960; x=1726836760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wl05HquAsncJfGKJSFBrSFOKrrN2t2JKKgtLUktSM2A=;
        b=N7AKG0sbyaXVU+nmfFuEiVj+r187jQD6d+gQkcptiVzGxQU0wKu3UCJIioeC8o+Nhk
         5bhJ6d9/zMxe2lawXAIkoTcBEI1TD/AypNcSUAjpQdQ2uElKuo2NcxS49lvvpQ9Fa9Pp
         9xiHiRS8QKjuAAUZLDlvt8INgNzCuhyAGAGx21o0BWHEUTctYU4NB+4RFsUUbULhv4u5
         eyxYR/mle2YvA057lHHkU4E5h9n6xKINsnj10dxaCiZaKwPsO9UTB9KoU7DYI3v0XW98
         5eMM73ApZFPkclHkyF7YcUx5wP6nMiiGyOVao1sZOBaf11zgqubxg9fLgZAikKGZe43D
         I2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXtUlzRcxELT87mvhBhEL2tBOGRzoNH9b0OLDE+sw/2zzP4B0i2sYIPCZJZME6SLEkPv1mtTw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJwcOgEROQLuxEEMXXUzV6eGPz1nG48iaqoQDuotYJQqPXkTek
	lq3rKQ9p8c6pudCKSHrJXakdE9CwxehyIUULLhHcJsCWyKlgvNKpPnL8h46rece9tWUJLDYChcL
	y7wfRtpU+MH5pOYNVPPvfODYi4UDRzbmAhuoU/EMkmyZPtw27Ubtq+i7c7yKecqNylyLMBom8vh
	yrcSvE+IfXo6PLDhunkHZ7b7/Bo20jwwUh
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id e9e14a558f8ab-3a08495478amr60011715ab.19.1726231960117;
        Fri, 13 Sep 2024 05:52:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwLSNinCxdMGjUdbfB8K3Nj35P1O2ZHOuUti0jQxahFf7ERb5uddFQ5NioJygZfBUzuO8uwTkyZu28jvB7vZ0=
X-Received: by 2002:a05:6e02:1383:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a08495478amr60011405ab.19.1726231959796; Fri, 13 Sep 2024
 05:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240911104109.1831501-1-usamaarif642@gmail.com>
 <CAMj1kXFVyQEwBTf2bG8yBXUktM16dzrcPH-Phz_toAsCK-NfMA@mail.gmail.com>
 <2542182d-aa79-4705-91b6-fa593bacffa6@gmail.com> <CAMj1kXGi+N6AukJt6EGQTao=-1Ud_=bzwPvdjEzhmzEraFU98w@mail.gmail.com>
 <20240912-wealthy-gabby-tamarin-aaba3c@leitao> <CAMj1kXHh-Kov8c1pto0LJL6debugz1og6GFMYCwvfu+RiQGreA@mail.gmail.com>
 <6b2cc4c4-4354-4b29-bc73-c1384b90dfc6@gmail.com> <CAMj1kXG1hbiafKRyC5qM1Vj5X7x-dmLndqqo2AYnHMRxDz-80w@mail.gmail.com>
 <CAMj1kXFr+N9LMj0=wULchYosUpV0ygZSKUj1vdUP0KWEANKasw@mail.gmail.com>
 <CALu+AoS9+OxPmVJB9fAJFkjsX9xUVw6K_uXiOi0-XsK6-b4THg@mail.gmail.com>
 <1c37546a-e15e-465f-bcbb-6f39c0fcf82d@gmail.com> <CALu+AoQ_Db=1naa1YffvdV7ziY8FPzugUutw6ggg8O5P0Z2ofA@mail.gmail.com>
 <CALu+AoSdN4Zh5gPbyTGS8gJ7wDFfOq81ANNH4wmv3z1vs-34Rw@mail.gmail.com> <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
In-Reply-To: <c76e9653-d991-4319-8924-5883e6829d17@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 13 Sep 2024 20:52:48 +0800
Message-ID: <CALu+AoStijsAxNvX0h2w7jBt-4sHr0O9AEtyyoxNbLBtgmZB7g@mail.gmail.com>
Subject: Re: [RFC] efi/tpm: add efi.tpm_log as a reserved region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Breno Leitao <leitao@debian.org>, linux-efi@vger.kernel.org, 
	kexec@lists.infradead.org, ebiederm@xmission.com, bhe@redhat.com, 
	vgoyal@redhat.com, tglx@linutronix.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, rmikey@meta.com, 
	gourry@gourry.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_055243_776893_4B7CFE59 
X-CRM114-Status: GOOD (  10.65  )
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

Hi Usama,

> > Anyway I was not aware very much about the firmware e820 tables and
> > kexec tables when they were created.   I suspect that a cleanup and
> > revisit is needed.  I will have a look at that.
>
> Yes, I feel like there is one too many tables! From reading the code
> I understand that /sys/firmware/memmap should contain the untouched map
> at time of boot, i.e. e820_table_firmware. But I would be in favour of
> getting rid of e820_table_firmware, and just having e820_table_kexec.
> And /sys/firmware/memmap gets data from e820_table_kexec.

Agreed, I have the same feelings.

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
