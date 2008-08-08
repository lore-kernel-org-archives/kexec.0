Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KRSmi-00013j-Hl
	for kexec@lists.infradead.org; Fri, 08 Aug 2008 14:17:40 +0000
Date: Fri, 8 Aug 2008 10:17:00 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -v2 7/8] kexec jump: ftrace_enabled_save/restore
Message-ID: <20080808141700.GF3840@redhat.com>
References: <1218178368.22039.80.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218178368.22039.80.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, rostedt@goodmis.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Fri, Aug 08, 2008 at 02:52:48PM +0800, Huang Ying wrote:
> Add ftrace_enabled_save/restore, used to disable ftrace for a
> while. This is used by kexec jump.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 


CCing Steven Rostedt for ftrace related changes.

> ---
>  include/linux/ftrace.h |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -98,6 +98,24 @@ static inline void tracer_disable(void)
>  #endif
>  }
>  
> +static inline int ftrace_enabled_save(void)
> +{
> +#ifdef CONFIG_FTRACE
> +	int saved_ftrace_enabled = ftrace_enabled;
> +	ftrace_enabled = 0;
> +	return saved_ftrace_enabled;
> +#else
> +	return 0;
> +#endif
> +}
> +
> +static inline void ftrace_enabled_restore(int enabled)
> +{
> +#ifdef CONFIG_FTRACE
> +	ftrace_enabled = enabled;
> +#endif
> +}
> +
>  #ifdef CONFIG_FRAME_POINTER
>  /* TODO: need to fix this for ARM */
>  # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
