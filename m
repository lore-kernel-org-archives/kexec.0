Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVaJS-00068b-I8
 for kexec@lists.infradead.org; Mon, 23 Jan 2017 08:49:20 +0000
Date: Mon, 23 Jan 2017 16:48:58 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: implemented XEN KEXEC STATUS to determine if
 an image is loaded
Message-ID: <20170123084858.GA20581@x1>
References: <1484931834-21060-1-git-send-email-eric.devolder@oracle.com>
 <20170121014319.GA18962@x1>
 <20170123083402.GF23864@olila.local.net-space.pl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170123083402.GF23864@olila.local.net-space.pl>
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
To: Daniel Kiper <daniel.kiper@oracle.com>
Cc: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, kexec@lists.infradead.org, simon@horms.net, xen-devel@lists.xenproject.org, Eric DeVolder <eric.devolder@oracle.com>

On 01/23/17 at 09:34am, Daniel Kiper wrote:
> On Sat, Jan 21, 2017 at 09:43:19AM +0800, Baoquan He wrote:
> > Hi,
> >
> > I don't strongly oppose against this, but could you tell what you have
> > met makes the kexec_loaded/kexec_crash_loaded checking not convenient to
> > you?
> 
> kexec_loaded/kexec_crash_loaded exposes Linux kernel kexec/crash state.
> It does not say anything about Xen kexec/crash state. So, we need a special
> approach to get the latter. Though for compatibility we provide similar
> functionality in kexec-tools for the former.
> 
> I hope that helps.

Thanks for telling.

Understood. Then it makes sense. Better put above explanation into log.

Thanks
Baoquan

> 
> > On 01/20/17 at 11:03am, Eric DeVolder wrote:
> > > Instead of the scripts having to poke at various fields we can
> > > provide that functionality via the -S parameter.
> > >
> > > Returns 0 if the payload is loaded. Can be used in combination
> > > with -l or -p to get the state of the proper kexec image.
> > >
> > > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> > > ---
> > > Note: The corresponding Xen changes have been committed
> > > to the Xen staging branch. Follow this thread:
> > > https://lists.xenproject.org/archives/html/xen-devel/2017-01/msg01570.html
> > >
> > > CC: Andrew Cooper <andrew.cooper3@citrix.com>
> > > CC: kexec@lists.infradead.org
> > > CC: xen-devel@lists.xenproject.org
> > > CC: Daniel Kiper <daniel.kiper@oracle.com>
> > >
> > > v0: First version (internal product).
> > > v1: Posted on kexec mailing list. Changed -s to -S
> > > v2: Incorporated feedback from kexec mailing list
> > > ---
> > >  configure.ac      |  8 ++++++-
> > >  kexec/kexec-xen.c | 26 +++++++++++++++++++++++
> > >  kexec/kexec.8     |  6 ++++++
> > >  kexec/kexec.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
> > >  kexec/kexec.h     |  5 ++++-
> > >  5 files changed, 98 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/configure.ac b/configure.ac
> > > index 3044185..c6e864b 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -165,8 +165,14 @@ fi
> > >  dnl find Xen control stack libraries
> > >  if test "$with_xen" = yes ; then
> > >  	AC_CHECK_HEADER(xenctrl.h,
> > > -		[AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
> > > +		[AC_CHECK_LIB(xenctrl, xc_kexec_load, [ have_xenctrl_h=yes ],
> > >  		AC_MSG_NOTICE([Xen support disabled]))])
> > > +if test "$have_xenctrl_h" = yes ; then
> > > +	AC_CHECK_LIB(xenctrl, xc_kexec_status,
> > > +		AC_DEFINE(HAVE_KEXEC_CMD_STATUS, 1,
> > > +			[The kexec_status call is available]),
> > > +		AC_MSG_NOTICE([The kexec_status call is not available]))
> > > +fi
> 
> Eric, I have a feeling that you should add en extra indentation
> for lines starting from "+if test "$have_xenctrl_h"..." and
> ending at "+fi".
> 
> Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
