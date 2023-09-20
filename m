Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F9ECE79AB
	for <kexec@archiver.kernel.org>; Wed, 20 Sep 2023 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vgf4MGUIPNCVivPyBCJ+52aSgDYgSHUV/m+XdNgan38=; b=Dv9Pimg+tXqDIC
	dA922nMxlHbt+KLXdJYyMyego/gLyeLRgCZ1D+0Lu0xfFUG85x3iwlsulBTHkQ/dlS1yKEhnicl5b
	n4cw5uiOTW7jo3oJ1ro3pNDbQtusV+AdbtcLn3iHb94RojLSpCUWbpkjo/AyWQU05KP2fyWViGsnd
	xERzIPUaHNUSinKEKOWELob0h00bmbB4yG9uDn2luk0JBEdDTFS0P0w+45H0ixDs8cPybmfQcYYVn
	ugBaLao4s1gfjXSTHG2xbJr+ibk2K/FBx1Uh6+CbOcinSmO1wTg/VIQHoC+AevV2gNSK/6KBJS1bu
	e1vQhZKd4dSGarJIGDaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qisl6-002JH2-1o;
	Wed, 20 Sep 2023 08:40:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qisl3-002JG3-2o
	for kexec@lists.infradead.org;
	Wed, 20 Sep 2023 08:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695199227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TBGan7puKQTZLNv3QP6UatLznvd0DiE0/xxoKZXKoRg=;
	b=CcmGhpDYpABwq5T/aCUynZn2cxJ8BeKC5rt6rIfymEMOGxCLLHMR1gLd6lH4NpJY0pOBrr
	zOlAYK+/stBLYHrvFck3YF09Q9Rbs7Q4TxoR+OhcoOBhetko1VR7W3fcszzy7hkJ8Adh4a
	bRLgu4dj4c7DI37miixShaL6CGM75FA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-BkomYLpKNV2cmbF1fWYQxw-1; Wed, 20 Sep 2023 04:40:25 -0400
X-MC-Unique: BkomYLpKNV2cmbF1fWYQxw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7983ed2a0f6so158221639f.0
        for <kexec@lists.infradead.org>; Wed, 20 Sep 2023 01:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695199225; x=1695804025;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBGan7puKQTZLNv3QP6UatLznvd0DiE0/xxoKZXKoRg=;
        b=TYH9bcscM36nYZImMpby9yd7yw88jAadKwBbjOaxvptOh9H8ptVm7JWIzD5hRaIhgF
         f9KUgueubPp/yykNj3VVwSHZKyVkR45stt8MJ2rngEQJ8p8+yYW4xjzn7H4BhCqyjAvG
         ozMJplWqx1nF2Zw8c3Bd/YNUHCuSxj+YBUWFdnfTQgI23M/kBqvZ+Ihr/SwDFIeOFZ36
         P7ZnwyLFKYuL3qlQ7TjdLZ1+88QIxyYt7js2VSy1GGz5doZOw2obrTWwF2Op+EY1iIns
         F7RcVkl3nKELHA5xY3BPyrsxcTte3D5u7Y8Mj8yQKLNgRSGLKqCloi6kmUEUWx+V8cFZ
         q3tw==
X-Gm-Message-State: AOJu0Yy4iimM32I6eAUazuanTAnzb7wXwk4v7CQCJY5+0Gyf7fX1WFO4
	gMVcUDijK45zNYXdvqLEzUdxu9FnVnOXQYA9TzDRvR591YQ3g+rII0AficOpHdDpk1NEm1dATSX
	2/GR0Mda3XHv/UZNnmSDPv4FwN6/NueQRBRal
X-Received: by 2002:a92:d647:0:b0:345:e438:7381 with SMTP id x7-20020a92d647000000b00345e4387381mr2119497ilp.2.1695199225025;
        Wed, 20 Sep 2023 01:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/nNlgdwWnUwZKtEwOL/WSZUqmM3GjHBG6pv7scdqieL1P4bXUAf2on7dPyGtRFzK6Kz3jzeu8+oYoL+Sj3fk=
X-Received: by 2002:a92:d647:0:b0:345:e438:7381 with SMTP id
 x7-20020a92d647000000b00345e4387381mr2119491ilp.2.1695199224757; Wed, 20 Sep
 2023 01:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230911052535.335770-1-kernel@jfarr.cc> <20230913160045.40d377f9@rotkaeppchen>
 <63952cb0-5217-42a8-9b62-8be6d03f5844@app.fastmail.com> <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
In-Reply-To: <CALu+AoTAUWWtx8yChQMKF9J5X_Qd8+x0hz0jzVwoOvAvh5VmHA@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 20 Sep 2023 16:40:04 +0800
Message-ID: <CALu+AoRiok-bzM4OQbiix44O-PUgO2N6Yi+_qTOn4iWtk_u4cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/kexec: UKI Support
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Philipp Rudo <prudo@redhat.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org, tglx@linutronix.de, 
	dhowells@redhat.com, vgoyal@redhat.com, keyrings@vger.kernel.org, 
	akpm@linux-foundation.org, Baoquan He <bhe@redhat.com>, bhelgaas@google.com, 
	Luca Boccassi <bluca@debian.org>, lennart@poettering.net, 
	"Liu, Pingfan" <piliu@redhat.com>, Ard Biesheuvel <ardb@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_014029_983132_D26C4EEC 
X-CRM114-Status: GOOD (  15.69  )
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

On Wed, 20 Sept 2023 at 15:43, Dave Young <dyoung@redhat.com> wrote:
>
> > > In the end the only benefit this series brings is to extend the
> > > signature checking on the whole UKI except of just the kernel image.
> > > Everything else can also be done in user space. Compared to the
> > > problems described above this is a very small gain for me.
> >
> > Correct. That is the benefit of pulling the UKI apart in the
> > kernel. However having to sign the kernel inside the UKI defeats
> > the whole point.
>
>
> Pingfan added the zboot load support in kexec-tools, I know that he is
> trying to sign the zboot image and the inside kernel twice. So
> probably there are some common areas which can be discussed.
> Added Ard and Pingfan in cc.
> http://lists.infradead.org/pipermail/kexec/2023-August/027674.html
>

Here is another thread of the initial try in kernel with a few more
options eg. some fake efi service helpers.
https://lore.kernel.org/linux-arm-kernel/ZBvKSis+dfnqa+Vz@piliu.users.ipa.redhat.com/T/#m42abb0ad3c10126b8b3bfae8a596deb707d6f76e

>
> Thanks
> Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
