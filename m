Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n003z-00A9zP-BL
 for kexec@lists.infradead.org; Wed, 22 Dec 2021 11:45:44 +0000
Date: Wed, 22 Dec 2021 19:45:18 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 3/3] panic: Allow printing extra panic information on kdump
Message-ID: <YcMPzs6t8MKpEacq@dhcp-128-65.nay.redhat.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
 <20211109202848.610874-4-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211109202848.610874-4-gpiccoli@igalia.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com, akpm@linux-foundation.org, feng.tang@intel.com, siglesias@igalia.com, kernel@gpiccoli.net, kexec@lists.infradead.org

Hi Guilherme,

Thanks for you patch.  Could you add kexec list for any following up
patches?  This could change kdump behavior so let's see if any comments
from kexec list.

Kudos for the lore+lei tool so that I can catch this by seeing this
coming into Andrews tree :)
On 11/09/21 at 05:28pm, Guilherme G. Piccoli wrote:
> Currently we have the "panic_print" parameter/sysctl to allow some extra
> information to be printed in a panic event. On the other hand, the kdump
> mechanism allows to kexec a new kernel to collect a memory dump for the
> running kernel in case of panic.
> Right now these options are incompatible: the user either sets the kdump
> or makes use of "panic_print". The code path of "panic_print" isn't
> reached when kdump is configured.
> 
> There are situations though in which this would be interesting: for
> example, in systems that are very memory constrained, a handcrafted
> tiny kernel/initrd for kdump might be used in order to only collect the
> dmesg in kdump kernel. Even more common, systems with no disk space for
> the full (compressed) memory dump might very well rely in this
> functionality too, dumping only the dmesg with the additional information
> provided by "panic_print".
> 
> So, this is what the patch does: allows both functionality to co-exist;
> if "panic_print" is set and the system performs a kdump, the extra
> information is printed on dmesg before the kexec. Some notes about the
> design choices here:
> 
> (a) We could have introduced a sysctl or an extra bit on "panic_print"
> to allow enabling the co-existence of kdump and "panic_print", but seems
> that would be over-engineering; we have 3 cases, let's check how this
> patch change things:
> 
> - if the user have kdump set and not "panic_print", nothing changes;
> - if the user have "panic_print" set and not kdump, nothing changes;
> - if both are enabled, now we print the extra information before kdump,
> which is exactly the goal of the patch (and should be the goal of the
> user, since they enabled both options).

People may enable kdump crashkernel and panic_print together but
they are not aware the extra panic print could cause kdump not reliable
(in theory).  So at least some words in kernel-parameters.txt would
help.
 
> 
> (b) We assume that the code path won't return from __crash_kexec()
> so we didn't guard against double execution of panic_print_sys_info().
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  kernel/panic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 5da71fa4e5f1..439dbf93b406 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -243,6 +243,13 @@ void panic(const char *fmt, ...)
>  	 */
>  	kgdb_panic(buf);
>  
> +	/*
> +	 * If we have a kdump kernel loaded, give a chance to panic_print
> +	 * show some extra information on kernel log if it was set...
> +	 */
> +	if (kexec_crash_loaded())
> +		panic_print_sys_info();
> +
>  	/*
>  	 * If we have crashed and we have a crash kernel loaded let it handle
>  	 * everything else.
> -- 
> 2.33.1
> 
> 

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
