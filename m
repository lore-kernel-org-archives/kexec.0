Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF4CD8C8C
	for <kexec@archiver.kernel.org>; Sun,  7 Jun 2026 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1i1ZZY3NH0NksSKwhex65P8mcwZtC9iSbou0/cGuXtQ=; b=BO1BVQv4dCn4iWOaT5UBUopmb1
	sS+wtWKaYGtt/mpapwd8wYA6659Rp1Wd1BBR87lowlgghuk9FAokLn5buhxtvB0tESKt3mAD+meu3
	Vje/QwUmq2hIjLtmDNDecgue2gE39+MuiGfAsew8AMypM0eJTCULcj6lCge1AtzB34ven8wzNESev
	vssZhDWqAT/DX75BuLaJVxIBql1lpivA18Xcpt1fHMZt10WNrzDhQUv9KejYM1ILSFi0s0IpWD1+x
	7pVRmnJtuVGdPkrqu+EBurg2UnGtS+EKKP0kyYRnXiS4EkqSXZJJB1xg2K+DyOaI75q+zFR49w9sN
	A4DUmx4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWDmV-00000002Grc-2Yzj;
	Sun, 07 Jun 2026 13:43:15 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWDmT-00000002Gr8-09rE
	for kexec@lists.infradead.org;
	Sun, 07 Jun 2026 13:43:14 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-9158629a220so392026185a.1
        for <kexec@lists.infradead.org>; Sun, 07 Jun 2026 06:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780839791; x=1781444591; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1i1ZZY3NH0NksSKwhex65P8mcwZtC9iSbou0/cGuXtQ=;
        b=CUU7g8PvOOUBfZJag3rmtfh/k7ywwL+Vn03h96FdjQBRjgq16FWkiPIeerlYNOMYBp
         ezjI4DKOMg0627Jmox4t/6sCPH4iINEqMRNgBTb5LJ8ejVPlNZ10feYCtbDlxhOQi96d
         +Q9u3QKVJSlpto/fYPRsJXgWYqf6RAty6bT6lvULNygiGxgPl3MsEM1QRMfbC07YuIRQ
         XsYhACzjhQEtDnvLvhJThXIIcS95E9+piRpHgUVXuaDfWLvvBxa31e98NiD87I2KIOlM
         4qzyJLig9JWJRxCDaH8BePBojT8A1uGvlgTjDt4GtEIrTVX/5KwFCP3QRa9Qqrwy4vtR
         h3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780839791; x=1781444591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1i1ZZY3NH0NksSKwhex65P8mcwZtC9iSbou0/cGuXtQ=;
        b=G315kSe+EtYB6SpMbDiDwtDYzej8WaXA2OzFCXgEzTAXhbYeteHwlHa65Pk39zx68F
         s8nAzNfk5wAvYMlIFxQH4YfKqXNdZfArXv8li0tYKkj+GvLSktteIyi1a0YWNicRI1hN
         WWI7naorBHSo6sRLROoBDfCfSi4btsRO2tB1nLKhVInWdSqRs1FnHJYNge1vXDy0LGo2
         aWdM5MIEG3zZODNQ0c50fAuxIX6SpZgCQVnbM2PYB05aUvc4zZrrjJROBS+MXGUEzCWn
         D16ssuCVZePJvxPMrrTPrKR4IsTTEYxnN/lU/9nEKMCo0fUBC3opkrbWVL11gS0JKdGQ
         B49w==
X-Forwarded-Encrypted: i=1; AFNElJ/gBKATD6jc1tZk57wQmFL2Swr8DJYRM05JfK8pnSVkKZjJBTPMt1pDmfYP9c+i5eihviOO9A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy8eIFs5nQXODtUIOaeN97iTwArluw1C8G8BulAj8ipa+UT7bDX
	4hi9kGhBXdw3k36ZY7Vqe+cG8+0VgPX/nJMRtL2OnKtkzBrlguIKI/lBSv0LxqAk38U=
