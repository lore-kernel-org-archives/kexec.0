Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msFVa-007K4U-3H
 for kexec@lists.infradead.org; Wed, 01 Dec 2021 02:38:11 +0000
Date: Wed, 1 Dec 2021 10:37:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Message-ID: <20211201023747.GN21646@MiWiFi-R3L-srv>
References: <cover.1637862358.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
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
To: Michal Suchanek <msuchanek@suse.de>
Cc: keyrings@vger.kernel.org, kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Heiko Carstens <hca@linux.ibm.com>, Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, Paul Mackerras <paulus@samba.org>, Hari Bathini <hbathini@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Frank van der Linden <fllinden@amazon.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Sven Schnelle <svens@linux.ibm.com>, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Hi,

On 11/25/21 at 07:02pm, Michal Suchanek wrote:
> Hello,
> 
> This is resend of the KEXEC_SIG patchset.
> 
> The first patch is new because it'a a cleanup that does not require any
> change to the module verification code.
> 
> The second patch is the only one that is intended to change any
> functionality.
> 
> The rest only deduplicates code but I did not receive any review on that
> part so I don't know if it's desirable as implemented.

Do you have the link of your 1st version?

And after going through the whole series, it doesn't tell what this
patch series intends to do in cover-letter or patch log.

Thanks
Baoquan

> 
> The first two patches can be applied separately without the rest.
> 
> Thanks
> 
> Michal
> 
> Michal Suchanek (6):
>   s390/kexec_file: Don't opencode appended signature check.
>   powerpc/kexec_file: Add KEXEC_SIG support.
>   kexec_file: Don't opencode appended signature verification.
>   module: strip the signature marker in the verification function.
>   module: Use key_being_used_for for log messages in
>     verify_appended_signature
>   module: Move duplicate mod_check_sig users code to mod_parse_sig
> 
>  arch/powerpc/Kconfig                     | 11 +++++
>  arch/powerpc/kexec/elf_64.c              | 14 ++++++
>  arch/s390/kernel/machine_kexec_file.c    | 42 ++----------------
>  crypto/asymmetric_keys/asymmetric_type.c |  1 +
>  include/linux/module_signature.h         |  1 +
>  include/linux/verification.h             |  4 ++
>  kernel/module-internal.h                 |  2 -
>  kernel/module.c                          | 12 +++--
>  kernel/module_signature.c                | 56 +++++++++++++++++++++++-
>  kernel/module_signing.c                  | 33 +++++++-------
>  security/integrity/ima/ima_modsig.c      | 22 ++--------
>  11 files changed, 113 insertions(+), 85 deletions(-)
> 
> -- 
> 2.31.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
