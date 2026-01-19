Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96980D2ECEB
	for <kexec@archiver.kernel.org>; Mon, 19 Jan 2026 20:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OqAdMoCLDfxesWeXSjFPeXninStgY+7qdqGzoS26PCI=; b=pRgvPkITv4ixapg/265m/s8Ri8
	MMoS+/HSRLOFmZliQwJezFThp3jzkPO059UnqlSm+v1pD0Q49MKM3A1T3hJasGCzIuDfBTD98f/od
	CYlBx8YY7PjHCrEuqVc/3KssZyvLVAwl0dkg9Y+GNXI/DPJyxJfDotjKP08P7riLJQGNgQP9ze3YD
	b+ghR83KkHRn3T/jPDD6JkD8LzebDEKcSMPFiNh05MzgY20lsJi5cgH0xtRnp6TAjfj3bpacdaeN0
	3boQYmugsD0rCma52F15mvAa/bymSB8eVCCgSz5wBV20fCOrQ0FovFeweaCDZvjWqTVeWTB4p+hzM
	20ka9ZWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhwLO-00000002rl4-2WpT;
	Mon, 19 Jan 2026 20:59:26 +0000
Received: from mail-qt1-f172.google.com ([209.85.160.172])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhwLL-00000002rjk-0nQr
	for kexec@lists.infradead.org;
	Mon, 19 Jan 2026 20:59:25 +0000
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-502a789834fso26227241cf.2
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 12:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768856362; x=1769461162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqAdMoCLDfxesWeXSjFPeXninStgY+7qdqGzoS26PCI=;
        b=ARzVIc899hrkvowQ99BLKdcdspHaHMLMe1m/da6fHWMt1Uk45rhpBSEOUtAXT0ErXs
         TAM+9ALj2Cy6IL2RrWsSWIyuhJt/I3bZyJTd3jeQrjEpmCoE6wvCKjTcKrp7cle7PwP2
         LvqHmXkBwKAExcEOOV5UuXLvJySeGYbxh121fKFcuzXHINm6QLB66ZTbwQtaESMhhULi
         rZza/CrCkVKQA2gmbhG5iFU8SErqKWTto90KDYBzeWek8NVW3BN670vui6NSovFOOJ0x
         jiTmNJuPuHdQfxchdINoms7eHIQozrp3Wy+glBXwNVZBkC0LdjHbaAtPm98aXIbRhmSM
         sm/w==
X-Forwarded-Encrypted: i=1; AJvYcCW/I93+BSe0RfY6McAjGp6NH2RtSpuAsbpR0f5ChlaVWg/+6rx6qbxdWDC7fkGR1fuKovQNIw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyUug3ccBG5xPwjqW2ejAiKQ8CpBEcFfrm7Ecgl7e6Ll2e2Blfa
	CGVKU1ta9FAM2b8AQ7yuKL6D4HKo0uidwk6JWF/KkIalbjVMCI/GzqeI8qwP6A==
X-Gm-Gg: AY/fxX77fMIPfEcMt5glCPrIZd03cNWwRlvAlCEWKRRyOI5LhHwOWl5zspksPRh3fCe
	koD4nI/t+XFs7WHNWGNTkCBImmNskUtww6bvT12JUxIPHbIC8f8HhiHokVgGCdawkc+AYgTTkfw
	I52ChllpPsQmxqbtYayqummNUMl5v66am7aP9+0FWkjzlXQmxCjyM/sYyeNGk4Fz5X0saiq4QtA
	jbSHF2i6dprLrVMo0Bgu7AdUyWOrzBWWAcRbGdBN+ymBA5yox0erej/iYKptWSZf2a9+Nyp2hGV
	1XyzQlbrjhU1R8mU+nQ3lx52Gn2MY8oXtw78CIU3w0Q8SqJ6X3nSXRl+spzQVOcjJEVw+2C4Gfz
	xCoeQcnIO7vrEerTeusrnL9N3QRpm5bMYrCl0AJVNb9IrgAsqiw4FsXSYE85zvTanXKd1HzntQE
	saWQ==
X-Received: by 2002:a05:6830:6d0d:b0:7c7:568d:cba with SMTP id 46e09a7af769-7cfdebc991cmr6635773a34.0.1768848852118;
        Mon, 19 Jan 2026 10:54:12 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf000b80sm7154662a34.0.2026.01.19.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:54:11 -0800 (PST)
