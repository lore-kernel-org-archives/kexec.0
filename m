Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.244])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1J0dgh-0004vy-SP
	for kexec@lists.infradead.org; Fri, 07 Dec 2007 13:56:25 +0000
Received: by an-out-0708.google.com with SMTP id c3so162613ana
	for <kexec@lists.infradead.org>; Fri, 07 Dec 2007 05:56:18 -0800 (PST)
Message-ID: <851fc09e0712070556g13741a0vc56348ffbbb57a1d@mail.gmail.com>
Date: Fri, 7 Dec 2007 21:56:18 +0800
From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH 4/4 -mm] kexec based hibernation -v7 : kimgcore
In-Reply-To: <200712071333.06836.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
References: <1197042824.24045.64.camel@caritas-dev.intel.com>
	<200712071333.06836.rjw@sisk.pl>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On Dec 7, 2007 8:33 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, 7 of December 2007, Huang, Ying wrote:
> > This patch adds a file in proc file system to access the loaded
> > kexec_image, which may contains the memory image of kexeced
> > system. This can be used by kexec based hibernation to create a file
> > image of hibernating kernel, so that a kernel booting process is not
> > needed for each hibernating.
>
> Hm, I'm not sure what you mean.
>
> Can you explain a bit, please?

The normal kexec based hibernation procedure is as follow:

1. kexec_load the kernel image and initramfs
2. jump to hibernating kernel
3. the normal boot process of kexeced kernel
4. jump back to hibernated kernel
5. execute ACPI methods
6. jump to hibernating kernel
7. write memory image of hibernated kernel
8. go to ACPI S4 state

With kimgcore:

A. Prepare a memory image of hibernation kernel:

A.1 kexec_load the kernel image and initramfs
A.2 jump to hibernating kernel
A.3 the normal boot process of kexeced kernel
A.4 jump back to hibernated kernel
A.5 save the memory image of hibernating kernel via kimgcore

The normal hibernate process is as follow:

1. kexec load the kimgcore of hibernatin kernel
2. jump to the hibernating kernel
3. execute ACPI methods
4. jump to hibernating kernel
5. write memory image of hibernated kernel
6. go to ACPI S4 state

So the boot process of hibernating kernel needs only once unless the
hardware configuration is changed.

Best Regards,
Huang Ying

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
