Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Veog7-0007oJ-3d
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 16:12:59 +0000
Message-ID: <527D0D50.6010607@zytor.com>
Date: Fri, 08 Nov 2013 08:12:00 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: make reboot task only run on the appropriate
 processor
References: <1383642967-12595-1-git-send-email-bhe@redhat.com>
 <20131108151416.GA13068@redhat.com>
In-Reply-To: <20131108151416.GA13068@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: Robin Holt <robinmholt@gmail.com>, mwhitehe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Robin Holt <robinmholt@linux.com>, davej@fedoraproject.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, akpm@linux-foundation.org, chaowang@redhat.com

On 11/08/2013 07:14 AM, Vivek Goyal wrote:
> 
> Hi Bao,
> 
> This patch fixes the issue for me too. I noticed that we have generic
> function migrate_to_reboot_cpu() to achieve what we want and rest of
> the reboot paths are using it. So how about using that function. I 
> wrote the new patch below. It works for me. Can you please give it
> a try.
> 
> Thanks
> Vivek
> 

Is this path exercised for the kdump flow?  migrate_to_reboot_cpu() is
unsafe in that case.

> Index: linux-2.6/kernel/kexec.c
> ===================================================================
> --- linux-2.6.orig/kernel/kexec.c	2013-10-16 00:30:50.000000000 -0400
> +++ linux-2.6/kernel/kexec.c	2013-11-08 21:34:02.492072375 -0500
> @@ -1676,6 +1676,7 @@ int kernel_kexec(void)
>  #endif
>  	{
>  		kernel_restart_prepare(NULL);
> +		migrate_to_reboot_cpu();
>  		printk(KERN_EMERG "Starting new kernel\n");
>  		machine_shutdown();
>  	}
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
