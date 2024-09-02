Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15989CA0ED3
	for <kexec@archiver.kernel.org>; Mon,  2 Sep 2024 08:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XZFJQD1hwKaOiMIV+wgvBa3X8NRay0Da+xF5EjV0WYo=; b=FMqAHAuboUxNe7
	BcZCOHYfRt+w/rz0lFj7BgKPJPY1SluvdaD4Mdp+FMoZRVvYSpIABhUhwgxi49iQOn21e2Kp+M3wH
	EF33bNU4UqLKmj7wNaIVxoGlGXiaRXM/b5FoPSh5Bsz7ilD8j+CVd5Ll0UCD4CKa8gZVzrFF3yptZ
	Z9EYMfRy4walpBq1UgESwIo0PSmKepfGnX91Erfqu2xXAEY8ODtGy3ekaTjUmxzCqq2lt5ec5b1bN
	dbnuOrYlZ76xhCul7OSzg342vRArvol7h10HTLhXCG4rXsEWmPMnykZVJXMz0qovSJw+cvwB6pY6G
	ky/SyY40CXJwTRrhNWpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl2OC-0000000DUfO-1VlS;
	Mon, 02 Sep 2024 08:26:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl2Ll-0000000DU1b-1Xe9
	for kexec@lists.infradead.org;
	Mon, 02 Sep 2024 08:23:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD8E65C5796;
	Mon,  2 Sep 2024 08:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBF9C4CEC2;
	Mon,  2 Sep 2024 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725265427;
	bh=Vw8owfhCT5NXCuUPrz+ei1KCOX779W7JZ98MuG1X2W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d64tsKgiZzjYTOkitlfnwrz3lEryc10shY3safBerLoybDvdJxIxZI6JfAePdfxFM
	 JkR/vZz0oZIPbL2ebh/dHJrK6NqC3nZCk0C2JM7E4m8Q4K20d/HjomMMc7cxcnAyWm
	 6yc/aQuDkvb/jGkwh5EcDtjAGkk6qY/XccGFxqtRTn52cDQd9bZMQLh+gdH5Z/olDa
	 I8d6qccvCjJQd+mNJL15Oxk1jVghce2qYb9Skawlk5p022ongUnqq3bcAQJV/AueKD
	 kfW0Lx7NvTFW3+iIIYMG3dAd64iTHRQgcEVwxHSPSqQxbS3OqqmdRS80V7vUPhwF2g
	 VHtYP5otX4KzQ==
Date: Mon, 2 Sep 2024 09:23:42 +0100
From: Simon Horman <horms@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org, bhe@redhat.com,
	corbet@lwn.net, kernel@gpiccoli.net, linux-kernel@vger.kernel.org,
	stephen.s.brennan@oracle.com, kernel-dev@igalia.com,
	dyoung@redhat.com, vgoyal@redhat.com,
	linux-debuggers@vger.kernel.org
Subject: Re: [PATCH V2] Documentation: Improve crash_kexec_post_notifiers
 description
Message-ID: <20240902082342.GC23170@kernel.org>
References: <20240830182219.485065-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830182219.485065-1-gpiccoli@igalia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_012349_477988_EF74BF00 
X-CRM114-Status: GOOD (  22.49  )
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

On Fri, Aug 30, 2024 at 03:21:00PM -0300, Guilherme G. Piccoli wrote:
> Be more clear about the downsides, the upsides (yes, there are some!)
> and about code that unconditionally sets that.
> 
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> 
> ---
> 
> V2: Some wording improvements from Stephen, thanks!
> Also added his review tag.
> 
> V1 link: https://lore.kernel.org/r/20240830140401.458542-1-gpiccoli@igalia.com/
> 
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 

Hi Guilherme,

Some subjective grammar nits.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index efc52ddc6864..351730108c58 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -913,12 +913,16 @@
>  			the parameter has no effect.
>  
>  	crash_kexec_post_notifiers
> -			Run kdump after running panic-notifiers and dumping
> -			kmsg. This only for the users who doubt kdump always
> -			succeeds in any situation.
> -			Note that this also increases risks of kdump failure,
> -			because some panic notifiers can make the crashed
> -			kernel more unstable.
> +			Only jump to kdump kernel after running the panic
> +			notifiers and dumping kmsg. This option increases the
> +			risks of a kdump failure, since some panic notifiers
> +			can make the crashed kernel more unstable. In the

nit: In the configurations -> In configurations

> +			configurations where kdump may not be reliable,
> +			running the panic notifiers can allow collecting more
> +			data on dmesg, like stack traces from other CPUS or
> +			extra data dumped by panic_print. Notice that some

nit: Notice that -> Note that

> +			code enables this option unconditionally, like

Maybe: some code enables -> some configurations enable

> +			Hyper-V, PowerPC (fadump) and AMD SEV.
>  
>  	crashkernel=size[KMG][@offset[KMG]]
>  			[KNL,EARLY] Using kexec, Linux can switch to a 'crash kernel'
> -- 
> 2.46.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
