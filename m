Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAEEEB64DE
	for <kexec@archiver.kernel.org>; Sun,  8 Sep 2024 19:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yym1dr/VmcHr0pbPN+YTJ26uMMCl/1iOzAK0rNlsRnc=; b=VUttByB87HAGuq
	kfa1SnzIJ+ZV5pgS1oDYJv+gur6TRoZVr5yKFAX/pGWQh3dHdx0iJt5FR+T7Ni17YVRpwTnRozbVB
	Ei4wQB5Lvp05YIgqQrNQYMhVT+uzXk4V6jdJzK7AF6ZaLZ24C2GMO0WLwyqDWKlGWFWrHgsDSECzY
	O3QTGzZeSg2JY/JV+WA7BiGKn6LP/2bWas3Dn0poNePw1FJVYnxo8jDpwHCwFQvTnYRYxXW77FNHQ
	MmEcGwlq61tqq0kN8Ub4hZdMP+x+tt7nGwy+8u2vZmDHm6DU3WIuLwtSwffMmei11axR/LxLk2fV7
	76YLfXzBtPWsvLZLj/Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snO2r-0000000HNEj-1qlY;
	Sun, 08 Sep 2024 19:58:01 +0000
Received: from mail-yb1-f182.google.com ([209.85.219.182])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snO2m-0000000HNEA-3xIw
	for kexec@lists.infradead.org;
	Sun, 08 Sep 2024 19:57:58 +0000
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e1a7d43a226so3975892276.3
        for <kexec@lists.infradead.org>; Sun, 08 Sep 2024 12:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725825475; x=1726430275;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6iRQ4ycMPuueLuQbrmkO5BYrgQaV5z5SVussbCyOKoM=;
        b=XDl2HH4UQ/bvZOnKgExn4NEH8o4qJiBIMqFBQPhyQSTUhRALUrXmyQi8ZJdNiFebAy
         9LCTRNJhLFomsEC8TY5d9Yk33JseDUOa27pgywDfXegqymDfS+2dkE8XTaR9y8XdTA4/
         jdkyDzf3+bR4Q7udFS/OHRzo72NohOPnyEoKdTYPLAOyX7aSL4R5ACnVNnOge+QAvqWh
         xknxmCTIN6jtUWoTMst3+xiYpGod6g342zyrDioap/xo2B1n9aytdHMtqH+eo/smcRe5
         Ol5qw/wBoafpjA6MYnVQ4yH5p3lGUgt1X8q2+1knzaiOsuQZ+OCWFCnIq+5op+s42hIf
         906w==
X-Forwarded-Encrypted: i=1; AJvYcCUIgARAREDZUWbpJqKUIYRvYcmlC1oYvBXfwDrQXujssNuiXeyF/I7arWgTIB9ChaUwX8fZ0Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxyMWpyhrCBg2wdyrkARlvYYlEBLz2sSbxVcq5KWVCIjLoV5lge
	ViBs8NxaOxxFrbxiar8lf/+CkPrwxjb889RB/JJzptXEoC63bIEG
X-Google-Smtp-Source: AGHT+IHbDiMdtH2pqnAbxLEMjAlHcuY4ygwDQW8Q8ews50/boV7RDQlibc4OTUwRVZ+TyW4cporrAg==
X-Received: by 2002:a25:cece:0:b0:e1d:436c:3b4f with SMTP id 3f1490d57ef6-e1d436c3bd7mr5094797276.50.1725825474790;
        Sun, 08 Sep 2024 12:57:54 -0700 (PDT)
Received: from [192.168.2.254] ([70.24.204.168])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e7723asm14597531cf.22.2024.09.08.12.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 12:57:54 -0700 (PDT)
Message-ID: <c04fe24a-26e6-44b5-a2dd-00eac589e36b@vasilevsky.ca>
Date: Sun, 8 Sep 2024 15:57:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crash: Default to CRASH_DUMP=n when support for it is
 unlikely
To: glaubitz@physik.fu-berlin.de, bhe@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, mpe@ellerman.id.au,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Reimar_D=C3=B6ffinger?= <Reimar.Doeffinger@gmx.de>
References: <20240823125156.104775-1-dave@vasilevsky.ca>
Content-Language: en-US
From: Dave Vasilevsky <dave@vasilevsky.ca>
In-Reply-To: <20240823125156.104775-1-dave@vasilevsky.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_125757_014223_BE66B333 
X-CRM114-Status: UNSURE (   6.36  )
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

I received a notification from Patchwork that my patch is now in the state "Handled Elsewhere".[0] Does that mean someone merged it somewhere? Or that I should be using a different mailing list? Or something else?

I'd appreciate some guidance.

Thanks,
Dave


[0] http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20240823125156.104775-1-dave@vasilevsky.ca/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
