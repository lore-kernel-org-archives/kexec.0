Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78923CD6E55
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 15:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GE3cxqAXSaCHVcc+WKXlgfot3UvMd9FsWD9Iu0pbg2Q=; b=W6RdFbSHtD97+z6iaxGGVsI7ga
	qrSqpVLMqE/ofTWbbLxb+DZ7dcuoH+Kdywm2NfvZNcmD8fs/GjWWhhiyWeng3JrxK7IZ8F9reYb/1
	BDSpnysK6MzdKMkmLibpT2c+sW49M0sxvnloakq8im7ABlVSpSrAsshbQmEAyulB9l35cy4AOjQJz
	HpIeFTQMyifUj5ui0Q9ElDirzSDWjrL/JyM2ZCQhhWiBB6KfOd6/BZPmVCtEmqEzzhVrLNLEnAxDP
	5dYWMG4G1Pyim5yee4Vp6gJ4ui6I9at5ULJL5m5Jp96TmMa2nVv6I/TKjhdx00tAz9NQO+IF9TxIr
	VNZFPPww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUn89-0000000FKOI-3XTe;
	Wed, 03 Jun 2026 15:03:41 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUn87-0000000FKNy-2HkO
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 15:03:40 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-5174363a843so9426191cf.1
        for <kexec@lists.infradead.org>; Wed, 03 Jun 2026 08:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780499018; x=1781103818; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GE3cxqAXSaCHVcc+WKXlgfot3UvMd9FsWD9Iu0pbg2Q=;
        b=bxt/+5LX0tLaM9xZ2dJa9wNoX1oF5v23l5TrBvFXPqJC/u6u4oV3511vTeTPpYACE4
         8NwxXoCgJrx8ayz27vqeW3mYH9RLAeUjK/rikDc/txrfuXkm01Zy2guJOSnPHDMCkiTg
         Xpu8MzoXjGUdD9isrHgxFZf8pcmW/gpQL4KceidrkgOX815JkqfRfV4t1WaKlz4CDPkt
         SXC5h0V6KgBcSl16dwa0aKEVTFBQxUBCdGPDutWO7lon4qFi/GFnZE5pBxXAfOVITiOR
         GwJ33E7M0js/BZX+WHHV0bqugDeOYaX2eKF37dlQ3AM98bFeeDs+bIXNnMziMxzhLFsV
         9cFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499018; x=1781103818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GE3cxqAXSaCHVcc+WKXlgfot3UvMd9FsWD9Iu0pbg2Q=;
        b=n/RrgHs/pSihheHqwqUHemct41XgYmuhnxFnjmF458sIWozj6TT9MzMLukl6GCmiJ1
         7C/Qd2NSVn8+EwgVnNJVjSrll40phoqXc3u1Q4e6Ak8tnbwjSNgbpP6fpwedzi1wICtU
         CqccryFjUFPE2kO4+lTasSgLMTvje1LyuMHxDGRHf9RK9eVd5EoZtLhljV0mtgPez02J
         +mLXzPLzOprEJSLQTCmdHrtHNylHe58eqrmckDI5bi74kz5itSYxBpHkUBOhjuR9CNB9
         K47W012hrZLlLUtHXRi8mGTMNc8m9JmWoGD1dDbjExSsfDagMBNmWFY6p2XshlB26C0C
         ZEEg==
X-Forwarded-Encrypted: i=1; AFNElJ/HetUIaCLDRyrI2704u411Grl4EYnxGFnlmO8v1wipWbXoTXnk1qHhi8qXcP+R35P/xatecg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyFXyeYDoO5Bd+uciii2TtE2FpP0TC1bQ07o0gHPhfnVG+StZz1
	GTLub782dk2Zqya73EWSVPxE+i4L5pIHZHiNm5ryZgyGvKbNzsxwMTDyrsIexiAJtBo=
X-Gm-Gg: Acq92OGRs05m/IP2idmfMRfkCDxiYvIME1oTr6jpE+SPOMDCrLMe052KMzeQNX5mO3J
	tqZIaKZ11QJLQP75bIUeJC2WGuOPOxc1hsBhQiedkluDVdFfoy/8kmsrJR4HxgL4nOXqjT4/l9b
	ZmX2gis3jvJtKjUfeyKtnUM9CJ4u/ZeZrwhMXzYi1jh38Nymo+Kvag7+axioSZpOMVKdk9Invv+
	dz0/aVYtIC6jMTCdKN3Rj1lYYeA6ynkET8HP+j0FKcs9NT/wJBRQ9nFYZLpe5m0IEYtqg/LaeOC
	H/8BFRDVA1BVK59WEnT6nEk7e03NswVTQfaNvmk582J4KHKfkXkcPYA4AWrAwRBHHV6ogRbYpyJ
	JxPGbPSdPa9EqiybEAKGLJnTshhA+oJhxe952huEf8WsCxqfKGIzNnPZaQBcUj80gO0G3+ZVvMg
	iuraR1kzLvZ7tsCG+/5GS4HHNWxF2hfmhyB/sJf9wab4K1jJicOoD8FUa0FHeyAw==
