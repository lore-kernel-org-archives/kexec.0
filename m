Return-path: <kexec-bounces@lists.infradead.org>
Received: from nf-out-0910.google.com ([64.233.182.186])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Ij7E7-00051I-Sb
	for kexec@lists.infradead.org; Sat, 20 Oct 2007 06:50:26 +0100
Received: by nf-out-0910.google.com with SMTP id h3so615079nfh
	for <kexec@lists.infradead.org>; Fri, 19 Oct 2007 22:50:11 -0700 (PDT)
Message-ID: <851fc09e0710192250k7c2d5269rf6bf1ec604a23603@mail.gmail.com>
Date: Sat, 20 Oct 2007 13:50:10 +0800
From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 0/2 -mm] kexec based hibernation -v5
In-Reply-To: <47190B28.6070405@cfl.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <1192068833.27482.13.camel@caritas-dev.intel.com>
	<47190B28.6070405@cfl.rr.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Phillip Susi <psusi@cfl.rr.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On 10/20/07, Phillip Susi <psusi@cfl.rr.com> wrote:
> Huang, Ying wrote:
> > The hibernation procedure with the patch set is as follow:
> >
> > 1. Boot a kernel A
> >
> > 2. Work under kernel A
> >
> > 3. Kexec another kernel B (crash dump enabled) in kernel A.
> >
> > 4. Save the memory image of kernel A through crash dump (such as "cp
> >    /proc/vmcore ~"). Save the "jump back entry".
>
> Doesn't this also save the memory of kernel B?

The memory area of kernel B is excluded from the elf header of
/proc/vmcore. This is done in kexec-tools (/sbin/kexec) patches.

> > 5. Shutdown or reboot
> >
> >
> > The restore process with the patch set is as follow:
> >
> > 1. Boot a kernel C (crash dump enabled), the memory area used by
> >    kernel C must be a subset of memory area used by kernel B.
>
> Why is a third kernel needed?  Why can't kernel B be used for this as
> well?  In fact, if kernel A has been compiled to be relocatable and
> crash dump enabled, why wouldn't it suffice for all 3 instances?

One kernel can be used for three situation. In fact, I use just one
kernel for testing.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
