Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fM9Sw-0006YW-Lo
 for kexec@lists.infradead.org; Fri, 25 May 2018 09:56:55 +0000
Date: Fri, 25 May 2018 11:56:34 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] Remove obsolete kdump tool and add missing uninstall
 rule
Message-ID: <20180525095633.xdij5gzz2gigaybv@verge.net.au>
References: <1524459622-2059-1-git-send-email-bhsharma@redhat.com>
 <20180521062330.GA6036@dhcp-128-65.nay.redhat.com>
 <CACi5LpP310OaiE1qsWhbYskGvj1b7MA=TBLw-OBBJcOH1E-z=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACi5LpP310OaiE1qsWhbYskGvj1b7MA=TBLw-OBBJcOH1E-z=Q@mail.gmail.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: Russell King <rmk@armlinux.org.uk>, kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, ebiederm@xmission.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Russell King <rmk@arm.linux.org.uk>

On Wed, May 23, 2018 at 11:13:16AM +0530, Bhupesh Sharma wrote:
> Hi Dave,
> 
> Thanks for the review.
> 
> On Mon, May 21, 2018 at 11:53 AM, Dave Young <dyoung@redhat.com> wrote:
> > Hi Bhupesh,
> > On 04/23/18 at 10:30am, Bhupesh Sharma wrote:
> >> This patchset contains two patches:
> >>
> >> [1/2] - Adds a missing uninstall rule to 'Makefile.in' to allow easier
> >>       uninstallation of executables and man pages installed via
> >>       'make install'
> >> [2/2] - Removes obsolete kdump tool as per the discussion on kexec
> >>       mailing list (see [1] for details), where a conclusion was
> >>       reached that with the availability of tools like crash/gdb the
> >>       analysis of the crashdump core has become rather easy, and it
> >>       makes the kdump tool obsolete.
> >>
> >>       Also the same naming convention (man page) causes confusion
> >>       when compared to similarly named distribution specific kdump
> >>       service/utilities, so its better to remove the same from
> >>       kexec-tools.
> >
> > I'm not suer about adding 'make uninstall',  the second patch looks
> > good,  can you send 2/2 separately?
> 
> I added 'make uninstall' rule to 'kexec-tools' to allow removing the
> executable(s) and man page(s) installed after making source and using
> 'make install' makefile rule.
> 
> Generally other user-space tools also have a similar makefile rule and
> its useful for root filesystems which use a non-rpm based
> environment(s) to cleaning uninstall locally compiled and installed
> executable(s) and man page(s).
> 
> I can send a new version separating the two patches.
> 
> @Russell, Simon - Do you have further comments, which I should include
> in the new version? If yes, kindly share the same.

This sounds fine to me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
