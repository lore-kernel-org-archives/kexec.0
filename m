Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C77CD98F0
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTaOMsodtgRUq8XpbHVyhD37ZGMGFGwNGtASXm9Po2o=; b=BB/va97/Xq3Zzm64oGahrJfmHV
	gtC7pvHcYaILEyw+XgyWAK3xMyAttq1p997uvzHrCk2y4sh7A7lChUxmm169MRkw2VHUnObUf99lb
	yXnvZ3VDcLvmBHOMUblOOUxLlNZeiIwt/t9Q2X5f0E0XczpNJoTrhphsR1d6d72eTBXpNs2rdbJ1D
	vGQMNN9OGtKoo5BkYGuWTbWppeb90GQBUTTA8BrUvfIh3lBY0WagQ1lNmVbi8YgVT8SfORo1RKpcs
	TSL6i1g23/u3X15A7etw1tAstdUfTDJM77LCuVtuuD1zCRCXtSLZjwF8C27JNl6OKuwG71A03Z8RO
	pDLe/bJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZwT5-00000000Ibq-3jpF;
	Wed, 17 Jun 2026 20:02:35 +0000
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZwT2-00000000Ia7-3Sh7
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 20:02:34 +0000
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-966db0b76daso737296241.0
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 13:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781726551; x=1782331351; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTaOMsodtgRUq8XpbHVyhD37ZGMGFGwNGtASXm9Po2o=;
        b=Jmffrz+RjE/FfJJSr9N9IeZRvP/Gy+0CAEPIjOdMy/lIO2Q1H/aS1CxDW+/l/MkNT7
         k6Kc184rHmkeN+btaoOUqbGrbvYN+eXrllfP6pB4CC3Ey6as9gCZHEkjysiLHPuM0Aya
         PQa8xNrkV1ap8U5JMp3IYWuJVLRuCuoGI7xBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726551; x=1782331351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HTaOMsodtgRUq8XpbHVyhD37ZGMGFGwNGtASXm9Po2o=;
        b=rIb/SPmGjV43h4CTnvvXAMFH4lt2KGmF2kPsAgCc5lb7T73ALpKdb+enuJdlrjkZjw
         wZCUqAZ6ZV0Qy9VlE7m0o76IQvutqKmz336gRz7KRe8O2yv5H5JqgOdHQbDthBdWHAkb
         hPA9Dl9f7pTIZSq8RkJfsnrH6XUn3OtsJ1nwWAmW8zLSDbPQ9I0rsHoOUnXVXXtyJ8Sy
         UeQMyMnBzCcaS/5HJr7aTzCZjjsHzyavdkOqU59Poll6AUWlLvk6hQmwTlhF7aBHk09b
         swrt4fT4LGh/e4G3/s7UqGFPquBbtGdmSeAKzqy01HPBLOA+zcU6Mn7rXguvKxz7214m
         YzBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+dCCltkXTaa7AXsHJGrt7pKTGmhacrLAgr7M7ZDzNepq60Set4DHKoCsLBWyrxXPAWeWtCqA==@lists.infradead.org
X-Gm-Message-State: AOJu0YythdTRm/EaRbJXOVaTdnylPGUoeh3VOQEYN32vF+jDc4XPhKa9
	omY378XUFE35zUd5EdLFcHY9NIwO11jljNNIZzNB68jHc1eWPv2XhimgTfehUX1Xd3ScSmNE7NW
	FNGE=
X-Gm-Gg: Acq92OHL7B1I/5UyqE2ssjsM1fzrhL1KzGHb8vAcY3opSpeiyTRpqWfvyceSKNRWLQ5
	qIfYA5LPs8SIY1gaSwOmoVujdWux1S9kNpDz8eSs+eeyNkU3WvuKG5sQkWmLGG7hYw4FxjAv27e
	ssdirVNfK44FVn4x+D0I2vlE0l7U4PnPXkH3DNJqdlQm1DdOgRVn8a81eeOf3GyytTpVGN+viUj
	tAcPeWJi225u33Xs4uWu62cWoEaDYBniGdmMV8idwY+ItZmVTkL6beU6rb/7wX5TUtXwB3K78m1
	P2jZDRZv/+bdSkPKLznbNvtx2oQS5GcNluLtuKhK/m3hKvZlHVg3PkJLPBO4+SfSQQ3SelBOobv
	c5luEqRwB/rw3+kXM+gv5XuJmW7v9mMP+6mtwMlanrEiiCHvdjCpucU9HJB3NBOhxA1bJw7ll2b
	roewMaT14MYZUE+WJKA1MTfOlnYVqFTbwYnCGaFt093oPFZJAcdLw=
X-Received: by 2002:a05:6102:6ce:b0:632:5db8:f672 with SMTP id ada2fe7eead31-727b3f1b9cemr492301137.6.1781726551374;
        Wed, 17 Jun 2026 13:02:31 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-720847c15a5sm7727936137.3.2026.06.17.13.02.28
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 13:02:30 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-6c6507549c3so1093495137.0
        for <kexec@lists.infradead.org>; Wed, 17 Jun 2026 13:02:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9FpUpbvtiOhsfNxdRkkOuaM0p8/R/L6iHfFWhpOgV2MeWM5mOqsBzpOsSISX80s+N5Nb0dWg==@lists.infradead.org
X-Received: by 2002:a05:6102:441a:b0:6d3:4e:6d80 with SMTP id
 ada2fe7eead31-727b499df48mr485597137.11.1781726547692; Wed, 17 Jun 2026
 13:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1781709543.git.kas@kernel.org> <b4fa56527950c27715cb603f8b35dc8652be955a.1781709543.git.kas@kernel.org>
In-Reply-To: <b4fa56527950c27715cb603f8b35dc8652be955a.1781709543.git.kas@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jun 2026 13:02:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9Vv6SUDr-ocuD5vp5w6ZCRM9jRbK=pCogQhYZ+jeGCg@mail.gmail.com>
X-Gm-Features: AVVi8CfCpXyjSEb8EYFqmwk9QVgZHo5eGMnJ0vI6j33_G6TOeXQwDdxOJT-BBxY
Message-ID: <CAD=FV=X9Vv6SUDr-ocuD5vp5w6ZCRM9jRbK=pCogQhYZ+jeGCg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] firmware: arm_sdei: add sdei_is_present()
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Petr Mladek <pmladek@suse.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Breno Leitao <leitao@debian.org>, Julien Thierry <julien.thierry.kdev@gmail.com>, 
	Lecopzer Chen <lecopzer@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, kernel-team@meta.com, 
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_130232_876288_23C48443 
X-CRM114-Status: GOOD (  12.44  )
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

Hi,

On Wed, Jun 17, 2026 at 12:20=E2=80=AFPM Kiryl Shutsemau <kirill@shutemov.n=
ame> wrote:
>
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>
> invoke_sdei_fn() returns -EIO when no SDEI conduit was probed, and the
> core warns ("Failed to create event ...") on any registration that hits
> that. An optional consumer that registers an event from an unconditional
> initcall would therefore make every boot on a non-SDEI system emit that
> warning for what is simply absent firmware.
>
> Expose whether SDEI firmware is present so such a consumer can skip
> registration -- and the warning -- when there is nothing to talk to.
>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  drivers/firmware/arm_sdei.c | 10 ++++++++++
>  include/linux/arm_sdei.h    |  3 +++
>  2 files changed, 13 insertions(+)

From a non-expert in SDEI, but FWIW:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

