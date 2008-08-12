Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KStaO-0004eg-5N
	for kexec@lists.infradead.org; Tue, 12 Aug 2008 13:06:52 +0000
Date: Tue, 12 Aug 2008 09:06:09 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -v3 6/7] kexec jump: __ftrace_enabled_save/restore
Message-ID: <20080812130609.GB3951@redhat.com>
References: <1218510876.24951.45.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1218510876.24951.45.camel@caritas-dev.intel.com>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, mingo@elte.hu

On Tue, Aug 12, 2008 at 11:14:36AM +0800, Huang Ying wrote:
> Add __ftrace_enabled_save/restore, used to disable ftrace for a
> while. Now, this is used by kexec jump, which need a version without
> lock, for general situation, a locked version should be used.
> 
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> 
> ---
>  include/linux/ftrace.h |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -98,6 +98,27 @@ static inline void tracer_disable(void)
>  #endif
>  }
>  
> +/* Ftrace disable/restore without lock. Some synchronization mechanism
> + * must be used to prevent ftrace_enabled to be changed between
> + * disable/restore. */
> +static inline int __ftrace_enabled_save(void)
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
> +static inline void __ftrace_enabled_restore(int enabled)
> +{
> +#ifdef CONFIG_FTRACE
> +	ftrace_enabled = enabled;
> +#endif
> +}
> +
>  #ifdef CONFIG_FRAME_POINTER
>  /* TODO: need to fix this for ARM */
>  # define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))

I guess steven would like to see a patch which introduces both locked
and lockless versions and with a very good comment explaining in what
kind of unusual situation one can use the lockless version.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
