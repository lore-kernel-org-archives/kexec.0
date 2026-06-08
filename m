Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24293CD8C9F
	for <kexec@archiver.kernel.org>; Mon,  8 Jun 2026 16:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G7BP0s37Q+khF0GZ143YoXVWV8LzH4rQFimf53xc42o=; b=d0S35KJVrCjDD5W63zw6OxQJqQ
	lM3SkgkvD0C69AknOYs2EsUyBUJalj6NnuRrF88Me0tI24N1nUJ+1scSrxiE+HuXjt18CbNrn56SQ
	/2FVK2ZUTOVnRkZXLA6aV5LCUS6Yswpdi92QNyJIsx+kpE2A96uBcjYSSp8yrWiViar6gzaYdE57M
	nRQbYX7NpzQ4vgEWmzOxgt72JcslLF6wxZfqxwL4aR8a73JHoTubdfL0Xl3K9J/YSlRYp2rF9oDwb
	9hL45Z7Gsq3nNIOv996eVq6CdYmHyy3CS4aNyJr1BhrDx+Wt8/9PxskOYBVHI7yMr5rwOYW0tZWGJ
	XyZm+5pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWcb0-000000042Ph-2h7c;
	Mon, 08 Jun 2026 16:13:02 +0000
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWcax-000000042Ox-2nRk
	for kexec@lists.infradead.org;
	Mon, 08 Jun 2026 16:13:00 +0000
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-91574384cc2so519743885a.2
        for <kexec@lists.infradead.org>; Mon, 08 Jun 2026 09:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780935178; x=1781539978; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7BP0s37Q+khF0GZ143YoXVWV8LzH4rQFimf53xc42o=;
        b=Qh4PyNWyGQMiUHTGfy0B2bhujqbuQAXi78tZoKIH2EtfrRKZpbw28XWr77rGrCT55H
         vQNI1bQ/rK87cB5Cb/b3f+XnDvGLwQTGqVnzFKzHsjGj7uiiN/DcXdyKbYdij2LLMZgH
         V+6aeSc1iM+IOvqEw6dD1NYR/c14m1Ci2Zaoz33XWw8H1zxULTpCPRwITAJXNazIcZt2
         OaE4/pC21cspZSVR8O2Ja3+wQ2SOTx+52xNzEizSbgYCyQAdAOhDdlXF0um06vWkWAPz
         iItK2BAsH5VLvDIJYtl4RbUWEGfxVzzLEfad0Xux21X4VP8f2bwgsXTvAzfhKFJFdnIr
         dGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935178; x=1781539978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7BP0s37Q+khF0GZ143YoXVWV8LzH4rQFimf53xc42o=;
        b=mNH8KSrQf8ZN45f81tp49TqHIpYdlwviSqRMVxZwJFKvoDcaEqS1O5sEwvG5j+qca4
         g11jV94LmUiJh2D6xWArL9HP9O8rKyl+Sqq5VSzPlpWdY+738Xe6roWOYkKGxbGkB1sb
         f6/x5EmKjuAZ9INRbDFHtjgv3Cj36gnRf0G218wJER5IVykZqIyXzoEatnNkir++mDAB
         dF2rW0kVUg/enQ+N7mF5GWU4SvwWGs2o2rNf0xZcZUn+p1m5dTBDtnZ3Za5tVPYVTidK
         nIC6bL7sS8ETgXxorErm9YZmd03/HDBnRYPbxwFa7NOpFJ+s6zW5FnPX2D8oW2mHCRWG
         NDxA==
X-Forwarded-Encrypted: i=1; AFNElJ/sv56auP2TSZhP7fWMLYASu0UV1YMW151pav2BTPUI//EyXtj+OU2a+UbEvjskqcqbK77L5A==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhHXMoEyezuwKXBx0AEWHWCOi7smaijBDeZTerkrNm+PZm0WaS
	yphPp8K8Hu1ryLPpYoRDnQbECWy7UT73KS6j9P6S9qQ8Uh+ce+VwScgYge/4aZOb7Ug=
