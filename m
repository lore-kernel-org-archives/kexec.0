Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from rv-out-0910.google.com ([209.85.198.186])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IZD3A-0002mC-Dx
	for kexec@lists.infradead.org; Sat, 22 Sep 2007 18:02:10 -0400
Received: by rv-out-0910.google.com with SMTP id c24so1174883rvf
	for <kexec@lists.infradead.org>; Sat, 22 Sep 2007 15:02:06 -0700 (PDT)
Message-ID: <9e0cf0bf0709221502u1701cd16vcb31f88896924d6e@mail.gmail.com>
Date: Sun, 23 Sep 2007 00:02:06 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3: kexec jump
In-Reply-To: <1190342757.21818.75.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<200709211157.28622.nigel@nigel.suspend2.net>
	<1190341137.21818.52.camel@caritas-dev.intel.com>
	<200709211225.25874.nigel@nigel.suspend2.net>
	<1190342757.21818.75.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, nigel@suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>

On 9/21/07, Huang, Ying <ying.huang@intel.com> wrote:
> This is fairly simple in fact. For example, you can specify the
> bdev/sectors in kernel command line when do kexec load "kexec -l <...>
> --append='...'", then the image writing system can get it through
> "cat /proc/cmdline".

I hope you take into account encrypted swap configuration.
Currently all three suspend implementations support using encrypted
swap in order to suspend/resume.
A configuration which forces the user to remap encryption on the kexec
kernel during suspend is not valid.

Best Regards,
Alon Bar-Lev.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
