Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96227C44520
	for <kexec@archiver.kernel.org>; Mon, 20 Jul 2026 17:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fcxOfDsXTcakJrNFPmSVKWlmd6kcWw4ERDrOVBmABaQ=; b=HM6IjKno601HZ/CKZ0B8lZYMck
	Jwic5FL7jHQYRvEABWDdSZJXnNqvKtQrSUX9YYjsPlJ9XfvdUAzdPU2Al5hajPwdKLZ6H0d7imtCl
	GLCY/g+zqx/XXeR04Ucobln0R2glw4mOHqj5pS/rthciSd9JiIPPdUSkUDB7UKEUaXUEr52UYzUjk
	p+0ox6o4ec8DVHjsRJtZFozIzRHQ6KuZOQgNVOuFVH/hd+z/if9O6KI633NPL1nEX3uEA8E1h50oi
	Fl+KZzpovWZB3Z8IfYI+meYHjteYf7KnTWvRE47KZykjLXAg0gTIUlwXSF2qv2eiWY4n/S7rGzP4l
	wT0ZWoHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlruB-00000007YRV-2nXR;
	Mon, 20 Jul 2026 17:35:51 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlru7-00000007YPb-1eBK
	for kexec@lists.infradead.org;
	Mon, 20 Jul 2026 17:35:49 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2cf420670bbso3478325ad.1
        for <kexec@lists.infradead.org>; Mon, 20 Jul 2026 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20251104.gappssmtp.com; s=20251104; t=1784568946; x=1785173746; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fcxOfDsXTcakJrNFPmSVKWlmd6kcWw4ERDrOVBmABaQ=;
        b=J14vbNoHeOnVVXEdFbsygOp1Oor/EfEureByp7P0PGqKWDJkeGFC8U/GAD2f5wTu+o
         DYaZOaeF87UhATTEN/uEQ+41qjQ7ST7ojr6NUk6itJEpFfYkN7b4vpdhkeFUthtq3KEE
         XnHyHxbuKlZGYqwcWm+PEJZqXJhONAJ9s05ydHxF54lD3u+YMhedFWc2Db/KZwvXZB7j
         Tz8wW4v/r5yLNKrkVqXpg2XTGwRI1F4n497w45j/+sf6Ue9+7CALVp831MQs7wZ2YGn2
         CjlpktDRuhcsDWXxFqGKnXirSORHUGMO/htd9Y/oADOoJdyWDhU/ME5gtdd2aOSZ0Er5
         zTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568946; x=1785173746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fcxOfDsXTcakJrNFPmSVKWlmd6kcWw4ERDrOVBmABaQ=;
        b=T3nUjfa4rV/PieUP/O9RCrwueCtxvRCJqGgVBLl4Kx7BsQa1XAVTNIJyCG2ZR+tUvu
         M58+KSWh/GBRveoKIMHBpJfKXqeJJdnwSv4SiI1VlDzt58Ug6V1y5CFcj7ZfruYqDCIZ
         xZHX5Cj2PVanT6m5YbzVeMYwS4LWcRVXJclPyeFlmQBXsaXQauLCCPkg4I11dYpDW6A7
         XollIASuNTGAqAAOXyZi44TcmoIDD5wIA/DL5OZTBk4MErrFXHpa3RUrayux81sgXD+i
         ARo7wyvAN6a0Dx8fn4yCx9rDabOMia9jpBBXbuTQUxByDwwRYghhqh6fnSmeqay+SBs0
         GO5g==
X-Forwarded-Encrypted: i=1; AHgh+Rp9mPV890gumF9TzQrvR/a4vbSqENGC694V5XYzKMOgd2vzkb7WncxrpHiY+76dHTJz1EFWpQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwJm7U0mwaHSmnMBNSnZrwcsRoBAv6ayTiypIXwtEk8zEsH1qBY
	Q14K+yAXM2JksdHrhiqawzrnTghaH8E9ZdDxelt09P8HDAh/tMHZh4EhnfX7TjRqgQc=
X-Gm-Gg: AR+sD10PonjhGOwZAekEVUt9Wbp3boN2aEDqiBvWpkhJ/TdhFvFR1mn1x5EGPrmycdr
	0DlU+3jVzSy6j2IR6HOVv9OBSwfsPdI6iPcQh1wLNlHKFMzacV2f5YPWGlzK8YOgeTE8vnRmEMU
	6k406VS9Gzf9ZV3VKPGWMnHIkC/29ZwZdEgYeMelG4bNkJBL4RjGNFuHs57Mxt2sAWJmz5F0f6i
	gMzZZFmWyMPgSaAGgl32Dk4evQDHLsB860e5vqYQGRu52a36c4narFSY2OfIl3llUgTG/nc4uTb
	mkD0qL71meIQ1SRUTDxpLIfUqZMyoS1O8QuseMo85203c07nSDflyYUulf3YJVazoyARBuzh03z
	dJxmLtA7vXns5CSLeL7zTtvbak/WK3CtyZqeTFRB9ev1Co2hB5WxsaVI5Vo/PX+WVBZN2hvy6/K
	kpwQfDiuN5GzfXDoBk
X-Received: by 2002:a17:902:ef48:b0:2ce:aea4:5e80 with SMTP id d9443c01a7336-2cf7bf7814bmr11505315ad.6.1784568945998;
        Mon, 20 Jul 2026 10:35:45 -0700 (PDT)
