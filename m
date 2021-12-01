Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msO6N-008FzO-Ht
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 11:48:45 +0000
Date: Wed, 1 Dec 2021 12:48:36 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Message-ID: <20211201114836.GD117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <20211201023747.GN21646@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211201023747.GN21646@MiWiFi-R3L-srv>
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
To: Baoquan He <bhe@redhat.com>
Cc: Nayna <nayna@linux.vnet.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Rob Herring <robh@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <borntraeger@de.ibm.com>, James Morris <jmorris@namei.org>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, linux-crypto@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, Philipp Rudo <prudo@redhat.com>, Frank van der Linden <fllinden@amazon.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Sven Schnelle <svens@linux.ibm.com>, linux-security-module@vger.kernel.org, Jessica Yu <jeyu@kernel.org>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, buendgen@de.ibm.com

Hello,

On Wed, Dec 01, 2021 at 10:37:47AM +0800, Baoquan He wrote:
> Hi,
> 
> On 11/25/21 at 07:02pm, Michal Suchanek wrote:
> > Hello,
> > 
> > This is resend of the KEXEC_SIG patchset.
> > 
> > The first patch is new because it'a a cleanup that does not require any
> > change to the module verification code.
> > 
> > The second patch is the only one that is intended to change any
> > functionality.
> > 
> > The rest only deduplicates code but I did not receive any review on that
> > part so I don't know if it's desirable as implemented.
> 
> Do you have the link of your 1st version?

This is the previous version:
https://lore.kernel.org/lkml/cover.1635948742.git.msuchanek@suse.de/

Thanks

Michal

> And after going through the whole series, it doesn't tell what this
> patch series intends to do in cover-letter or patch log.
> 
> Thanks
> Baoquan
> 
> > 
> > The first two patches can be applied separately without the rest.
> > 
> > Thanks
> > 
> > Michal
> > 
> > Michal Suchanek (6):
> >   s390/kexec_file: Don't opencode appended signature check.
> >   powerpc/kexec_file: Add KEXEC_SIG support.
> >   kexec_file: Don't opencode appended signature verification.
> >   module: strip the signature marker in the verification function.
> >   module: Use key_being_used_for for log messages in
> >     verify_appended_signature
> >   module: Move duplicate mod_check_sig users code to mod_parse_sig
> > 
> >  arch/powerpc/Kconfig                     | 11 +++++
> >  arch/powerpc/kexec/elf_64.c              | 14 ++++++
> >  arch/s390/kernel/machine_kexec_file.c    | 42 ++----------------
> >  crypto/asymmetric_keys/asymmetric_type.c |  1 +
> >  include/linux/module_signature.h         |  1 +
> >  include/linux/verification.h             |  4 ++
> >  kernel/module-internal.h                 |  2 -
> >  kernel/module.c                          | 12 +++--
> >  kernel/module_signature.c                | 56 +++++++++++++++++++++++-
> >  kernel/module_signing.c                  | 33 +++++++-------
> >  security/integrity/ima/ima_modsig.c      | 22 ++--------
> >  11 files changed, 113 insertions(+), 85 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> > 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
