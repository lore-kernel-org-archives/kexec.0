Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27410CDB46F
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 12:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okApS8kA1BHmpX9NtGOiC0KXJACuDAVb6ZoT6zw+Ygs=; b=uasZFXiu9ryveZATanxa6e4D+x
	WHjoPmqHUu35+3/mtw0LnnJSUeaWwaiX1bTqVMtADkxFEJG/cPfWtOkXHQIhv2U0z+IA+7k9UUycy
	GtdOVbsvlHD5/en4KBpSuhCTVtbTgHwmQd06fAf1Q4SiltW4zzUnx83UZ6oD5Y/iP64pbpLnB12F0
	H1vnYs09mjg7dCpGjf2+gCdxaGCy/CNTHBNRZQFaMU2iqKf0w8irlWrFU0ALsZh39kkELjjIv5Ssb
	X7+lvlI4mkIpAI4wWcd1tc5NXWLYIqusx0OuW/58BnNppNTP8riWoWm8TuHakRaXE2kLu9gwbfT3Z
	XYlvEJGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc05z-00000006FQV-2kJ5;
	Tue, 23 Jun 2026 12:19:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc05y-00000006FPy-3Ybv
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 12:19:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B0294373A;
	Tue, 23 Jun 2026 12:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145E61F000E9;
	Tue, 23 Jun 2026 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217154;
	bh=okApS8kA1BHmpX9NtGOiC0KXJACuDAVb6ZoT6zw+Ygs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=m2knUe1M/njq7jjIqMM0aYd0IQ1XadhqQ4jHEZXlizp3dwr2PJ2e3+wjZ0In7VD6r
	 +/Pkf7DTaEef2gEGsEyTvnu1KWETnlSwseXzQ0BP6nB7fOkEZ0SwRdHibAG9V3aLz2
	 xFqh4wBNAyd/83J23xxCJTz6i06Xw7goDbYaJT8QMTkdJ5XPeVBWESgp3K0viBLkPs
	 V30JcTeKkiT7nLtPEaHhjNVQGN/g9YjHKPZxpfJ4VxEiWx7GcEQQ8rtaegWUBuNW7l
	 N+9jFDja10LrcQIoov0l7Vbv4xErtjZ11aJ7GMV9bJefR1ifZ3PmI3k7E5MWLp5cge
	 wzrxfxhdONdbw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] mm/memfd_luo: validate serialized_data before
 conversion
In-Reply-To: <20260623105201.3724592-2-tarunsahu@google.com> (Tarun Sahu's
	message of "Tue, 23 Jun 2026 10:51:59 +0000")
References: <20260623105201.3724592-1-tarunsahu@google.com>
	<20260623105201.3724592-2-tarunsahu@google.com>
Date: Tue, 23 Jun 2026 14:19:11 +0200
Message-ID: <2vxz5x39o3eo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 23 2026, Tarun Sahu wrote:

> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> on args->serialized_data before checking if the physical address is valid.
> Since physical address 0 does not map to virtual NULL (due to direct
> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> catching a missing serialized_data, leading to unsafe dereferences later.
>
> Validate that args->serialized_data is non-zero before calling
> phys_to_virt().
>
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

