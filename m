Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C489CA0EE6
	for <kexec@archiver.kernel.org>; Thu, 21 Aug 2025 04:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u/WvUROpWXa34opBDScUwj1u1jCxzqmrIjCS0d+p5vA=; b=mrvOmcGVhqLnGJF3S/p+yBk+tl
	xXzzCQyGEwyrs52fxgABljTpvgMwxRDgK4dDVBnYlbXVFuO4P+3Gxk7REajRLNRc8JoT299yY/rbL
	7MukwRY39xd3gC83OLjXQDvGMsxtOvHQMg/5fiJ50LGG0NdjwRBPccTsVJ3daPvvxMK4GE32DIPSu
	K/DwzLxWZa9ni8azO5yts4vntBw5hMatAa8h4Koa0HhVs8Tc8hCG1JsLLTRyIMBEA0UwzfG4Tyha7
	SUzvWGoNP8NZQEA+s4nZjKNSKgd6k0okzkyH8QZtUkCKiIX1bWHjBSQtMmIF1z2SbMX9p67hKMcgX
	IdE1aZZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxEV-0000000FpGk-166R;
	Thu, 21 Aug 2025 04:49:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uovyO-0000000Fcjs-0P9g
	for kexec@lists.infradead.org;
	Thu, 21 Aug 2025 03:28:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755746898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u/WvUROpWXa34opBDScUwj1u1jCxzqmrIjCS0d+p5vA=;
	b=PRuVKDxv8x+sIma+fEkt8otwrEgdJupec88v4HMb17tg0xilOq6n8ASSMaT/48AgovRsEp
	6AjbUv8+7Kj0JlNdByUDjunzd7xuQi8QNCaf1DHT/Rk58Jgl1rxpmT6ejMnLdzU6BH0EUQ
	P3Pt8oF+DxyZU3ReM1GGeuFhwj7SV9w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-EJs5jAs3MCCmHsDcU1lnsA-1; Wed,
 20 Aug 2025 23:28:15 -0400
X-MC-Unique: EJs5jAs3MCCmHsDcU1lnsA-1
X-Mimecast-MFC-AGG-ID: EJs5jAs3MCCmHsDcU1lnsA_1755746894
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9ECC91800446;
	Thu, 21 Aug 2025 03:28:13 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43F661800447;
	Thu, 21 Aug 2025 03:28:10 +0000 (UTC)
Date: Thu, 21 Aug 2025 11:28:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, paulmck@kernel.org,
	leitao@debian.org, kernel-team@meta.com
Subject: Re: [RFC] kexec: Add bootconfig support to get_command_line
Message-ID: <aKaSRJ9HGNR07Svl@MiWiFi-R3L-srv>
References: <20250811153736.3865487-1-usamaarif642@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20250811153736.3865487-1-usamaarif642@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rqxCnQqaQescAp2uSaaND7649eemEPIw49YZSBeP7wU_1755746894
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_202820_208872_5BB92B8B 
X-CRM114-Status: GOOD (  35.56  )
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

On 08/11/25 at 04:37pm, Usama Arif wrote:
> If the kernel is enabled with CONFIG_BOOT_CONFIG_FORCE, it will
> always append the bootconfig at the start of the kernel commandline.
> If reuse-cmdline option is used in kexec, the bootconfig will be
> repeatedly appended at the start of the commandline on every kexec.
> As there is a limit on the size of kernel commandline that can be
> used, --reuse-cmdline option will break kexec depending on the
> size of bootconfig on repeated kexec.
> 
> Bootconfig is embedded in the kernel, so it should not be considered
> when reusing kernel command line.
> Modify get_command_line() to first attempt reading kernel parameters
> from /proc/bootconfig before falling back to /proc/cmdline. This allows
> kexec to use the original boot parameters without bootconfig which
> is embedded in the kernel.

Thanks for the great fix. While I have some questions about the change.

1, if we can read kernel parameters from /proc/bootconfig, does it mean
   we will skip other kernel parameters, e.g I set some parameters in
   grub, meanwhile set bootconfg? Is this allowed?

2. If /proc/bootconfig includes the whole kernel parameters of the
   runnign kernel, setup_boot_config() will parse and append bootconfig
   to kernel cmdline again, right? But it doesn't matter.

Sorry, I am not familiar with bootconfig.

Thanks
Baoquan

> 
> The function will fallback to /proc/cmdline behavior when:
> 
> - /proc/bootconfig doesn't exist
> - /proc/bootconfig is empty
> - /proc/bootconfig doesn't contain the expected marker format
> - The extracted parameter line is empty
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  kexec/kexec.c | 50 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 6bf12d7..b31cb1f 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1235,15 +1235,53 @@ static char *slurp_proc_file(const char *filename, size_t *len)
>   */
>  char *get_command_line(void)
>  {
> -	char *p, *line;
> +	char *p, *line = NULL;
>  	size_t size;
> +	char *bootconfig_line;
> +	size_t bootconfig_size;
> +
> +	/* First try to get command line parameters from /proc/bootconfig */
> +	bootconfig_line = slurp_proc_file("/proc/bootconfig", &bootconfig_size);
> +	if (bootconfig_line && bootconfig_size > 0) {
> +		/* Look for "# Parameters from bootloader:" */
> +		char *params_marker = strstr(bootconfig_line, "# Parameters from bootloader:");
> +		if (params_marker) {
> +			/* Find the next line after the marker */
> +			char *params_start = strchr(params_marker, '\n');
> +			if (params_start) {
> +				params_start++; /* Move past the newline */
> +
> +				/* Check if this line starts with "# " */
> +				if (strncmp(params_start, "# ", 2) == 0) {
> +					/* Skip the "# " prefix */
> +					params_start += 2;
> +
> +					/* Find the end of the line */
> +					char *params_end = strchr(params_start, '\n');
> +					if (params_end) {
> +						*params_end = '\0';
> +					}
> +
> +					/* Check if the extracted line is not empty */
> +					if (strlen(params_start) > 0) {
> +						/* Allocate and copy the parameters */
> +						line = xstrdup(params_start);
> +					}
> +				}
> +			}
> +		}
> +		free(bootconfig_line);
> +	}
>  
> -	line = slurp_proc_file("/proc/cmdline", &size);
> -	if (!line || !size)
> -		die("Failed to read /proc/cmdline\n");
> +	/* Fall back to reading /proc/cmdline if we didn't get a line from bootconfig */
> +	if (!line) {
> +		line = slurp_proc_file("/proc/cmdline", &size);
> +		if (!line || !size)
> +			die("Failed to read /proc/cmdline\n");
>  
> -	/* strip newline */
> -	line[size-1] = '\0';
> +		/* strip newline */
> +		line[size-1] = '\0';
> +	}
>  
>  	p = strpbrk(line, "\r\n");
>  	if (p)
> -- 
> 2.47.3
> 
> 


