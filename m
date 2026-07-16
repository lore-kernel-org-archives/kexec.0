Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B575AC44515
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 14:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Hq7mqdQ2orEVSVK+XIkt+n7imo/sMvdXL9WaKcDjY4=; b=AQVpYSBt7H8ss7LTeDL3TQHr9a
	gaG87AKEFQQuZZ4rVyeaA/3VFw6HHIO8WwStC/EgY1gUwPQsd4qX0JSDV063SAxJyaGzTqqBWggrl
	G4IGtG1jgEpkDMAU1Fz0Le0879A2GUpEdLFuTIVkHZhUqmr/N8Kw+wnaMbTrsy8EXuqQvC266+bDI
	j3FoTIyVS2nrhfpsFbHrVmoaLFNRXQ9Nbg2Qn+pXAZINQH3SVE5lHC7Qh+7PW+ENd+Pkp2KcCtcnJ
	yMY0pYayIZfbE53zZ7yEwnFXrgid0H+cFbQf8QIbIVtxZP6riCZnX4U8Kg6j6vWp4PfxXBd2jB4WW
	8xtibAYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNGO-0000000HWOU-01zk;
	Thu, 16 Jul 2026 14:40:36 +0000
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkNGM-0000000HWNU-037Y
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 14:40:35 +0000
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-81e69a2db34so7936587b3.0
        for <kexec@lists.infradead.org>; Thu, 16 Jul 2026 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1784212832; x=1784817632; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9Hq7mqdQ2orEVSVK+XIkt+n7imo/sMvdXL9WaKcDjY4=;
        b=VHHTnbSAQxd93tP/bc9Rk6i+sdqLxdKkU0DNN4d+WSMefR/V8fDrpfNg6+tbW7Q2GO
         GPnNPLOMpW5IwaduoPsoEHUt0waL8FHicLLS3w0iceOKS20Y0P/liSRtd3k2r0TWQaB9
         guaE50mWOogTsBD/kcZRRroJdHK/JXKp1BWcTWQHqdUM/vv6YtkxQ0JI548OACH8KPrQ
         4yaqcE5Mqjk3ElJJAsw1yx+L956ARyp8E70enh7FZ6wTILFPGjA274+dviWOExLnVLoo
         JIkYSLOizF8xIPlYHscdnye8qskhkzSj3valx5pmq5oR0XdsfWpGvoKXNDsx77B8h2Gv
         23sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212832; x=1784817632;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9Hq7mqdQ2orEVSVK+XIkt+n7imo/sMvdXL9WaKcDjY4=;
        b=Om/E4RynQ7jo+QDxlrNEczyQU4DxZtOhxrCPnsEbf0+hM+bgPFzI6mG1VlmNr2CX24
         UqWtW/E0tOwJKozklrswASA99A8p/280rPJ2gnRxcugviBW6iYb+LVU2Zi3BP4Yme084
         g2bzbf69C2Zy/CLSydQyKjBzHTs7h4CL8FOg6/2go0TlG/M+BoVtYRyRWkNnj4yZARaC
         TwPr2imtW83LIHpFbTU2DWTZIFQazfW8179qUs8iVFDhNB3jpdBiFSN2Uofhwt2mSq0t
         zjdTobAy5WdFrgg9VLLpXNgWNFofXziQI/AvoFMbayidJqZhPy55AHTPKHEmmGFLZu3H
         lyvA==
X-Forwarded-Encrypted: i=1; AHgh+RqvGgZH27tkp0fAtjhhXDyAW/MUaXx2439l/RLi86wUxsHUfNp+1Wu4lnmN6zOq0SpuXaDxRw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzM6sJXfFvt6V3qjzyatGNNG4BDqabGdvP/1efnjk3YOX6awvBY
	J72gFkpQPujsl0gov436aRSmUfFZ/q1KJLCJW4QTBmkiEIEE8MsEZ3YQ5aOCSzaQDwQ=