X-Gm-Gg: Acq92OERPJ0LRquEqJVOvp8cFh593ycYrHRCP0QJFWk8EoX/+WguOm8SLksHS8+3UDU
	QnrcaGPDW2IbPDrhzA+QQRFNrzPLRmjEOOQyuk/suueZlkItkVIvBH+sZCfSqLjlwyfugd/m/F/
	ZdyikJIrPwm07qqkkO8xXdzDLjXQDNqc+YdWhB2i/oHQGB2Y9gdgGvIKnF0wL46rrGo/0zR5Yiu
	qxZT+ER71AjkGTP9jgfUr8kTLWHmnQQ8rTzxjrDlTvPl2vF4CbpvdotZuGcLZpIuU2EkiEiMin6
	R02Q7mq5tvokXAxG2waeUhQWy+m98rj4jpsV6CHcvVu/c1JzLrRYjZXV+E8leHuJJiF3YgJJdNq
	oqd4WZ81Hnm85f8KyKx3kbaTwjXAhIdPZZRmv6hr3++57ZkgJnR5k8FqN8aRaFma0kxaGM3vkLS
	Vp58rN0JrEoqp/wxdAT5FNHdXxl/oBNkrUJCQ518ZubPGzIGSScRVeCuiS/hw0uQ==
X-Received: by 2002:a05:620a:1988:b0:8cf:c106:faca with SMTP id af79cd13be357-915a9d899a6mr2683778685a.36.1780935178189;
        Mon, 08 Jun 2026 09:12:58 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a00ba04sm1761661385a.7.2026.06.08.09.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:12:57 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:12:56 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, jasonmiu@google.com, 
	linux-kernel@vger.kernel.org, corbet@lwn.net, ran.xiaokai@zte.com.cn, 
	kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
Subject: Re: [RFC v1 0/9] kho: granular compatibility and header decoupling
Message-ID: <aibYJvzQQnpoN6YW@plex>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
 <178083348872.1648214.17778188633648887952.b4-review@b4>
 <aiVp5RlbWRz5VnPB@plex>
 <178091437240.1648214.10761111570005003901.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178091437240.1648214.10761111570005003901.b4-reply@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_091259_773133_C38C34D7 
X-CRM114-Status: GOOD (  68.38  )
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

On 06-08 13:26, Mike Rapoport wrote:
> On 2026-06-07 13:43:09+00:00, Pasha Tatashin wrote:
> > On 06-07 14:58, Mike Rapoport wrote:
> > 
> > > On Fri, 05 Jun 2026 03:32:26 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > > 
> > > Hi,
> > > 
> > > 
> > > I'd keep vmalloc where it is, it's more of a memory preservation primitive
> > > rather than a data structure of it's own. The data structure it uses is an
> > > implementation detail.
> > 
> > kho vmalloc is absolutely a data structure. KHO core only provides the
> > basic handover mechanism (FDT nodes, physical memory ranges). vmalloc
> > is a structured representation on top of KHO, and should provide its own
> > versioned ABI.
> 
> kho_preserve_vmalloc() has the same semantics as kho_preserve_folio().
> It's not intended to be used as a data structure. The data structure is
> an implementation detail unlike with kho_block and kho_radix_tree that
> are intended to be used as data structures and expose clear data
> structure APIs.
> 
> Yes, vmalloc should have versioning, but that does not mean it must move
> to different files.

Core KHO preserves contiguous ranges of unmovable physical memory, that 
is it. Preserving physical addresses and folios falls into that 
category, and everything else is built on top of it.

The underlying implementation is where the ABI contract is defined. 
Unlike kho_preserve_pages(), which just tracks raw physical ranges, 
kho_preserve_vmalloc() must serialize non-contiguous virtual memory. To 
do this, it passes metadata kho_vmalloc, kho_vmalloc_hdr, linked list of 
PFN arrays.

I do not understand why you are so against the modularization of 
higher-level implementations on top of KHO. Moving them to dedicated 
files makes the codebase cleaner and easier to maintain. For instance, 
at some point we might support sparse or partially filled vmalloc areas 
where VA size > PA size, or areas that have holes.

Keeping all of that in a single KHO file is the wrong approach and goes 
against how other logically separated subsystems in Linux are organized 
(e.g., mm/vmap.c, mm/vmalloc.c, etc.). Yes, there are some messier 
places in the kernel as well, but keeping this in its own dedicated 
kho_vmalloc.c file makes complete sense to me.

> 
> And, btw, moving KHOSER_PTR() infra along with vmalloc is wrong. It was
> my oversight that I didn't insist on using it for most of the
> serializeable pointers instead of open coded
> virt_to_phys()/phys_to_virt(). We need to fix it.

The only reason it was moved to vmalloc.h in this series is because kho 
vmalloc is currently the only user of DECLARE_KHOSER_PTR / 
KHOSER_STORE_PTR in the tree. I can move it to the newly introduced 
compat.h to keep it in a shared place.

