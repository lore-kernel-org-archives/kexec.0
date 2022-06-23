Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B363C433EF
	for <kexec@archiver.kernel.org>; Thu, 23 Jun 2022 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T4i//E8XJRGFldrHoOe0plYlk4gg5/MvRr2kpsDPk0k=; b=e6kH5jD1l8voPB
	eOKd6+0M/871QYQXgoPXnp3xnvMm0SKSTWHow4mVF0t23d5S0DWQLJ0EYyVUP2cRQipSv5rngDqfO
	JjMILamH1rMRo9zmD2pxCdb8l7th92CLii8xDBXrdfHRgEEKAKltW74dLURKIk9uenTI3FnSOuy0x
	byRFv047cMVCn8CX2SnCXQRS4+q7Rn4XVQOrOPx6cboc2wgdFDrDLLmdWIzL8MPSXRq+4o9y+Bffz
	4Yx2fkKsYhkRKw/PHuW0bsKnBMKcyDucpHsDO29J4zHQiVXTILz9EALQbK7U6T4MuwPbAiHVlWthr
	KwdN4V46MXH9GvnTRHVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Nne-00FXBL-Ap; Thu, 23 Jun 2022 14:27:14 +0000
Received: from zeeaster.vergenet.net ([206.189.110.174])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Nnb-00FXA9-0I
	for kexec@lists.infradead.org; Thu, 23 Jun 2022 14:27:13 +0000
Received: from madeliefje.horms.nl (86-88-72-229.fixed.kpn.net [86.88.72.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by zeeaster.vergenet.net (Postfix) with ESMTPSA id 8BE5B2008D;
	Thu, 23 Jun 2022 14:17:14 +0000 (UTC)
Received: by madeliefje.horms.nl (Postfix, from userid 7100)
	id 4D5683AD8; Thu, 23 Jun 2022 16:17:14 +0200 (CEST)
Date: Thu, 23 Jun 2022 16:17:14 +0200
From: Simon Horman <horms@kernel.org>
To: Hui Li <lihui@loongson.cn>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v4] kexec-tools: mips: Pass initrd parameter via cmdline
Message-ID: <YrR16vXtDAQ4gud7@vergenet.net>
References: <20220610085352.26171-1-lihui@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220610085352.26171-1-lihui@loongson.cn>
Organisation: Horms Solutions BV
X-Virus-Scanned: clamav-milter 0.103.6 at zeeaster
X-Virus-Status: Clean
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_072711_231837_37379101 
X-CRM114-Status: GOOD (  35.97  )
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

On Fri, Jun 10, 2022 at 04:53:52PM +0800, Hui Li wrote:
> Under loongson platform, use command:
> kexec -l vmlinux... --append="root=UUID=28e1..." --initrd=...
> kexec -e
> quick restart failed like this:
> 
> ********************************************************************
> [    3.420791] VFS: Cannot open root device "UUID=6462a8a4-02fb-49..."
> [    3.431262] Please append a correct "root=" boot option; ...
> ...
> ...
> ...
> [    3.543175]   0801         4194304 sda1 554e69cc-01
> [    3.543175]
> [    3.549494]   0802        62914560 sda2 554e69cc-02
> [    3.549495]
> [    3.555818]   0803         8388608 sda3 554e69cc-03
> [    3.555819]
> [    3.562139]   0804       174553229 sda4 554e69cc-04
> [    3.562139]
> [    3.568463] 0b00         1048575 sr0
> [    3.568464]  driver: sr
> [    3.574524] Kernel panic - not syncing: VFS: Unable to mount root fs...
> [    3.582750] ---[ end Kernel panic - not syncing: VFS:...
> *******************************************************************
> 
> The kernel cannot parse the UUID, the UUID is parsed in the initrd.
> For compatibility with previous platforms, loongson platform obtain
> initrd parameter through cmdline in kernel, the kernel supports use
> cmdline to parse initrd. But under the mips architecture, kexec-tools
> pass the initrd through DTB.
> 
> So some modifications as follows:
> 
> (1) in kexec/arch/mips/kexec-elf-mips.c
>     Add patch_initrd_info(), at runtime to distinguish different cpu,
>     only for loongson cpu, add initrd parameter to cmdline.
> 
> (2) in kexec/arch/mips/crashdump-mips.c
>     Because loongson uses a different page_offset, it should be modified
>     to ensure that crashdump functionality is correct and reliable.
> 
> Signed-off-by: Hui Li <lihui@loongson.cn>

Hi Hui Li,

thanks for the follow-up and sorry for the slow response.

Overall I am happy with this approach.
I have made a few minor comments inline for your consideration.

> ---
>  kexec/arch/mips/crashdump-mips.c |  3 ++
>  kexec/arch/mips/kexec-elf-mips.c | 73 +++++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/arch/mips/crashdump-mips.c b/kexec/arch/mips/crashdump-mips.c
> index aa09c83..548aeff 100644
> --- a/kexec/arch/mips/crashdump-mips.c
> +++ b/kexec/arch/mips/crashdump-mips.c
> @@ -335,6 +335,9 @@ static int patch_elf_info(void)
>  			/* OCTEON uses a different page_offset. */
>  			if (strstr(line, "Octeon"))
>  				elf_info64.page_offset = 0x8000000000000000ULL;
> +			/* LOONGSON uses a different page_offset. */
> +			else if (strstr(line, "Loongson"))
> +				elf_info64.page_offset = 0xffffffff80000000ULL;

nit: 0xffffffff80000000ULL is used twice. Perhaps we could make it a #define.
And perhaps 0x8000000000000000ULL too, while we are here.

>  			break;
>  		}
>  	}
> diff --git a/kexec/arch/mips/kexec-elf-mips.c b/kexec/arch/mips/kexec-elf-mips.c
> index a2d11fc..b9e0341 100644
> --- a/kexec/arch/mips/kexec-elf-mips.c
> +++ b/kexec/arch/mips/kexec-elf-mips.c
> @@ -40,6 +40,74 @@ static const int probe_debug = 0;
>  #define CMDLINE_PREFIX "kexec "
>  static char cmdline_buf[COMMAND_LINE_SIZE] = CMDLINE_PREFIX;
>  
> +/* Converts unsigned long to ascii string. */
> +static void ultoa(unsigned long i, char *str)
> +{
> +	int j = 0, k;
> +	char tmp;
> +
> +	do {
> +		str[j++] = i % 10 + '0';
> +	} while ((i /= 10) > 0);
> +	str[j] = '\0';
> +
> +	/* Reverse the string. */
> +	for (j = 0, k = strlen(str) - 1; j < k; j++, k--) {
> +		tmp = str[k];
> +		str[k] = str[j];
> +		str[j] = tmp;
> +	}
> +}
> +
> +/* Adds initrd parameters to command line. */
> +static int cmdline_add_initrd(char *cmdline, unsigned long addr, char *new_para)
> +{
> +	int cmdlen, len;
> +	char str[30], *ptr;
> +
> +	ptr = str;
> +	strcpy(str, new_para);
> +	ptr += strlen(str);
> +	ultoa(addr, ptr);
> +	len = strlen(str);
> +	cmdlen = strlen(cmdline) + len;
> +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> +		die("Command line overflow\n");
> +	strcat(cmdline, str);
> +
> +	return 0;
> +}
> +
> +/* add initrd to cmdline to compatible with previous platforms. */
> +static int patch_initrd_info(char *cmdline, unsigned long initrd_base, unsigned long initrd_size)

