Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvFcn-00FP3R-F1
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 09:22:02 +0000
Date: Thu, 9 Dec 2021 10:21:55 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v2 2/6] powerpc/kexec_file: Add KEXEC_SIG support.
Message-ID: <20211209092155.GO117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <8b30a3c6a4e845eb77f276298424811897efdebf.1637862358.git.msuchanek@suse.de>
 <c3c9c6e4-6371-2f5a-ac94-fa4389d5dbe5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c3c9c6e4-6371-2f5a-ac94-fa4389d5dbe5@linux.vnet.ibm.com>
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

On Wed, Dec 08, 2021 at 08:51:47PM -0500, Nayna wrote:
> 
> On 11/25/21 13:02, Michal Suchanek wrote:
> > Copy the code from s390x
> > 
> > Signed-off-by: Michal Suchanek<msuchanek@suse.de>
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
> 
> After manually applying the patch, the build is failing with the following
> error:
> 
> build failed with error "arch/powerpc/kexec/elf_64.o: In function
> `elf64_verify_sig':
> /root/kernel/linus/linux/arch/powerpc/kexec/elf_64.c:160: undefined
> reference to `verify_appended_signature'"

This patch does not add call to verify_appended_signature.

Maybe you applied the following patch as well?

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