X-Received: by 2002:ac8:7e86:0:b0:516:82e2:7788 with SMTP id d75a77b69052e-51779701719mr41203361cf.1.1780499017835;
        Wed, 03 Jun 2026 08:03:37 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dd2e53sm25188571cf.24.2026.06.03.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 08:03:37 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:03:36 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v6 07/13] kho: add support for linked-block serialization
Message-ID: <aiA_j7udFaO9TRBP@plex>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
 <20260603032905.344462-8-pasha.tatashin@soleen.com>
 <178046937151.468621.13398573538792303093.b4-review@b4>
 <aiANtYRRDr5iO5QR@plex>
 <aiAzT9TvGYjITiB8@kernel.org>
 <aiA1slnqPnC4_8XY@plex>
 <178049725439.475072.11560134126837430744.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178049725439.475072.11560134126837430744.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_080339_603781_04C77128 
X-CRM114-Status: GOOD (  37.40  )
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

On 06-03 17:34, Mike Rapoport wrote:
> On 2026-06-03 14:11 +0000, Pasha Tatashin wrote:
> > On 06-03 16:59, Mike Rapoport wrote:
> > > On Wed, Jun 03, 2026 at 12:05:04PM +0000, Pasha Tatashin wrote:
> > > > On 06-03 09:49, Mike Rapoport wrote:
> > > > > On Wed, 03 Jun 2026 03:28:58 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > > > > diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
> > > > > > new file mode 100644
> > > > > > index 000000000000..8641c20b379b
> > > > > > --- /dev/null
> > > > > > +++ b/include/linux/kho/abi/block.h
> > > > > > @@ -0,0 +1,56 @@
> > > > > > [ ... skip 25 lines ... ]
> > > > > > +#define _LINUX_KHO_ABI_BLOCK_H
> > > > > > +
> > > > > > +#include <asm/page.h>
> > > > > > +#include <linux/types.h>
> > > > > > +
> > > > > > +#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
> > > > > 
> > > > > It's never used by block set and after looking at the following patches I
> > > > > found that it's appended to LUO compatible string.
> > > > > 
> > > > > While this works for LUO, I think it should be kho_block_set_restore()
> > > > > responsibility to verify the compatibility.
> > > > 
> > > > It should work for any component that relies on  kho_block. My proposal 
> > > > is to use this method for other common KHO data structures (e.g.,  kho 
> > > > vmalloc,  kho radix, future kho xarray). There is no need for them to 
> > > > carry the compatibility string in their metadata, as whoever uses them 
> > > > will include their compatibility string.
> > > 
> > > So if, say, memfd_luo uses kho vmalloc, xarray and blocks it'll have five
> > > compatibility strings glued together?
> > 
> > That is correct, but it will be in only one place: the header of the 
> > client's KHO subtree. Since it is dynamically sized and 8-byte aligned, 
> > it should be safe to include in any struct.
> 
> This is safe, you are right.
> But I have more usability concerns from one side and the duplication it
> causes from the other.
> 
> I can see the downside of putting the version information in the data
> structure itself as it either requires a different header for the first
> element or needlessly increases all the headers.
> 
> But 
> 
> #define LUO_ABI_COMPATIBLE     LUO_COMPAT_BASE "-" KHO_BLOCK_ABI_COMPATIBLE "-" KHO_VMALLOC_ABI_COMPATIBLE "-" KHO_RADIX_COMPATIBLE
> 
> is not really digestible too. And it forces KHO users to potentially
> track KHO internal changes.

These are compatibilities; I think they are quite digestible, both to 
write and also when the  LUO_ABI_COMPATIBLE  string is printed out for 
debugging/info purposes.

> We still don't promise any compatibility between different kernel
> versions so to avoid blocking this series on the decision what is the
> best way to convey KHO data structures compatibility I suggest to bump
> kho ABI version in v6.2* of the patch that adds KHO blocks and postpone
> this discussion to after rc1 when we'll have plenty of time.

Let's keep this patch as is for now. We will have a broader discussion 
when we convert other participants to this new scheme. If we decide not 
to pursue this approach, we will change this code to use an independent 
compatibility string. However, having this in place as a template will 
help us convert other components correctly, ensuring proper alignment 
and that correct string helpers like  strncmp / strscpy are used—which I 
have already ensured is the case in LUO.

> * sending a new version of a single file does same email traffic, but it
> confuses b4 and quite possibly other tools, so I think v7 is better.

Agreed, I also prefer re-sending the whole series...

Pasha

> > Pasha
> > 
> > >  
> > > > For now, reviewers will have to make sure that if the ABI header content 
> > > > is changed, the compatibility string is updated.
> > > 
> > -- 
> > > Sincerely yours,
> > > Mike.
> > 
> 
> 

