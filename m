Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74A9FDEE3F
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 18:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+ensqe6zjCbzuMF9mpOUvwz9y3ZF8YoEKZ4oK6PKrM=; b=Lz7f6oXLBuyvHPoRFvAkXF402G
	GATFX3Gy0yrQmg2MptDyHxLOzHmJrV4/ec6RpRBfnF26o299TWF5i5MPFYlcs6jcUk0pnfwSY7+UB
	3luJs+r8AVBoi82jP24lf0TWN+GRcjnq1bHkc/1jopgHrQNaiqUzO0/uuZPf6eCKyJO8tOnLe0ABI
	1k+KzpJP5op5R+aV7ZA4sYTMrHwm+0jvZjkTSynxM0VhpT9qbh8NxV4xv+fCvnmc33VMTew2X+KH9
	ZBZQLah3nkcEurLTgiYmlqneqmF3IuyBpT9kUZHLEHV5DmrI0EPT1BSndEjYkpkLQZinRS1HEkZYs
	orQshW1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyYk-0000000C6nO-0HIT;
	Thu, 23 Apr 2026 18:13:54 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFyYh-0000000C6mn-2W0g
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 18:13:52 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-8c70b5594f4so766385485a.1
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776968030; x=1777572830; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+ensqe6zjCbzuMF9mpOUvwz9y3ZF8YoEKZ4oK6PKrM=;
        b=WwLvKoIv/NAbIAgLytiz+9k4HaMzhUrJfT31lwq8FaMOUBHh+eWucYEkiopcpDvuR1
         Q66OO0X2pWP+gOHzHKg2J5QvL8zbQBL3hQY013akrFzMhao1yCDZjXpY0S5Dc2NJYYVL
         7iOwanqli/tQ6qIj6zjTa/xGNSMFYGp9XHNfHH0/KakJ6Ky3BbjxPGbparcBe4T7Hk4x
         oTOLZA1ME3yFCTCDUi9XLd1iBauO0pMFTOQwtyoLb/2wc3XxIf14kW+7zSYNUN9jNAjV
         aNHUVuxZzW3UvRKKheP7MOrdrbIwYMsnZ6A9nbtRefSjePhMKiRmDT9kCdn4LUwqnvZC
         EiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776968030; x=1777572830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+ensqe6zjCbzuMF9mpOUvwz9y3ZF8YoEKZ4oK6PKrM=;
        b=PH8yLThVvp0xw0Ub6at1jqbtN6bv7uSrQS+ogYEP+BEmzHXufo+oZ0FqN9X+XDdoKS
         J3ycrX14fEZcnF66zQ32zgjCpBFu7Wud4COOrdV9V9sJFF47pg4DHKorlxJfJtdeOmft
         B6jdw6M/oBoUXXZzyRTHMwsg2IVJSBqRFw7HDsr6lsLiUi4HylNdKb9nz72UE44xFOlu
         olNdqPkY82JQVPIsDN5OFpqa73blypBrSobrm5InxttcpfqX3tyJ2ExLMD8MbrL2s4jx
         9njIFSNNFu6cswzOtM8aCe/H/U+cwAOnstnntqTdUdt6UIXEaukiy1524ghNmOk3WtsZ
         JdoQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fVxNDdnvnLVeb7IzsjCWWByPAac7jHnSvKF2i1TuenWG6CPd14vyUiqO7Igh7OWHIyzbuEw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzMo6Ei1mU/NaHY+CA/q+UlWyP9+7BrvQDW7/WDMxUfqke8I7SL
	87WierukzXIH6EvvNKhg2BsmPEpryTWdI/YObwJ0Nm5WGcgSpIXUaahvz5bQy5voDWE=
X-Gm-Gg: AeBDietnm6TSIXUSpEcJGKRrwljCvH0/KKIVncdWjWJlId22PEglkxtgnB5cTzPP5FU
	xDJ8iL7zvvV1DYpjmwIjkTHXtUbqsCXjIJUpjDvJnqMJMrnvphpplsWw0F4+hHdWtytILJmMsYG
	5vtpnOA727HyFc03yvvwkHIzmbFKtzMFHFiYLtBBVpcVsXtCye9FESO1xzlAq9zHEaz87prQYxj
	6d5KqFDiNOs2BIlAKMihzcxSfCDhTTjuh1ciq2I+hv7v+008T/HlnaFF9LevyuMhxLRXbBREDgY
	3BRZVpYx3+ZBcf98yBbixXrM+f/Za/bz51crehjR1nPupXCBMnTyrUxZXftKT3GdpWlT3R5WIc3
	IL/pDaaqfpob1Ukk3L88QDmXwHXEy+sy/Q+aoyIWR60OSLrB5za5MT9k7H8AxmE3S+ZE3rg2BnU
	fhYJRk8LQHAvXMsGKmevC1i5Yl4p83fbOLLGoD0S+QVknspVaHFRoYtxMBbnOOGQ==
X-Received: by 2002:a05:620a:1995:b0:8c6:a103:496b with SMTP id af79cd13be357-8e78bde95bbmr3483374285a.25.1776968030344;
        Thu, 23 Apr 2026 11:13:50 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d92ce037sm1608488085a.32.2026.04.23.11.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:13:49 -0700 (PDT)
Date: Thu, 23 Apr 2026 18:13:48 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org
Subject: Re: [PATCH 0/2] liveupdate: FLB refcounting improvements
Message-ID: <aepgyxZDc4evs5ew@plex>
References: <20260423174032.3140399-1-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423174032.3140399-1-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_111351_653294_C7F494F8 
X-CRM114-Status: GOOD (  17.31  )
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

Please include kexec@lists.infradead.org so the patches are tested by 
Sashiko, and added to patchwork that we are using to maintaine live 
update work.

Pasha

On 04-23 17:40, David Matlack wrote:
> This series can be found on GitHub:
> 
>   https://github.com/dmatlack/linux/tree/liveupdate/flb/refcount/v1
> 
> This series has 2 patches to improve how FLB refcounting works in
> preparation for using FLB in the PCI core. The first patch converts the
> existing refcounting to use refcount_t, and the second patch allows
> users of the incoming FLB to hold references to the FLB to avoid it
> getting freed.
> 
> Users of the outgoing FLB don't need to take an extra reference yet
> since it's always done in the context of a preserve/unpreserve file
> callback, which are already synchronized with outgoing FLB creation
> and destruction.
> 
> This series has been tested against the existing Live Update selftests
> (liveupdate, luo_kexec_simple, and luo_multi_session) on an Intel EMR
> host.
> 
> 
> David Matlack (2):
>   liveupdate: Use refcount_t for FLB reference counts
>   liveupdate: Reference count incoming FLB data
> 
>  include/linux/liveupdate.h  |  9 ++++++-
>  kernel/liveupdate/luo_flb.c | 52 ++++++++++++++++++-------------------
>  lib/tests/liveupdate.c      |  3 +++
>  3 files changed, 37 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 2a4c0c11c0193889446cdb6f1540cc2b9aff97dd
> -- 
> 2.54.0.rc2.544.gc7ae2d5bb8-goog
> 

