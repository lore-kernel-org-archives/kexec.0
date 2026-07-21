Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504CDC4452D
	for <kexec@archiver.kernel.org>; Tue, 21 Jul 2026 23:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kK8bQTGCWBVYNgO28KRycMBgomSj7cEEqhXHP2aOvCg=; b=UxJPiIhk6N+pl55Le9dKRYxry/
	+giY0YZWHXR2Lg7rb2iKM63LZwahHXFdgLyKyMHxMkd5xUIyLzu4kUnHZkd7aK94ToXKSHF8o19GT
	h/GtkmSXyAnvP2mmNOV9FcXZNTTa4QHsbffWyWZNpnTnLne2GWKpGDQdxi+SJJzd9MkYAFGj+UUcI
	iMkpC6XyB48hAALVrHLLRulmanPPFtaqjA6zcbWLe4v9I8NMT0yDL21MG2vSze0TP4wtxaOPBoJ8Z
	aexJQyW/48VQGAnO2KUss+fZJ+buaiQ76XkZg1X3RRPPSHAVvbuKedUEL8W06Dt5Qe5oRLRuifhX6
	t/956bdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmJUK-0000000AXjI-3H9j;
	Tue, 21 Jul 2026 23:03:00 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmJUI-0000000AXik-3Pmp
	for kexec@lists.infradead.org;
	Tue, 21 Jul 2026 23:03:00 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cacef7d299so582055ad.1
        for <kexec@lists.infradead.org>; Tue, 21 Jul 2026 16:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784674977; x=1785279777; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kK8bQTGCWBVYNgO28KRycMBgomSj7cEEqhXHP2aOvCg=;
        b=jOnSUZl01f2szHxnlp2qgK10Ob7aUbQbh0rhBExaGxBHkvt9dnBGxx3ZIwy8VyUqzY
         OeNyGYzVTRSAK+DCHY5qbgW+2Y3N8BNle+u2/QQhSanJKKAgfYh+WA3Wo9dQq+/7SbVr
         R91EliSXS4wXuU+ir+92EQjj2BQ3tdS0h9PRopCK0yLpqWGfJii/1OejlOA824BG9bi3
         dzIOCq+2SEWCM2HbbLsx+fvSw/hEMKg8Ls21pUJJqDhSqIdiZ8PTnSdkVW5VqhPk536n
         +xJ6tVKrwtRAbHUZagSV/FwZwiGZNWJGLiBl5cJ3h4CCOErr0KQEacfiblnLukrTzilV
         cELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784674977; x=1785279777;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kK8bQTGCWBVYNgO28KRycMBgomSj7cEEqhXHP2aOvCg=;
        b=eWP35P/DX+TekRTte+uU0jRn5nxoagANxa/9WDtsL3HsnJS87HGY//GJsxK6RekGCx
         /qU4zoEpFWcmWU19OAeJgqn9wUzRiy7HPRQUCwxfG4/4mulKuNaIRKSEE5O0CI9GYHxV
         ZnD5CxcIX/Mb2CFXHYVXN24wSMztYLsw4ZnWJ3ekZP5bZumChjNbjsYeUoj/d2GIGyck
         0eLBoA4BeLU96Inf0HMH591g19s8s8Xo1KLZ9GjroGc1n/eoFnu8qgKvY2Z8LYiHfYMG
         q66maXYmDHNyksINdIkIEyQ7gzVbnIC+vQwvAEKzCFi6LjgFbKOZB/ziouSToNtPpbBH
         4QrA==
X-Forwarded-Encrypted: i=1; AHgh+RrbwHTdt04yCnbcxre66v66RUZ2V9RGiqlrbVW17stJlf9S6hkYTryoP3Cqbn2J4rw6G6Tzbw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxQ92udYTDZUWel/OpA90ffRao2QbcZ2pp1pue9uscVbLmZJFAI
	uWr0ifFti+HkAKXBfWjPwXespq2DR67NRSMgTaAc/mdk/mlF2ok1TXdcdfYBQGMVsw==
