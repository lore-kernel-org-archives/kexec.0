Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D945C55167
	for <kexec@archiver.kernel.org>; Thu, 30 Jul 2026 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=; b=Z7EEuPMHcq8nLd1BkQkdNLBJi1
	HOYH13BS5iZxTlTnBt2JnNqD67sZGp3mVwlmFf/Ci8OPxPhqE4UX9s1zPP9jDj7FfieKhD9G5z8ed
	75xxS64Cs6fFsUls5IVrriOy1RP9kotnpBA7av1GB2B8TofUPUGUsuSpwyNMThALH1C/EJGQuu+qO
	fpGsbmTd8AXNlslvykXIs1JzXCG8GHy6LOGcL2uOYSTZhcQuUm2XKRI126jBL9xLkmmW7fqB8qWX0
	i7ncQckQ1FLFIGr0iFFaJ+aMcnMi7y0FDSz4L9tDi28qtCIVVTgUipSejtGqtgzIdfLqZ/mCTQzGS
	V8tGUJ+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZWI-0000000BS09-1wrg;
	Thu, 30 Jul 2026 22:46:30 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZWD-0000000BRzj-16TV
	for kexec@lists.infradead.org;
	Thu, 30 Jul 2026 22:46:28 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso194317a91.1
        for <kexec@lists.infradead.org>; Thu, 30 Jul 2026 15:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785451584; cv=none;
        d=google.com; s=arc-20260327;
        b=pkqzEEMFt/shWzY+k+BGskmQgM9xuBwBYOVtn0m1zfmZtCnFPpoZmBLWKdcJ+NOZZy
         YJ7N6zy/VtP971FY9KdNdyu/0xXzThhHus++v8C5uv0JLX4DT7IAMtg7pUmRIS4bG5NO
         A7wkFV5i8GN70RpqIUWilbMGWg26X8UcgIYvRecykdB4nvJxjixWtbkhPGAeEa2510rj
         f1PtXIDO6aetmZ2fNlRgxMfZazwciIeIOnnC0yxPAqGR0XxhPCiQtSd0gOoxsg/h+Pa6
         K9/+qxch6h1R6JjjXu69lWgXa881HDtdJDU4XOBbNDA9JrqNohvcviPsgnMonRmOVMO2
         xveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
        fh=FT9dLOFX0FYAIXP5wczl6fEMfGHAl/CThdJWjpowaQo=;
        b=oafqzE1TuvgJ2jJW0IZNbd14oIooeFPiLOuUNt3zhJ3oLpJK/yw3tcrsxl5bADkI7r
         IknhVVGwCpAz0yOuW+3zPMrM48qxRAzHrhiGj+gdLmFDUgd+4BcnJ+Dv89sO1Ow19A6H
         YEqCjVO8xHTQh1awzOmUCzSeTS45+izy1VLcVqzp5pvnQ3TI7bR/Gqxf094V2zuLfG2w
         pu3pvRMABjtn7KTZO6Sd8t0MTh9O/RDXySgqC3ziog5K/RiJ29x2RvqH+iDvlJP3insn
         EnlC3xJM5w7gENk7RZoBS7jWPezyXDlQ1TE7oMvhpmwEfAxkFMSckz0JDoMSOkstNcm7
         iheg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785451584; x=1786056384; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
        b=jzNXs+7JMS1OtjMcnYp9XZsbHy9a52hq2H4TxwH3zI3V9LSK8GCW44UCN1t0rUkylQ
         JdiIeuSpBlO74ToVMn9KvdhHCcis6kPg9q6n4jzmDTtEA0g95CVaX11kwnLSzRIYCpXY
         O0eb77/lbpTbB0t85CJKtmwd7/qhs2obx7eAtBel4jCAl5/a2uTAWY+0o6B03n20Zqr2
         TVIBshv+Hdjdsj1VTQrkwLj7Mf4IqQYX3FXLWc8LeCNYZRX48v52v/lASohcg4M04JgL
         1zDsFETXcDGGWjHv1JF2rQBWyUnbCdQb/FWD05ioGGFJoR8g9qAvy53oJSgBXLMf2xXU
         +1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785451584; x=1786056384;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W7DZ+f0MeQTnq04NgpGqANM3Cz0BYewhjBpaHxc9ELk=;
        b=jyd4cFhzlLl8pz1/uRC0WklKH21RHXXbvL1FuUBB+lRqgzz0IupV65oXRYi2KGMDHV
         07tjzIZQNRXTHKU3/4NKB4xJAwL3uoUN9N5bXl0zDn2/hh3TjB/BDT+TBQ3xAEj9nAwM
         B29ILkly0cqvTyb1UxsaTmPf2D29eW425iE3uSTopaGL1uRFIVWMlwG9JxMEINhV18yO
         4crzMAH3e52CpZmSvAMeOSfg8/8VA1J7cs2XsP9ZW2UFEXH25onqZhv4v514c8ZneXaF
         vc4dI5eWz8JOSTrbEJCvQFbpAKxcTC4jqlGOTmliV8wGwFEIy9FRarVpE4J7nyoIPlfw
         Ejdw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/Y2QsN0zVR3XjVnoTvFY7/Riug1LNOpQNNW4mHdVKNFvxY0z9GJFTtPU78r1uWRcXysBZ1A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxB7miJr8xeJ+6jec80SGV83ifFmSd6bJAfj3Hd5VfGeJmGPD86
	joEoX5GAteI2rzjjbjDWBRfWC9lQoHx4uanyDADWbsGcGXkgIdbkhp/0iQnf0IQNDvE3jktZmMS
	XH83ER3pcxB0fTKq8FetS3qwA6tjWsctxNkMW8Xz1
