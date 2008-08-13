Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KTGGe-0004YZ-HM
	for kexec@lists.infradead.org; Wed, 13 Aug 2008 13:20:00 +0000
Date: Wed, 13 Aug 2008 09:19:27 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] kexec jump: fix code size checking
Message-ID: <20080813131927.GB3957@redhat.com>
References: <1218589475.24951.59.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218589475.24951.59.camel@caritas-dev.intel.com>
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

On Wed, Aug 13, 2008 at 09:04:35AM +0800, Huang Ying wrote:
> Fix building issue when CONFIG_KEXEC=n. Thanks to Vivek Goyal for his
> reminding.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  include/asm-x86/kexec.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/include/asm-x86/kexec.h
> +++ b/include/asm-x86/kexec.h
> @@ -43,6 +43,9 @@
>  
>  #ifdef CONFIG_X86_32
>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
> +# ifndef CONFIG_KEXEC
> +#  define kexec_control_code_size	0
> +# endif
>  #endif
>  
>  #ifndef __ASSEMBLY__

I think Andrew already fixed it. Right way is to put code in vmlinux.lds.S
under #ifdef CONFIG_KEXEC, than defining the symbol kexec_control_code_size
if CONFIG_KEXEC=n

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
