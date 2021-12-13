Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwptx-00AuoQ-AP
 for kexec@lists.infradead.org; Mon, 13 Dec 2021 18:18:18 +0000
Date: Mon, 13 Dec 2021 19:18:13 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v2 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Message-ID: <20211213181813.GV117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
 <17153a1c-86c6-6ffd-35d6-5329829661df@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <17153a1c-86c6-6ffd-35d6-5329829661df@linux.vnet.ibm.com>
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
To: Nayna <nayna@linux.vnet.ibm.com>
Cc: keyrings@vger.kernel.org, kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Frank van der Linden <fllinden@amazon.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Sven Schnelle <svens@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Hello,

On Sun, Dec 12, 2021 at 07:46:53PM -0500, Nayna wrote:
> 
> On 11/25/21 13:02, Michal Suchanek wrote:
> > Copy the code from s390x
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   arch/powerpc/Kconfig        | 11 +++++++++++
> >   arch/powerpc/kexec/elf_64.c | 36 ++++++++++++++++++++++++++++++++++++
> >   2 files changed, 47 insertions(+)
> > 
> > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > index ac0c515552fd..ecc1227a77f1 100644
> > --- a/arch/powerpc/Kconfig
> > +++ b/arch/powerpc/Kconfig
> > @@ -561,6 +561,17 @@ config KEXEC_FILE
> >   config ARCH_HAS_KEXEC_PURGATORY
> >   	def_bool KEXEC_FILE
> > 
> > +config KEXEC_SIG
> > +	bool "Verify kernel signature during kexec_file_load() syscall"
> > +	depends on KEXEC_FILE && MODULE_SIG_FORMAT
> > +	help
> > +	  This option makes kernel signature verification mandatory for
> > +	  the kexec_file_load() syscall.
> > +
> 
> Resending my last response as looks like it didn't go through mailing list
> because of some wrong formatting. My apologies to those who are receiving it
> twice.
> 
> Since powerpc also supports IMA_ARCH_POLICY for kernel image signature
> verification, please include the following:
> 
> "An alternative implementation for the powerpc arch is IMA_ARCH_POLICY. It
> verifies the appended kernel image signature and additionally includes both
> the signed and unsigned file hashes in the IMA measurement list, extends the
> IMA PCR in the TPM, and prevents blacklisted binary kernel images from being
> kexec'd."

It also does blacklist based on the file hash?

There is a downstream patch that adds the support for the module
signatures, and when the code is reused for KEXEC_SIG the blacklist
also applies to it.

Which kind of shows that people really want to use the IMA features but
with no support on some major architectures it's not going to work.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