X-Gm-Gg: AfdE7cnUefTy14Y6RYxjFimlluJHSi/xPUCiLV7ewH5MLRTrBSOqWl5lRzTO8HPY9Yz
	dUv8Sdy6g4cVXouXuhXBS8yPOKd04tcdHxI9UK2pl2nruGqu81bVBZr0NePR8wrwOg9gEbQjmCS
	cVJrt6C3Vi48ZmsUFIvb/q2e0lb99Kxf0xEcruXwJ+UBBKFju+wsShcwdvyk8lnnkbbNHbgRyPw
	3tPvjUmVxEuNxF3aSG0ynNiyDGSytVQ+fdiOs9wcoZLgC/lkY9msPDACWEk1X/WFjTZ6AN64V4M
	lEgViNTUS28u/Kmy0wjnN7ybn9hb5lNU1GCLcUMkYhZI0vt3YA33Xxlwy7/QulSj39zKAxsOpz4
	m2PKBHs792rBJ9PIJhg1ATrzKjl1jik5zd2ABYB7wq1QYz/itWl8JiyGGWImDJUiTqjCdBx2QT4
	J2jTm8TQbsqu/w2qZauuXRSM0atIFc6CWG8wYtXv2r4NIwY1bhqykEdM+BqF1OMFKFjyQyRMKVW
	iqcCHC1yWluJutYsXJdm58=
X-Received: by 2002:a05:690c:4b13:b0:81d:6eec:fe22 with SMTP id 00721157ae682-81ecfa0f945mr56355607b3.44.1784212831974;
        Thu, 16 Jul 2026 07:40:31 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ec99280e3sm58348947b3.12.2026.07.16.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:40:31 -0700 (PDT)
Date: Thu, 16 Jul 2026 10:40:30 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <shuah@kernel.org>, luca.boccassi@gmail.com
Subject: Re: [RFC PATCH] liveupdate: Allow multiple openers for
 /dev/liveupdate
Message-ID: <aljtXsr6xvI6FAmA@google.com>
References: <20260714190356.190328-1-dmatlack@google.com>
 <2vxzy0fcicpi.fsf@kernel.org>
 <20260715172336.GC3775915@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715172336.GC3775915@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_074034_073514_63ED1CFA 
X-CRM114-Status: GOOD (  28.37  )
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

On 07-15 14:23, Jason Gunthorpe wrote:
> On Wed, Jul 15, 2026 at 03:50:33PM +0200, Pratyush Yadav wrote:
> > Hi David,
> > 
> > On Tue, Jul 14 2026, David Matlack wrote:
> > 
> > > Remove the single-opener restriction for /dev/liveupdate by removing the
> > > atomic in_use tracking and the exclusive open check in luo_open() that
> > > returned -EBUSY. Protect luo_session_deserialize() with a mutex guard so
> > > that concurrent open attempts by multiple processes safely executes
> > > deserialization only once. Update liveupdate selftest to verify that
> > > multiple concurrent openers succeed.
> > >
> > > LUO does not inherently require a single opener. There is some
> > > documentation about it simplifying state management, but the only thing
> > > it actually protects is the session deserialization during first open,
> > > which can be easily handled with a mutex.
> > >
> > > Relaxing the single-opener requirement avoids the kernel forcing a
> > > design pattern on userspace that it itself does not require, e.g.
> > > allowing multiple userspace processes to create and manage sessions.
> > 
> > Agreed. When the kernel had a global state machine in the early versions
> > of LUO, this might have been more relevant. With sessions, even if we
> > later add a state machine, it likely will be per-session instead of
> > being global. So I think letting userspace open /dev/liveupdate multiple
> > times makes a lot of sense.
> > 
> > Also, today's systemd only supports preserving individual files, and
> > does not hand out sessions. To get sessions, userspace must open

It should in the future, because of permissions issue, see below.

> > /dev/liveupdate and create a session. This opens up room for one bad
> > process to block every other process from creating sessions. It also
> > imposes a need for userspace to add a polling/retry logic for getting
> > sessions and serializes their execution around this point.
> 
> Shouldn't systemd open and own /dev/liveupdate? That was at least what
> I originally expected here, you'd talk to it and get a session FD
> through dbus.
> 
> Moving to multi-opening /dev/liveupdate and removing visibility of
> what sessions are open from systemd is a different model
> 
> Not saying this patch is wrong or anything, but that I don't really
> understand what kind of model you are going for now.

CC Luca for systemd's take.

/dev/liveupdate should only be accessed by a privileged process, and 
sessions should be accessed by whoever originally created them. While 
this patch does not change the permissions, it paves the road for us to 
move in the wrong direction: instead of having a privileged userspace 
manager that distributes the sessions to their rightful owners, it 
encourages userspace to work around the permissions so that VMMs access 
/dev/liveupdate to retrieve or store their sessions directly. This would 
also allow them to access sessions belonging to any other participant of 
the live update.

Instead, sessions should be created and retrieved by a privileged 
process that knows to send them back to their rightful owner after 
retrieval.

Also, as a minor concern, each userspace LUO manager needs its own 
session to maintain state. This means that by allowing multiple 
managers, they may run into naming conflicts for those state sessions.

Pasha

> 
> Jason

