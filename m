Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473A0C25B78
	for <kexec@archiver.kernel.org>; Thu, 23 May 2024 02:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zg4c6sqfuGNcPrkya9gY1N1jAjsetaw36g1/mdNG8VY=; b=sjs3k9fJUGIQXJ
	SlvkDpTeh4EEfugMLCviFBNzE9WivX25nfN0lQs5VE3ZuNuLJ+gpsg5bKDXgZeaDrXY8lm8vzqiIC
	4//lb9i5SYlK7XYD1wO6KQVxbp57k7h7Qd3MF1z1mQIi4xb87C+m0uHlolpxMXhjKJJMpMJPyG6n2
	RCwI7hOWz7W0adaXGcdwo/II4Mw/ngxuMSO/HgWQ/sif805KIday8C3uDfQbhYGu7NEda7qfBWVpY
	lOzFlZql0KsnBgZMt5oaPZNk5CCBqd5C/bd5TkYDJ+inK6YMjgyqT8cHuAsXQQTK6hZXyQO4yvyEy
	niY1aCFA/bGVqSJiTrzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9yb0-00000004pgN-3Feh;
	Thu, 23 May 2024 02:54:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9yau-00000004pfF-1PhA
	for kexec@lists.infradead.org;
	Thu, 23 May 2024 02:54:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716432855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u7PAynGSneULEGsZEeUTDx10vqiJthWdZNRrBnIUivM=;
	b=eNjISuj9FmFbmLR00qRgQ/RzEJgw4r2Qt7Tcw7goUgAK5Dno6Yekhi3YROn2zACpE5P8Z2
	x3Y1hyDv4PEMTmZ4vbQK712hCBqDNXP8okqLBKuWIyrxcU6x+khuEZKp9VK0cbG6zygk49
	LPwmyDQGFdkyqmE3qt4Yb5bgrEglQsM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-cmm7GbiTP96Js0rRQawRIQ-1; Wed, 22 May 2024 22:54:13 -0400
X-MC-Unique: cmm7GbiTP96Js0rRQawRIQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c854ced78so4011345ab.3
        for <kexec@lists.infradead.org>; Wed, 22 May 2024 19:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716432853; x=1717037653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7PAynGSneULEGsZEeUTDx10vqiJthWdZNRrBnIUivM=;
        b=ZhcxlvlwXlL5Gcc5k34608WYu+zKFUWEhtFrmgONxDfZ0J1sIzZ2j0WnS9R/sLpmrp
         yyet4PGHjgVbGTrmxnrreJu0MH2AqXJsI6b4kRkixec7J7dagpwQmP4EznlD8i1Rr3I1
         9vVZqPX5GV3JZBoHwgXzSEv6CdwVBl4nzOSlA6iOg1TVjSUPooYa025RTh+MffX8I/rW
         7lIFhDhKlo5OLf8drx35tlJz0NZpKlUOxmotweLypWVm77P4pEOc+L0BdnQN1+bGQWF/
         tyLssTWxRoCmePLAQTvTBY6mKO4Sx83AgBkQ1aLbOXk8AbuhrL+YmwvVFXEf96ZpnJfN
         lqPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV14JAMBo4sBRs4i5LQ4bBbmuWKDxH7qMPrGtH7gHmPjQ/EZGN4wK2YpqHrP21d4BR0h+K3TPePWhu3wwyJ3RW2dDzRkv5BOEy4
X-Gm-Message-State: AOJu0YxV8Wew3kpB1vaz9bu7m//ioup3s0KotEXr6tFRqb/A2gl8GzJL
	g2XXh9SK3w69TtGEHf1QhoYbXCMqNz6DkFWShlsf/eliszmA5zzZeX/vmMPjkPWqbTSFjIHs+3q
	qibQoVWQ5YNSIalN4HO06kXyeic9Kx0RX6D/34MYL3JkvJ67udt3Wqnz4yWxYrglvBLM5hssw+S
	dmp602EPxCiSXDCYjWXC2NY7jDIu6Z21bu
X-Received: by 2002:a05:6e02:1447:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-371f92ff411mr48838615ab.3.1716432852947;
        Wed, 22 May 2024 19:54:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoUKoGiEr3/sh0h7NFbA0eRmtxogyNERfkCpDAdV/NZDOzIG/XLDnnztL7o7uIwbdWdpTl7hmrnVgYmwuDbbI=
