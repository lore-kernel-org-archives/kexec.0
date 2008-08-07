Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KR5Ls-00052b-OQ
	for kexec@lists.infradead.org; Thu, 07 Aug 2008 13:16:25 +0000
Date: Thu, 7 Aug 2008 09:15:57 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/6] kexec jump: check code size in control page
Message-ID: <20080807131557.GB27783@redhat.com>
References: <1218099926.5164.33.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218099926.5164.33.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Thu, Aug 07, 2008 at 05:05:26PM +0800, Huang Ying wrote:
> Kexec/Kexec-jump requires code size in control page is less than
> PAGE_SIZE/2. This patch adds runtime checking for this.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  arch/x86/kernel/machine_kexec_32.c   |    4 ++++
>  arch/x86/kernel/relocate_kernel_32.S |    3 +++
>  include/asm-x86/kexec.h              |    1 +
>  3 files changed, 8 insertions(+)
> 
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -92,6 +92,10 @@ int machine_kexec_prepare(struct kimage 
>  {
>  	if (nx_enabled)
>  		set_pages_x(image->control_code_page, 1);
> +
> +	BUG_ON((unsigned long)kexec_control_page_code_end - \
> +	       (unsigned long)relocate_kernel >= PAGE_SIZE/2);
> +

Hi Huang,

Run time check is better than nothing but I think in this case it would
be better if we can catch it at compile time. 

One of the methods will be to write a small program of your own and
put in script/ and at build time check for the size and flag error. May
be there are other better ways to do this.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
