Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C75C4332F
	for <kexec@archiver.kernel.org>; Mon, 12 Dec 2022 21:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tgMNLIY4YwMNaiVIby4TLlQbwWJfNfZqdi3dpq6K8bg=; b=jjdDdWmENfGAaz
	89VZIh7o45b1xrGsumpNrv22wTRCFtVPdWAb382EFmZWh4hOZEsizBNDSkw2si436l0pfRR8AKTRB
	mvk6FaOldAwpOgw4iYPBf7DeJpxplfczHYHjWtkoEPDhyTNmb43ZZAmIitLJs6s0kr497oOrC9Fj7
	NG++BjUqpMh8jf8fxr9T3UOYWJOCzeGszoCAOfFhBs23JnQpShQZCXOiJ4EbLp3CQd/KZpg76H5NH
	eIZbxNVCUHqVbXrc8EccMK+iyGIzhMZT5k2twmW1YLX6fw/MvcGftGFJztaaQCjX+26fQsHGYsLeC
	IOxYgHO8hLDb6vRp8xZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4qay-006DV8-Hl; Mon, 12 Dec 2022 21:44:20 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4qau-006DU2-TW
	for kexec@lists.infradead.org; Mon, 12 Dec 2022 21:44:18 +0000
Received: by mail-pf1-x431.google.com with SMTP id a14so879512pfa.1
        for <kexec@lists.infradead.org>; Mon, 12 Dec 2022 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+ag/PhyV4lazzaYSTLTzsH3BZMXMT1SW00v66ePL4c=;
        b=hoXlROpzKSmvO37lOPrXW/ff8+sY5+Zu9u0y8qRxtFyMRPcHMtiujUoJEMNmxQMtyx
         5uTPAaNn1u5Hrl56fcYAaiIL9DdecnkOfi9VtUV+9ZWD071hR2fOqfGCRBl8vuvPqagR
         dZ6j0Jl1l4vfokpJAv9vBTaGZVHQQJU3Wp/2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+ag/PhyV4lazzaYSTLTzsH3BZMXMT1SW00v66ePL4c=;
        b=7PIsrWVyOxhZgD3hUASeAqmU51lBTU4+4SRFoPHG9ts/GQVMi/dQWREUJVXlMWMt+J
         sZYEP+2J6WQnzH0fDdVsDOFKS68McvtLwsPTIKZ56tQW8tW4W807Fnh104j2tr6JzfKB
         9+szSGmWj3U1qr3Bag2Dug2iu2j82XYgjG2L5uZZrZwJFvTq8U2K+OeDz6ZPulVhzVGU
         GVL7XBgoTrSMk36bWsQrY7tvvFBkY1Q6+gPRn5lrhtdwjepR3d2aUWY8OGLCnFG2V6SA
         OcXf1atVFPLEAfPrxbhiclyOAX8cMgzB9IcCTkwg8u9k4o+7SRCVJ5fcI19i5b7PDJXS
         yGhQ==
X-Gm-Message-State: ANoB5pnrUnacmHDgxsXLtJQ3jv0CKu8cYV1OXR+uS6VJOXIwHyC1fc4s
	A0Aq+deJpiFZAK/kRttEowhuUnBqVsRHz0bU6I0=
X-Google-Smtp-Source: AA0mqf5kgpSw3bLQogImVaUAfrV/mm61+/hfKkXb6J+cnsQKt4Eg5owMY7UgstosXzzy4FpNu5IABg==
X-Received: by 2002:a05:6a00:188b:b0:576:9eed:61de with SMTP id x11-20020a056a00188b00b005769eed61demr23488065pfh.4.1670881454083;
        Mon, 12 Dec 2022 13:44:14 -0800 (PST)
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com. [209.85.216.48])
        by smtp.gmail.com with ESMTPSA id i30-20020a056a00005e00b0057758798be9sm6267460pfk.155.2022.12.12.13.44.11
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 13:44:11 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id t17so1228118pjo.3
        for <kexec@lists.infradead.org>; Mon, 12 Dec 2022 13:44:11 -0800 (PST)
X-Received: by 2002:a17:90a:644f:b0:219:8132:70db with SMTP id
 y15-20020a17090a644f00b00219813270dbmr61283pjm.183.1670881450434; Mon, 12 Dec
 2022 13:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org>
 <20221114-disable-kexec-reset-v1-2-fb51d20cf871@chromium.org>
 <20221117160650.16e06b37@rotkaeppchen> <CANiDSCvyQ66mXbhEgj_qnE_zR4frsxtu1bXaukDrEG0FjrE4yw@mail.gmail.com>
 <20221121150948.6f7c1f1f@rotkaeppchen> <CANiDSCtqYykAjRinx9r4O+DxdTBA=OQSjF8URmM6X54nN7pDUA@mail.gmail.com>
 <20221124124000.5af23cad@rotkaeppchen> <CANiDSCvO+6TrM900Z_Jr4QL=c1uHS21deto7cU9W4mr7KimhJQ@mail.gmail.com>
 <20221124160115.23ae7928@rotkaeppchen> <20221128114200.72b3e2fe@gandalf.local.home>
 <20221129144450.75a7181e@rotkaeppchen> <20221129093245.599903e7@gandalf.local.home>
In-Reply-To: <20221129093245.599903e7@gandalf.local.home>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 12 Dec 2022 22:43:59 +0100
X-Gmail-Original-Message-ID: <CANiDSCs6jyNBiO+wO-MHB3qv5am0mmGbv7y4eHv1PSLQh5EPTA@mail.gmail.com>
Message-ID: <CANiDSCs6jyNBiO+wO-MHB3qv5am0mmGbv7y4eHv1PSLQh5EPTA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kexec: Introduce kexec_reboot_disabled
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Philipp Rudo <prudo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
	Jonathan Corbet <corbet@lwn.net>, Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, Ross Zwisler <zwisler@kernel.org>, linux-doc@vger.kernel.org, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_134417_012157_472D2A7D 
X-CRM114-Status: GOOD (  16.28  )
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

Hi Philipp

On Tue, 29 Nov 2022 at 15:32, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 29 Nov 2022 14:44:50 +0100
> Philipp Rudo <prudo@redhat.com> wrote:
>
> > An alternative approach and sort of compromise I see is to convert
> > kexec_load_disabled from a simple on/off switch to a counter on how
> > often a kexec load can be made (in practice a tristate on/off/one-shot
> > should be sufficient). Ideally the reboot and panic path will
> > have separate counters. With that you could for example use
> > kexec_load_limit.reboot=0 and kexec_load_limit.panic=1 to disable the
> > load of images for reboot while still allow to load a crash kernel
> > once. With this you have the flexibility you need while also preventing
> > a race where an attacker overwrites your crash kernel before you can
> > toggle the switch. What do you think?
>
> I actually like this idea :-)

In case you missed it.  I sent an initial implementation of this at
https://lore.kernel.org/lkml/20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org/

Regards!

>
> -- Steve



-- 
Ricardo Ribalda

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
