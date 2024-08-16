Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EE6C531DC
	for <kexec@archiver.kernel.org>; Fri, 16 Aug 2024 06:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4XRcAc0Z/6t/9dAwLIJVNbIpbZZ90OpFwYzVtkrDTMU=; b=pccanyGz0Pmrkf
	v7Np4/VV6NOHEubxuWpA9eAOSmcBbIWIZ9Q+DojyDOyKqVxbdN5lQuOu9zacmp7ANZGJGtEMuaQR4
	9xTK01pejIkW4ZaYC9kHG/oXl/YsFSkSBdf8F4ZTUOqVCoEJVsCHDhcv2sloJ7113dhpIze9/+Jz4
	JlC445X3bndHQL57gfoGuP/hYUhYdLbL7id46OB6a7zWu++GTvquh3k/58q1yjtr5NCYgHzPSwHWb
	fb8vnughoO92eo3KtJolf1GsDogZlQj0MKwZc24ZfSakJEiZIBNUKcDn9hZQ/E2u548ZU7WhGpMw/
	U9UbtejgeX93BrYO/2IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seqX9-0000000Bx0v-0bRR;
	Fri, 16 Aug 2024 06:33:59 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seqX4-0000000BwzB-1nyr
	for kexec@lists.infradead.org;
	Fri, 16 Aug 2024 06:33:55 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso11065665e9.0
        for <kexec@lists.infradead.org>; Thu, 15 Aug 2024 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1723790032; x=1724394832; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ru72ythl7RCMGJzB+CaFD1wc8SkQVegXHi4g22TOCfA=;
        b=C5/Z+BQQrPklfw3A8xq++exn6cUVGTAVi1QWMTQggfIzNBCFdXsa90uYqovuMH8UQB
         2DXAKML8WKz5CnlrLGlkwMRcCgJCOCBQuEJywVSe+xmjgIfjvVAkUGMPjPGuSLkISEhT
         Oabtgq+3KIWjT3CT+zy7mpac8Ig6tqzPLGTm5IFlRVtHUyqi9pNkpiFYHMYsYqyT9KjT
         tvulni/JW3aczAxCqoHrlV3oKU+fBBfDLcBPxLohQN0VFtkIisVLMtoDGnvT+FPgUQoa
         xNuNk+xVajSYWgVIr4H8XJWnUbgTdUaPCBs2dpZXe5BonIgmbk/Xp6wiZivRd3AUtOlm
         IJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790032; x=1724394832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ru72ythl7RCMGJzB+CaFD1wc8SkQVegXHi4g22TOCfA=;
        b=m2ejTlML7ZCoqM+r51HUVr6YVC8o09oyJ+EKX9HqTS8B4dtCM/E4/9LWDoczhgCmlq
         dLP34w2MHQFwPEu1GObqHISA0Hvucyi0YCM0NZ0TrQwx7HViN0hqo5Rhmmny7L/zyX3A
         +5loVqELf82iFIHZMmff3Y++NAz4e1IpN38tN5Fz3Son52ckL053HUp2IwGKCDuIZrIi
         ean8XEW+qYtZS8tTedXMCdKjhQil30b4IRB0bZ1R/CDn5e4RNTlXIRZqSvTa9iKKdErB
         GLBpyQYe3Na8eHwxACor6b3yaSI2Oh1Z6ujGGbhqQVE3DDMkTHmVm6YbGEKmgXArrER+
         RKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaUNz6Oece/jXcwDnT4X+vpWS3R7laiAIvH39Ux13g4bHi6fWbN47t/kr34IzopPFlEwb2IQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxqUwvxbiGLip9iug2bLMa9D5+I8CoFzdydl4BN3nGbU8xQd8zl
	iIlJNMltiThbov3/U+EXNbZIMn9kaNnldMg+hFuybzsS8d9gHc2nyx9oxFJkglQ=
X-Google-Smtp-Source: AGHT+IHMr4FewiaDTQWL/NtTZPjZsJdIOHrGXpi4AtwWkG+BIijKhi2MlUkSB3mA+WUfVsgpu7V6Bw==
X-Received: by 2002:adf:ef46:0:b0:363:7bbf:efcc with SMTP id ffacd0b85a97d-371946d6b09mr1188194f8f.62.1723790031461;
        Thu, 15 Aug 2024 23:33:51 -0700 (PDT)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a047sm2933367f8f.11.2024.08.15.23.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:33:51 -0700 (PDT)
Date: Fri, 16 Aug 2024 08:33:49 +0200
From: Petr Tesarik <ptesarik@suse.com>
To: Baoquan He <bhe@redhat.com>
Cc: Petr Tesarik <petr.tesarik@suse.com>, Eric Biederman
 <ebiederm@xmission.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Hari
 Bathini <hbathini@linux.ibm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Eric DeVolder <eric.devolder@oracle.com>,
 "open list:KEXEC" <kexec@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [PATCH 1/1] kexec_file: fix elfcorehdr digest exclusion when
 CONFIG_CRASH_HOTPLUG=y
Message-ID: <20240816083349.3fd6f1c1@mordecai.tesarici.cz>
In-Reply-To: <ZrFZM4W7S89VpfaG@MiWiFi-R3L-srv>
References: <20240805150750.170739-1-petr.tesarik@suse.com>
	<ZrFZM4W7S89VpfaG@MiWiFi-R3L-srv>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_233354_505136_745E97F2 
X-CRM114-Status: GOOD (  19.59  )
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

On Tue, 6 Aug 2024 06:59:35 +0800
Baoquan He <bhe@redhat.com> wrote:

> On 08/05/24 at 05:07pm, Petr Tesarik wrote:
> > From: Petr Tesarik <ptesarik@suse.com>
> > 
> > Fix the condition to exclude the elfcorehdr segment from the SHA digest
> > calculation.
> > 
> > The j iterator is an index into the output sha_regions[] array, not into
> > the input image->segment[] array. Once it reaches image->elfcorehdr_index,
> > all subsequent segments are excluded. Besides, if the purgatory segment
> > precedes the elfcorehdr segment, the elfcorehdr may be wrongly included in
> > the calculation.  
> 
> Indeed, good catch.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Thank you, Baoquan.

Who should apply the fix now? How can it be merged into Linus tree?

Petr T

> > 
> > Fixes: f7cc804a9fd4 ("kexec: exclude elfcorehdr from the segment digest")
> > Cc: stable@kernel.org
> > Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> > ---
> >  kernel/kexec_file.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 3d64290d24c9..3eedb8c226ad 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -752,7 +752,7 @@ static int kexec_calculate_store_digests(struct kimage *image)
> >  
> >  #ifdef CONFIG_CRASH_HOTPLUG
> >  		/* Exclude elfcorehdr segment to allow future changes via hotplug */
> > -		if (j == image->elfcorehdr_index)
> > +		if (i == image->elfcorehdr_index)
> >  			continue;
> >  #endif
> >  
> > -- 
> > 2.45.2
> >   
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