X-Gm-Gg: Acq92OEGI6PbZoNs8g2ZSS0THK1YbK2YqD3GPC8P5dv1YgyRvXkamZRxbk/rD/c3rjX
	AZmnuIsaD1pl1o6axjm4Jl2AQy1867MuG+caXfnyArr1RK8qdfT3SaPjAeXceo5KTuFseRCRq7y
	m8cxdkphaayhmDsFwo9FGCCaJFf4Ew3AFyS81zrBoAgWVI9gLb7V/PjAGA2d0HW2R5Fq8lqlV5e
	1hWORfv75c80uhOJprphgBtn3I3USxsY/ZdjXuA9kPStNYRKK1p7P7rdw8LD7TBMwc1Zl/j9cCe
	3ZvrjB7HDwTJFU0StAA+kE+Xfur3TDmfIF7u0KYzNOBXmqMB0615Se8EVMdXQGb1AP+ysgADRmP
	ddVUu4SbyE6OEfl8S9btL1sX+3g988Qs3f7rqGMCz1hZNt3TDOeozuz4CcYctmFc31Yuz2vhlgG
	YobAmTAMZeI8dLrXOifKtItdXKaOmOAVS3dSkyrzkaRRIZrZmFEeWg8TSViAI9cg==
X-Received: by 2002:a05:620a:2990:b0:915:6e30:5bdf with SMTP id af79cd13be357-915a9cad06cmr1888383385a.19.1780839790896;
        Sun, 07 Jun 2026 06:43:10 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a40d566sm1415396285a.47.2026.06.07.06.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 06:43:10 -0700 (PDT)
Date: Sun, 7 Jun 2026 13:43:09 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, jasonmiu@google.com, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
Subject: Re: [RFC v1 0/9] kho: granular compatibility and header decoupling
Message-ID: <aiVp5RlbWRz5VnPB@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <178083348872.1648214.17778188633648887952.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178083348872.1648214.17778188633648887952.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260607_064313_104178_DEB7A88E 
X-CRM114-Status: GOOD (  42.12  )
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

On 06-07 14:58, Mike Rapoport wrote:
> On Fri, 05 Jun 2026 03:32:26 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> 
> Hi,
> 
> > [...]
> > data structure. Keeping all of this within the same `kexec_handover.c`
> > file, and also under the same global version, is no longer sustainable.
> > 
> > To address this, this series:
> > 1. Refactors and reorganizes the code by splitting out radix tree
> >    and vmalloc into separate files.
> 
> I'd keep vmalloc where it is, it's more of a memory preservation primitive
> rather than a data structure of it's own. The data structure it uses is an
> implementation detail.

kho vmalloc is absolutely a data structure. KHO core only provides the
basic handover mechanism (FDT nodes, physical memory ranges). vmalloc
is a structured representation on top of KHO, and should provide its own
versioned ABI.

If we change any of the vmalloc serialized structures (like kho_vmalloc,
kho_vmalloc_chunk, or kho_vmalloc_hdr), then vmalloc won't work and
compatibility will break.

Core KHO does not need vmalloc; nothing in kexec_handover.c uses it.

Instead, vmalloc has external customers:
- memfd (uses it to preserve serialized folio metadata)
- KHO test suite in lib/test_kho.c (uses it to preserve physical address arrays)

> Let's minimize the churn where possible for the sake of git blame and
> backports.

It is much better to do the right cleanups now while KHO is young. Once more
subsystems are added, this refactoring will be twice as hard. Modularizing the
code now guarantees a simpler, safer, and scalable design. Placing each data
structure in its own file gives us code that is easier to maintain, review, and
less prone to bugs.

> > 2. Moves and organizes internal and ABI headers into structured
> >    directories under include/linux/kho/ and include/linux/kho/abi/.
> >    Instead of cluttering include/linux/ with prefix-styled headers like
> >    kho_block.h or kho_radix_tree.h, we use the already existing
> >    include/linux/kho/ directory (e.g., kho/block.h and
> >    kho/radix_tree.h).
> 
> This looks to me like unnecessary churn.
> These all are bundled with KHO anyway, there is no header dependencies
> that justify small headers for each two functions and netiher
> linux/kexec_handover.h nor linux/kho/abi/kexec_handover.h are that long
> to start splitting them.

