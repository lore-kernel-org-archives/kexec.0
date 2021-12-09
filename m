Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mvKrk-00GSG3-Om
 for kexec@lists.infradead.org; Thu, 09 Dec 2021 14:57:50 +0000
Date: Thu, 9 Dec 2021 15:57:44 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Message-ID: <20211209145744.GQ117207@kunlun.suse.cz>
References: <cover.1637862358.git.msuchanek@suse.de>
 <b5e6ec36-a9ec-22f4-be58-28d48bdc38b4@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b5e6ec36-a9ec-22f4-be58-28d48bdc38b4@linux.vnet.ibm.com>
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

On Wed, Dec 08, 2021 at 08:50:54PM -0500, Nayna wrote:
> 
> On 11/25/21 13:02, Michal Suchanek wrote:
> > Hello,
> 
> Hi Michael,
> 
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
> > 
> > The first two patches can be applied separately without the rest.
> 
> Patch 2 fails to apply on v5.16-rc4. Can you please also include git
> tree/branch while posting the patches ?

Sorry, I did not have a clean base and the Kconfig had another change.

Here is a tree with the changes applied:
https://github.com/hramrach/kernel/tree/kexec_sig

> 
> Secondly, I see that you add the powerpc support in Patch 2 and then modify
> it again in Patch 5 after cleanup. Why not add the support for powerpc after
> the clean up ? This will reduce some rework and also probably simplify
> patches.

That's because I don't know if the later patches will be accepted. By
queueing this patch first it can be applied standalone to ppc tree
without regard for the other patches. It's a copy of the s390 code so it
needs the same rework - not really adding complexity.

Thanks

Michal

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