However, overall enforcing the use of KHOSER is unrelated to this work. 
I have my own thoughts on this, and perhaps with proper versioning, 
using KHOSER_PTR everywhere would be appropriate, but let's keep that as 
a separate work.

> > If we change any of the vmalloc serialized structures (like kho_vmalloc,
> > kho_vmalloc_chunk, or kho_vmalloc_hdr), then vmalloc won't work and
> > compatibility will break.
> > 
> > Core KHO does not need vmalloc; nothing in kexec_handover.c uses it.
> > 
> > Instead, vmalloc has external customers:
> > - memfd (uses it to preserve serialized folio metadata)
> > - KHO test suite in lib/test_kho.c (uses it to preserve physical address arrays)
> 
> Following this logic, kho_presrve_folio() should be moved out because
> it's not used by KHO but has external customers. And radix tree should
> forever remain in kexec_handover.c because KHO uses it ;-)
> 
> > > Let's minimize the churn where possible for the sake of git blame and
> > > backports.
> > 
> > It is much better to do the right cleanups now while KHO is young. Once more
> > subsystems are added, this refactoring will be twice as hard. Modularizing the
> > code now guarantees a simpler, safer, and scalable design. Placing each data
> > structure in its own file gives us code that is easier to maintain, review, and
> > less prone to bugs.
> 
> dependencies
> > > that justify small headers for each two functions and netiher
> > > linux/kexec_handover.h nor linux/kho/abi/kexec_handover.h are that long
> > > to start splitting them.
> > 
> > External users only need to include the headers they actually use. For
> > example, LUO shouldn't have to pull vmalloc or radix tree KHO
> > declarations, and memfd does not need block.
> > 
> > From a maintenance point of view, it is much easier to catch ABI
> > changes when the file with the appropriate version has been changed,
> > and most likely the version of that file should be updated. If a single
> > header contains compatibility versions for several different data
> > structures, it is easier to miss the correct version update.
> 
> No matter in what files the definition lives, someone can forget to
> update version and we may miss it during review.
> 
> Would be better to spend this time and energy to add kho-specific prompt
> to LLM review to catch such issues ;-)

LLMs are great, and we should absolutely rely on them. Spending time 
defining LLM rules and helps in the long term, but none of that is an 
excuse for keeping the codebase messier than necessary. Having the 
codebase logically separated and modularized is still the right 
approach; ease of human review should always be prioritized, even with 
LLM assistants.

Localized context is incredibly powerful for preventing human error. 
When a developer modifies a structure in vmalloc.h, the corresponding 
compatibility version is right there in front of them in the same file, 
making it far more obvious that a version bump is required. In a 
monolithic header, it's easy to modify a structure on line 100 and 
completely overlook a global version defined on line 10.

Modular files drastically reduce noise in git history and diffs. If a 
reviewer sees a patch touching include/linux/kho/abi/vmalloc.h, it is an 
immediate, high-signal flag that a specific ABI is being altered.

Even LLMs behave much better when the context window is smaller. An LLM 
can read a focused file and understand the interactions much more 
accurately, compared to polluting its context with a unrelated 
subsystems.

> > Since we are splitting the source files (like kho_radix.c and
> > kho_vmalloc.c), the headers should logically follow the same
> > modularity.
>  
> They could. Doesn't mean they have to.

This is not a logical argument, nothing is have to... Keeping headers 
aligned 1:1 with their implementation files provides clean 
encapsulation, prevents transitive dependency pollution, and ensures 
that ABI changes are tightly localized.

> > > I agree that we should decouple versioning of these components from the
> > > global KHO versioning.
> > > Can't say I agree with the way you propose to do it.
> > > 
> > > I don't like that each user of a KHO component should include that
> > > component version in its own version string (or whatever it may become
> > > later).
> > > 
> > > It requires ABI headers update each time a user decides to add a new
> > > data structure and worse when there is a change to that data structure.
> > > It creates coupling of the data structure user with its particular
> > > version and just looks ugly IMHO.
> > 
> > It is actually the opposite.
> > 
> > If a user adds a new data structure, that new data structure will have
> > its own compatibility version. Instead of the current approach where
> > the global version string needs to be updated, only the new version
> > string would be added.
> > 
> > Also, if someone updates their code to use the new data structure, their
> > compatibility string is going to be updated anyway, as part of using
> > the data structure requires including the dependency in their
> > compatibility.
> 
> Sorry I wasn't clear. I agree that kho_vmalloc, block and radix tree
> should have their own versioning rather than rely on global KHO version.
> 
> What I don't like in your proposal is mixing versioning of a component
> with its dependencies.
> 
> I think that versioning should be completely local to each component.
> LUO should not care about kho_block "on wire" layout. This should be
> encapsulated in kho_block.

