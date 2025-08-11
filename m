Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E5DCA0EC4
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 22:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7HbBcEdTW8AbXl0j/9hPjOAFfKKILaBg+uEMgIl5g9Y=; b=adUzJ/SCjWiil/o3csCxo8/pJy
	I6fjei+5GWGcQ1yeuzKLv+HLInMZd5kgkRMMZKD/2HSnfzvwGmLGalL1w7sZhqKC+fwn3tqNWMs+1
	P8g2ZKabdWO+CxPuVM7OhZbv2dgQ1VjOeTZK7lTZwV8UwxVgpwLpK/ijGyapJhWsHSjThh+Hsu7Xr
	Iu9/i0923dSjnv3pT2UO2Nug81D6ZtbIOJdbRf0dBHZ92bFzwQ/IGK6PJqkfhTPCRN2YsRkV6ligT
	qgWnUj85LvqlSxFY/xJj2pyrzvyK8fBvzGkrN7zfcf/z8juDLw4TDgs2CWyY87Ja3x5YoL0GATsOF
	s1C665vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulaax-000000099sh-1sTR;
	Mon, 11 Aug 2025 22:02:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulVHX-00000008Nyc-3CFi
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 16:21:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EF9C845077;
	Mon, 11 Aug 2025 16:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1256C4CEED;
	Mon, 11 Aug 2025 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754929314;
	bh=bnb7otn7hPJswvGkhYz8W10ho90R+a+UilYf9AXmygc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mjRaSgV8k7LNziMPI4K1xkYDqLPX/5Xcb+c3zPjLg4TcIZp6Os8AOhXFvD4xJ2nO3
	 WyT5wjhQxww+7rlLUukMWSBNUi2eenD2vjwaAxwJkFPVOBGExooUdLEJWWREwnD/xN
	 GEFQGE2FRAA5xiwgxmBZmOdI7yT1ACGDMmH7A2sTFRyrO/RWcDi4P9Kh97UojF97Te
	 v6ou1MufvlkdabD7m9jpHWnsXS1dAO1AWCaagS9hHB/oUzoPzH/bfk/Nahzyw/tNjM
	 t9e+D9UhcMSPgnjSICiurXjMTUCtgEt6NTp8ndWUsUIVMJfieiE5RJRfo6gLvR57S+
	 08Xidc9ZnVQ1w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7CF40CE0B2D; Mon, 11 Aug 2025 09:21:54 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:21:54 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, leitao@debian.org,
	kernel-team@meta.com
Subject: Re: [RFC] kexec: Add bootconfig support to get_command_line
Message-ID: <ead1cb70-63f1-42a2-b7c5-227d26cbb934@paulmck-laptop>
References: <20250811153736.3865487-1-usamaarif642@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811153736.3865487-1-usamaarif642@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_092155_850001_302EC568 
X-CRM114-Status: GOOD (  32.82  )
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
Reply-To: paulmck@kernel.org
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Aug 11, 2025 at 04:37:36PM +0100, Usama Arif wrote:
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
> 
> The function will fallback to /proc/cmdline behavior when:
> 
> - /proc/bootconfig doesn't exist
> - /proc/bootconfig is empty
> - /proc/bootconfig doesn't contain the expected marker format
> - The extracted parameter line is empty
> 
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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

