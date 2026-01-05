Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84C9C2A094
	for <kexec@archiver.kernel.org>; Mon,  5 Jan 2026 10:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AEsrfFSGpZi9ASLRdkHNghNCtZ2WVv91pfY2tmYJY2c=; b=sQwzQvKTgENREPZEWKqjo5GWmu
	lHQit8CbnUQGDNocL57pFmiHRJ0yiTbBahZBVtgYPZ/VPFRRk8MPO77PkeWYUyPB6fTxCy+1CWwl8
	MK6LSPhUPEZDYjLg+28aL7ZjJoQm4twQcHlO4j7CAWVRbzqYM3Dy8l/CpoVfi3G2iu2jLSCInvW1q
	WuprCE7y9ajrTdU6z/hHfIOcOhXxJ/XA9jYL5nzcGYhWRdANuH2jptwC1ztTjkEthP9kyhgMUCNOd
	ByYY4QG17qnmFNWD4Zb6reO+qGOLHx3A6Uo1ulWSIdsOUsTR97Rc75gq/3vfLDVz/EXyJr3l8Sfpo
	NL5Fvk3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vci7l-0000000B8g9-36zC;
	Mon, 05 Jan 2026 10:47:45 +0000
Received: from mail-oi1-f176.google.com ([209.85.167.176])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vci7j-0000000B8fl-3cdP
	for kexec@lists.infradead.org;
	Mon, 05 Jan 2026 10:47:44 +0000
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-459fa8b6044so2795264b6e.2
        for <kexec@lists.infradead.org>; Mon, 05 Jan 2026 02:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610062; x=1768214862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEsrfFSGpZi9ASLRdkHNghNCtZ2WVv91pfY2tmYJY2c=;
        b=tsnIxYwce8a47AbwCAzF24WUou59lWua+irsCI08pk8rPvv19grr6oBRqe65YweVr9
         BH9cwKx1UTPNCCz8lFMCGZJQkCtqZDV1V5YIpgxeITGMhNSzNaHLxTzF2co8Ii9MRcDY
         wmt02itKXwD6l2Ad1URzTdo+hmrm/eLcv8g5xJMhKaZXTlUkPCqC+mw5DyTc/UMNaPNp
         dmbYXsbN16OolIiPayHnBWRkVh4fYwkahfbdn+a2w1wIwdPEWU7bHYgVmrZXp4Lzs3t3
         +Xb9OvpgIz4gXW709e4QYTlOpvQSfIecoL3AaMqPiwSjn6653JrNrarMNspDIuzsvVa+
         ba3w==
X-Forwarded-Encrypted: i=1; AJvYcCWiNaJW2r3Kys2VN8nSrs0fEUSOTMBTFUhUAyD7GDPqiTr3bPehbY6KfVSRAV5Um+l5jne9Fw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyF36uXSOeOFzo/AYnwX0mib7K2PO53HZIREsNUxbf1scygvWcV
	VILRlzr8sg9GcqyCSFCkaUnFsZBfDMrPrVVaUALCdkR/lh+v8KvDW1mU
X-Gm-Gg: AY/fxX5j0xKX613OEf3D/A1DPlypp+TatnjilZ0cMFORD+oE5uiGBbsxmxVgpqSMUvl
	4fK4INRm/l/iQKp5DnPi9aC5bIbEd+Xg/2m9+OGdMHnEfVshJ0rb8gS8fvL5g/Zh8QcR5YTcvkw
	zmatSjO97ZHhIcNrriPyLOVhf5F6BZrXWwuHFyFNy8whS5cHSMwqRLnIhcgyIrfYTjB0apLLMVD
	RHMyyIjCXRmUEv3MX0t4IWjGZgNYGXhtEGu6yIhYwZCdvTJKhsL/CNrzqRv8HAd+b43ZBWkeQJa
	ptKAobqcdVkWsvErQQtukqEezEyQaZWHF7aNYE22n2yiBwPdP5VF5XjwauJUTkJzQXeCM+Y98N3
	Yy5yLrxyIIe0o8lXbXt/zFyTtERHl9K+qGvDJdxelzdfkhbzmBC23z+gQCSCkVoJtJwU6ZxaYbc
	+DqVZ+3hXPflBJL8SP8E72aZ6J
X-Google-Smtp-Source: AGHT+IEwXxwWocz3VK/aAh4+7MTdg42Q1LzhGoYzyLvRU3S8MGGvIvy4zzBvdu4VmS5Kx6cPAUk+Qg==
X-Received: by 2002:a05:6808:1882:b0:450:c776:876f with SMTP id 5614622812f47-457b22410ccmr21114894b6e.54.1767610062321;
        Mon, 05 Jan 2026 02:47:42 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-457b3f1761csm23007975b6e.22.2026.01.05.02.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:47:41 -0800 (PST)
Date: Mon, 5 Jan 2026 02:47:39 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] kexec: history: track previous kernel version
Message-ID: <josgeh3zd55a5sjmclidj53v7hoekzvb63ah45aocvgwh6ajxk@rnzjabyqkojz>
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-1-1747b1a3a1d6@debian.org>
 <86secn7ors.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86secn7ors.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_024743_905956_5E153F4F 
X-CRM114-Status: GOOD (  21.94  )
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

Hello Pratyush,

On Fri, Jan 02, 2026 at 09:17:27PM +0100, Pratyush Yadav wrote:
> > Subject: [PATCH v2 1/2] kexec: history: track previous kernel version
> 
> Nit: please use the prefix "kho: " for KHO patches.

ack.

> On Fri, Jan 02 2026, Breno Leitao wrote:
> > Add CONFIG_KEXEC_HISTORY to store and display the kernel version from
> > the previous kexec boot.
> >
> > When enabled, the current kernel's release string is saved to the
> > "previous-release" property in the KHO device tree before kexec. On
> > the next boot, if this property exists, the previous kernel version
> > is retrieved and printed during early boot.
> >
> > This helps diagnose bugs that only manifest when kexecing from
> > specific kernel versions, making it easier to correlate crashes with
> > the kernel that initiated the kexec.
> 
> Why can't you use journalctl to figure out which kernel was running
> previously?

This is a good question, this is why this doesn't work for me:

1) in some cases you cannot rely on systemd infrastructure.
   - This is very common when you have linux as the boot loader, which
     basically boot linux (UEFI -> Bootloader/linux -> kexec -> target linux)
   - In these cases, the bootloader doesn't have write access to the
     filesyste/journal
   - This is becoming more and more common. For instance, at Meta, Linux
     is the default bootloader.

2) in some of the bugs I've listed earlier, the machine doesn't even get
   to userspace before the crash. For instance, in the bug fixed by
   commit 77d48d39e991 ("efistub/tpm: Use ACPI reclaim memory for event
   log to avoid corruption"), the kernel was not reach userspace/init,
   thus, it would not be possible to run journalctl.

Thanks for the review,
--breno

