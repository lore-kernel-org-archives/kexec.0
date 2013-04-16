Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URzDC-0005qZ-Cx
 for kexec@lists.infradead.org; Tue, 16 Apr 2013 06:17:52 +0000
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Tue, 16 Apr 2013 11:44:21 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 8F92FE0054
 for <kexec@lists.infradead.org>; Tue, 16 Apr 2013 11:49:36 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3G6HYB111927636
 for <kexec@lists.infradead.org>; Tue, 16 Apr 2013 11:47:34 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3G6HbwS004028
 for <kexec@lists.infradead.org>; Tue, 16 Apr 2013 16:17:39 +1000
Message-ID: <516CECFE.6020504@in.ibm.com>
Date: Tue, 16 Apr 2013 11:47:34 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [UPDATED PATCH] kexec/powerpc: Handle buffer overflow in kernel
 command line
References: <515AB9BF.5080104@gmail.com>
 <20130402121228.435.27569.stgit@suzukikp.in.ibm.com>
In-Reply-To: <20130402121228.435.27569.stgit@suzukikp.in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org, zhangyanfei.yes@gmail.com

On 04/02/2013 05:43 PM, Suzuki K. Poulose wrote:
> Zhang,
>
> Sorry, it was my mistake. I have updated my patch based on the upstream
> tree now.
>
> ---
>
> From: Suzuki K. Poulose <suzuki@in.ibm.com>
>
> Enforce size check for kernel command line to make sure it
> doesn't overflow COMMAND_LINE_SIZE.
>
> Reported-by: Nathan D. Miller <nathanm2@us.ibm.com>
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Simon,

Could you please apply this one ?

Thanks
Suzuki
> ---
>   kexec/arch/ppc/kexec-elf-ppc.c    |   29 ++++++++++++++++-------------
>   kexec/arch/ppc/kexec-uImage-ppc.c |   23 ++++++++++++++---------
>   2 files changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
> index 3daca2d..98cae9c 100644
> --- a/kexec/arch/ppc/kexec-elf-ppc.c
> +++ b/kexec/arch/ppc/kexec-elf-ppc.c
> @@ -157,7 +157,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>   	struct mem_ehdr ehdr;
>   	char *command_line, *crash_cmdline, *cmdline_buf;
>   	char *tmp_cmdline;
> -	int command_line_len;
> +	int command_line_len, crash_cmdline_len;
>   	char *dtb;
>   	int result;
>   	char *error_msg;
> @@ -244,19 +244,10 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>   	} else {
>   		command_line = get_command_line();
>   	}
> -	command_line_len = strlen(command_line) + 1;
> +	command_line_len = strlen(command_line);
>
>   	fixup_nodes[cur_fixup] = NULL;
>
> -	/* Need to append some command line parameters internally in case of
> -	 * taking crash dumps.
> -	 */
> -	if (info->kexec_flags & KEXEC_ON_CRASH) {
> -		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
> -		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
> -	} else
> -		crash_cmdline = NULL;
> -
>   	/* Parse the Elf file */
>   	result = build_elf_exec_info(buf, len, &ehdr, 0);
>   	if (result < 0) {
> @@ -292,16 +283,23 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>   		goto out;
>   	}
>
> -	/* If panic kernel is being loaded, additional segments need
> -	 * to be created.
> +	/*
> +	 * Need to append some command line parameters internally in case of
> +	 * taking crash dumps. Additional segments need to be created.
>   	 */
>   	if (info->kexec_flags & KEXEC_ON_CRASH) {
> +		crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
> +		memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
>   		result = load_crashdump_segments(info, crash_cmdline,
>   						max_addr, 0);
>   		if (result < 0) {
>   			result = -1;
>   			goto out;
>   		}
> +		crash_cmdline_len = strlen(crash_cmdline);
> +	} else {
> +		crash_cmdline = NULL;
> +		crash_cmdline_len = 0;
>   	}
>
>   	/*
> @@ -337,6 +335,11 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>
>   	info->entry = (void *)arg_base;
>   #else
> +	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
> +		printf("Kernel command line exceeds size\n");
> +		return -1;
> +	}
> +
>   	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
>   	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
>   	if (command_line)
> diff --git a/kexec/arch/ppc/kexec-uImage-ppc.c b/kexec/arch/ppc/kexec-uImage-ppc.c
> index 9113fbe..008463b 100644
> --- a/kexec/arch/ppc/kexec-uImage-ppc.c
> +++ b/kexec/arch/ppc/kexec-uImage-ppc.c
> @@ -82,7 +82,7 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>   {
>   	char *command_line, *cmdline_buf, *crash_cmdline;
>   	char *tmp_cmdline;
> -	int command_line_len;
> +	int command_line_len, crash_cmdline_len;
>   	char *dtb;
>   	unsigned int addr;
>   	unsigned long dtb_addr;
> @@ -178,29 +178,34 @@ static int ppc_load_bare_bits(int argc, char **argv, const char *buf,
>
>   	add_segment(info, buf, len, load_addr, len + _1MiB);
>
> +
>   	if (info->kexec_flags & KEXEC_ON_CRASH) {
>                   crash_cmdline = xmalloc(COMMAND_LINE_SIZE);
>                   memset((void *)crash_cmdline, 0, COMMAND_LINE_SIZE);
> -        } else
> -                crash_cmdline = NULL;
> -
> -	if (info->kexec_flags & KEXEC_ON_CRASH) {
>   		ret = load_crashdump_segments(info, crash_cmdline,
>   						max_addr, 0);
>   		if (ret < 0) {
>   			ret = -1;
>   			goto out;
>   		}
> +		crash_cmdline_len = strlen(crash_cmdline);
> +	} else {
> +		crash_cmdline = NULL;
> +		crash_cmdline_len = 0;
> +	}
> +
> +	if (crash_cmdline_len + command_line_len + 1 > COMMAND_LINE_SIZE) {
> +		printf("Kernel command line exceeds maximum possible length\n");
> +		return -1;
>   	}
>
>   	cmdline_buf = xmalloc(COMMAND_LINE_SIZE);
>   	memset((void *)cmdline_buf, 0, COMMAND_LINE_SIZE);
> +
>   	if (command_line)
> -		strncat(cmdline_buf, command_line, command_line_len);
> +		strcpy(cmdline_buf, command_line);
>   	if (crash_cmdline)
> -		strncat(cmdline_buf, crash_cmdline,
> -			sizeof(crash_cmdline) -
> -			strlen(crash_cmdline) - 1);
> +		strncat(cmdline_buf, crash_cmdline, crash_cmdline_len);
>
>   	elf_rel_build_load(info, &info->rhdr, (const char *)purgatory,
>   				purgatory_size, 0, -1, -1, 0);
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
