From: Petr =?unknown-8bit?b?VGVzYcWZw61r?= <ptesarik@suse.cz>
Date: Thu, 27 Jan 2022 16:53:01 +0100
Subject: [RFC PATCH] kdump: Add support for crashkernel=auto
In-Reply-To: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
References: <1643275911-19489-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <d513dea3-7300-9684-73af-0b51f5f0e572@suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Tiezhu Yang,

I'm afraid the whole concept is broken by design. See below.

Dne 27. 01. 22 v 10:31 Tiezhu Yang napsal(a):
> Set the reserved memory automatically for the crash kernel based on
> architecture.
> 
> Most code of this patch come from:
> https://gitlab.com/redhat/centos-stream/src/kernel/centos-stream-8/-/tree/c8s

And that's the problem, I think. The solution might be good for this 
specific OS, but not for others.

>[...]
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 256cf6d..32c51e2 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -252,6 +252,26 @@ static int __init __parse_crashkernel(char *cmdline,
>   	if (suffix)
>   		return parse_crashkernel_suffix(ck_cmdline, crash_size,
>   				suffix);
> +
> +	if (strncmp(ck_cmdline, "auto", 4) == 0) {
> +#if defined(CONFIG_X86_64) || defined(CONFIG_S390)
> +		ck_cmdline = "1G-4G:160M,4G-64G:192M,64G-1T:256M,1T-:512M";
> +#elif defined(CONFIG_ARM64)
> +		ck_cmdline = "2G-:448M";
> +#elif defined(CONFIG_PPC64)
> +		char *fadump_cmdline;
> +
> +		fadump_cmdline = get_last_crashkernel(cmdline, "fadump=", NULL);
> +		fadump_cmdline = fadump_cmdline ?
> +				fadump_cmdline + strlen("fadump=") : NULL;
> +		if (!fadump_cmdline || (strncmp(fadump_cmdline, "off", 3) == 0))
> +			ck_cmdline = "2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G";
> +		else
> +			ck_cmdline = "4G-16G:768M,16G-64G:1G,64G-128G:2G,128G-1T:4G,1T-2T:6G,2T-4T:12G,4T-8T:20G,8T-16T:36G,16T-32T:64G,32T-64T:128G,64T-:180G";
> +#endif
> +		pr_info("Using crashkernel=auto, the size chosen is a best effort estimation.\n");
> +	}
> +

How did you even arrive at the above numbers? I've done some research on 
this topic recently (ie. during the last 7 years or so). My x86_64 
system with 8G RAM running openSUSE Leap 15.3 seems needs 188M for 
saving to the local disk, and 203M to save over the network (using 
SFTP). My PPC64 LPAR with 16G RAM running latest Beta of SLES 15 SP4 
needs 587M, i.e. with the above numbers it may run out of memory while 
saving the dump.

Since this is not the first time, I'm trying to explain things, I've 
written a blog post now:

https://sigillatum.tesarici.cz/2022-01-27-whats-wrong-with-crashkernel-auto.html

HTH
Petr Tesarik