Date: Mon, 19 Jan 2026 10:54:09 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org, 
	rppt@kernel.org, graf@amazon.com, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, ricardo.neri-calderon@linux.intel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v4] kho: validate preserved memory map during population
Message-ID: <z2lraqiivexvfvokff4gmqyvbpswmfwhbkhv4u7lo3nnnyz346@mibnt7dkrvey>
References: <20251223140140.2090337-1-pasha.tatashin@soleen.com>
 <jixxiqeajngwox3nh2u3pwf2rivhmqxxmpyttqxu32pixshyde@4jdn5jvg5hvk>
 <2vxzo6mt7cl3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzo6mt7cl3.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_125923_256922_66D0E97C 
X-CRM114-Status: GOOD (  29.65  )
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

On Fri, Jan 16, 2026 at 04:21:28PM +0000, Pratyush Yadav wrote:
> > On Tue, Dec 23, 2025 at 09:01:40AM -0500, Pasha Tatashin wrote:
> >> If the previous kernel enabled KHO but did not call kho_finalize()
> >> (e.g., CONFIG_LIVEUPDATE=n or userspace skipped the finalization step),
> >> the 'preserved-memory-map' property in the FDT remains empty/zero.
> >> 
> >> Previously, kho_populate() would succeed regardless of the memory map's
> >> state, reserving the incoming scratch regions in memblock. However,
> >> kho_memory_init() would later fail to deserialize the empty map. By that
> >> time, the scratch regions were already registered, leading to partial
> >> initialization and subsequent list corruption (freeing scratch area
> >> twice) during kho_init().
> >
> > While trying my new patchset [0] on top of this patch, I got the
> > following issue:
> >
> > 	[    0.000000] KHO: disabling KHO revival: -2
> >
> > Trying to solve it, I come up with a change in kho_get_mem_map_phys() to
> > distinguish no memory and error, see the patch attached later.
> >
> > This is what I used to test [0] on top of linux-next. Is this useful?
> >
> > Link: https://lore.kernel.org/all/20260108-kho-v3-1-b1d6b7a89342@debian.org/ [0]
> >
> > thanks
> > --breno
> >
> > commit 5d7855fede8110d74942e1b67056ba589a1cb54a
> > Author: Breno Leitao <leitao@debian.org>
> > Date:   Thu Jan 8 07:44:08 2026 -0800
> >
> >     kho: allow KHO to work when no memory is preserved
> >     
> >     Fix KHO initialization failing when no memory pages were preserved by
> >     the previous kernel.
> >     
> >     Commit eda79a683a0a ("kho: validate preserved memory map during
> >     population") introduced kho_get_mem_map_phys() which returns the physical
> >     address of the preserved memory map directly as its return value. The
> >     caller then validates it with:
> >     
> >         mem_map_phys = kho_get_mem_map_phys(fdt);
> >         if (!mem_map_phys) {
> >             err = -ENOENT;
> >             goto out;
> >         }
> >     
> >     This creates an ambiguity: physical address 0 is used both as an error
> >     indicator (property missing/malformed) and as a valid value (property
> >     exists with value 0, meaning no memory was preserved).
> >     
> >     "No memory preserved" is a legitimate state. KHO provides features beyond
> >     memory page preservation, such as previous kernel version tracking and
> >     kexec count tracking. When the previous kernel enables KHO but doesn't
> >     preserve any memory pages, it sets 'preserved-memory-map' to 0. This is
> >     semantically different from "KHO not initialized" - it means "KHO is
> >     active, there's just nothing in the memory map."
> 
> This isn't true. If you hand over _any_ state, you will at least need
> the KHO FDT. And the KHO FDT is preserved memory (see the
> kho_alloc_preserve() call in kho_init()). So I don't see how you can
> ever have valid KHO with no memory.
> 
> mem_map_phys _can_ be 0, but only when KHO was enabled but not used. And
> that is of course also a valid use case.

Oh, I was not finalizing KHO, and in commit e1c3bfd091f363c1
("kho: validate preserved memory map during population") started to fail this
on purpose.

So, I understand we want to fail if mem_map_phys = 0, but thn FDT was properly
passed (how is it possible)? I know I can read
KHO_PROP_PREVIOUS_RELEASE/KHO_PROP_PREVIOUS_RELEASE from the fdt, even when
mem_map_phys is 0.

