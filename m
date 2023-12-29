Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CEEC47074
	for <kexec@archiver.kernel.org>; Fri, 29 Dec 2023 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pYq4pNnCKkFvPK0wJXJQ1PyJgaoK/nr9rGfhP5O2d94=; b=eQxLRXnWV5bqvy
	qoq7hxKurzA2EtJV6OCOoCDuPVPcFRv6ijgDWVbSwj9jo2r7zT8eVfyoxdPv94RD7zXOrMgQycKyo
	d+Njena42PyCOPsdcsLovrdHWuDlM2kEc9o0JwZki268ofCx3H1ktiz9j9iVt4OoUtY4MWHF2jXoj
	SBmYaEFc67j3lwmhGtq+bj+j3krDoUWUTWvGsbXS5JUOwCjYdWSlUHSUvRHjlcl1Cn1etdPi1P9Pn
	FREyZkWATYnzP8y7pxlfrKA0mWq49p+ihTT4tpPsB38qaYMiwRVfIRYB2e+1XOiMcyUKHWf68eMmW
	R3CZWGl7ma04Ky7NA9fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJJBW-001RFl-2D;
	Fri, 29 Dec 2023 20:10:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJJBQ-001REQ-2l
	for kexec@lists.infradead.org;
	Fri, 29 Dec 2023 20:10:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 11A6861228;
	Fri, 29 Dec 2023 20:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB32C433C8;
	Fri, 29 Dec 2023 20:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1703880615;
	bh=nRJweA6alfblDRh8g5qaz56eqzwAOoHvkXgtYYOUkNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rGlAIj2wbFYkvEoxn4AeYdP5GKwYAAt13/i217HbUQf2vgdpmB7H4ki/UePSuCZyO
	 P5kuYIMwkIatC8cLtfBhQ0gd3LlTnzcf2/gG4Qc0ia5Oh9VeuyGW0/HmHMeVnyPqj3
	 3VuCOhbnLMPRSrALGrF/FzWDWUHjRXuBSGYAB1X0=
Date: Fri, 29 Dec 2023 12:10:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: bhe@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 dyoung@redhat.com, hbathini@linux.ibm.com, hpa@zytor.com,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
 seanjc@google.com, tglx@linutronix.de, tiwai@suse.de, vgoyal@redhat.com,
 x86@kernel.org
Subject: Re: [PATCH] crash_core: optimize crash_exclude_mem_range()
Message-Id: <20231229121014.fd090f8c616a34fbb45f7843@linux-foundation.org>
In-Reply-To: <20231219163418.108591-1-ytcoode@gmail.com>
References: <20231218092902.9fae480cfcad3874e9e7236f@linux-foundation.org>
	<20231219163418.108591-1-ytcoode@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231229_121016_937250_0B60E4A1 
X-CRM114-Status: GOOD (  13.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Wed, 20 Dec 2023 00:34:18 +0800 Yuntao Wang <ytcoode@gmail.com> wrote:

> Because memory ranges in mem->ranges are stored in ascending order, when we
> detect `p_end < start`, we can break the for loop early, as the subsequent
> memory ranges must also be outside the range we are looking for.
> 
> Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
> ---
> Hi Andrew,
> 
> Patch "[PATCH 2/2] crash_core: fix out-of-bounds access check in
> crash_exclude_mem_range()" can be ignored, use this patch instead.
> 

Some reviewer input on this would be helpful please?

> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -575,9 +575,12 @@ int crash_exclude_mem_range(struct crash_mem *mem,
>  		p_start = mstart;
>  		p_end = mend;
>  
> -		if (p_start > end || p_end < start)
> +		if (p_start > end)
>  			continue;
>  
> +		if (p_end < start)
> +			break;
> +
>  		/* Truncate any area outside of range */
>  		if (p_start < start)
>  			p_start = start;
> -- 
> 2.43.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
