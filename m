Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73] helo=mx1.redhat.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1f0l4d-0005A0-Gl
 for kexec@lists.infradead.org; Tue, 27 Mar 2018 09:39:24 +0000
Date: Tue, 27 Mar 2018 17:39:04 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 1/5] kexec: Return -ENOSYS when kexec does not know
 how to call KEXEC_FILE_LOAD
Message-ID: <20180327093904.GA4681@dhcp-128-65.nay.redhat.com>
References: <20180302091706.GA15374@dhcp-128-65.nay.redhat.com>
 <e810acd57d9fc2d7ba3b0e95d470c20de9948462.1521561315.git.msuchanek@suse.de>
 <20180326072558.iidgbvxi2fh7cjgu@verge.net.au>
 <20180326075324.GA22899@dhcp-128-65.nay.redhat.com>
 <20180326201734.34ba54b3@kitsune.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180326201734.34ba54b3@kitsune.suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Petr Tesarik <ptesarik@suse.cz>, Tony Jones <tonyj@suse.com>

On 03/26/18 at 08:17pm, Michal Such=E1nek wrote:
> On Mon, 26 Mar 2018 15:53:24 +0800
> Dave Young <dyoung@redhat.com> wrote:
> =

> > Hi Simon
> > On 03/26/18 at 09:25am, Simon Horman wrote:
> > > Hi Michal, thanks for the updated patches.
> > > =

> > > Dave, are you planning to review this series?
> > >   =

> > =

> > I have same concern as I commented in last versioni, but seems
> > we can not convince each other with Michal.
> > =

> > For example for -EINVAL/-ENOEXEC, since it can be some misc
> > error checking in kernel code, it is not equal to an unsupported
> > syscall.  I'm not keen to think broken kernel file (include the case
> > for unsupported kernel format, but not limit to that) is equal as an
> > unsupported syscall
> =

> I do not say it is equal to unsupported syscall. However, the kernel
> cannot really tell if the image is complete garbage or if it is in
> format it does not understand. The only way to check that is trying to
> load in the old way. I don't see any way around that if we want an
> --auto option which is of any use.

Maybe it is some personal taste, I tend to only checking syscall
supported so that it can be simpler.  And maybe from the beginning I
understand the "supported" as only for the syscall itself..

Anyway as having said before let's see how Simon think about this. =


Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
