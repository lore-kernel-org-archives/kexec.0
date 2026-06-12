Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D06CCD98CF
	for <kexec@archiver.kernel.org>; Fri, 12 Jun 2026 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4fdlV1svnoMA4warxZ5zK3ylIeyyzAc6d3U562SAKBc=; b=U8d0ayoS0rvOQ0f7V6BE8ogp1K
	E5Ha7H/VVNUILMRjIDY56lg56D6W/jojfcZfBzBo8GesoNiAatSwK48LXGUySBgz0pWDgqsaS3kDJ
	VRJOrvetDOWI6r3XSWJIaMbHnL1bQ15EpDSGwskLsZ7I/zjsKatR6kGIK2ZUAzUaNl+3YSDx555Wh
	iBAQ/DTGS1/+XY1dYY7sE6wgxI89bGy8guJwFQhnKrnlS072RjuiXtwABtSIZgRVnMpiyKbkPYYu0
	xykiQHTmmHqvzP2s/1d3yQFm6RQXd6ygsNDQqTEanUKmjHYsdUup9mDjY/lbbVUon/mTcihqAIPnC
	G0AIsexg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6yr-0000000BQ94-13uI;
	Fri, 12 Jun 2026 18:51:49 +0000
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wY6yo-0000000BQ8b-1xX0
	for kexec@lists.infradead.org;
	Fri, 12 Jun 2026 18:51:47 +0000
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-8ccef25789fso10335286d6.3
        for <kexec@lists.infradead.org>; Fri, 12 Jun 2026 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781290305; x=1781895105; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fdlV1svnoMA4warxZ5zK3ylIeyyzAc6d3U562SAKBc=;
        b=dG5LurNpuiy1MS5u02jPFj4T+oBxSG+DWalux5dIRg8hAhGIBS6Z3b9tBJYzOU2fl8
         U5VOQcj9SBOhTYTGljDZ4o5pYtjhlVuT5lTevs1QDNFvl2GZDJdfwbtcqptQO2VqAy5D
         J8TdCrTwLwycOIfWKVyZuI1c9ybR6waCwTvg3Tk+a/qr1fpIG7EN32gh4hBmEEGs+MsO
         EDEHVJ/W+LWUgcI3C5wLqPz2uTOfgJ32GUeCzWGBQqzf/DeSW/L1qSErQYUCgs9BkkD0
         bjdgUqHknkHVZHbKAvZ2Hmo4g0gI1TTp0+QcA6yfrF9Z4TC8V+3qD9P12i2HKj4PMAps
         shZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290305; x=1781895105;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fdlV1svnoMA4warxZ5zK3ylIeyyzAc6d3U562SAKBc=;
        b=VAbl/YwXiUlVnOA56j5OSURq59PRxUbkmknzlDJCMfNP/N5+i86m7GTfVh3E5S8P2g
         KstRl8DH13ttd/rOaPaZH90bsE9oPtea+evvBe/vNmrTF15MVtrS+oaGKXBwNYp5PCGQ
         lBDXJm3oxswVxbKDZXOe1uDLlB3ZCEREpxsrfT1mmmEdSeMDH9fzYK6DxZ8oFwfbA4MQ
         uNL7zcN+QHotMkqbq51un2+K1zUTszKgjZaoDvdkdQOxFb/BRDW5kEZNqswEKSSK2b+O
         0YCIHA9Q8ZT0BF52hon97aY7ordwDvZ0e/Jhv6nEXZ4BOXyFWgQfjatYQQIY80gGkFo5
         Xe/A==
X-Forwarded-Encrypted: i=1; AFNElJ/dr4cpsPECVrtCH3ubeGiytEtmlNxv+hpOZZpqGwek353VrfeYDdTPhXbS7gnfw4WJmtgqLg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxEPpGKHdMLDvm+QJsYuKZeaWJTsXZ1nDhaziGPRt5oL3y/FRtz
	d8Wr2y5lGpEWLpLFV9N+I2lqo1NY8WsV0R/6/KWqHrPSyLGKpeG+tpG+YLCwCO7EDjY=
X-Gm-Gg: Acq92OE2vIdtIphbehFZSa2TfBf8WvXYsRvprybqhbaW6XOwPn/sze8yUv1H+djPGu0
	6FVBi33A4d8JXhUl2kRDPPlvBfO7hPXURLMVOw/cxJwH0SNtR0k0S9lisKK8iAifoxnM/h9GJcD
	fuSmrXCC1c8NUid1lIeFpPbFxRLn+enoTc6oSEdLXhqDlJ6kGixaPJJ3Wcrpa5ZAWWPg1dd9Tbi
	AGx6nngcXdy6iDFHCeSgAKdTKiyW3CIJZCG1t5afA/0IEqGpMpAdk1AwkwDIJU+SavfEAr/7fdA
	hcN+UFvBIh4wqZ1iohUWl016hqmffn3le7SGrSFtiKspwnKa03VFprZv6h3wctspKXayPG7VpXX
	zA9u9BXfmTm6b+0iY5hOySdhiwC7fTkwAV8+CWtFeB/I6FTEs5+IQ79XvK2Jul1EvEzXerwp/j1
	MsPXkwtzByMo0Zk8hF/cyWi428U0xYwiEQyDFx8qN39ZebkKge6iY=
