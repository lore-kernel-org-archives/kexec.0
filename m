Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYGfK-0006IZ-OI
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 08:46:11 +0000
Date: Wed, 27 Aug 2008 18:46:08 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Let kexec work on IBM QS2x blade servers
Message-ID: <20080827084606.GA9280@verge.net.au>
References: <OF33221B02.C088FDA5-ONC12574B2.002C5BF5-C12574B2.002C7A61@de.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OF33221B02.C088FDA5-ONC12574B2.002C5BF5-C12574B2.002C7A61@de.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Shchetynin <maxim@de.ibm.com>
Cc: kexec@lists.infradead.org

On Wed, Aug 27, 2008 at 10:04:56AM +0200, Maxim Shchetynin wrote:
> 
> Hello,
> 
> please have a look at the following patch. This patch allows kexec to work
> on IBM QS2x blades. Would it be possible to apply this patch to a next
> kexec version?

Thanks, I have applied the following to the kexec-tools git tree
on git.kernel.org.

From: Maxim Shchetynin <maxim@de.ibm.com>

Let kexec work on IBM QS2x blade servers

Hello,

please have a look at the following patch. This patch allows kexec to work
on IBM QS2x blades. Would it be possible to apply this patch to a next
kexec version?

Signed-off-by: Maxim Shchetynin <maxim@de.ibm.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

diff --git a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
index 1c9fce5..f5a9628 100644
--- a/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
+++ b/kexec/arch/ppc64/kexec-elf-rel-ppc64.c
@@ -56,6 +56,7 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, unsigned long r_type,
 		break;
 
 	case R_PPC64_ADDR64:
+	case R_PPC64_REL64:
 		/* Simply set it */
 		*(uint64_t *)location = value;
 		break;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
