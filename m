Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BC0C4453A
	for <kexec@archiver.kernel.org>; Wed, 22 Jul 2026 18:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JvsC0je0dp2LaZT9DNha2g/XRrObDHKnCFxExrTr+Do=; b=O4XKYj2sqZMxlYQG5W9KJ95i7w
	X03j/7SnMoC2r8DFLFwa4NTylX9xeJZwIGHKbPua6ALfb3DsZLQErYAX7d+pTwc/8vyWkrCZz5iQq
	SKSst14y1oSlW8yy94afrn3BWaid5de6HqeJeLUi1rlAZEDH49il2Yjr9agkRRuGEsplT+6jwJImS
	TRxxPq6nzKbbJzxfPJRHnmeA0kJ2okOMh2aTTg+ywPMRJwFzVBCCYc/gl+FnnRf92GofnwYMLTfnk
	OKWd5P4QaZd93djYm54inzUrkAfCf4N8AaPEshbc1TSwBK7BEZ9IzSIBzORCdyf6ekGycBhnM1TR1
	RDUP7rfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc00-0000000CaOD-1eq5;
	Wed, 22 Jul 2026 18:48:56 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmbzu-0000000CaNb-2xVF
	for kexec@lists.infradead.org;
	Wed, 22 Jul 2026 18:48:51 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso1815166b.3
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 11:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1784746128; x=1785350928; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JvsC0je0dp2LaZT9DNha2g/XRrObDHKnCFxExrTr+Do=;
        b=Tb4k/bEdkqR73Wy8FMnjgl9QlslhAE0YRdHxgIInClVmfAbt46xWEQy3sR1bo3qpEq
         CJ4rpNSySCcn+G7CjUB+/t/XeBBWenHTwV12cOTLzHSB1nI2InFWxCXKxvltQ2DN2jOZ
         apGWp1sVcg+uTd332ZXwcOH3o70LnRx9qaHZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746128; x=1785350928;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JvsC0je0dp2LaZT9DNha2g/XRrObDHKnCFxExrTr+Do=;
        b=kVzReUk+h/3QLuv0eBLJ+2jHkw5JquDCLQSd2ryjdPq1LwCpdk38IWocglfeIGA5St
         tzExUfJ4R2pMgLnoET/j883DeWgFDMBpswKdHsSnLoyuGcNL1KhvKc1BVNsWp6cMd0GN
         gbgSOZT+e6PTwLGUMPFq+Lkx5znKvbxVN3n2o1p4IFYCHxXh5fOrXbxKovHa4RrSE670
         dETcrE7gpGncMd5IwNQWz18sV6KA1PmOH185qwhsC0hzz1grib0/g4ljA/00w1mzwVTb
         ozk26VisobkJWgIu9t6pFO/uGFuzDh5LvcGzs08djfDbt5AR1wDB8z+LDz6i6sadZZZp
         K/mg==
X-Forwarded-Encrypted: i=1; AHgh+Rqtiy5XgMNqO2tsQs97TN+q5B9UAzVwpCCh6AijqgMRU87Ug9G8Y9ogvgQtEXyDDXLcV7HWgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyl1EJecJzfhLVu+uWiEm5dfh80uPrLOgU/liFouqBpT0bTC6yn
	AoEyvEEfqedzbzGhIQ4X5Fe28AQhJye83idXtIDAG+Q5gxxTwiE/Z3LwR4fRGTWrxwnq5bXXljm
	1uwrzq4I=
X-Gm-Gg: AR+sD11N9N4kGHDWKx07X1q/4yaCDppWz14Cuc5wlaqYJozLYhAHrGY8I+0K6AGO1JA
	t29CdBTCnKiH6vjbQa3IeWsL7ukqdE3AN3UQS32rxVOHnJJd0x7xeu+SH2Q+PPRjTREhhBIYRle
	e2RA5ipICTHGjNUE6Z07So/UqcndGuUqnZaZelzYo62dcb6LJCeh5KQ2NJ1ggV0jMEhk2aNupfH
	tsQYnrqE7RFyB6l8HFD03yaTfwMdBU+X3xpywrvp9/nOAgWc83wfqkcdDuA2lKRtxQBPMyvIlN0
	2ji+o6TuQPo514S4rWdmBnbPkNT51nr8i32eUD9oiwe4zYGquzK275cabX19CHfTBkfScQ0mPSC
	vVDesNgw6Vj5Wd5FuB/KTsJTt0+dht4klap1q/2SFE6fIP00HTqKE602aYDvVVLKLS+LLWbVAE/
	yZ6q+Ir4T/G55g8HxtK4TbFbjH43BEbjZLzcV5qbfWoED0W9mS5qGJEnNE3XOApA==
X-Received: by 2002:a17:907:98d:b0:c15:bea2:d209 with SMTP id a640c23a62f3a-c1c506e8a4cmr4760366b.4.1784746128067;
        Wed, 22 Jul 2026 11:48:48 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32c902d2sm135602566b.34.2026.07.22.11.48.47
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 11:48:47 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15f360851aso1466146666b.2
        for <kexec@lists.infradead.org>; Wed, 22 Jul 2026 11:48:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RogeODLnoq+9zqILgKOXO11H/q1eXnwqjaCPOodqWyN6l12uoNYitUslrf6tfIxRc8w2lcNmg==@lists.infradead.org
X-Received: by 2002:a17:907:e1cf:10b0:c16:1901:6b8a with SMTP id
 a640c23a62f3a-c1c5099eeb3mr2116966b.53.1784746126816; Wed, 22 Jul 2026
 11:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260722162524.1014269-1-rppt@kernel.org>
In-Reply-To: <20260722162524.1014269-1-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Jul 2026 11:48:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyYBFw+o9RRyGXvfS+ipQgGAM1oHFL9KXFoCCkRvrTfA@mail.gmail.com>
X-Gm-Features: AUfX_myAXYQuU_kPICxeO5GLyQkjc8T4p23hA50rUKENvJzdOpfG8u9jWEz5ikU
Message-ID: <CAHk-=whyYBFw+o9RRyGXvfS+ipQgGAM1oHFL9KXFoCCkRvrTfA@mail.gmail.com>
Subject: Re: [GIT PULL] liveupdate: a fix for v7.2-rc5
To: Mike Rapoport <rppt@kernel.org>
Cc: Jackie Liu <liuyun01@kylinos.cn>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_114850_858786_C22D23F4 
X-CRM114-Status: GOOD (  12.71  )
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

On Wed, 22 Jul 2026 at 09:25, Mike Rapoport <rppt@kernel.org> wrote:
>
> * Fix validation of LIVEUPDATE_SESSION_GET_NAME ioctl argument caused by a
>   wrong resolution of a merge conflict during the last merge window

Hmm. I tried to figure this one out, and there's no "Fixes" tag on this commit.

It would seem to appear that the "merge conflict" wasn't actually a
merge conflict, it was in fact a bad rebase (which in turn was due to
a merge conflict in linux-next).

People really should be extra careful about rebases like this. They
destroy history, and when bugs happen, it's really hard to see *why*
the bug happened because the actual cause of the bug has disappeared
and no longer exists after the rebase.

I *think* this commit should have a

   Fixes: 507e3b479f9c ("liveupdate: validate session type before
performing operation")

but I'm not familiar with this code, so somebody should check that.

I really would like to see "Fixes" tags in general - but
*particularly* for something like this because it's marked for stable
(apparently because the bad rebase was marked for stable).

             Linus

