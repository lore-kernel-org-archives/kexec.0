Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwPU8-0001rw-RM
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 08:43:14 +0000
Date: Fri, 7 Apr 2017 16:42:42 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
Message-ID: <20170407084242.GB11402@dhcp-128-65.nay.redhat.com>
References: <20170407061935.GB10100@dhcp-128-65.nay.redhat.com>
 <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
 <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
 <1491536950.4184.10.camel@linux.vnet.ibm.com>
 <21418.1491548875@warthog.procyon.org.uk>
 <20170407074159.GB10737@dhcp-128-65.nay.redhat.com>
 <1491553688.4184.73.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1491553688.4184.73.camel@linux.vnet.ibm.com>
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

On 04/07/17 at 04:28am, Mimi Zohar wrote:
> On Fri, 2017-04-07 at 15:41 +0800, Dave Young wrote:
> > On 04/07/17 at 08:07am, David Howells wrote:
> > > Dave Young <dyoung@redhat.com> wrote:
> > > =

> > > > > > > +	/* Don't permit images to be loaded into trusted kernels if=
 we're not
> > > > > > > +	 * going to verify the signature on them
> > > > > > > +	 */
> > > > > > > +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locke=
d_down())
> > > > > > > +		return -EPERM;
> > > > > > > +
> > > > > > >  =

> > > > > =

> > > > > IMA can be used to verify file signatures too, based on the LSM h=
ooks
> > > > > in =A0kernel_read_file_from_fd(). =A0CONFIG_KEXEC_VERIFY_SIG shou=
ld not be
> > > > > required.
> > > > =

> > > > Mimi, I remember we talked somthing before about the two signature =

> > > > verification. One can change IMA policy in initramfs userspace,
> > > > also there are kernel cmdline param to disable IMA, so it can break=
 the
> > > > lockdown? Suppose kexec boot with ima disabled cmdline param and th=
en
> > > > kexec reboot again..
> > > =

> > > I guess I should lock down the parameter to disable IMA too.
> > =

> > That is one thing, user can change IMA policy in initramfs userspace,
> > I'm not sure if IMA enforce the signed policy now, if no it will be also
> > a problem.
> =

> I'm not sure how this relates to the question of whether IMA verifies
> the kexec kernel image signature, as the test would not be based on a
> Kconfig option, but on a runtime variable.

I assumed one can change the policy to avoid kexec and initramfs check
And we use a global IMA status in the -EPERM check for the lockdown
checking.  But if there is some fine grained checking to ensure kernel
signature verification it should be fine.
> =

> To answer your question, the rule for requiring the policy to be
> signed is: =A0appraise func=3DPOLICY_CHECK appraise_type=3Dimasig
> =

> When the ability to append rules is Kconfig enabled, the builtin
> policy requires the new policy or additional rules to be signed.
> =A0Unfortunately, always requiring the policy to be signed, would have
> broken userspace.
> =

> Mimi
> =


Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
