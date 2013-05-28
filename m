Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhL2a-0007HP-9q
 for kexec@lists.infradead.org; Tue, 28 May 2013 14:38:21 +0000
Date: Tue, 28 May 2013 10:37:56 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/7] Remove unused /dev/oldmem interface
Message-ID: <20130528143756.GD7088@redhat.com>
References: <51A02E50.5020507@gmail.com>
 <87mwri8wwu.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mwri8wwu.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Sat, May 25, 2013 at 04:25:21PM -0700, Eric W. Biederman wrote:
> Zhang Yanfei <zhangyanfei.yes@gmail.com> writes:
> 
> > /dev/oldmem provides the interface for us to access the "old memory" in
> > the dump-capture kernel. Unfortunately, no one actually uses this interface.
> >
> > And this interface could actually cause some real problems if used on ia64
> > where the cached/uncached accesses are mixed. See the discussion from
> > the link: https://lkml.org/lkml/2013/4/12/386.
> >
> > So Eric suggested that we should remove /dev/oldmem as an unused piece of
> > code.
> >
> > Besides, we used a global variable saved_max_pfn to let the capture kernel
> > know the amount of memory that the previous kernel used. And for almost all
> > architectures (except x86. In x86, saved_max_pfn is used by detect_calgary()),
> > the only user of this variable is the read_oldmem interface of /dev/oldmem, so
> > also remove the setting for saved_max_pfn in those architectures.
> 
> Except for the devices.txt update.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric,

Should we schedule the removal of this interface after 1-2 releases
and give a warning once if anybody opens /dev/oldmem and tell them
to use /proc/vmcore instead? 

I am kind of inclined towards warning approarch. If there is any xyz
/dev/oldmem user in the wild out there, he/she atleast gets a chance to
migrate to /proc/vmcore.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