External users only need to include the headers they actually use. For
example, LUO shouldn't have to pull vmalloc or radix tree KHO
declarations, and memfd does not need block.

From a maintenance point of view, it is much easier to catch ABI
changes when the file with the appropriate version has been changed,
and most likely the version of that file should be updated. If a single
header contains compatibility versions for several different data
structures, it is easier to miss the correct version update.

Since we are splitting the source files (like kho_radix.c and
kho_vmalloc.c), the headers should logically follow the same
modularity.

> 
> > 3. Introduces a standard set of compatibility helpers in
> >    kho/abi/compat.h.
> > 4. Decouples the compatibility strings of individual KHO subsystems
> >    (radix tree, vmalloc, and block) from the global KHO version.
> >    This enables independent, granular compatibility versioning.
> 
> I agree that we should decouple versioning of these components from the
> global KHO versioning.
> Can't say I agree with the way you propose to do it.
> 
> I don't like that each user of a KHO component should include that
> component version in its own version string (or whatever it may become
> later).
> 
> It requires ABI headers update each time a user decides to add a new
> data structure and worse when there is a change to that data structure.
> It creates coupling of the data structure user with its particular
> version and just looks ugly IMHO.

It is actually the opposite.

If a user adds a new data structure, that new data structure will have
its own compatibility version. Instead of the current approach where
the global version string needs to be updated, only the new version
string would be added.

Also, if someone updates their code to use the new data structure, their
compatibility string is going to be updated anyway, as part of using
the data structure requires including the dependency in their
compatibility.


> Suppose we added new fields to vmalloc, but made the implementation of
> restore to be able to cope with both old and new versions. 
> How this would be reflected in memfd versioning?
> We'll add both versions of vmalloc to memfd version? And all other vmalloc
> users?

Backward compatibility is not in scope at the moment, but we can make
the version parsing more granular in the future.

Instead of a simple strncmp(), we can introduce a standard callback
interface for data structures. Each data structure implementation would
implement this interface, and we would pass the parsed version string
to the data-structure-specific version check.

> Or, say, we add support to kmalloc() and use it in kho_block.
> Then we'd have to add kmalloc() versioning to all kho_block users, right?

I was thinking about this. Since we don't have examples of data
structures depending on each other right now, I simply made sure
there are no duplicates in the compatibility strings.

If data structures have interdependencies in the future, we can easily
remove this uniqueness restriction. The users of block will still
include the block compatibility string (which automatically includes
kmalloc), and if user also depends on kmalloc, they will include it
as well.

> I think the versioning of each component should be handled by ->restore()
> of that component. If it sees an incompatible version in the preserved
> data, it returns an error. The versions can be stored e.g. in the base KHO
> fdt.

Hm, I think, checking compatibility inside ->restore() of each component may be
too late in the boot sequence.

By checking the composite compatibility strings upfront (before invoking
the actual restore/retrieve callbacks), we can guarantee that the entire
state configuration is fully compatible. If any mismatch is found, we
can cleanly abort the live update.

Additionally, keeping the versioning managed via composite strings on the
serialized data and registered handlers keeps the KHO core completely
decoupled from individual component ABIs, avoiding the need to bloat the
base KHO FDT with subsystem-specific versions.

> > 5. Adds a KUnit test suite to verify that the composite compatibility
> >    strings of different subsystems remain unique and sorted in
> >    alphabetical order, guaranteeing a consistent and predictable
> >    representation across configurations.
> 
> Without "composite compatibility strings" we don't need to care about
> them "remaining unique and sorted in alphabetical order".

These are not strict runtime requirements; they are simply there to enforce
code cleanliness and prevent human errors like accidental duplicates or
mismatched orders.

Even with a simple strncmp(), it works perfectly fine as long as the
strings match exactly. If the uniqueness or sorting constraints are too
strict, they can easily be removed.

In the future, we can transition to a more sophisticated version checker
that parses the composite string into individual subsystem version tokens
and verifies them one-by-one, rather than relying on a strict literal
strcmp() string comparison.

> The need for this test alone is already a red flag ;-)

I will remove test ;-)

