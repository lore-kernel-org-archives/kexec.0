Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A056FEA3C22
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FzWgWPTYOUXksm2yrkcRcT+jT0HPJKIhnfcAUSbpY+U=; b=ORrXdytfkc8rT9IQGejMqpRFO6
	XKBkJuEcx7AxM8NEbscmxu5CUWvRHemO7tg/WAKtTOZcXc/vaSuuyc34IMC4TFSX8/cwrTynzK4fY
	SC4Hfnz8zE5SQH9fksBvtONt3fN89FFJrNQiq75nGGogGNOvivcAP3rS+ozQTEBp7Us9LPwK//7Dd
	sJGFOm8IJ6lnz8QKFUhTxEyOExCSPiAEf02UzlPy0KIF3o3WynLM6GwDxUMW9mWk97NlHA6hW22R2
	Ltw2PWUsU5+tCi2NpkYWVjIP5qo7qjkYJhCcMLz86mxWyUIkxSpFtFi18UqhX8UtxrfgAvarCEehN
	AQLdaPwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAmOh-0000000A8N8-3Nld;
	Thu, 09 Apr 2026 10:14:03 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAmOd-0000000A8Mn-12Vq
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 10:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FzWgWPTYOUXksm2yrkcRcT+jT0HPJKIhnfcAUSbpY+U=; b=Os4bzlJi9bj/d529D/CNPg2+mG
	57BpudCqnG69DUWP3fHaIAFLnOgZi0lzTjI/xDZf1ptRBTLOHX4krCZjLPuKjaKRQIC/Mrq4pLT68
	KB1dXUJDOYIswsUI51ySf+3kG1IaQuUe4F+mGKI0YunJQt76F/+xqpuC6ewFl9hwGnbXVQ62ceTWE
	vUkwxjaU5gX9mfD7gC8eVnjYubM5nz7NfokII2vTefdvU3ehednwVYgbwn3ATc0MH4DHuWZMEvVT0
	8eF71tXDvzj7ZTfjtnZcYugLaKQ3aV8KiQabvi4Hwo/O7GeopnRZNn5AKZU2z6Z9+PuhAtbqFdx/U
	5HHciUHg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wAmOT-0097x9-2S;
	Thu, 09 Apr 2026 10:13:50 +0000
Date: Thu, 9 Apr 2026 03:13:43 -0700
From: Breno Leitao <leitao@debian.org>
To: akpm@linux-foundation.org, mclapinski@google.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>, 
	kernel-team@meta.com, Alexander Graf <graf@amazon.com>, 
	Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, puranjay@kernel.org, asml.silence@gmail.com
Subject: Re: [PATCH v8 5/6] kho: kexec-metadata: track previous kernel chain
Message-ID: <add4SuufMiHo8Mpm@gmail.com>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
 <20260309-kho-v8-5-c3abcf4ac750@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-kho-v8-5-c3abcf4ac750@debian.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260409_031359_291549_A77CA6E3 
X-CRM114-Status: GOOD (  14.76  )
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

Hello Andrew,

On Mon, Mar 09, 2026 at 06:41:48AM -0700, Breno Leitao wrote:
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 1f22705d5d246..7bac80e9a29a4 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -1441,6 +1512,10 @@ static __init int kho_init(void)
>  	if (err)
>  		goto err_free_fdt;
>  
> +	err = kho_kexec_metadata_init(fdt);
> +	if (err)
> +		goto err_free_fdt;
> +
>  	for (int i = 0; i < kho_scratch_cnt; i++) {
>  		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
>  		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;

I discovered an issue while testing this code on the current linux-next:
the kho_kexec_metadata_init() call is now unreachable due to recent
changes.

My original patch was based on commit 5c9e55fecf93658 ("Add linux-next
specific files for 20260312"), which included commit d7176a010afce8
("kho: fix deferred init of kho scratch"). However, that commit has since
been rebased/reworked in linux-next, and the code flow has changed.

I'll send a follow-up patch to correct the placement.

For reference, the intended code structure should be:

  static __init int kho_init(void) {
	  ....
          err = kho_out_fdt_setup();
          if (err)
                  goto err_free_fdt;

          err = kho_kexec_metadata_init(fdt);
          if (err)
                  goto err_free_fdt;


Currently in linux-next, it looks like:

          err = kho_out_fdt_setup();
          if (err)
                  goto err_free_fdt;

          if (fdt) {					    |
                  kho_in_debugfs_init(&kho_in.dbg, fdt);    |  -> This code was moved by d7176a010afce8, but, not anymore
                  return 0; 				    |
          }						    |

          err = kho_kexec_metadata_init(fdt);               |  -> This code is now unreachable
          if (err)
                  goto err_free_fdt;


I will send the fix for it soon, and we can carry on the discussion
there.

Thanks,
--breno


