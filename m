Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c94O0-0002Ay-RJ
 for kexec@lists.infradead.org; Tue, 22 Nov 2016 06:16:58 +0000
Date: Tue, 22 Nov 2016 14:16:22 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v10 04/10] kexec_file: Add support for purgatory built as
 PIE.
Message-ID: <20161122061622.GB11254@dhcp-128-65.nay.redhat.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1478748449-3894-5-git-send-email-bauerman@linux.vnet.ibm.com>
 <20161120024546.GA4413@dhcp-128-65.nay.redhat.com>
 <5009580.5GxAkTrMYA@morokweng>
 <87ziksuk7t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ziksuk7t.fsf@concordia.ellerman.id.au>
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
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Baoquan He <bhe@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Hi Michael
On 11/22/16 at 05:01pm, Michael Ellerman wrote:
> Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > Am Sonntag, 20. November 2016, 10:45:46 BRST schrieb Dave Young:
> >> On 11/10/16 at 01:27am, Thiago Jung Bauermann wrote:
> >> > powerpc's purgatory.ro has 12 relocation types when built as
> >> > a relocatable object. To implement support for them requires
> >> > arch_kexec_apply_relocations_add to duplicate a lot of code with
> >> > module_64.c:apply_relocate_add.
> >> > 
> >> > When built as a Position Independent Executable there are only 4
> >> > relocation types in purgatory.ro, so it becomes practical for the powerpc
> >> > implementation of kexec_file to have its own relocation implementation.
> >> > 
> >> > Also, the purgatory is an executable and not an intermediary output from
> >> > the compiler so it makes sense conceptually that it is easier to build
> >> > it as a PIE than as a partially linked object.
> >> > 
> >> > Apart from the greatly reduced number of relocations, there are two
> >> > differences between a relocatable object and a PIE:
> >> > 
> >> > 1. __kexec_load_purgatory needs to use the program headers rather than the
> >> > 
> >> >    section headers to figure out how to load the binary.
> >> > 
> >> > 2. Symbol values are absolute addresses instead of relative to the
> >> > 
> >> >    start of the section.
> >> > 
> >> > This patch adds the support needed in generic code for the differences
> >> > above and allows powerpc to load and relocate a position independent
> >> > purgatory.
> >> 
> >> [snip]
> >> 
> >> The kexec-tools machine_apply_elf_rel is pretty simple for ppc64, it is
> >> not that complex. So could you look into simplify your kexec_file
> >> implementation?
> >
> > I can try, but there is one fundamental issue here: powerpc position-dependent 
> > code relies more on relocations than x86 position-dependent code does, so 
> > there's a limit to how simple it can be made without switching to position-
> > independent code. And it will always be more involved than it is on x86.
> 
> I think we need to go back to the drawing board on this one.
> 
> My hope was that building purgatory as PIE would reduce the amount of
> complexity, but instead it's just added more. Sorry for sending you in
> that direction.
> 
> 
> In general I dislike the level of complexity of the kexec-tools
> purgatory, and in particular I'm not comfortable with things like:
> 
> diff --git a/arch/powerpc/purgatory/sha256.c b/arch/powerpc/purgatory/sha256.c
> new file mode 100644
> index 000000000000..6abee1877d56
> --- /dev/null
> +++ b/arch/powerpc/purgatory/sha256.c
> @@ -0,0 +1,6 @@
> +#include "../boot/string.h"
> +
> +/* Avoid including x86's boot/string.h in sha256.c. */
> +#define BOOT_STRING_H
> +
> +#include "../../x86/purgatory/sha256.c"
> 

Agreed, include x86 code in powerpc looks bad

> 
> I think the best way to get this over the line would be to take the
> kexec-lite purgatory implementation and use that to begin with. I know
> it doesn't have all the features of the kexec-tools version, but it
> should work, and we can look at adding the extra features later.

Instead of adding other implementation, moving the purgatory sha256 code
out of x86 sounds better so that we can reuse them cleanly..

> 
> I'll try and get that working tonight.
> 
> cheers

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