X-Gm-Gg: AR+sD10CN5EXCOB/OPLWXxJ2E98P096XYuRymyAwbfh2huZWZnEQVGHL8TE3cVGeIzm
	oW6uafxqPsz0Q55KdxmK6V4eY4d5bCXl0aVEq4afDe/6SnGNGppMyIyWypAU2/iLJyapDwWA9oX
	ETwn+XC+18AUqq0YlZldrVRGTjz38e90/+fC11MKqzhqoFY3bSDoT9z6yJs4/Za7ojSo1XCcv08
	xdKlieMlMALLPPX8xiJXS4xLH84xP3kzsV6CUzNhgzc0kTEr0bgTDTCa7Mkh0GvLtoTs1dtFb4r
	+aY6mAiRpsU8BwNIRwWiIujZqUq5vVG0gQe2Lz1GASlCEr6wlTr4VxPM89Fzzxb34L7Syx6UXLF
	9OlvB0EmIakV1LcbpxvgFm9KbR3AT7DK4d4NRdDeaYsQBgCGyzeBZvqLHzkm03xsCA3T+x4+csl
	4GPHh09d64QVkDNr343hRY7H+bay624Y4qe2YVK9VBLaXEV5Gy5wRfCm6CSrUot3/1H+CklHl9
X-Received: by 2002:a17:903:2409:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2cf8f3c3e69mr1002465ad.12.1784674976345;
        Tue, 21 Jul 2026 16:02:56 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f18bb8dsm207669a12.19.2026.07.21.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:02:55 -0700 (PDT)
Date: Tue, 21 Jul 2026 23:02:52 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pranjal Shrivastava <praan@google.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/12] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <al_3nOssZoa6RoCq@google.com>
References: <20260710212616.1351130-1-dmatlack@google.com>
 <20260710212616.1351130-4-dmatlack@google.com>
 <178432481253.189683.3297727348836286619.b4-review@b4>
 <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=e1Gcu-9TD7F--41cYqKBrStKOE4VqQ4K3PKdNuYnNmcQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_160258_858070_D2DAE5DC 
X-CRM114-Status: GOOD (  21.28  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Jul 20, 2026 at 02:54:51PM -0700, David Matlack wrote:
>On Fri, Jul 17, 2026 at 2:47 PM Pasha Tatashin
><pasha.tatashin@soleen.com> wrote:
>>
>> On Fri, 10 Jul 2026 21:26:06 +0000, David Matlack <dmatlack@google.com> wrote:
>> > diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
>> > index 03075ce06ac9..df6a02240aa4 100644
>> > --- a/drivers/pci/liveupdate.c
>> > +++ b/drivers/pci/liveupdate.c
>> > @@ -298,6 +377,87 @@ void pci_liveupdate_unpreserve(struct pci_dev *dev)
>> > [ ... skip 76 lines ... ]
>> > +     /*
>> > +      * Hold the ref on the incoming FLB until pci_liveupdate_finish() so
>> > +      * that dev->liveupdate.incoming cannot get freed while the PCI core
>> > +      * has a pointer to it. It's better to leak the incoming FLB than do a
>> > +      * use-after-free if driver does not call pci_liveupdate_finish().
>> > +      */
>>
>> I am confused by this. Each preserved PCI device must have an associated
>> FD preserved with it via LUO. I.e., vfiofd would need to be preserved. If
>> the vfiofd was not reclaimed, and finish is not possible, that vfiofd
>> would still be owned by LUO, and therefore PCI FLB refcount would stay
>> positive.
>>
>> However, if finish is possible, and this is the last vfiofd that is
>> finished, FLB will be freed as soon as the reference count reaches zero,
>> which I would think is the expected behavior.
>>
>> What is the point of holding a reference here, instead of only for the
>> duration of FLB access, i.e. to make sure we are accessing a valid data?
>
>The duration of the access is from here until pci_liveupdate_finish()
>because that it when the pointer (dev->liveupdate.incoming) is
>cleared. So that is why the PCI core holds the reference from here
>until pci_liveupdate_finish().

I think LUO gives you guarantee that this pointer remains valid until
the FLB finish(), because all the vfiofd that were preserved have not
finished. And when all vfiofd have finished, LUO lets you know that the
pointer is becoming invalid so you can unset these in the finish()
callback from LUO?

If I understand this correctly, I think by keeping long references until
finish you are replicating the vfiofd bound lifecycle that LUO already
gives you.
>
>We could avoid this by deleteing dev->liveupdate.incoming and,
>instead, fetching the incoming FLB and doing the xarray lookup every
>atime the PCI core needs to access the device's incoming ser struct,
>but that would be inefficient.

Sami