X-Gm-Gg: AR+sD10UFwk6unFWo9xbP/pPDBfSFG22dOvU6/CifcQTM4A13MSjALxk/DsY3ic/F9m
	yfP+0I+eLCVwQ3CXwzHxXrgX2uyBTd6s0N0KHvVeo4GiAVGHNOXL+VCp4JAUQ0gsztbrM2YKKRU
	f9pJrnP0N1PoW4H9IqjmWqfLCeccXosTlUQckuMB4UoG4bd+AokBfotuZ9oacK413VSCt9868AU
	x8PEl7u+2N11sDOa0CqmaxpeISh6+oL+wzUHamYSKOQX7yDPvvPI38FqhDeKgZ7KZkZM/WKQ+6M
	WlYw7SCd1LaED2+rQRXPtRTiQAl1LFr8l1rfHgo5AyxTFlXk+pZMbqtc663xYXavD8UHSgy8p6U
	dxRWvlVSGSj5NJgXttvHrX5s/fVXa8MM1CWCgNT0h1cAbQA==
X-Received: by 2002:a17:90b:2f06:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-38fa68500b7mr1838360a91.4.1785451583701; Thu, 30 Jul 2026
 15:46:23 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:46:22 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Jul 2026 15:46:22 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <afEwWZksU0Fw61oT@plex>
References: <afEwWZksU0Fw61oT@plex>
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 15:46:22 -0700
X-Gm-Features: AUfX_mztKVf-vmsid_VHO9yf9OChzZkQAo084zzlpI1FA8C_xfqYz8r7z-LEAo8
Message-ID: <CAEvNRgE8YHXVZLTQQYZJrJvnrW+WUfpGUn2XpxpkDRj1Zwi4Cw@mail.gmail.com>
Subject: Re: [RFC] proposal: KVM: Orphaned VMs: The Caretaker approach for
 Live Update
To: Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, kvm@vger.kernel.org, linux-mm@kvack.org, 
	kvmarm@lists.linux.dev
Cc: rppt@kernel.org, graf@amazon.com, pratyush@kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, maz@kernel.org, oupton@kernel.org, dwmw2@infradead.org, 
	alex.williamson@redhat.com, kevin.tian@intel.com, rientjes@google.com, 
	Tycho.Andersen@amd.com, anthony.yznaga@oracle.com, baolu.lu@linux.intel.com, 
	david@kernel.org, dmatlack@google.com, mheyne@amazon.de, jgowans@amazon.com, 
	jgg@nvidia.com, pankaj.gupta.linux@gmail.com, kpraveen.lkml@gmail.com, 
	vipinsh@google.com, vannapurve@google.com, corbet@lwn.net, 
	loeser@linux.microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	roman.gushchin@linux.dev, akpm@linux-foundation.org, pjt@google.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_154627_198270_115374B8 
X-CRM114-Status: GOOD (  14.07  )
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

Pasha Tatashin <pasha.tatashin@soleen.com> writes:

>
> [...snip...]
>
> The Caretaker
> =============
>
> The Caretaker is a specialized, identity-mapped bare-metal executable
> attached to each vCPU. While it is installed during the initial VM setup
> and remains permanently enabled as an interpose layer between the Guest
> and KVM, it is the key architectural feature required for a VM to be
> orphaned. By providing an execution environment independent of the host
> OS, the Caretaker enables the guest workload to safely survive the host
> lifecycle transition.
>
> During normal VM operation, the Caretaker acts as a fast-path shim: it
> forwards standard VM Exits down to the backing KVM kernel module and
> handles certain exits autonomously. However, during the "Management Gap"
> (when no host OS is active and standard KVM handlers are offline), the
> Caretaker enters a standalone mode to ensure continuous guest execution
> without host intervention.
>

I think this might already be explained in different ways by the other
commenters.

I guess the main question I have is, if the Caretaker could indeed take
over caretaking during a "Management Gap", then we're adding code to
tell KVM what to do to handle some VM exits.

In that case, it would be awesome to have that functionality provided by
KVM in the first place, to avoid some number of kernel exits to the
userspace VMM.

> While this proposal focuses on its critical role in minimally disruptive
> Live Update, the Caretaker is fundamentally designed as an extensible
> primitive.

If the Caretaker can/needs to be extended, then on the other extreme,
the entirety of the userspace VMM's functionality could go into the
caretaker, and perhaps that's another direction to go, where maybe LUO
could keep some slice of userspace alive? (then the VM is no longer
orphaned)

> Its architecture allows it to be leveraged for a variety of
> other advanced virtualization use cases, such as running custom
> lightweight hypervisors or completely offloading virtualization duties
> to an accelerator card.
>
>
> [...snip...]
>

