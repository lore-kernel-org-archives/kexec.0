Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0C5ECAAD5
	for <kexec@archiver.kernel.org>; Wed, 31 Aug 2022 01:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rW58JTRUQ77XW+iTR3AtQLYPyOh7yal4LbSV2Gnbc3M=; b=S2Y08kuaYwe68L
	esB2YyCH/G0TdTNEDcbEoZlch/xKWeLbXW2nKZflrULT5GyYdMcvTRbRxMtIFKjsrDdulkmYJbmzR
	5uSMUBT/i4gXvMRBQZr9fu6nmgz4Mr3D9Lw7qadOgOvQ6n8XbDqhzVxNYoQHh6duOHjGsihzJd2X+
	/ZtEjTFQ4jqeFckxlfpLqfgVbeV514c9qR4ek/0EE6OTXyq+SsQdbTzVfksvS6hATza93BPDFQjX1
	ODLqgzA+VcMisC1fW9HrtlMa7xFBIXog2ljr3eNpgsp1mt9VTLYsZ5Yfm3XWKSAr1qnBW1Q3jgMeV
	Z5y4QOIO53NXkglmVHCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCaO-0031Hq-Lx; Wed, 31 Aug 2022 01:32:08 +0000
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTCaC-00318M-BA; Wed, 31 Aug 2022 01:31:57 +0000
Received: by mail-yb1-xb2e.google.com with SMTP id g5so2110228ybg.11;
        Tue, 30 Aug 2022 18:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=RCIdrG6LDAedhSE42XN+4y6hSNrTwRm5e11e8nEVmVw=;
        b=o/DzT/t1E+SKAXpwyeV62gGY8v+nnAOI+imh6LKznUbwYgPJnZ7usmfUjF56ADeMFT
         UQCovwXYvmvjoi1XoqjRR4Y1Uy2KrliU01AyXFnOGRcvqBpR8eKHhPBFEbiQV2uu+yCG
         6RO2up7zaOjrCd6NyQ7cI4MVXuTtaBjveGzeZ3sKROO1HWBmxO9Z0Qwqfv2Oi1RhoJlk
         PH2a9qhdxZe7IbSfkbCkKy2L7d8m+ESqYgjuaYP+FFHSOgOE6JVdK8q1xKETfb3G0EXh
         MOFvFtnUuT3ZGO/UadQlGRTuyZErvIIKcugSaJSMoHl4mSgfvSrQOex1rIt34YDxqT0u
         +xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=RCIdrG6LDAedhSE42XN+4y6hSNrTwRm5e11e8nEVmVw=;
        b=rBeJn4O38rczEQGqR7e+e6+XARIXUwiQX1rt062TyxbV5oGQYob3YiPsPmhGG2h/83
         oyR3JCpxRIsgp1g7Rh3ATi1/xGlcFe2AxI4VFD56jEjv6QxUJESCDnhA2t1Pd66Gqv9K
         1v+LPJbYCb3d3iJ2PtnM0IivtV4fwb4ULAK/hHVQORZoHFEKJ0wGeAdWpyQ0Q+Xxf9/w
         PyGVteHZ3VtPWrsgcDNstL31UkqjJhzdJBTTBP0KBmuuFW8xU0zO+8HSleZG4NAsuaI/
         6ojcuaWfSguDYcNl2uzQsodIOT/slIfblId/eHPkQ6zXYgdG/UiYC1yVy9B+51E2tbHi
         pLGQ==
X-Gm-Message-State: ACgBeo05qI/izfbXQ/WuWoMfGfpHkCXdEFtnHw8nED242RXvaOz/dD6v
	F/VgajZw21Pq76RT/QohjCHybD+2mm1FbyB+SxPSMmc1sHc=
X-Google-Smtp-Source: AA6agR5tfdxpD7NSTdOmGADKdDM2vXuDkbEF19oNMZAG+sN77hZcjLzupSv0Pb2cpPirHqDLwx2TwxtzqIqJj+fLtwI=
X-Received: by 2002:a25:24b:0:b0:696:4e87:7cec with SMTP id
 72-20020a25024b000000b006964e877cecmr13659265ybc.202.1661909514331; Tue, 30
 Aug 2022 18:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAM7-yPTdihLsPjDKM-0OEszxNd8n0bgeRseiEkCsSZW-uuaRvw@mail.gmail.com>
 <20220830092839.3197-1-ppbuk5246@gmail.com> <Yw49m7Hpq+NIZYWw@arm.com>
 <CAM7-yPQjjwM_fCgojYHbrhE4GFCX22VLoCiTVkorNG6hQDj9EQ@mail.gmail.com> <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
In-Reply-To: <Yw62//C+LmH+BcEh@MiWiFi-R3L-srv>
From: Yun Levi <ppbuk5246@gmail.com>
Date: Wed, 31 Aug 2022 10:31:42 +0900
Message-ID: <CAM7-yPRKC8hGSoSe34+RbCuRDdv88QsFzD=VznM2v9yu0YZMWA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64/kexec: Fix missing extra range for crashkres_low.
To: Baoquan He <bhe@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, nramas@linux.microsoft.com, 
	thunder.leizhen@huawei.com, linux-arm-kernel@lists.infradead.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_183156_415294_E2CC23C7 
X-CRM114-Status: UNSURE (   8.84  )
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

> No, I don't think the Fixes commit is right. It should fix the commit
> where crashkernel,low is introduced. Before that, no issue caused.
> So the tags should be:
>
> Fixes: 944a45abfabc ("arm64: kdump: Reimplement crashkernel=X")
> Cc: stable@vger.kernel.org

Thanks! I'will resend the patch with fixed commit message and the tags
including Fixes, Cc, Review-By and Acked-by.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
