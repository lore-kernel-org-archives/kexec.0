Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8F4C5472D
	for <kexec@archiver.kernel.org>; Mon, 26 Aug 2024 06:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E08A6JWxi/4wdLq+6U0xv8OPYxiHpU08Q7JbG5bFwoA=; b=1eFtTW2ml7IYwa
	mUJIA8sy0CHR7mipdE+/CX7Ue/6UsjbkOFOTZuPrmAlcXar3Mk/j+GSq5zf0uIdVQ9ha7Bnl7ah5M
	nBBA4nIbcN88ac30uTJp19Mbf+2rg7nXqNwP1mIMdX90pt/hjOZHXFhT6y8mHki+bYoSYMkj4cjbk
	6Rc3ujIxZsfyH5arb4hvmVbBfBOTmvzzL7peZP4/oPNiQv4CAqOM0z8d2557lolvgJk/6mcMCdanJ
	et0i0cGcyL8cDTa32JHLx/MSczV285Y/Bv/oDGUtbvkopIGIkIwmbkMnub00sFtPX7v2ZKf+G1Nns
	Q9Y/vGEQY6PP6dRrxVpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siSpU-00000005xCX-1vHs;
	Mon, 26 Aug 2024 06:03:52 +0000
Received: from mail-qv1-f48.google.com ([209.85.219.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siSpQ-00000005xBp-2mcM
	for kexec@lists.infradead.org;
	Mon, 26 Aug 2024 06:03:50 +0000
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf9ddfc2dcso17378506d6.1
        for <kexec@lists.infradead.org>; Sun, 25 Aug 2024 23:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724652227; x=1725257027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKXjBrfmroCoc+jNcJVKdc7dB1QcJh0d700AGCluMS4=;
        b=NIyvN8foTwWUnlH/mQy7x9401Dl9D7AOWt+gVm2TIOZRKduRYByGGTKUnrjUYt2cuR
         n1WHwkHxgFQjdoIs8mXIfedC82612nUY6el2bJdvw5XY/6x6jchNylLoVVTmkLoge8ts
         QYS6Fw2R18fFa/NZrEtlbnZAqK2S0CbaEA1sYspNhbvo5HfNnc5J+IIYk55hFfetmzsJ
         Co8AXr7kX31gEeVXA+zc4NmkRkSSvG4Q1GCJFET5qDg+a4h6A9yy0WF3MXto1PhvZ5De
         ULnuFzKoi7dxuj1zuIxPHetoF+a0up1Z55hwIIq7r/VNiw+Zc3I9+vp9Cuf5XjbUhi1f
         FubA==
X-Forwarded-Encrypted: i=1; AJvYcCXJ3mSC0pDqmeDlbUK+bhIQ/gk6tArGA42fJUolERKnNzsphrB4/BfXkkcd/wIkhcFt9/rlVw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxTxB1amWhDsvrLIKL/7L3lTRQ/5JgmodO4nvhs0yWtHCAlvdk0
	2a3fs5vJrtEDTbl0P/anmE/7gy3osZvFh6uCychMCGpozfQlKTba
X-Google-Smtp-Source: AGHT+IGSGyPTkUxMgB/i4Zy4QLzMECErNv2aanCJjyDmWf6JxbREWcMAfmUgTeNndDbjPNgn8lnisA==
X-Received: by 2002:a05:6214:3d98:b0:6b0:7f36:8ae3 with SMTP id 6a1803df08f44-6c16dc93d89mr90352156d6.32.1724652226893;
        Sun, 25 Aug 2024 23:03:46 -0700 (PDT)
Received: from [192.168.2.219] (bras-base-mtrlpq3141w-grc-05-65-93-184-127.dsl.bell.ca. [65.93.184.127])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0991sm43641976d6.91.2024.08.25.23.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 23:03:46 -0700 (PDT)
Message-ID: <94540d05-12ab-49b8-9e37-04a29f5cdf77@vasilevsky.ca>
Date: Mon, 26 Aug 2024 02:03:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bhe@redhat.com, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
 <CAMuHMdVYNhFJ+qBDP3_fi9oeHsgOL0vqPe1YqE18+M8n1onssw@mail.gmail.com>
 <87frqsghws.fsf@mail.lhotse>
 <c1fd73a3941c54e58420d7555524cd6baeebfb96.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <c1fd73a3941c54e58420d7555524cd6baeebfb96.camel@physik.fu-berlin.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240825_230348_735119_CE3A092B 
X-CRM114-Status: UNSURE (   7.65  )
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

On 2024-08-26 01:38, John Paul Adrian Glaubitz wrote:
> On Mon, 2024-08-26 at 12:02 +1000, Michael Ellerman wrote:
>> So IMHO having it enabled by default in upstream does make sense,
>> because it more closely matches what distros/users actually run.
> 
> Well, at least Debian did not enable it by default as otherwise we wouldn't
> have noticed this change downstream.

Debian does enable it explicitly on some supported architectures, but not all: https://salsa.debian.org/search?group_id=2107&nav_source=navbar&project_id=18670&repository_ref=master&scope=blobs&search=path%3Aconfig+CRASH_DUMP&search_code=true

By my count, 6.9's new default affected mips, powerpc (32-bit), riscv, and sh in Debian.

-Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
