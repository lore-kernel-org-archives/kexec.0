Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwOqW-0007AF-GV
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 08:02:18 +0000
Date: Fri, 7 Apr 2017 16:01:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
Message-ID: <20170407080144.GC10737@dhcp-128-65.nay.redhat.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
 <1491551101.4184.48.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1491551101.4184.48.camel@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, Chun-Yi Lee <jlee@suse.com>, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com

On 04/07/17 at 03:45am, Mimi Zohar wrote:
> On Fri, 2017-04-07 at 14:19 +0800, Dave Young wrote:
> > On 04/06/17 at 11:49pm, Mimi Zohar wrote:
> > > On Fri, 2017-04-07 at 11:05 +0800, Dave Young wrote:
> > > > On 04/05/17 at 09:15pm, David Howells wrote:
> > > > > From: Chun-Yi Lee <joeyli.kernel@gmail.com>
> > > > > =

> > > > > When KEXEC_VERIFY_SIG is not enabled, kernel should not loads ima=
ge
> > > > > through kexec_file systemcall if securelevel has been set.
> > > > > =

> > > > > This code was showed in Matthew's patch but not in git:
> > > > > https://lkml.org/lkml/2015/3/13/778
> =

> I specifically checked to make sure that either kexec_file() signature
> verification was acceptable and would have commented then, if it had
> not been included.
> =

> > > > > Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > > > > Signed-off-by: David Howells <dhowells@redhat.com>
> > > > > cc: kexec@lists.infradead.org
> > > > > ---
> > > > > =

> > > > >  kernel/kexec_file.c |    6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > =

> > > > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > index b118735fea9d..f6937eecd1eb 100644
> > > > > --- a/kernel/kexec_file.c
> > > > > +++ b/kernel/kexec_file.c
> > > > > @@ -268,6 +268,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel=
_fd, int, initrd_fd,
> > > > >  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> > > > >  		return -EPERM;
> > > > >  =

> > > > > +	/* Don't permit images to be loaded into trusted kernels if we'=
re not
> > > > > +	 * going to verify the signature on them
> > > > > +	 */
> > > > > +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locked_do=
wn())
> > > > > +		return -EPERM;
> > > > > +
> > > > >  =

> > > =

> > > IMA can be used to verify file signatures too, based on the LSM hooks
> > > in =A0kernel_read_file_from_fd(). =A0CONFIG_KEXEC_VERIFY_SIG should n=
ot be
> > > required.
> > =

> > Mimi, I remember we talked somthing before about the two signature =

> > verification. One can change IMA policy in initramfs userspace,
> > also there are kernel cmdline param to disable IMA, so it can break the
> > lockdown? Suppose kexec boot with ima disabled cmdline param and then
> > kexec reboot again..
> =

> Right, we discussed that the same method of measuring the kexec image
> and initramfs, for extending trusted boot to the OS, could also be
> used for verifying the kexec image and initramfs signatures, for
> extending secure boot to the OS. =A0The file hash would be calculated
> once for both.
> =

> All of your concerns could be addressed with very minor changes to
> IMA. =A0(Continued in response to David.)

Thanks! As long as IMA can ensure not breaking the lockdown it should be
fine to add an check for either !CONFIG_KEXEC_VERIFY_SIG or !IMA
enforced.

> =

> > > =

> > > > 	/* Make sure we have a legal set of flags */
> > > > >  	if (flags !=3D (flags & KEXEC_FILE_FLAGS))
> > > > >  		return -EINVAL;
> > > > > =

> > > > > =

> > > > > _______________________________________________
> > > > > kexec mailing list
> > > > > kexec@lists.infradead.org
> > > > > http://lists.infradead.org/mailman/listinfo/kexec
> > > > =

> > > > Acked-by: Dave Young <dyoung@redhat.com>
> > > > =

> > > > Thanks
> > > > Dave
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-sec=
urity-module" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > =

> > > =

> > =

> =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