Received: from telecaster ([2620:10d:c090:500::5ee8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b037sm40732696eec.27.2026.07.20.10.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:35:44 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:35:41 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Baoquan He <baoquan.he@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>, Pnina Feder <pnina.feder@mobileye.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Alexandre Ghiti <alex@ghiti.fr>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
Message-ID: <al5cbYMD18UbKe-6@telecaster>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
 <akybBoCAm-kJbfHL@kernel.org>
 <20260720091927.GA1736709@horms.kernel.org>
 <al4X300UObXawEIJ@kernel.org>
 <al4yeHrkDHFoo6A0@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <al4yeHrkDHFoo6A0@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_103547_606225_4E005ACF 
X-CRM114-Status: GOOD (  41.57  )
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

On Mon, Jul 20, 2026 at 10:40:43PM +0800, Baoquan He wrote:
> On 07/20/26 at 03:43pm, Mike Rapoport wrote:
> > Hi Simon,
> > 
> > On Mon, Jul 20, 2026 at 10:19:27AM +0100, Simon Horman wrote:
> > > On Tue, Jul 07, 2026 at 09:21:58AM +0300, Mike Rapoport wrote:
> > > > On Tue, Jun 23, 2026 at 12:14:26AM +0300, Pnina Feder wrote:
> > > > > This series extends vmcoreinfo with struct offsets and sizes needed by
> > > > > the vmcore-tasks userspace tool to extract per-task state from a vmcore
> > > > > dump without requiring kernel debug symbols (DWARF/BTF).
> > > > > 
> > > > > The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore file) and
> > > > > reconstructs, for each task:
> > > > >   - task name, pid, state, flags
> > > > >   - VMA list (start, end, flags, backing file)
> > > > >   - user register state (saved on the kernel stack at kernel entry)
> > > > >   - user-space backtrace with VMA/filename mapping
> > > > >   - kernel dmesg buffer
> > > > > 
> > > > > This provides a lightweight post-mortem crash analysis capability for
> > > > > production environments where full debug info (DWARF/BTF) is not
> > > > > available.
> > > > > 
> > > > > The companion userspace tool is submitted to kexec-tools:
> > > > >   https://lore.kernel.org/all/20260622205550.1087163-1-pnina.feder@mobileye.com/
> > > > 
> > > > Sorry for the delay, this fell between the cracks somehow.
> > > > 
> > > > The kernel side looks fine overall, but to merge it there should be an
> > > > agreement from the userspace side maintainers that vmcore-tasks is
> > > > something they are wishing to accept.
> > > 
> > > Hi Mike, all,
> > > 
> > > Sorry for the extended delay.
> > > 
> > > I will send some minor feedback to the user-space tool patchset
> > > but overall, yes, this is something I would be happy to accept.
> > > 
> > > I don't want to create a chicken-and-egg type problem here.
> > > But it's probably worth mentioning that usually features
> > > hit the kernel before the corresponding code is accepted
> > > into kexec-tools.
> > 
> > Sorry if I wasn't clear. 
> > 
> > I didn't mean that the feature should be merged into kexec-tools before
> > merging the kernel bits. I just wanted to make sure there's no fundamental
> > issue from kexec-tools perspective.
> > 
> > > Let me know how you would like to proceed.
> > 
> > I'm going to wait for Baoquan's review and once that's done I'll pick up
> > the kernel bits.
> 
> Oh, sorry, I just noticed this series, but a quick look give me a hint
> of 'No, I don't like it.' We have had Crash utility, Drgn, now a new one
> comes up. I have some concerns to Pnina:
> 
> 1. Exporting maple tree internals (maple_node, maple_range_64,
>    maple_arange_64, maple_metadata) as vmcoreinfo ABI is problematic.
>    These are private implementation details, not stable structures like
>    task_struct. Any refactoring of the maple tree will silently break
>    the userspace tool. 
> 
> 2. Without DWARF/BTF, the debugging scope is inherently limited — no
>    kernel stack backtrace, no symbol resolution, no variable access.
>    That's essentially "ps + /proc/PID/maps" from a vmcore. Have you
>    considered enabling CONFIG_DEBUG_INFO_BTF on your platforms instead?
>    BTF is compact (typically < 1 MB) and would give drgn full access
>    without needing vmlinux debug packages. That seems like a better
>    return-on-investment than maintaining ~40 new vmcoreinfo exports.
> 
> 3. Beyond the technical concerns, I wonder about adoption. vmcore-tasks
>    targets a fairly narrow use case — platforms without DWARF/BTF, where
>    you still have vmcore but can't ship vmlinux. Is Mobileye currently
>    the only consumer? Are you guys already using it widely and fully?
>    If this lands but doesn't see broader uptake, the ~40 exports risk
>    becoming dead weight in vmcoreinfo — nobody actively uses them, but
>    kernel changes still need to keep them consistent, or they silently
>    rot and give users wrong results. 
> 
> Regards,
> Baoquan

(Adding linux-debuggers mailing list).

I agree with all of Baoquan's points here, with a couple of notes:

1. drgn's BTF support is currently a work in progress, but it's shaping
   up well: https://github.com/osandov/drgn/pull/625.
2. makedumpfile is also gaining BTF extension support:
   https://lore.kernel.org/all/20260617051834.95404-1-ltao@redhat.com/.
   It's lighter-weight than drgn while still being much more general
   than this series.

Thanks,
Omar

