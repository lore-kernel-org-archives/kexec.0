Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga11.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6xtx-0007XU-1L
	for kexec@lists.infradead.org; Fri, 13 Jun 2008 01:16:25 +0000
Subject: Re: [PATCH -mm 2/2] kexec jump -v11: save/restore device state
From: "Huang, Ying" <ying.huang@intel.com>
In-Reply-To: <20080612130225.GA9654@redhat.com>
References: <1213082106.22608.30.camel@caritas-dev.intel.com>
	<20080611163026.GG6450@redhat.com>
	<1213232019.21353.8.camel@caritas-dev.intel.com>
	<20080612130225.GA9654@redhat.com>
Date: Fri, 13 Jun 2008 09:18:52 +0800
Message-Id: <1213319932.22697.9.camel@caritas-dev.intel.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Thu, 2008-06-12 at 09:02 -0400, Vivek Goyal wrote:
[...]
> Few things I don't understand.
> 
> - Are you saying that hibernated image will be saved in initrd
>   (rootfs.gz)? But that saving is only in RAM, we never write back
>   it to disk?

No. Hibernated image should be saved in a dedicated raw partition as you
said below.

> - I thought we probably have to dedicate a raw partition kind of thing
>   for saving image and then modify boot loader command line to something
>   similar to, "resume=partition". Then initrd can go hunting for image
>   in respective partition (as specified by command line parameter) and if
>   image is not available then continue with normal boot.

Yes. But the boot-loader command line only need to be changed during
system install or hibernation setup. We need not change the location of
"hibernation partition" frequently.

So I think one boot-loader command line is sufficient for:

- normal boot
- normal boot a system to be hibernated
- boot helper system to restore the hibernated system

Best Regards,
Huang Ying


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
