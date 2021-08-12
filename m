Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE7cH-009brJ-WB
 for kexec@lists.infradead.org; Thu, 12 Aug 2021 10:07:15 +0000
Received: by mail-lj1-x22f.google.com with SMTP id n6so9735465ljp.9
 for <kexec@lists.infradead.org>; Thu, 12 Aug 2021 03:07:13 -0700 (PDT)
Date: Thu, 12 Aug 2021 13:07:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH 07/11] treewide: Replace the use of mem_encrypt_active()
 with prot_guest_has()
Message-ID: <20210812100724.t4cdh7xbkuqgnsc3@box.shutemov.name>
References: <cover.1627424773.git.thomas.lendacky@amd.com>
 <029791b24c6412f9427cfe6ec598156c64395964.1627424774.git.thomas.lendacky@amd.com>
 <166f30d8-9abb-02de-70d8-6e97f44f85df@linux.intel.com>
 <4b885c52-f70a-147e-86bd-c71a8f4ef564@amd.com>
 <20210811121917.ghxi7g4mctuybhbk@box.shutemov.name>
 <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0a819549-e481-c004-7da8-82ba427b13ce@amd.com>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Borislav Petkov <bp@alien8.de>, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

On Wed, Aug 11, 2021 at 10:52:55AM -0500, Tom Lendacky wrote:
> On 8/11/21 7:19 AM, Kirill A. Shutemov wrote:
> > On Tue, Aug 10, 2021 at 02:48:54PM -0500, Tom Lendacky wrote:
> >> On 8/10/21 1:45 PM, Kuppuswamy, Sathyanarayanan wrote:
> >>>
> >>>
> >>> On 7/27/21 3:26 PM, Tom Lendacky wrote:
> >>>> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> >>>> index de01903c3735..cafed6456d45 100644
> >>>> --- a/arch/x86/kernel/head64.c
> >>>> +++ b/arch/x86/kernel/head64.c
> >>>> @@ -19,7 +19,7 @@
> >>>> =A0 #include <linux/start_kernel.h>
> >>>> =A0 #include <linux/io.h>
> >>>> =A0 #include <linux/memblock.h>
> >>>> -#include <linux/mem_encrypt.h>
> >>>> +#include <linux/protected_guest.h>
> >>>> =A0 #include <linux/pgtable.h>
> >>>> =A0 =A0 #include <asm/processor.h>
> >>>> @@ -285,7 +285,7 @@ unsigned long __head __startup_64(unsigned long
> >>>> physaddr,
> >>>> =A0=A0=A0=A0=A0=A0 * there is no need to zero it after changing the =
memory encryption
> >>>> =A0=A0=A0=A0=A0=A0 * attribute.
> >>>> =A0=A0=A0=A0=A0=A0 */
> >>>> -=A0=A0=A0 if (mem_encrypt_active()) {
> >>>> +=A0=A0=A0 if (prot_guest_has(PATTR_MEM_ENCRYPT)) {
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr =3D (unsigned long)__start_bss_dec=
rypted;
> >>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 vaddr_end =3D (unsigned long)__end_bss_d=
ecrypted;
> >>>
> >>>
> >>> Since this change is specific to AMD, can you replace PATTR_MEM_ENCRY=
PT with
> >>> prot_guest_has(PATTR_SME) || prot_guest_has(PATTR_SEV). It is not use=
d in
> >>> TDX.
> >>
> >> This is a direct replacement for now.
> > =

> > With current implementation of prot_guest_has() for TDX it breaks boot =
for
> > me.
> > =

> > Looking at code agains, now I *think* the reason is accessing a global
> > variable from __startup_64() inside TDX version of prot_guest_has().
> > =

> > __startup_64() is special. If you access any global variable you need to
> > use fixup_pointer(). See comment before __startup_64().
> > =

> > I'm not sure how you get away with accessing sme_me_mask directly from
> > there. Any clues? Maybe just a luck and complier generates code just ri=
ght
> > for your case, I donno.
> =

> Hmm... yeah, could be that the compiler is using rip-relative addressing
> for it because it lives in the .data section?

I guess. It has to be fixed. It may break with complier upgrade or any
random change around the code.

BTW, does it work with clang for you?

> For the static variables in mem_encrypt_identity.c I did an assembler rip
> relative LEA, but probably could have passed physaddr to sme_enable() and
> used a fixup_pointer() style function, instead.

Sounds like a plan.

> > A separate point is that TDX version of prot_guest_has() relies on
> > cpu_feature_enabled() which is not ready at this point.
> =

> Does TDX have to do anything special to make memory able to be shared with
> the hypervisor?

Yes. But there's nothing that required any changes in early boot. It
handled in ioremap/set_memory.

> You might have to use something that is available earlier
> than cpu_feature_enabled() in that case (should you eventually support
> kvmclock).

Maybe.

> > I think __bss_decrypted fixup has to be done if sme_me_mask is non-zero.
> > Or just do it uncoditionally because it's NOP for sme_me_mask =3D=3D 0.
> =

> For SNP, we'll have to additionally call the HV to update the RMP to make
> the memory shared. But that could also be done unconditionally since the
> early_snp_set_memory_shared() routine will check for SNP before doing
> anything.

-- =

 Kirill A. Shutemov

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
