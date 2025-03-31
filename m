Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E75AC28B20
	for <kexec@archiver.kernel.org>; Mon, 31 Mar 2025 03:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJYht588chhOshnh/oM01PQlP9cicgLlbkkCnh6ie10=; b=JPVbhsoJ4NqSDqVYMwWrgHnuTA
	gSF7hX6iRHsrNamSEBruzTXScIjWeU7EBaaTW3NZj4aTZ/B3DJYzrmuf8XPFLeVyQ2BuobGhWHRKh
	0avXhaecmg+7AE1GhHJ6OlRLw6RcinCcx81nFUz5d7oTsdl6WUIQ4YoP9IMYDryw5E/3EOIMFq6xR
	1ScoI2xa3AFG3oSzBtobm1y+J3OReSBp07LeGdVhrrVVtdzkkiTD5MZIRlYlqdR6S2VVby1mVQYgv
	qwIhpkgRAjiJnTwGAgq5hsLEicJASl4jyDPXajSwWuWXRbfikxBTA8q6ZAIjWLWUNaWaX1yaheQQW
	dP3j2Z5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz5jT-0000000GxTW-0Gig;
	Mon, 31 Mar 2025 03:22:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz5jM-0000000GxTD-3ZH4
	for kexec@lists.infradead.org;
	Mon, 31 Mar 2025 03:22:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743391350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DJYht588chhOshnh/oM01PQlP9cicgLlbkkCnh6ie10=;
	b=JEwFdcXb4BArWGTfnD66tLS2NLniPug8c+GfVlIKCyX0Pyal/Ej5qMxiy246hnHuwrifTc
	5NSJBFshaxssi3LlV4mGg66NuA3LDzdmgFAVioTdEaD04rCeXW+TG8mrevPovsJx/Cj5/7
	xVqQnvPjQNfNmQiOZX2kOH9hFrrnPLI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-4vzbJAtIPyeDb-LdSrZLkw-1; Sun, 30 Mar 2025 23:22:28 -0400
X-MC-Unique: 4vzbJAtIPyeDb-LdSrZLkw-1
X-Mimecast-MFC-AGG-ID: 4vzbJAtIPyeDb-LdSrZLkw_1743391348
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d5d6c997d2so25336855ab.0
        for <kexec@lists.infradead.org>; Sun, 30 Mar 2025 20:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743391348; x=1743996148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJYht588chhOshnh/oM01PQlP9cicgLlbkkCnh6ie10=;
        b=Eea86qbvKYBSwnYmAmycqrhDSgiyRJwq8qT85LHb/luM9YXU/7YxhShxJWGBKvmKuN
         HTXfDIKqLC92KwcZJmOCmIJqKEZu/y+svCsWq0ggso7SSKBoh3uNc5COCgX+ZWbITKBn
         5ZFBPPudVd3op0iaCC0/rG0b6TT0s9vrCc2WvtbQu/9HjZGxTEae9EwOYO3GakI09sMJ
         gE97+qQx1duRDg7L//fEFYa06A5dnl9zo0MWx4dsuNQFBIAtygjHuKgi41I17gyHb148
         QB6iIVXb/JFmklGxCeaCtaZMT+mQsqlKKHkT5vbBUcY0Ou/xEAgtqWC8aKY0ktnS2kvE
         p7mw==
X-Forwarded-Encrypted: i=1; AJvYcCU/HBcxXVX4bh7gVLN0bRrjQXdeItYjndisGpYlGh40QUYqyQt+xMTyOSmohdWWbhubpuN0tw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzcNsphR1/ZUveJJQTiI6k5lezpFgYOmhSJadC42VKbAqJQz0UB
	DSCnAUbFs8s7jpRiHSp2c5T1yQejppGwX9CbNUpKyIz5v4Nd0dX3aLFQUsMoicLyVjFz/0+SgQJ
	l5dYTOt82ketXJ9aquiKOXnNaMoYz0UfD7SQXu4U2I3shnfmis0Q2FXi32aAXu2UGAGMRrYYoJX
	lnZNP9wdS7c9FbNfAb873ceRYrF9f/LT41
X-Gm-Gg: ASbGncsnuTZmmDV7kiD2axWxZVOkNtfrHjFjHxL9rmyqkWaz7s3x9GE2nl722c8cLBx
	HMFSXZWHYctNH0X01+g5GLp+lbFwEZLKcchKGgj2VItiUBSp1sHBXcB2ZOU69U7mAA7+rPDXI9A
	==
X-Received: by 2002:a05:6e02:17ce:b0:3a7:820c:180a with SMTP id e9e14a558f8ab-3d5e0a093b2mr79160995ab.19.1743391347967;
        Sun, 30 Mar 2025 20:22:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzaH25Vzm7n70KpLV36fle/W5sj7NSSdA8hJmo754X2wtwvaPhuyZSC58LigxxsFYAU0bQlbQf86JZovKBAVI=
X-Received: by 2002:a05:6e02:17ce:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3d5e0a093b2mr79160885ab.19.1743391347656; Sun, 30 Mar 2025
 20:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <Z4WFjBVHpndct7br@desktop0a> <Z5bx7ZHNcyc5fM_L@darkstar.users.ipa.redhat.com>
 <CALu+AoSSKh=5ELgQyzDrGEDm5fm2XKteH1ZC70mm89pNSSPMHw@mail.gmail.com>
 <Z-c7V2hptt9U9UCl@desktop0a> <Z+dQZozsbdls6yqJ@MiWiFi-R3L-srv> <Z-hYWc9LtBU1Yhtg@desktop0a>
In-Reply-To: <Z-hYWc9LtBU1Yhtg@desktop0a>
From: Dave Young <dyoung@redhat.com>
Date: Mon, 31 Mar 2025 11:22:50 +0800
X-Gm-Features: AQ5f1Jq_A3xmC-EmSPquFgYtTSaWdlNOr-d-et357PEEYRDXHWaZEck-6AeRlpk
Message-ID: <CALu+AoTrPZS7ukuLsCTCwKNKVd8=PUN8nXwh9BdicyV-==-W=g@mail.gmail.com>
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
To: Roberto Ricci <io@r-ricci.it>
Cc: Baoquan He <bhe@redhat.com>, ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz, 
	ytcoode@gmail.com, kexec@lists.infradead.org, linux-pm@vger.kernel.org, 
	akpm@linux-foundation.org, regressions@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: seaJ7tH9tbo_PfqlPhfquioU80GCkmy8c1sZpvqoxWs_1743391348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250330_202232_963579_E07E2FDD 
X-CRM114-Status: UNSURE (   7.86  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

> With v4.9.337, kexec (via kexec_load) + hibernation works.
> With v5.4.291 it doesn't.
> I'm not sure how bisection could be done in this case.
>

Not confident, but maybe you can try latest mainline kernel see if the
below commit helps:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2498e5c453b3d8d054d77751487cd593332f8c2

I noticed the e820 export is different for v4.9.337 and v5.4.291

Thanks
Dave


