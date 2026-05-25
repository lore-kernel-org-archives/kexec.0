Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9F5CD5BC9
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=34eaHJRXGUxn6aCaWNiWQiEzep2YC7iFCHhas4g5QaM=; b=WRIfpo8Sel8z1GZ2TLzv8Hymdl
	nhJVTtIKM5z7QWMsB/+E2Syf1aB55nRW7Digbxuk6OKZKnBEGTO9/07qeZyrKRvg2x5TaiyCOGqJ4
	f5fXseHvw/Qo8ZyQz2GBSmi8WSYF3tyifxmtIyOXLNSEPvpJEEKdCE1K+uU1YTvMlzlO73uYzSNwb
	fB8M7dzW5BQkm+Ju6ihfw1A23VPhuqvbot/F1j3Hoao+NiLk7c8TRfokeHqwSFXHyog05VK4UMkk7
	Hladf9tjnejS0pcJ8YTH9U2yU7QWtB6VfqgQp4xTZrIL73hwnlfOIlOnZ5AG8mPk6/tbCLywv3YSW
	2Thtkiwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRZQk-00000000AQI-2JIf;
	Mon, 25 May 2026 17:49:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRZQj-00000000APw-1ura
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 17:49:33 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6705E60008;
	Mon, 25 May 2026 17:49:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24B01F000E9;
	Mon, 25 May 2026 17:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779731372;
	bh=34eaHJRXGUxn6aCaWNiWQiEzep2YC7iFCHhas4g5QaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=itXByRbw+mP3n0WYUFSgOvuNWwiQkJMyZndGej1Q+qst31PJZbH6hK5bKQPa8pye+
	 8z8HSlCAtj0uObcAzFM41I0i1eME3B6Bi8ajwvxrJYfYLrghnHBDvJdiJzElpB6dgx
	 6udxDWvfBe/N7Wnl4Rg3vu7KbiWdMEYlpoOK3B2DJ+t01suWb5DaAsMMK3B1krviAH
	 GxhO/AdojFJgoYBSOPNzAhbQgIYy8pkvAB/sTodPhcLgM7fa7Xy/FT1idtC3pqgPAF
	 zAo5rkvorkJD1JryB7ndb0kXfNlZDrLT21DM1MHfbYKs+V+EtGAisgsYyQwcWj+KKU
	 ozSnoW+MLfQsA==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: chenhuacai@kernel.org,  rppt@kernel.org,  pasha.tatashin@soleen.com,
  pratyush@kernel.org,  kernel@xen0n.name,  graf@amazon.com,
  shuah@kernel.org,  loongarch@lists.linux.dev,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH 2/7] LoongArch: kho: strip stale kho_handover= from
 reused cmdline
In-Reply-To: <20260525062810.103367-3-dongtai.guo@linux.dev> (George Guo's
	message of "Mon, 25 May 2026 14:28:05 +0800")
References: <20260525062810.103367-1-dongtai.guo@linux.dev>
	<20260525062810.103367-3-dongtai.guo@linux.dev>
Date: Mon, 25 May 2026 19:49:28 +0200
Message-ID: <2vxzpl2j5qhj.fsf@kernel.org>
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

On Mon, May 25 2026, George Guo wrote:

> From: George Guo <guodongtai@kylinos.cn>
>
> When kexec is invoked with --reuse-cmdline after a liveupdate boot, the
> running kernel's command line already contains a kho_handover= parameter
> from the previous kexec load.  load_other_segments() prepends a fresh
> kho_handover= for the new handover FDT but then appends the original
> cmdline verbatim, resulting in two kho_handover= entries:
>
>   kho_handover=0x4000@<new_fdt>,... kho_handover=0x4000@<stale_fdt>,...
>
> early_param() calls early_parse_kho() for each occurrence in order, so
> kho_populate() is invoked twice and the second call overwrites the first
> with the stale FDT address.  The stale address no longer holds a valid
> KHO FDT, causing __kho_radix_walk_tree() to dereference a garbage
> pointer and panic early in mm_core_init().
>
> Fix this by adding the new kho_handover= to the cmdline prefix first,
> then stripping any stale kho_handover= tokens from the appended original
> cmdline portion, so only the freshly generated entry survives.
>
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>  arch/loongarch/kernel/machine_kexec_file.c | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/loongarch/kernel/machine_kexec_file.c b/arch/loongarch/kernel/machine_kexec_file.c
> index ddf4d0e0e7fd..ffaedd055e62 100644
> --- a/arch/loongarch/kernel/machine_kexec_file.c
> +++ b/arch/loongarch/kernel/machine_kexec_file.c
> @@ -71,6 +71,37 @@ static void cmdline_add_kho(struct kimage *image, unsigned long *cmdline_tmplen,
>  	    image->kho.scratch->bufsz,    (u64)image->kho.scratch->mem);
>  	*cmdline_tmplen += n;
>  }
> +
> +/*
> + * Remove all "kho_handover=..." tokens from cmdline.  Needed when
> + * --reuse-cmdline is used: the running kernel's cmdline already carries a
> + * stale kho_handover= from the previous kexec load; without removal the new
> + * kernel sees two entries and kho_populate() ends up using the wrong (stale)
> + * FDT address.
> + */
> +static void cmdline_remove_kho(char *cmdline)
> +{
> +	const char *key = "kho_handover=";
> +	size_t key_len = strlen(key);
> +	char *p = cmdline;
> +
> +	while ((p = strstr(p, key)) != NULL) {
> +		char *start = p;
> +		char *end;
> +
> +		/* Only match at a token boundary */
> +		if (start != cmdline && *(start - 1) != ' ') {
> +			p += key_len;
> +			continue;
> +		}
> +		end = start + key_len;
> +		while (*end && *end != ' ')
> +			end++;
> +		while (*end == ' ')
> +			end++;
> +		memmove(start, end, strlen(end) + 1);
> +	}
> +}

Ugh, modifying the commandline supplied by userspace feels odd... Can
you at all do this via device tree?

If not, would it make more sense to reject kexec_load if command line
has kho_handover= and teach kexec-tools to strip it on its side?

>  #endif
>  
>  #ifdef CONFIG_CRASH_DUMP
> @@ -249,6 +280,10 @@ int load_other_segments(struct kimage *image,
>  	}
>  
>  	memcpy(modified_cmdline + cmdline_tmplen, cmdline, cmdline_len);
> +#ifdef CONFIG_KEXEC_HANDOVER
> +	/* Strip stale kho_handover= that --reuse-cmdline may have carried over */
> +	cmdline_remove_kho(modified_cmdline + cmdline_tmplen);
> +#endif
>  	cmdline = modified_cmdline;
>  	image->arch.cmdline_ptr = (unsigned long)cmdline;

-- 
Regards,
Pratyush Yadav

