Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNhNQ-0007jm-DQ
 for kexec@lists.infradead.org; Thu, 14 Jul 2016 14:12:32 +0000
Date: Thu, 14 Jul 2016 22:12:05 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Add option to fallback to old kexec syscall when
 kexec file based syscall failed
Message-ID: <20160714141205.GB9366@x1.redhat.com>
References: <1468485911-21427-1-git-send-email-jlee@suse.com>
 <20160714095124.GA9366@x1.redhat.com>
 <20160714103510.GX11998@linux-rxt1.site>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160714103510.GX11998@linux-rxt1.site>
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
To: joeyli <jlee@suse.com>
Cc: Simon Horman <horms@verge.net.au>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, Petr Tesarik <ptesarik@suse.com>

On 07/14/16 at 06:35pm, joeyli wrote:
> Hi Baoquan, 
> 
> Thanks for your response!
> 
> On Thu, Jul 14, 2016 at 05:51:24PM +0800, Baoquan He wrote:
> > On 07/14/16 at 04:45pm, Lee, Chun-Yi wrote:
> > > This patch adds a new "--fallback-kexec" option to give a chance to
> > > fallback to old kexec syscall when file based kexec syscall operation
> > > failed.
> > > 
> > > This option works with --kexec-file-syscall to provide more flexible
> > > way to adapt to different kernels that those kernels built with
> > > different kexec syscall config or have different verification policy.
> > 
> > Usually distribuition system uses script to build a framework to
> > connect the kexec/kdump, makedumpfile utility chain. This can make user
> > execute a very simple script command to implement kexec load or kexec
> > jumping job. In this case script can do what you are trying to do.
> > 
> 
> Yes, the fallback function can be implemented by script. But a new kexec
> option is useful to the distro that it may not provides help scripts to
> user.
> 
> > Besides, have you actually met that kexec-file failed but old kexec
> > syscall works? I mean how did you test it? I am wondering when it will
> > happen.
> > 
> > Thanks
> > Baoquan
> >
> 

I understand, thanks for telling, Joey Lee.

However it seems not very necessary to me. So leave this to other
people, see if you can get support and an Acked-by.

Thanks
Baoquan

> The currently mainline kernel allows to set CONFIG_KEXEC or CONFIG_KEXEC_FILE
> individual. So if kexec found that the file based kexec syscall isn't
> available then this is a case to fallback to old kexec.
> 
> Another case is when KEXEC_VERIFY_SIG is set, The fallback function is more
> convenient to user to build his own kernel for using or testing. The kexec
> tool can try old syscall when verification failed.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
