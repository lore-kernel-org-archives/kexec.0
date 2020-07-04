Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jreXC-0007Dz-2h
 for kexec@lists.infradead.org; Sat, 04 Jul 2020 09:32:34 +0000
Date: Sat, 4 Jul 2020 17:30:08 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3 1/3] crash: add VMCOREINFO macro to define offset in a
 struct declared by typedef
Message-ID: <20200704093008.GA23574@MiWiFi-R3L-srv>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-2-john.ogness@linutronix.de>
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
To: John Ogness <john.ogness@linutronix.de>
Cc: Andrea Parri <parri.andrea@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Paul McKenney <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

On 06/18/20 at 04:55pm, John Ogness wrote:
> The existing macro VMCOREINFO_OFFSET() can't be used for structures
> declared via typedef because "struct" is not part of type definition.
> 
> Create another macro for this purpose.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/crash_core.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 525510a9f965..43b51c9df571 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -53,6 +53,9 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  #define VMCOREINFO_OFFSET(name, field) \
>  	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
>  			      (unsigned long)offsetof(struct name, field))
> +#define VMCOREINFO_TYPE_OFFSET(name, field) \
> +	vmcoreinfo_append_str("OFFSET(%s.%s)=%lu\n", #name, #field, \
> +			      (unsigned long)offsetof(name, field))

Acked-by: Baoquan He <bhe@redhat.com>

>  #define VMCOREINFO_LENGTH(name, value) \
>  	vmcoreinfo_append_str("LENGTH(%s)=%lu\n", #name, (unsigned long)value)
>  #define VMCOREINFO_NUMBER(name) \
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
