Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90531CA101F
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 16:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ssFMi1sJkq3DwLXtFEHozIINPdAKzWOlmS2TKLbZ6EU=; b=jVlfEBGE9bx0tCNy8ALg492Rol
	Iam70kmDnloDsylcOsEGHqxtVdVWfve2lSDC1JaXp3iWCirpgug5UlmOPwamkSbOcUNX0vF904RP2
	eJtPfcaMcdM3Kfo8u4XnwhYSMDpLYsq5fD4nlbMU7qsEKViAdGKTe4qQXLQy9uV/FLiJXDcgM9hhT
	7/dp01yOyfDcAg1MrMMkAdaXXjUuklt8RoSk2dsPjUPr3aNRJNSimUskRwvNJLMur2gZUuWnO8NHC
	2o0/bi7+gY+8HtuGfW157dd0FkpnjEEpNLlF4tCtkOYHrsyrA0cEBpTwGqEPh6YddWiKe22kRbT3E
	9mEwAh3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwO1O-0000000FcGp-1siY;
	Wed, 10 Sep 2025 16:50:14 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwO1M-0000000FcGL-1L4C
	for kexec@lists.infradead.org;
	Wed, 10 Sep 2025 16:50:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D0C2843FCF;
	Wed, 10 Sep 2025 16:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB16C4CEEB;
	Wed, 10 Sep 2025 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757523011;
	bh=ug5CvfYVPJihh5Zy5QREZIKCevb4x/BKaIGi7u0wAkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CPAOgAbmybkyYUUePXHpTFbjK4/sSheXD5Cb30bErD6cxup1wf9xVxlmDMRNMwIRT
	 USv2axQrbQ9wY+QTzUewNNHgDwGIdgP0EjSPGNTVuC9d0QkPOrgMA92s+XiOFek6X1
	 PGMz9vUOXTxn0jSQ3m8DaC5UtBYLbIJXCJZ0NwZftg6ovmRECwNzzyDuBU0ehgCApW
	 EEOuiAPzHvdeIAFmWJxQp2PNt2U3wGDVHlH3skZ/ypc4gZkH9N44g0S0cm0zhGw28r
	 TpE4NPHIm94DswLhRiL/EjL0BtfMRvLWNDtU8OlRbNqE+QNkJW4kvmOlj4D7+u+QnS
	 LICDXPxSa2YPw==
Date: Wed, 10 Sep 2025 11:50:10 -0500
From: Rob Herring <robh@kernel.org>
To: Andrey Ryabinin <arbn@yandex-team.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, Pratyush Yadav <ptyadav@amazon.de>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Rientjes <rientjes@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Chris Li <chrisl@kernel.org>, Ashish.Kalra@amd.com,
	William Tu <witu@nvidia.com>, David Matlack <dmatlack@google.com>,
	Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] kho: replace KHO FDT with kstate metadata
Message-ID: <20250910165010.GA223810-robh@kernel.org>
References: <20250909201446.13138-1-arbn@yandex-team.com>
 <20250909201446.13138-5-arbn@yandex-team.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909201446.13138-5-arbn@yandex-team.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_095012_385061_974987D7 
X-CRM114-Status: GOOD (  17.16  )
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

On Tue, Sep 09, 2025 at 10:14:39PM +0200, Andrey Ryabinin wrote:
> Store KSTATE physical address & size instead of FDT in kho_data.
> and initialize KSTATE from kho_populate().
> To be able to use FDT in parallel with KSTATE place FDT
> address&size into 'struct kho_fdt' and save/restore it using KSTATE.
> 
> This finishes wiring KSTATE with KHO, making it fully functional.
> 
> Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
> ---
>  arch/x86/include/uapi/asm/setup_data.h |  4 +-
>  arch/x86/kernel/kexec-bzimage64.c      |  6 +--
>  arch/x86/kernel/setup.c                |  3 +-
>  drivers/of/fdt.c                       |  6 +--
>  include/linux/kexec.h                  |  2 +-
>  include/linux/kstate.h                 |  1 +
>  kernel/liveupdate/kexec_handover.c     | 60 +++++++++++++++++++++-----
>  7 files changed, 61 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
> index 2671c4e1b3a0..844f5b93473f 100644
> --- a/arch/x86/include/uapi/asm/setup_data.h
> +++ b/arch/x86/include/uapi/asm/setup_data.h
> @@ -83,8 +83,8 @@ struct ima_setup_data {
>   * Locations of kexec handover metadata
>   */
>  struct kho_data {
> -	__u64 fdt_addr;
> -	__u64 fdt_size;
> +	__u64 kstate_addr;
> +	__u64 kstate_size;
>  	__u64 scratch_addr;
>  	__u64 scratch_size;
>  } __attribute__((packed));

Isn't this part of the ABI which you can't just change.

Rob

