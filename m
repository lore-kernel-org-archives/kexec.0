Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TVTVc-0005Ja-T5
 for kexec@lists.infradead.org; Mon, 05 Nov 2012 20:43:02 +0000
Date: Mon, 5 Nov 2012 15:42:49 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kdump with signed images
Message-ID: <20121105204249.GG28720@redhat.com>
References: <1351276649.18115.217.camel@falcor>
 <20121101131003.GA14573@redhat.com>
 <20121101135356.GA15659@redhat.com>
 <1351780159.15708.17.camel@falcor>
 <20121101144304.GA15821@redhat.com>
 <20121101145225.GB10269@srcf.ucam.org>
 <20121102132318.GA3300@redhat.com> <87boffd727.fsf@xmission.com>
 <20121105180353.GC28720@redhat.com> <87mwyv96mn.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mwyv96mn.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Roberto Sassu <roberto.sassu@polito.it>, Dmitry Kasatkin <dmitry.kasatkin@intel.com>, Kees Cook <keescook@chromium.org>, Peter Jones <pjones@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux kernel mailing list <linux-kernel@vger.kernel.org>, horms@verge.net.au, "H. Peter Anvin" <hpa@zytor.com>, Matthew Garrett <mjg@redhat.com>, Dave Young <dyoung@redhat.com>, Khalid Aziz <khalid@gonehiking.org>

On Mon, Nov 05, 2012 at 11:44:48AM -0800, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Fri, Nov 02, 2012 at 02:32:48PM -0700, Eric W. Biederman wrote:
> >> 
> >> It needs to be checked but /sbin/kexec should not use any functions that
> >> trigger nss switch.  No user or password or host name lookup should be
> >> happening.
> >
> > I also think that we don't call routines which trigger nss switch but
> > be probably can't rely on that as somebody might introduce it in
> > future. So we need more robust mechanism to prevent it than just code
> > inspection.
> 
> The fact that we shouldn't use those routines is enough to let us
> walk down a path where they are not used.  Either with a static glibc
> linked told to use no nss modules (--enable-static-nss ?), or with
> another more restricted libc.

Is there anything wrong with using uClibc? Trying to link again
customized glibc (with --enable-static-nss) sounds just extra work for
build environments. Are there know restricted libc or we need to create
one with passing more compile time options to libc.

Instead of doing more work in an attempt to create restricted libc,
it might be easier to just link against any already available
restricted library.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
