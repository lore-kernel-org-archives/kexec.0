Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhobV-00010X-82
 for kexec@lists.infradead.org; Wed, 29 May 2013 22:12:22 +0000
Date: Wed, 29 May 2013 15:11:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/7] Remove unused /dev/oldmem interface
Message-Id: <20130529151159.2f1d6b5092c58b61724bee7c@linux-foundation.org>
In-Reply-To: <51A4C926.2040701@zytor.com>
References: <51A02E50.5020507@gmail.com> <87mwri8wwu.fsf@xmission.com>
 <20130528143756.GD7088@redhat.com> <51A4C926.2040701@zytor.com>
Mime-Version: 1.0
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Zhang Yanfei <zhangyanfei.yes@gmail.com>

On Tue, 28 May 2013 08:11:34 -0700 "H. Peter Anvin" <hpa@zytor.com> wrote:

> On 05/28/2013 07:37 AM, Vivek Goyal wrote:
> > 
> > Eric,
> > 
> > Should we schedule the removal of this interface after 1-2 releases
> > and give a warning once if anybody opens /dev/oldmem and tell them
> > to use /proc/vmcore instead? 
> > 
> > I am kind of inclined towards warning approarch. If there is any xyz
> > /dev/oldmem user in the wild out there, he/she atleast gets a chance to
> > migrate to /proc/vmcore.
> > 
> 
> This has been discussed ad nauseam at the Kernel Summit.  It doesn't work.
> 

Who said that and what was their evidence?  Giving users (especially
the more technical ones) several months warning is eminently sensible.

Although it doesn't appear to be necessary in this case.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
