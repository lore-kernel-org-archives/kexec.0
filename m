Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by casper.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RV9ei-000820-Jx
 for kexec@lists.infradead.org; Mon, 28 Nov 2011 22:26:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20111125081959.GA2505@darkstar.nay.redhat.com>
Date: Mon, 28 Nov 2011 14:27:02 -0800
In-Reply-To: <20111125081959.GA2505@darkstar.nay.redhat.com> (Dave Young's
 message of "Fri, 25 Nov 2011 16:19:59 +0800")
Message-ID: <m1aa7fq3wp.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec: do not call kmsg_dump in crashdump
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

Dave Young <dyoung@redhat.com> writes:

> mtd/ram oops dumper will make more functions envolved. In case crash kexec, 
> we should avoid kmsg dumper to ensure crashdump success.
>
> kill kmsg_dump callback while crash dumping 

Agreed.

There is a similar?  Or possibly the same patch already queued in
Andrews tree.

Eric

>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kernel/kexec.c |    2 --
>  1 file changed, 2 deletions(-)
>
> --- linux-2.6.orig/kernel/kexec.c	2011-11-18 16:34:18.000000000 +0800
> +++ linux-2.6/kernel/kexec.c	2011-11-24 16:05:08.138660500 +0800
> @@ -1094,8 +1094,6 @@ void crash_kexec(struct pt_regs *regs)
>  		if (kexec_crash_image) {
>  			struct pt_regs fixed_regs;
>  
> -			kmsg_dump(KMSG_DUMP_KEXEC);
> -
>  			crash_setup_regs(&fixed_regs, regs);
>  			crash_save_vmcoreinfo();
>  			machine_crash_shutdown(&fixed_regs);

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
