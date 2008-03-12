Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JZWvd-0006ly-WF
	for kexec@lists.infradead.org; Wed, 12 Mar 2008 19:47:58 +0000
Date: Wed, 12 Mar 2008 15:47:51 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH -mm] kexec jump -v9
Message-ID: <20080312194751.GF13549@redhat.com>
References: <1204773188.4707.109.camel@caritas-dev.intel.com>
	<20080311211004.GA30164@redhat.com>
	<1205286326.29069.16.camel@caritas-dev.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1205286326.29069.16.camel@caritas-dev.intel.com>
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
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org

On Wed, Mar 12, 2008 at 09:45:26AM +0800, Huang, Ying wrote:

[..]
> > I have thought through it again and try to put together some of the
> > new kexec options we can introduce to make the whole thing work. I am 
> > considering a simple case where a user boots the kernel A and then
> > launches kernel B using "kexec --load-preseve-context". Now a user
> > might save the hibernated image or might want to come back to A.
> > 
> > - kexec -l <kernel-image>
> >         Normal kexec functionality. Boot a new kernel, without preserving
> >         existing kernel's context.
> > 
> > - kexec --load-preserve-context <kernel-image>
> >         Boot a new kernel while preserving existing kernel's context.
> > 
> >         Will be used for booting kernel B for the first time.
> > 
> > - kexec --load-resume-image <resumable-core>
> 
> In original kexec-tools, this can be done through:
> kexec -l --args-none <resumable-core>
> 
> Do you need to define an alias for it?

Ok, we can get rid of --load-resume-image and go by the Eric's idea
of detecting image type and taking action accordingly.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
