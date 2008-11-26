Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rcsinet13.oracle.com ([148.87.113.125]
	helo=rgminet13.oracle.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L5B22-0006uv-N9
	for kexec@lists.infradead.org; Wed, 26 Nov 2008 03:25:39 +0000
Message-ID: <492CC1AA.3010408@oracle.com>
Date: Tue, 25 Nov 2008 19:25:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix kexec x86_64 load failed bug
References: <20081125134738.7075a13a@hale.suse.de>
	<1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
In-Reply-To: <1227662409.2442.11.camel@yhuang-dev.sh.intel.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Huang Ying <ying.huang@intel.com>
Cc: Bernhard Walle <bwalle@suse.de>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Huang Ying wrote:
> Fix a bug of kexec load on x86_64. Kexec fails to do load on x86_64, with
> error message:
> 
>   Symbol: cmdline_end not found cannot set
> 
> Because kexec/arch/i386/kexec-bzImage.c accesses cmdline_end symbol in
> i386 purgatory, but there is no cmdline_end in x86_64 purgatory, and
> kexec-bzImage.c is used by x86_64 too.
> 
> cmdline_end is added into x86_64 purgatory to solve the bug, because kexec
> jump support for x86_64 is planned.
> 
> Reported-by: Bernhard Walle <bwalle@suse.de>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> diff --git a/purgatory/arch/x86_64/purgatory-x86_64.c b/purgatory/arch/x86_64/purgatory-x86_64.c
> index 374b554..67a37f9 100644
> --- a/purgatory/arch/x86_64/purgatory-x86_64.c
> +++ b/purgatory/arch/x86_64/purgatory-x86_64.c
> @@ -5,6 +5,7 @@
>  uint8_t reset_vga = 0;
>  uint8_t legacy_pic = 0;
>  uint8_t panic_kernel = 0;
> +char *cmdline_end = 0;
>  
>  void setup_arch(void)
>  {

This isn't kernel code?  Where is /purgatory/ ?

Anyway, for kernel code, that should be:
char *cmdline_end = NULL;

-- 
~Randy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
