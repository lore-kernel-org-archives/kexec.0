Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3894E7717D
	for <kexec@archiver.kernel.org>; Fri, 13 Dec 2024 12:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s5mJgH2vYbz07rPKVezfgJE2ydvgOdSl0yFBkL3TIyE=; b=ZANg9a5hLhDjeF5+zkBA+8Ugi1
	0Om4GftUHnC3/8gUCFjXgVPR7HcKURwZNdiTYWYHu57iLZaHGvh94D38HCfCajnDSeDfE3X82V/ud
	jCEHy+TYkeY9AVB4PiWUkRHAD7iR6mqa2j5fFLRH+Fo7oka/Rv1M58YALsnx6ri/vVYUlP9aSCqhu
	zcKpy62ouyUS/brhLwz1gDxZpzf0rPUQ2SJxzfrhAFP8wFnFHAyiP1prr4fVjxwWDxiZCToNYWb8R
	XFO0dzjnHk4XChPa7yRqyKndXYDeXU6+dTllkWwqx16ssDu0+Hzce2j/0+Mq3j8THqVe90F2/tyR+
	WQSas/Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM53x-00000003krt-2kVa;
	Fri, 13 Dec 2024 12:46:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM53v-00000003kqu-2zCk
	for kexec@lists.infradead.org;
	Fri, 13 Dec 2024 12:46:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B5BCBA40D1F;
	Fri, 13 Dec 2024 12:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEB2C4CED0;
	Fri, 13 Dec 2024 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734093990;
	bh=jXiaShug2wttndrKcMOGxNVDw7K00abgCEjLBZziBes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dG02Av30DVA/IgXd3R6oteIsLluDtR1dmZ3uui+TyABrJH13JGpKEhXyUFQMAIN16
	 +0BO8qEEPciAMbBh/AdhBhol7RSKHlOVPTb9Pqy/4EPC0HdA75foa5vIPWSYW+CU3K
	 zajf7YObu9rJzwS0fR5qkTGB1wfDiSW4y8C2jck5BKpJiRGal5SlXmUBIxoeWZfUEZ
	 ETIMELcwc64aL6+XvyO/M6Xiva+W0B6/J9akfQKXLuV8RkkvG4p0Mrr+FYXkICtdbF
	 ULzDK7j17P09dC1L3cPurzQ1B6zzmb9eJdMjrUVTuzbLEo2bI1XR1yI0LyCjIH0VtI
	 U0hWJtAHd5uvg==
Date: Fri, 13 Dec 2024 12:46:27 +0000
From: Simon Horman <horms@kernel.org>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: kexec@lists.infradead.org, piliu@redhat.com, dyoung@redhat.com
Subject: Re: [Patch v2 2/2] kexec: Enable zstd in kexec decompression paths
Message-ID: <20241213124507.GY2110@kernel.org>
References: <20241212211325.805138-1-jeremy.linton@arm.com>
 <20241212211325.805138-3-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212211325.805138-3-jeremy.linton@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_044631_815671_A1659524 
X-CRM114-Status: GOOD (  11.34  )
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

[Dropped arb@kernel.org: mail.kernel.org refuses to accept my email otherwise]

On Thu, Dec 12, 2024 at 03:13:25PM -0600, Jeremy Linton wrote:
> The kexec decompression routines support detecting zlib or lzma
> compressed images. Lets add the ability to automatically decompress
> zstd ones as well. The zstd attempt is made after gzip because its
> fairly inexpensive relative lzma, and gzip remains a popular option.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Acked-by: Pingfan Liu <piliu@redhat.com>

Thanks, applied.

When doing so I removed the trailing whitespace which I have noted below.

...

> diff --git a/kexec/kexec.c b/kexec/kexec.c

...

> @@ -639,9 +640,12 @@ char *slurp_decompress_file(const char *filename, off_t *r_size)
>  
>  	kernel_buf = zlib_decompress_file(filename, r_size);
>  	if (!kernel_buf) {
> -		kernel_buf = lzma_decompress_file(filename, r_size);
> -		if (!kernel_buf)
> -			return slurp_file(filename, r_size);
> +	        kernel_buf = zstd_decompress_file(filename, r_size);	        

Trailing whitespace on the line above.

> +		if (!kernel_buf) {
> +                        kernel_buf = lzma_decompress_file(filename, r_size);
> +			if (!kernel_buf)
> +				return slurp_file(filename, r_size);
> +		}
>  	}
>  	return kernel_buf;
>  }
> -- 
> 2.47.0
> 

