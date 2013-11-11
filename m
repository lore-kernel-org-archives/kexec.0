Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vfts0-0004E2-W9
 for kexec@lists.infradead.org; Mon, 11 Nov 2013 15:57:45 +0000
Date: Mon, 11 Nov 2013 10:57:11 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86: make reboot task only run on the appropriate
 processor
Message-ID: <20131111155711.GB11547@redhat.com>
References: <1383642967-12595-1-git-send-email-bhe@redhat.com>
 <20131108151416.GA13068@redhat.com> <527D0D50.6010607@zytor.com>
 <20131111152948.GA11547@redhat.com>
 <469ce80c-c6a0-4238-aab5-9a4d8c562387@email.android.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <469ce80c-c6a0-4238-aab5-9a4d8c562387@email.android.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Robin Holt <robinmholt@gmail.com>, Baoquan He <bhe@redhat.com>, mwhitehe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Robin Holt <robinmholt@linux.com>, davej@fedoraproject.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, chaowang@redhat.com

On Mon, Nov 11, 2013 at 07:39:18AM -0800, H. Peter Anvin wrote:
> Yes, unless there is a better path for it since it is not x86-specific.  I am fine taking it, though.

Generally Andrew Morton routes kexec/kdump patches through his tree. Andrew,
do you think it should go through your tree?

Thanks
Vivek

> 
> Vivek Goyal <vgoyal@redhat.com> wrote:
> >On Fri, Nov 08, 2013 at 08:12:00AM -0800, H. Peter Anvin wrote:
> >> On 11/08/2013 07:14 AM, Vivek Goyal wrote:
> >> > 
> >> > Hi Bao,
> >> > 
> >> > This patch fixes the issue for me too. I noticed that we have
> >generic
> >> > function migrate_to_reboot_cpu() to achieve what we want and rest
> >of
> >> > the reboot paths are using it. So how about using that function. I 
> >> > wrote the new patch below. It works for me. Can you please give it
> >> > a try.
> >> > 
> >> > Thanks
> >> > Vivek
> >> > 
> >> 
> >> Is this path exercised for the kdump flow?  migrate_to_reboot_cpu()
> >is
> >> unsafe in that case.
> >
> >Hi Peter,
> >
> >Can you please consider queuing up this patch for next release.
> >
> >Thanks
> >Vivek
> >
> >> 
> >> > Index: linux-2.6/kernel/kexec.c
> >> > ===================================================================
> >> > --- linux-2.6.orig/kernel/kexec.c	2013-10-16 00:30:50.000000000
> >-0400
> >> > +++ linux-2.6/kernel/kexec.c	2013-11-08 21:34:02.492072375 -0500
> >> > @@ -1676,6 +1676,7 @@ int kernel_kexec(void)
> >> >  #endif
> >> >  	{
> >> >  		kernel_restart_prepare(NULL);
> >> > +		migrate_to_reboot_cpu();
> >> >  		printk(KERN_EMERG "Starting new kernel\n");
> >> >  		machine_shutdown();
> >> >  	}
> >> > 
> 
> -- 
> Sent from my mobile phone.  Please pardon brevity and lack of formatting.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
