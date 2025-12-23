Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CE5E6FE23
	for <kexec@archiver.kernel.org>; Tue, 23 Dec 2025 17:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TTLC7OEVGIoEXEyvllrnolAl7aW+wPLOmIrEw4xjfLQ=; b=SaNAgSgwYzmNr+kiwRXDaHdySH
	coKJsHuQ/e4PK1MrH58iwKKSNbPsZ8MdL1e4RSbaVFFZCcinq0P/yO68e/T/2X3XkrhjSpXM07EJT
	kYLPqEaDrZGd5o8anRpg/3S6XVpwI3Sskjr49tCN3hbMS1vuS2LuXE8bdmY803XPMI8FzHznqHm6O
	xFCeq1kNgrb4aIBuI/8R9fVQ4Oa31k/hnuz7UIxc+bgPzD2bcXND4THk9615zJ4Fxdxqk1vRUZp7Z
	jCnGdf2X+AA1h6gai+bl4G0M8JWq1f1IcrwtwBlEKr1Hgvxq1q5x2mZzgFggRhRxu8jUnjUiU9esB
	+C3K/7cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6Ku-0000000FqBn-4ARx;
	Tue, 23 Dec 2025 17:38:16 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY6Ks-0000000FqBN-188W
	for kexec@lists.infradead.org;
	Tue, 23 Dec 2025 17:38:15 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so7476035a12.0
        for <kexec@lists.infradead.org>; Tue, 23 Dec 2025 09:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1766511492; x=1767116292; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TTLC7OEVGIoEXEyvllrnolAl7aW+wPLOmIrEw4xjfLQ=;
        b=Lq/nmdNjfWIPYBN1mpZlT/6yaO8w27/61uX92FXYFyk/TqflXQaiBP+uFz9ziYGV4N
         iisO5NtQ8kLkxgP2hzMVvOkZAIZBNWFrUprKamin4FGMChd7VGVujiSC1OJYinz1PVYC
         S6XoVCBZAFCEtf0UK9yV8QNmPl7FdNDGSmcdh+Q0XO6/2uSAU7XtkZC+Y6NaVTtrKYb5
         9V0K+14Rf+BIRAqxW8PN0HTky1h8ip9QdIp1KTUJRcmfnFFjNhGTxwRYZTs+06rOEvpx
         qznfEujxK49Q7sqiYshYbPpLawq5OG1QuI13NHDk70M9LwnbQrFG9hG15ZOut5REcKuO
         v6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766511492; x=1767116292;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTLC7OEVGIoEXEyvllrnolAl7aW+wPLOmIrEw4xjfLQ=;
        b=quR8l1gNgxnc5bt61rwrwpW0W2BLH1gpprBf/JDtM3WKeI/tROAtR4GO0XootQ0abO
         lCVRgCIdjF0DxvK8iLifYiT90TmPDQL9sqIs3988aC3qqmx3B4dwCpgCG/rr1MAFliGU
         BL0ohM+GVQ6PccoUH9f6OPTJpcXO5O87iptoZKHqWpxNhVRPsTmAe7az5sZ0/m1hQU7N
         srph88f9UhjWZItpErHJBo9jptbwbywGbbUQXBvicF2PPxmBjNI+EXFgbuvEgiKBC1Yo
         GZlp82JJUUBAuWjfusz1bC4gSEnzOB8tF0Z2lEWUb/U6UUdlIlxXSSSkj4pnpSKR7Kjw
         oOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAlWkCLwY1IR38KymbTKq+M+/NiuSE2agZIu5PFmxcRzNSAsxYNB1u58+rMOHxG2NSgKe1cA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxHIkFfBXWHgKKOpcgrjlmuFkcAham06ezdpHcuQKKhtDZpv5WD
	FEacL1TqKjZzL4Raq2g+m8K7N8RW1sF51053KATtcNBLj57dTKS80GyccizfhiMqRrQdbIfhuUY
	WKlrlub0Hu2s6Vszij2BFWXIUhEuc+EFRlZg6xexFKA==
X-Gm-Gg: AY/fxX4Ck5JFzi7SnKXEk7GjRtNlZnvrDa43v+CBMNUckzcuG6aCwdYbKSm2qQwf79Y
	cqjP+3zPWfWv5ulF9c4US/TYE/7Hx7wtdCUfeZPYy9hYOyIlyfK7919qvP7/fdv4DNY0Kp2+uGX
	DyY+2FscsNCgEKXrysSN9GKJ53LVnDQj/W7BmuIq4UaiK8Ugyqjc7/0g5Z7XqbG3RSD2WC/Ot81
	6eNlXEXO5mEp/j+XaLdPMFFR9RrWtDDmGcqGacN7oPGS0FVrdmWT5KzDn+cPzKqDqcvZV+g6F6q
	FZR0Vz1/wcJKE+1MX638iD2jJg==
