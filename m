Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwI4v-0001Q9-7D
 for kexec@lists.infradead.org; Fri, 17 Jul 2020 04:34:34 +0000
Date: Thu, 16 Jul 2020 23:34:21 -0500
From: Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 00/12] ima: Fix rule parsing bugs and extend
 KEXEC_CMDLINE rule support
Message-ID: <20200717043421.GF3673@sequoia>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
 <1594960293.27397.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1594960293.27397.2.camel@linux.ibm.com>
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
Cc: Nayna Jain <nayna@linux.ibm.com>, Janne Karhunen <janne.karhunen@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Prakhar Srivastava <prsriva02@gmail.com>, kexec@lists.infradead.org, James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Casey Schaufler <casey@schaufler-ca.com>, linux-integrity@vger.kernel.org, "Serge E . Hallyn" <serge@hallyn.com>

On 2020-07-17 00:31:33, Mimi Zohar wrote:
> On Thu, 2020-07-09 at 01:18 -0500, Tyler Hicks wrote:
> > This series ultimately extends the supported IMA rule conditionals for
> > the KEXEC_CMDLINE hook function. As of today, there's an imbalance in
> > IMA language conditional support for KEXEC_CMDLINE rules in comparison
> > to KEXEC_KERNEL_CHECK and KEXEC_INITRAMFS_CHECK rules. The KEXEC_CMDLINE
> > rules do not support *any* conditionals so you cannot have a sequence of
> > rules like this:
> > =

> >  dont_measure func=3DKEXEC_KERNEL_CHECK obj_type=3Dfoo_t
> >  dont_measure func=3DKEXEC_INITRAMFS_CHECK obj_type=3Dfoo_t
> >  dont_measure func=3DKEXEC_CMDLINE obj_type=3Dfoo_t
> >  measure func=3DKEXEC_KERNEL_CHECK
> >  measure func=3DKEXEC_INITRAMFS_CHECK
> >  measure func=3DKEXEC_CMDLINE
> > =

> > Instead, KEXEC_CMDLINE rules can only be measured or not measured and
> > there's no additional flexibility in today's implementation of the
> > KEXEC_CMDLINE hook function.
> > =

> > With this series, the above sequence of rules becomes valid and any
> > calls to kexec_file_load() with a kernel and initramfs inode type of
> > foo_t will not be measured (that includes the kernel cmdline buffer)
> > while all other objects given to a kexec_file_load() syscall will be
> > measured. There's obviously not an inode directly associated with the
> > kernel cmdline buffer but this patch series ties the inode based
> > decision making for KEXEC_CMDLINE to the kernel's inode. I think this
> > will be intuitive to policy authors.
> > =

> > While reading IMA code and preparing to make this change, I realized
> > that the buffer based hook functions (KEXEC_CMDLINE and KEY_CHECK) are
> > quite special in comparison to longer standing hook functions. These
> > buffer based hook functions can only support measure actions and there
> > are some restrictions on the conditionals that they support. However,
> > the rule parser isn't enforcing any of those restrictions and IMA policy
> > authors wouldn't have any immediate way of knowing that the policy that
> > they wrote is invalid. For example, the sequence of rules above parses
> > successfully in today's kernel but the
> > "dont_measure func=3DKEXEC_CMDLINE ..." rule is incorrectly handled in
> > ima_match_rules(). The dont_measure rule is *always* considered to be a
> > match so, surprisingly, no KEXEC_CMDLINE measurements are made.
> > =

> > While making the rule parser more strict, I realized that the parser
> > does not correctly free all of the allocated memory associated with an
> > ima_rule_entry when going down some error paths. Invalid policy loaded
> > by the policy administrator could result in small memory leaks.
> > =

> > I envision patches 1-7 going to stable. The series is ordered in a way
> > that has all the fixes up front, followed by cleanups, followed by the
> > feature patch. The breakdown of patches looks like so:
> > =

> >  Memory leak fixes: 1-3
> >  Parser strictness fixes: 4-7
> >  Code cleanups made possible by the fixes: 8-11
> >  Extend KEXEC_CMDLINE rule support: 12
> =

> Thanks, Tyler.=A0=A0This is a really nice patch set. =A0The patches are n=
ow
> in the "next-integrity-testing" branch.

Thank you for all the helpful review comments. You know where to find me
if any bugs pop up during testing. :)

Tyler

> =

> Mimi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
