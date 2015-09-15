Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 15 Sep 2015 10:06:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 09/13] Move bp_type_idx to kernel/event/hw_breakpoint.c
Message-ID: <20150915080607.GW16853@twins.programming.kicks-ass.net>
References: <1441832902-28993-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-1-git-send-email-palmer@dabbelt.com>
 <1442271047-4908-10-git-send-email-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1442271047-4908-10-git-send-email-palmer@dabbelt.com>
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
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: dave@sr71.net, linux-xtensa@linux-xtensa.org, Frederic Weisbecker <fweisbec@gmail.com>, dhowells@redhat.com, jcmvbkbc@gmail.com, hpa@zytor.com, mingo@kernel.org, ast@plumgrid.com, aarcange@redhat.com, bhe@redhat.com, x86@kernel.org, tomi.valkeinen@ti.com, 3chas3@gmail.com, paulmck@linux.vnet.ibm.com, dyoung@redhat.com, vgoyal@redhat.com, aishchuk@linux.vnet.ibm.com, linux-arch@vger.kernel.org, jikos@kernel.org, arnd@arndb.de, plagnioj@jcrosoft.com, josh@joshtriplett.org, acme@kernel.org, mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk, luto@kernel.org, tglx@linutronix.de, drysdale@google.com, chris@zankel.net, iulia.manda21@gmail.com, geoff@infradead.org, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, davem@davemloft.net

On Mon, Sep 14, 2015 at 03:50:43PM -0700, Palmer Dabbelt wrote:
> This has a "#ifdef CONFIG_*" that used to be exposed to userspace.
> 
> The names in here are so generic that I don't think it's a good idea
> to expose them to userspace (or even the rest of the kernel).  Since
> there's only one kernel user, it's been moved to that file.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
> ---
>  include/uapi/linux/hw_breakpoint.h | 10 ----------
>  kernel/events/hw_breakpoint.c      | 10 ++++++++++
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/linux/hw_breakpoint.h b/include/uapi/linux/hw_breakpoint.h
> index b04000a2296a..7a6a5a7f9511 100644
> --- a/include/uapi/linux/hw_breakpoint.h
> +++ b/include/uapi/linux/hw_breakpoint.h
> @@ -17,14 +17,4 @@ enum {
>  	HW_BREAKPOINT_INVALID   = HW_BREAKPOINT_RW | HW_BREAKPOINT_X,
>  };
>  
> -enum bp_type_idx {
> -	TYPE_INST 	= 0,
> -#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
> -	TYPE_DATA	= 0,
> -#else
> -	TYPE_DATA	= 1,
> -#endif
> -	TYPE_MAX
> -};

This is rather unfortunate; you are correct that the naming is too
generic (and I tend to agree), but I think these values are required by
userspace to fill out:

  perf_event_attr::bp_type

So removing them will break things.

Frederic?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