X-Received: by 2002:a05:6e02:1447:b0:36c:3856:4386 with SMTP id
 e9e14a558f8ab-371f92ff411mr48838235ab.3.1716432852467; Wed, 22 May 2024
 19:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240520183633.1457687-1-steve.wahl@hpe.com> <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
In-Reply-To: <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 23 May 2024 10:54:33 +0800
Message-ID: <CALu+AoR_OZbrrVWL_2EbDB-ctSR28+006q+nHhwgZ55QhK0qSw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, 
	Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>, 
	Simon Horman <horms@verge.net.au>, Eric Biederman <ebiederm@xmission.com>, Sarah Brofeldt <srhb@dbc.dk>, 
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>, Tao Liu <ltao@redhat.com>, 
	kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_195416_796297_06E8989A 
X-CRM114-Status: GOOD (  41.78  )
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

Cc kexec list as well.

On Thu, 23 May 2024 at 10:52, Dave Young <dyoung@redhat.com> wrote:
>
> Add Tao in the cc list.
>
> On Tue, 21 May 2024 at 02:37, Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > Although there was a previous fix to avoid early kernel access to the
> > EFI config table on Intel systems, the problem can still exist on AMD
> > systems that support SEV (Secure Encrypted Virtualization).  The
> > command line option "nogbpages" brings this bug to the surface.  And
> > this is what caused the regression with my earlier patch that
> > attempted to reduce the use of gbpages.  This patch series fixes that
> > problem and restores my earlier patch.
> >
> > The following 2 commits caused the EFI config table, and the CC_BLOB
> > entry in that table, to be accessed when enabling SEV at kernel
> > startup.
> >
> >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> >                           earlier during boot")
> >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> >                           detection/setup")
> >
> > These accesses happen before the new kernel establishes its own
> > identity map, and before establishing a routine to handle page faults.
> > But the areas referenced are not explicitly added to the kexec
> > identity map.
> >
> > This goes unnoticed when these areas happen to be placed close enough
> > to others areas that are explicitly added to the identity map, but
> > that is not always the case.
> >
> > Under certain conditions, for example Intel Atom processors that don't
> > support 1GB pages, it was found that these areas don't end up mapped,
> > and the SEV initialization code causes an unrecoverable page fault,
> > and the kexec fails.
> >
> > Tau Liu had offered a patch to put the config table into the kexec
> > identity map to avoid this problem:
> >
> > https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
> >
> > But the community chose instead to avoid referencing this memory on
> > non-AMD systems where the problem was reported.
> >
> >     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
> >                           on non-AMD hardware")
> >
> > I later wanted to make a different change to kexec identity map
> > creation, and had this patch accepted:
> >
> >     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> >
> > but it quickly needed to be reverted because of problems on AMD systems.
> >
> > The reported regression problems on AMD systems were due to the above
> > mentioned references to the EFI config table.  In fact, on the same
> > systems, the "nogbpages" command line option breaks kexec as well.
> >
> > So I resubmit Tau Liu's original patch that maps the EFI config
> > table, add an additional patch by me that ensures that the CC blob is
> > also mapped (if present), and also resubmit my earlier patch to use
> > gpbages only when a full GB of space is requested to be mapped.
> >
> > I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> > two different kernel versions can be in play, and the earlier fix
> > still covers non-AMD systems when the kexec'd-from kernel doesn't have
> > these patches applied.
> >
> > All three of the people who reported regression with my earlier patch
> > have retested with this patch series and found it to work where my
> > single patch previously did not.  With current kernels, all fail to
> > kexec when "nogbpages" is on the command line, but all succeed with
> > "nogbpages" after the series is applied.
> >
> > Tao Liu (1):
> >   x86/kexec: Add EFI config table identity mapping for kexec kernel
> >
> > Steve Wahl (2):
> >   x86/kexec: Add EFI Confidential Computing blob to kexec identity
> >     mapping.
> >   x86/mm/ident_map: Use gbpages only where full GB page should be
> >     mapped.
> >
> >  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
> >  arch/x86/mm/ident_map.c            | 23 +++++++--
> >  2 files changed, 95 insertions(+), 10 deletions(-)
> >
> > --
> > 2.26.2
> >


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