X-Received: by 2002:ad4:5d6f:0:b0:8ce:c19a:3f03 with SMTP id 6a1803df08f44-8d32c010a68mr65033106d6.10.1781290305055;
        Fri, 12 Jun 2026 11:51:45 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d2fdc9e3cesm31734306d6.0.2026.06.12.11.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:51:44 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:51:43 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Subject: Re: [PATCH v2] pstore: add a KHO backend
Message-ID: <aixVD7vyjAcJBZDB@plex>
References: <20260605121040.1177072-1-mclapinski@google.com>
 <aiwa4jIWEMsvfnVg@kernel.org>
 <aiwbUfeaF9RdCGR-@plex>
 <CAAi7L5cnRt6enZnrrbbhsVwtxUDBXrxj16zsg8TtRFvP70ocoQ@mail.gmail.com>
 <aixSCR1P2zVHDo3e@plex>
 <CAAi7L5fZTvhb5np=xGWnDEmr4bNXqoAcMhR_ePZ4Qga4E-KucQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAi7L5fZTvhb5np=xGWnDEmr4bNXqoAcMhR_ePZ4Qga4E-KucQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260612_115146_517630_418F14DD 
X-CRM114-Status: GOOD (  33.09  )
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
Cc: Tony Luck <tony.luck@intel.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Kees Cook <kees@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 06-12 20:49, Michał Cłapiński wrote:
> On Fri, Jun 12, 2026 at 8:38 PM Pasha Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > On 06-12 19:57, Michał Cłapiński wrote:
> > > On Fri, Jun 12, 2026 at 7:21 PM Pasha Tatashin
> > > <pasha.tatashin@soleen.com> wrote:
> > > >
> > > > On 06-12 17:42, Mike Rapoport wrote:
> > > > > Hi,
> > > > >
> > > > > On Fri, Jun 05, 2026 at 02:10:40PM +0200, Michal Clapinski wrote:
> > > > > > Up to this point to preserve late shutdown logs in memory, users had to
> > > > > > predefine a memory region using ramoops. This commit changes this by
> > > > > > preserving a buffer using kexec-handover.
> > > > > >
> > > > > > pstore_kho supports preserving only 1 dmesg buffer.
> > > > > > It gets replaced with the new buffer on every kexec, so the user has to
> > > > > > copy the file out of pstore after every kexec.
> > > > > > There is no erase() support.
> > > > >
> > > > > Sorry I didn't jump at v1.
> > > > >
> > > > > pstore does not really need a KHO backend. It can use ram backend with
> > > > > reserve_mem and reserve_mem can be preserved with KHO already.
> > > >
> > > > I just tested it, and it works well, I think it would be fine for
> > > > Google's requirements:
> > > >
> > > > CONFIG_PSTORE=y
> > > > CONFIG_PSTORE_RAM=y
> > > > CONFIG_PSTORE_CONSOLE=y
> > >
> > > Is it common to write to this console? I think what I typically see in
> > > the console are error logs that are also in dmesg, so if I preserve
> > > console logs and dmesg I just have 2 files where one is a subset of
> > > lines from the other.
> >
> > We need either your KHO backend, or the following patch:
> > https://lore.kernel.org/all/20260612172623.1218280-1-pasha.tatashin@soleen.com/
> >
> > We need all dmesg messages.
> 
> We get all of the dmesg messages if you compile with
> 
> CONFIG_PSTORE=y
> CONFIG_PSTORE_RAM=y

Ah awesome, thanks! My patch is not needed, I will reply to it.

Pasha

> 
> and the cmdline:
> reserve_mem=2M:2M:dmesg_buffer ramoops.mem_name=dmesg_buffer
> ramoops.max_reason=5 ramoops.console_size=0
> ramoops.record_size=2097152 ramoops.ftrace_size=0 ramoops.pmsg_size=0
> (the diff between yours and mine is I set console_size to 0 and
> record_size to 2M, you do it the other way round).
> 
> Dmesg is kept in "record_size". We don't need to preserve the console
> at all (unless there is something in console that isn't in dmesg but
> I've never seen that).
> 
> > >
> > > > With the following parameters:
> > > > 'reserve_mem=2M:2M:dmesg_buffer ramoops.mem_name=dmesg_buffer ramoops.max_reason=5 ramoops.console_size=2097152 ramoops.record_size=0 ramoops.ftrace_size=0 ramoops.pmsg_size=0'
> > > >
> > > > KHO preserves pstore properly. However, we need one patch that would
> > > > allow for ramoops console to capture the output even when quiet is
> > > > provided.
> > > >
> > > > Pasha

