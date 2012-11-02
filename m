Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TUIMU-0006Jb-Rs
 for kexec@lists.infradead.org; Fri, 02 Nov 2012 14:36:44 +0000
Date: Fri, 2 Nov 2012 10:36:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121102143603.GD3300@redhat.com>
References: <20121026023916.GA16762@srcf.ucam.org>
 <20121026170609.GB24687@redhat.com>
 <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com>
 <1351780159.15708.17.camel@falcor>
 <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org>
 <20121102132318.GA3300@redhat.com>
 <CAKTCnzkQwhWGJRTiuxv8wp7uPDFoT6eGsN0k51Bvw8=EqQFW=w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKTCnzkQwhWGJRTiuxv8wp7uPDFoT6eGsN0k51Bvw8=EqQFW=w@mail.gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Khalid Aziz <khalid@gonehiking.org>

On Fri, Nov 02, 2012 at 07:59:15PM +0530, Balbir Singh wrote:
> On Fri, Nov 2, 2012 at 6:53 PM, Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Thu, Nov 01, 2012 at 02:52:25PM +0000, Matthew Garrett wrote:
> >> On Thu, Nov 01, 2012 at 10:43:04AM -0400, Vivek Goyal wrote:
> >>
> >> > So I think this does satisfy the requirement matthew specified. Isn't it?
> >> > Matthew, what do you think?
> >>
> >> Sure, if you can ensure that. You'll need to figure out how to get the
> >> build system to sign the userspace binaries and you'll need to ensure
> >> that they're statically linked and don't dlopen anything (including the
> >> nsswitch modules), but otherwise that should work.
> >>
> >
> > [ CC peter jones ]
> >
> > Ok, so even if we build kexec-tools statically with glibc, we have the
> > issue of name service switch modules. glibc will still do dlopen on
> > these modules. So what are options now.
> >
> > - Sign glibc and associated shared libraries. Do not allow unsigned
> >   shared library to dynamically link with signed executable.
> >
> > - Peter mentioned that work with uClibc for kexec-tools.
> >
> > I personally think that however hard it is but first option sounds like
> > a long term solution. We might have more user space processes which
> > we might have to trust a generic solution will help with that. For example,
> > we might have to sign and trust qemu at some point of time.
> >
> > Are there other ways of handing glibc issue?
> >
> 
> Have you seen http://sourceware.org/glibc/wiki/FAQ - "Even statically
> linked programs need some shared libraries which is not acceptable for
> me. What can I do?" Probably, worth trying.

Yes I have seen this. IIUC, it says that build libc with -enable-static-nss
and then individual programs need to statically build against the nss
modules program will use.

I think building libc with -enable-static-nss part will be unacceptable
for general server as other programs would like to make use of the
existing nss functionality.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