That is a fair point.

As I mentioned in my previous reply, we can definitely look into making 
the version checking more modular. For example, each component could 
implement a standard compatibility-checking interface.

These checks could run early in boot to determine whether each component 
is capable of accepting the incoming preserved data format.

Whenever the component is later used by LUO, memfd, etc., we can query 
that cached status. This achieves four key benefits:

1. It avoids delaying the compatibility check to the actual time of data 
retrieval, which is too late to safely abort.

2. It prevents a local incompatibility from triggering a global kernel 
panic, allowing us to handle failures gracefully for just that specific 
component or session.

3. It keeps the local version local, as you suggested, so it is checked 
only by the consumers of that specific component.

4. It provides a clean path for backward compatibility, as components 
can individually decide whether they understand the incoming data 
format.

> > Backward compatibility is not in scope at the moment, but we can make
> > the version parsing more granular in the future.

100% Agreed.

> > Instead of a simple strncmp(), we can introduce a standard callback
> > interface for data structures. Each data structure implementation would
> > implement this interface, and we would pass the parsed version string
> > to the data-structure-specific version check.
> 
> Backward compatibility will be in scope sooner or later and string
> parsing is surely not the way to deal with multiple versions.
> 
> How do you suggest to represent support for multiple versions?
> "luo-v2;luo-v3;block-v2;block-v3;block-v4"?
> 
> > > Or, say, we add support to kmalloc() and use it in kho_block.
> > > Then we'd have to add kmalloc() versioning to all kho_block users, right?
> > 
> > I was thinking about this. Since we don't have examples of data
> > structures depending on each other right now, I simply made sure
> > there are no duplicates in the compatibility strings.
> > 
> > If data structures have interdependencies in the future, we can easily
> > remove this uniqueness restriction. The users of block will still
> > include the block compatibility string (which automatically includes
> > kmalloc), and if user also depends on kmalloc, they will include it
> > as well.
> > 
> > > I think the versioning of each component should be handled by ->restore()
> > > of that component. If it sees an incompatible version in the preserved
> > > data, it returns an error. The versions can be stored e.g. in the base KHO
> > > fdt.
> > 
> > Hm, I think, checking compatibility inside ->restore() of each component may be
> > too late in the boot sequence.
> >
> > By checking the composite compatibility strings upfront (before invoking
> > the actual restore/retrieve callbacks), we can guarantee that the entire
> > state configuration is fully compatible. If any mismatch is found, we
> > can cleanly abort the live update.
> 
> If a ->restore() returned an error (for any reason) we anyway need to
> reboot, don't we? 
> 
> What do we do if memfd discovered incompatibility, but, say hugetlb
> global state was already restored?
> 
> If you really want to run the compatibility check upfront, we need a
> mechanism for that. And that should probably happen even before
> kho_mem_init().
> 
> > Additionally, keeping the versioning managed via composite strings on the
> > serialized data and registered handlers keeps the KHO core completely
> > decoupled from individual component ABIs, avoiding the need to bloat the
> > base KHO FDT with subsystem-specific versions.
> 
> Actually FDT "compatible" handles versioning nicer than composite strings
> You can have
> 
> 	compatible="kho-v4", "vmalloc-v1", "radix-v1", "block-v2";
> 
> and check fdt_node_check_compatible("vmalloc-v1") for vmalloc and
> fdt_node_check_compatible("block-v2") for block.

That is actually very similar to what I am proposing—individual version 
tokens (which in my current series are concatenated into a composite 
compatibility string separated by ';').

But let's not get too fixated on the composite string formatting. I 
actually really like what you are proposing: using integers for versions 
and having each registered component carry its own "NAME" and version 
number in the KHO FDT.

> And we wouldn't need to reimplement string parsing ;-)
> 
> But yeah, I do see value of making components versioning and KHO global
> versioning independent. I just don't like composite strings and I don't
> like mixing versioning with dependencies.
> 
> Since we are moving from FDT for the most things, version should become
> a number rather than a string and version compatibility should be

AFAIK, for everything but KHO itself is going to be FDT free. I would 
like to be strict about that going forward :-)

> independently verified by each component.
> Then dependencies between components will remain at API level rather
> than brought into the ABI.
> 
> If you think ->restore() is too late for compatibility check, we should
> work on a mechanism for upfront compatibility verification.

+1.

Pasha