X-Google-Smtp-Source: AGHT+IE124uBCZCPJySJNjN/QHQdpyXa77YXFpY55orIImpDxYcMb4oh90L3OIkReSgyrytjfimRLEMoj5BCtx1k5Zs=
X-Received: by 2002:a05:6402:34cc:b0:64d:498b:aee7 with SMTP id
 4fb4d7f45d1cf-64d498bb3ccmr7158286a12.9.1766511491347; Tue, 23 Dec 2025
 09:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20251216084913.86342-1-epetron@amazon.de> <aUFJH9xzJXYOt_X8@kernel.org>
 <CA+CK2bDGvgcGJijAtSSa2k_FWjnZXm2jRiFd6Z9-XjEQ-Y68DQ@mail.gmail.com>
 <aUF4fsWwD9BswkFh@kernel.org> <CA+CK2bB2mn5b0N9gs1UavYLUQhbpVvdo702oHZa15E9OaZkKWg@mail.gmail.com>
 <aUUYprAotKYMiEs0@kernel.org> <CA+CK2bD101cSC_7+OWkMei2QvUVjSaRLy+LboLe8Sz7KS3by4g@mail.gmail.com>
 <861pkpkffh.fsf@kernel.org> <CA+CK2bA1kYCf0BwhX3Sg9Ur82nK-7HPzs0sg6xbVWFAJaZLhpw@mail.gmail.com>
 <86jyyecyzh.fsf@kernel.org> <CA+CK2bDxnTEe9Ohq5zLuyF-jqgD0DPhfdq6z=yztUsXU5p5fSQ@mail.gmail.com>
 <863452cwns.fsf@kernel.org>
In-Reply-To: <863452cwns.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 23 Dec 2025 12:37:34 -0500
X-Gm-Features: AQt7F2qaH0m0VJoMuoVXVcmA15RsVJHyeu9_tkkVe-fDVNFSdl7k8MrpDozG4X8
Message-ID: <CA+CK2bCjJWZG_rPoPsHWSxirmUCTOuFQzTCss2AKf9UqpThrdw@mail.gmail.com>
Subject: Re: [PATCH] kho: add support for deferred struct page init
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Evangelos Petrongonas <epetron@amazon.de>, Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jason Miu <jasonmiu@google.com>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	nh-open-source@amazon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_093814_346773_7207199C 
X-CRM114-Status: GOOD (  39.37  )
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

> > if (WARN_ON_ONCE(info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER))
> > return NULL;
>
> See my patch that drops this restriction:
> https://lore.kernel.org/linux-mm/20251206230222.853493-2-pratyush@kernel.org/
>
> I think it was wrong to add it in the first place.

Agree, the restriction can be removed. Indeed, it is wrong as it is
not enforced during preservation.

However, I think we are going to be in a world of pain if we allow
preserving memory from different topologies within the same order. In
kho_preserve_pages(), we have to check if the first and last page are
from the same nid; if not, reduce the order by 1 and repeat until they
are. It is just wrong to intermix different memory into the same
order, so in addition to removing that restriction, I think we should
implement this enforcement.

Also, perhaps we should pass the NID in the Jason's radix tree
together with the order. We could have a single tree that encodes both
order and NID information in the top level, or we can have one tree
per NID. It does not really matter to me, but that should help us with
faster struct page initialization.

> >> To get the nid, you would need to call early_pfn_to_nid(). This takes a
> >> spinlock and searches through all memblock memory regions. I don't think
> >> it is too expensive, but it isn't free either. And all this would be
> >> done serially. With the zone search, you at least have some room for
> >> concurrency.
> >>
> >> I think either approach only makes a difference when we have a large
> >> number of low-order preservations. If we have a handful of high-order
> >> preservations, I suppose the overhead of nid search would be negligible.
> >
> > We should be targeting a situation where the vast majority of the
> > preserved memory is HugeTLB, but I am still worried about lower order
> > preservation efficiency for IOMMU page tables, etc.
>
> Yep. Plus we might get VMMs stashing some of their state in a memfd too.

Yes, that is true, but hopefully those are tiny compared to everything else.

> >> Long term, I think we should hook this into page_alloc_init_late() so
> >> that all the KHO pages also get initalized along with all the other
> >> pages. This will result in better integration of KHO with rest of MM
> >> init, and also have more consistent page restore performance.
> >
> > But we keep KHO as reserved memory, and hooking it up into
> > page_alloc_init_late() would make it very different, since that memory
> > is part of the buddy allocator memory...
>
> The idea I have is to have a separate call in page_alloc_init_late()
> that initalizes KHO pages. It would traverse the radix tree (probably in
> parallel by distributing the address space across multiple threads?) and
> initialize all the pages. Then kho_restore_page() would only have to
> double-check the magic and it can directly return the page.

I kind of do not like relying on magic to decide whether to initialize
the struct page. I would prefer to avoid this magic marker altogether:
i.e. struct page is either initialized or not, not halfway
initialized, etc.

Magic is not reliable. During machine reset in many firmware
implementations, and in every kexec reboot, memory is not zeroed. The
kernel usually allocates vmemmap using exactly the same pages, so
there is just too high a chance of getting magic values accidentally
inherited from the previous boot.

> Radix tree makes parallelism easier than the linked lists we have now.

Agree, radix tree can absolutely help with parallelism.

> >> Jason's radix tree patches will make that a bit easier to do I think.
> >> The zone search will scale better I reckon.
> >
> > It could, perhaps early in boot we should reserve the radix tree, and
> > use it as a source of truth look-ups later in boot?
>
> Yep. I think the radix tree should mark its own pages as preserved too
> so they stick around later in boot.

Unfortunately, this can only be done in the new kernel, not in the old
kernel; otherwise we can end up with a recursive dependency that may
never be satisfied.

Pasha

