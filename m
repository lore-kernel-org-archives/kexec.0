Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EECECD4F54
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GG/5GCoeUNsrfPDvW1y+TyKN6C1lDobHYKQB8oiejhg=; b=S2W3Y89IAa7NHgtrXpOTd0Ytpd
	6Yz5xz95uYMqZTazvaQpvb6QNh5oBAcIw7wEHEJ1NIMnrgb0NJe9tBtCNDpiw+fcjzg/M/XD6CKr1
	d4EyLBY3932mheDJM9nAynDpLwsnPUajqZaT3OXZLxyuUEnt+jDDhYWDygIX5dsa1fdWKyfrXIwXg
	1oC6Pdq1BbiKrYxEenrXedwin/vtHKJMqNVITJsYSlYZAubaNWetkLGg/xJke3ArnikpDqDSKmVJH
	1gIuX8iK0sEs6d+t1+5uHXqPX2j0/FWj1iVmCgJ1iMewjFcSMFRs1VsJju6yilLm12im73++UH305
	W7bx1hvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4Uc-00000008Ew1-2lsc;
	Fri, 29 May 2026 21:11:46 +0000
Received: from out-178.mta0.migadu.com ([2001:41d0:1004:224b::b2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wT4UZ-00000008Ev1-2e7A
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 21:11:45 +0000
Date: Fri, 29 May 2026 14:11:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=key1; t=1780089100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GG/5GCoeUNsrfPDvW1y+TyKN6C1lDobHYKQB8oiejhg=;
	b=JnH/IUB+yUZ+0i59/kNTQ7Fn6NoTlkzZgqYd5GGytHRXFwVBdL41P1R8q2hwP2TvJPqbXp
	//3zQgg2Yf5zrlvY8CTyQ5ybkYpI/9HSOkO+g3QoDOEzY83AdEHkzzhNqKQcyvijrBFfYH
	6ptASG3En9xDOc5nzeIdF39Y9dEv17ymzJr2nm9VtET1AqsfKt475ClPOmAZndVvPZ8tdw
	5jJVwqVFNdEBeV2ZksOVHwT2fREIuoF17HIFRmJPiQtKpcpyRXZMBtDfqrGNOMXkBgTF1k
	5kPsyLusjA36bTtD3UEs2dhbDEEF0dn5WN2zhzf5xxjYJw52DWD0wFoc9PK4mw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Krister Johansen <kjlx@templeofstupid.com>
To: Tao Liu <ltao@redhat.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org,
	aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
Message-ID: <ahoA_5MfC7FuC8CQ@templeofstupid.com>
References: <20260414102656.55200-1-ltao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_141143_911552_EA5F3FB0 
X-CRM114-Status: GOOD (  28.44  )
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

On Tue, Apr 14, 2026 at 10:26:47PM +1200, Tao Liu wrote:
> A) This patchset will introduce the following features to makedumpfile:
> 
>   1) Add .so extension support to makedumpfile
>   2) Enable btf and kallsyms for symbol type and address resolving.
> 
> B) The purpose of the features are:
> 
>   1) Currently makedumpfile filters mm pages based on page flags, because flags
>      can help to determine one page's usage. But this page-flag-checking method
>      lacks of flexibility in certain cases, e.g. if we want to filter those mm
>      pages occupied by GPU during vmcore dumping due to:
> 
>      a) GPU may be taking a large memory and contains sensitive data;
>      b) GPU mm pages have no relations to kernel crash and useless for vmcore
>         analysis.
> 
>      But there is no GPU mm page specific flags, and apparently we don't need
>      to create one just for kdump use. A programmable filtering tool is more
>      suitable for such cases. In addition, different GPU vendors may use
>      different ways for mm pages allocating, programmable filtering is better
>      than hard coding these GPU specific logics into makedumpfile in this case.
> 
>   2) Currently makedumpfile already contains a programmable filtering tool, aka
>      eppic script, which allows user to write customized code for data erasing.
>      However it has the following drawbacks:
> 
>      a) cannot do mm page filtering.
>      b) need to access to debuginfo of both kernel and modules, which is not
>         applicable in the 2nd kernel.
>      c) eppic library has memory leaks which are not all resolved [1]. This
>         is not acceptable in 2nd kernel.
> 
>      makedumpfile need to resolve the dwarf data from debuginfo, to get symbols
>      types and addresses. In recent kernel there are dwarf alternatives such
>      as btf/kallsyms which can be used for this purpose. And btf/kallsyms info
>      are already packed within vmcore, so we can use it directly.
> 
>   With these, this patchset introduces makedumpfile extensions, which is based
>   on btf/kallsyms symbol resolving, and is programmable for mm page filtering.
>   The following section shows its usage and performance, please note the tests
>   are performed in 1st kernel.
> 
>   3) Compile and run makedumpfile extensions:
> 
>   $ make LINKTYPE=dynamic USELZO=on USESNAPPY=on USEZSTD=on EXTENSION=on
>   $ make extensions

I love this idea.  Do you have time to take it further, and if not are
you open to making the extension framework more modular so that we could
add others in the future?

Could the btf lookups be extended to cover the symbol lookups used by
eppic and the erase filters so that the -x option is unnecessary for
kernels that have BTF support?

The current extension implementation is focused just on skipping pages,
but it would be great to be able to use this to erase data in structures
like the config filters and eppic, but without having to provide a
vmlinux at dump time.  What do you think about adding the ability to
use the extensions to also erase parts of data structures, in addition
to filtering whole pages?

Would you be willing to modify the extension registration options to
allow an extension to specify what kind it is? That way, in the future
we could register multiple different kinds without breaking existing
ones.  One for filtering pages, one for erasing / modifying dump
content, and others based upon whatever additional use cases develop.

Thanks,

-K

