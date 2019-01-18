Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkJ4P-0001cp-TF
 for kexec@lists.infradead.org; Fri, 18 Jan 2019 01:35:43 +0000
Date: Fri, 18 Jan 2019 09:35:30 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 0/2] let kexec_file_load use platform keyring to
 verify the kernel image
Message-ID: <20190118013530.GA2814@dhcp-128-65.nay.redhat.com>
References: <20190116101654.7288-1-kasong@redhat.com>
 <1547773684.4026.10.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1547773684.4026.10.camel@linux.ibm.com>
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
Cc: jwboyer@fedoraproject.org, Kairui Song <kasong@redhat.com>, ebiggers@google.com, nayna@linux.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, jmorris@namei.org, dhowells@redhat.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, dwmw2@infradead.org, bauerman@linux.ibm.com, serge@hallyn.com

On 01/17/19 at 08:08pm, Mimi Zohar wrote:
> On Wed, 2019-01-16 at 18:16 +0800, Kairui Song wrote:
> > This patch series adds a .platform_trusted_keys in system_keyring as the
> > reference to .platform keyring in integrity subsystem, when platform
> > keyring is being initialized it will be updated. So other component cou=
ld
> > use this keyring as well.
> =

> Remove "other component could use ...".
> > =

> > This patch series also let kexec_file_load use platform keyring as fall
> > back if it failed to verify the image against secondary keyring, make it
> > possible to load kernel signed by third part key if third party key is
> > imported in the firmware.
> =

> This is the only reason for these patches. =A0Please remove "also".
> =

> > =

> > After this patch kexec_file_load will be able to verify a signed PE
> > bzImage using keys in platform keyring.
> > =

> > Tested in a VM with locally signed kernel with pesign and imported the
> > cert to EFI's MokList variable.
> =

> It's taken so long for me to review/test this patch set due to a
> regression in sanity_check_segment_list(), introduced somewhere
> between 4.20 and 5.0.0-rc1. =A0The sgement overlap test - "if ((mend >
> pstart) && (mstart < pend))" - fails, returning a -EINVAL.
> =

> Is anyone else seeing this?

Mimi, should be this issue?  I have sent a fix for that.
https://lore.kernel.org/lkml/20181228011247.GA9999@dhcp-128-65.nay.redhat.c=
om/

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
