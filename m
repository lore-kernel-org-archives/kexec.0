Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Veaxn-00084o-FC
 for kexec@lists.infradead.org; Fri, 08 Nov 2013 01:34:21 +0000
Date: Fri, 8 Nov 2013 09:33:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86: make reboot task only run on the appropriate
 processor
Message-ID: <20131108013330.GA4684@dhcp-16-126.nay.redhat.com>
References: <1383642967-12595-1-git-send-email-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1383642967-12595-1-git-send-email-bhe@redhat.com>
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
To: Baoquan He <bhe@redhat.com>
Cc: mwhitehe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, vgoyal@redhat.com, davej@fedoraproject.org, mingo@redhat.com, holt@sgi.com, trenn@suse.de, hpa@zytor.com, rmk+kernel@arm.linux.org.uk, tglx@linutronix.de, akpm@linux-foundation.org, chaowang@redhat.com

On 11/05/13 at 05:16pm, Baoquan He wrote:
> Currently system always reboot after below message when execute "kexec -e".
> 
> [    0.572119] smpboot: Booting Node   0, Processors  #   1 OK
> 
> In commit 1b3a5d02ee070c8f9943333b9b6370f486601e0f, reboot= handling was
> moved to kerne/reboot.c. However, the code to migrate current thread to
> reboot cpu was removed. That cause this incorrect kexec behavior.
> 
> Now add that code block back.

quote a mail from Thomas Renninger <trenn@suse.de>:
Answer his questions here.

> > For the smp boot issue I think there's nothing to do with dracut.
> >
> > Can you try below patch?
> > https://lkml.org/lkml/2013/11/5/88
>
> That seem to have helped, thanks!
>
> Feel free to add:
>
> Tested-by: trenn@suse.de
>
> The problem existed in 3.11 already?
> I had the problem with a 3.11 kernel and tried a
> 3.12 kernel with this patch now.

It's a regression between 3.10 ~ 3.11

>
> It would be great if:
> Cc: stable@vger.kernel.org
> is added as well then.
>

I also like it to be in stable.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
