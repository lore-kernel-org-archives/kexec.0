Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joaqi-0004yW-PA
 for kexec@lists.infradead.org; Thu, 25 Jun 2020 23:00:08 +0000
Date: Thu, 25 Jun 2020 17:59:57 -0500
From: Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH 12/12] ima: Support additional conditionals in the
 KEXEC_CMDLINE hook function
Message-ID: <20200625225957.GC4694@sequoia>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
 <20200623003236.830149-13-tyhicks@linux.microsoft.com>
 <1593125804.27152.426.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1593125804.27152.426.camel@linux.ibm.com>
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
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Prakhar Srivastava <prsriva02@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>

On 2020-06-25 18:56:44, Mimi Zohar wrote:
> On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> > Take the properties of the kexec kernel's inode and the current task
> > ownership into consideration when matching a KEXEC_CMDLINE operation to
> > the rules in the IMA policy. This allows for some uniformity when
> > writing IMA policy rules for KEXEC_KERNEL_CHECK, KEXEC_INITRAMFS_CHECK,
> > and KEXEC_CMDLINE operations.
> > =

> > Prior to this patch, it was not possible to write a set of rules like
> > this:
> > =

> >  dont_measure func=3DKEXEC_KERNEL_CHECK obj_type=3Dfoo_t
> >  dont_measure func=3DKEXEC_INITRAMFS_CHECK obj_type=3Dfoo_t
> >  dont_measure func=3DKEXEC_CMDLINE obj_type=3Dfoo_t
> >  measure func=3DKEXEC_KERNEL_CHECK
> >  measure func=3DKEXEC_INITRAMFS_CHECK
> >  measure func=3DKEXEC_CMDLINE
> > =

> > The inode information associated with the kernel being loaded by a
> > kexec_kernel_load(2) syscall can now be included in the decision to
> > measure or not
> > =

> > Additonally, the uid, euid, and subj_* conditionals can also now be
> > used in KEXEC_CMDLINE rules. There was no technical reason as to why
> > those conditionals weren't being considered previously other than
> > ima_match_rules() didn't have a valid inode to use so it immediately
> > bailed out for KEXEC_CMDLINE operations rather than going through the
> > full list of conditional comparisons.
> =

> This makes a lot of sense.
> =

> <snip>
> =A0
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index c1583d98c5e5..82acd66bf653 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -731,13 +731,15 @@ int ima_load_data(enum kernel_load_data_id id)
> >   * @eventname: event name to be used for the buffer entry.
> >   * @func: IMA hook
> >   * @pcr: pcr to extend the measurement
> > + * @inode: inode associated with the object being measured (NULL for K=
EY_CHECK)
> >   * @keyring: keyring name to determine the action to be performed
> >   *
> >   * Based on policy, the buffer is measured into the ima log.
> >   */
> >  void process_buffer_measurement(const void *buf, int size,
> >  				const char *eventname, enum ima_hooks func,
> > -				int pcr, const char *keyring)
> > +				int pcr, struct inode *inode,
> > +				const char *keyring)
> >  {
> =

> The file descriptor is passed as the first arg to
> process_measurement(). =A0Sorry for the patch churn, but could we do the
> same for process_buffer_measurements. =A0As much as possible lets keep
> them in same.

Yep! That makes sense to me.

Tyler

> =

> thanks,
> =

> Mimi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