nit: I would prefer if the code was less than 80 columns wide.

> +{
> +	const char cpuinfo[] = "/proc/cpuinfo";
> +	char line[MAX_LINE];
> +	FILE *fp;
> +	unsigned long page_offset = PAGE_OFFSET;
> +
> +	fp = fopen(cpuinfo, "r");
> +	if (!fp) {
> +		fprintf(stderr, "Cannot open %s: %s\n",
> +		cpuinfo, strerror(errno));
> +		return -1;
> +	}
> +	while (fgets(line, sizeof(line), fp) != 0) {
> +		if (strncmp(line, "cpu model", 9) == 0) {
> +			/* LOONGSON64  uses a different page_offset. */
> +		if (strstr(line, "Loongson")) {
> +				if (arch_options.core_header_type == CORE_TYPE_ELF64)
> +					page_offset = (unsigned long)0xffffffff80000000ULL;
> +				cmdline_add_initrd(cmdline, page_offset + initrd_base, " rd_start=");
> +				cmdline_add_initrd(cmdline, initrd_size, " rd_size=");
> +				break;
> +			}
> +		}
> +	}
> +	fclose(fp);
> +	return 0;
> +}
> +
>  int elf_mips_probe(const char *buf, off_t len)
>  {
>  	struct mem_ehdr ehdr;
> @@ -171,9 +239,10 @@ int elf_mips_load(int argc, char **argv, const char *buf, off_t len,
>  		/* Now that the buffer for initrd is prepared, update the dtb
>  		 * with an appropriate location */
>  		dtb_set_initrd(&dtb_buf, &dtb_length, initrd_base, initrd_base + initrd_size);
> -	}
> -
>  
> +		/* Add the initrd parameters to cmdline */
> +		patch_initrd_info(cmdline_buf, initrd_base, initrd_size);
> +	}
>  	/* This is a legacy method for commandline passing used
>  	 * currently by Octeon CPUs only */
>  	add_buffer(info, cmdline_buf, sizeof(cmdline_buf),
> -- 
> 2.20.1
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
