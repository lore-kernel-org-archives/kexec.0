Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F72ECAAD3
	for <kexec@archiver.kernel.org>; Wed, 14 Sep 2022 18:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TvvIZfp6ZbWZ/EZKHpWT3IkPDrgxTPJrM+v+4uOS+D0=; b=oMBhwM9UWSQqgm
	XRz/mjQmb/Fon7OmlRNeRAdfj1183hlsm430T1sPIDjSCJD0o6ZOxipuWo0XCBmU8mUaG8NN61FVx
	MvCom2Xg8p+bBNay8F0fC+fkItcXlLGoVkm2uLrg7Md/lykNC9nEqlkcYixQVCMOq+CATEpaT4Zgj
	DHeBVqXdsjaYQNVOP9Ojgv12+BSjIrUyAO48pyiQTrSnvqp7D72ok549Y+Gc0WED4BKyYVSl9YyWx
	rM6XAzmdNHB3lUQmoT1dWWmPoMvxTf5y4KYWrXw5O8O4sfdcDnxLGSRTdUgS09fGAhNOkhfJDu+qF
	PDZ9lQhNb0oCqGoUCMgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYWhz-006LRx-1y; Wed, 14 Sep 2022 18:01:59 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oYWhs-006LCh-TC
	for kexec@lists.infradead.org; Wed, 14 Sep 2022 18:01:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id ED1F1CE18FE
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2022 18:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9DAC433D7
	for <kexec@lists.infradead.org>; Wed, 14 Sep 2022 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663178509;
	bh=IaRc+kbMjivZhNvmyVyVqhwHTTU7PnRXsB1LvpQ4Cww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XGPDFpbKDV3XAt7Vn879yC0fY/+0YrQaS4Cgsy3aHHL8qAb1c3izwYcG861CT8zWI
	 VpUEAKanXJZVTW0d9yD6FyJBHizlErC20snhHBCuGuRWm7R2BDuBntpPWEUX6e8LoG
	 uqVJydc7xlCJ5qFFAZSpv+1m4c/CBpUYYIa6krdzaJ5g6d5EGIhzO/iSwZ6KEBbUZV
	 H8C8lIZg08UjzH9AGVuMz5oaFOGcOuIZSMYsVJ2mKhAooBXy0YwCXCmVz8sGOl7f2K
	 Atj1uVj+PFkk0GTbzw0OPOSmOE1aE75oiLvlHL3ZDyySC1hx1EEpdjxLqCNo6dWm0c
	 lRCXpbQlddZlQ==
Received: by mail-vs1-f46.google.com with SMTP id 67so16762822vsv.2
        for <kexec@lists.infradead.org>; Wed, 14 Sep 2022 11:01:49 -0700 (PDT)
X-Gm-Message-State: ACgBeo1G0laMViJpV7PBfJCD6epuc1lDIuOTTkri6wEX81iXIh3fmZ7j
	Hu67HRMaQ8H9Nqw4pno9Zzati+FchcAChij87g==
X-Google-Smtp-Source: AA6agR4wk4fVXgojqfepqtmAKcZuFmARTsF1HTjrVBKEDbldUowx1Yjycvtlq2KIVEkqCjZHz854cskHl7lOJAOW+dU=
X-Received: by 2002:a67:c097:0:b0:390:d097:df91 with SMTP id
 x23-20020a67c097000000b00390d097df91mr11602815vsi.85.1663178508243; Wed, 14
 Sep 2022 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220901214610.768645-1-stefanb@linux.ibm.com> <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
In-Reply-To: <ce08b0af-fb1b-0ade-61ac-f66e95d6eb6a@linux.ibm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 14 Sep 2022 13:01:35 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
Message-ID: <CAL_JsqJ+M6TP9kWXDAUqqh7wfPHkE8YfEU7j5HWqeGMhL=c6bg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] tpm: Preserve TPM measurement log across kexec (ppc64)
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Nayna Jain <nayna@linux.ibm.com>, nasastry@in.ibm.com, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220914_110153_143284_ED4BF12C 
X-CRM114-Status: GOOD (  10.21  )
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

On Mon, Sep 12, 2022 at 8:01 AM Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>
> Hi Rob,
>
>    can you take this series in your tree?

IMO, it should be someone that cares about TPM, kexec, or powerpc.
Yes, there's code in drivers/of/, but that is purely to avoid
duplication of code across powerpc and arm64.

Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
