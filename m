Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C967C02183
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 12:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hqxZT9ozmvZjLWkTsq08CYG4jN1j/R696/vPQZFpMxM=; b=k6YzTMiQDayY7eMuSoqCZQrbYM
	+99x8R2iN5L6KNzT/plj/6m3tSy6GeJcugifH5Xna9OlgMKxpjKHOPkWDI9jpVyq0mzpIBNRGeZTo
	iNP94dCdbKz7EqNYfuFUKb98vGqGcbLhztRcWBPQpeT2dCIM8DzNaPu05p/nwSt0D9gzrd5up2C5H
	s0dIWDg4x2TaM44gWtpIOYIqGNLjjECGVePeQ3+i21zcL379mKQp8z5peRYtjPYs4O5LogXbvc5DU
	GEpW1X2Lc+tspL6vkMFMRwiEQbjaTSH1hfCvKIhucNeKqwcP96eB60FNXsO+okzr38vFMnm5sZ6Q5
	3jtiuiSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfwq-00000008NZs-0vuE;
	Tue, 14 Jan 2025 12:23:08 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXfwn-00000008NYU-2vfk
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 12:23:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 607DC1424;
	Tue, 14 Jan 2025 04:23:33 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2EDF3F66E;
	Tue, 14 Jan 2025 04:23:02 -0800 (PST)
Date: Tue, 14 Jan 2025 12:23:00 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	LEROY Christophe <christophe.leroy2@cs-soprasteria.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kexec@lists.infradead.org, binutils@sourceware.org,
	devel@daynix.com
Subject: Re: [PATCH v4 3/6] powerpc: Use note name macros
Message-ID: <Z4ZXJAn2A5Tawy5/@e133380.arm.com>
References: <20250111-elf-v4-0-b3841fa0dcd9@daynix.com>
 <20250111-elf-v4-3-b3841fa0dcd9@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111-elf-v4-3-b3841fa0dcd9@daynix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_042305_816580_2B551B76 
X-CRM114-Status: GOOD (  18.47  )
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

Hi,

On Sat, Jan 11, 2025 at 02:48:46PM +0900, Akihiko Odaki wrote:
> Use note name macros to match with the userspace's expectation.

Note, there seems to be some manual encoding of some arch-specific
notes in arch/powerpc/boot/addnote.c, but since this is all hard-coded
and the note types are not taken from elf.h anyway, I think this is
probably out of scope for this series.  I haven't tried to understand
fully what that code is doing.

Anyway:

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

> 
> Acked-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  arch/powerpc/kernel/fadump.c               | 2 +-
>  arch/powerpc/platforms/powernv/opal-core.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
> index 4b371c738213..d44349fe8e2b 100644
> --- a/arch/powerpc/kernel/fadump.c
> +++ b/arch/powerpc/kernel/fadump.c
> @@ -751,7 +751,7 @@ u32 *__init fadump_regs_to_elf_notes(u32 *buf, struct pt_regs *regs)
>  	 * prstatus.pr_pid = ????
>  	 */
>  	elf_core_copy_regs(&prstatus.pr_reg, regs);
> -	buf = append_elf_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
> +	buf = append_elf_note(buf, NN_PRSTATUS, NT_PRSTATUS,
>  			      &prstatus, sizeof(prstatus));
>  	return buf;
>  }
> diff --git a/arch/powerpc/platforms/powernv/opal-core.c b/arch/powerpc/platforms/powernv/opal-core.c
> index c9a9b759cc92..a379ff86c120 100644
> --- a/arch/powerpc/platforms/powernv/opal-core.c
> +++ b/arch/powerpc/platforms/powernv/opal-core.c
> @@ -149,7 +149,7 @@ static Elf64_Word *__init auxv_to_elf64_notes(Elf64_Word *buf,
>  	/* end of vector */
>  	bufp[idx++] = cpu_to_be64(AT_NULL);
>  
> -	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_AUXV,
> +	buf = append_elf64_note(buf, NN_AUXV, NT_AUXV,
>  				oc_conf->auxv_buf, AUXV_DESC_SZ);
>  	return buf;
>  }
> @@ -252,7 +252,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
>  	 * crashing CPU's prstatus.
>  	 */
>  	first_cpu_note = buf;
> -	buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
> +	buf = append_elf64_note(buf, NN_PRSTATUS, NT_PRSTATUS,
>  				&prstatus, sizeof(prstatus));
>  
>  	for (i = 0; i < oc_conf->num_cpus; i++, bufp += size_per_thread) {
> @@ -279,7 +279,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
>  		fill_prstatus(&prstatus, thread_pir, &regs);
>  
>  		if (thread_pir != oc_conf->crashing_cpu) {
> -			buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME,
> +			buf = append_elf64_note(buf, NN_PRSTATUS,
>  						NT_PRSTATUS, &prstatus,
>  						sizeof(prstatus));
>  		} else {
> @@ -287,7 +287,7 @@ static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
>  			 * Add crashing CPU as the first NT_PRSTATUS note for
>  			 * GDB to process the core file appropriately.
>  			 */
> -			append_elf64_note(first_cpu_note, CRASH_CORE_NOTE_NAME,
> +			append_elf64_note(first_cpu_note, NN_PRSTATUS,
>  					  NT_PRSTATUS, &prstatus,
>  					  sizeof(prstatus));
>  		}
> 
> -- 
> 2.47.1
> 
> 

