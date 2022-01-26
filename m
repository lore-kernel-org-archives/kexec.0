From: Joerg Roedel <jroedel@suse.de>
Date: Wed, 26 Jan 2022 15:26:01 +0100
Subject: [PATCH v2 07/12] x86/sev: Setup code to park APs in the AP Jump
 Table
In-Reply-To: <YYv1TPawuorQv1PR@zn.tnic>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-8-joro@8bytes.org> <YYv1TPawuorQv1PR@zn.tnic>
Message-ID: <YfFZ+SRutJhDoAkz@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Nov 10, 2021 at 05:37:32PM +0100, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 05:55:58PM +0200, Joerg Roedel wrote:
> >  extern unsigned char real_mode_blob[];
> > diff --git a/arch/x86/include/asm/sev-ap-jumptable.h b/arch/x86/include/asm/sev-ap-jumptable.h
> > new file mode 100644
> > index 000000000000..1c8b2ce779e2
> > --- /dev/null
> > +++ b/arch/x86/include/asm/sev-ap-jumptable.h
> 
> Why a separate header? arch/x86/include/asm/sev.h looks small enough.

The header is included in assembly, so I made a separate one.

> > +void __init sev_es_setup_ap_jump_table_data(void *base, u32 pa)
> 
> Why is this a separate function?
> 
> It is all part of the jump table setup.

Right, but the sev_es_setup_ap_jump_table_blob() function is already
pretty big and I wanted to keep things readable.

> 
> > +		return 0;
> 
> Why are you returning 0 here and below?

This is in an initcall and it returns just 0 when the environment is not
ready to setup the ap jump table. Returning non-zero would create a
warning message in the caller for something that is not a bug in the
kernel.

> > + * This file contains the source code for the binary blob which gets copied to
> > + * the SEV-ES AP Jumptable to park APs while offlining CPUs or booting a new
> 
> I've seen "Jumptable", "Jump Table" and "jump table" at least. I'd say, do
> the last one everywhere pls.

Fair, sorry for my english being too german :) I changed everything to
'jump table'.

> > +	/* Reset remaining registers */
> > +	movl	$0, %esp
> > +	movl	$0, %eax
> > +	movl	$0, %ebx
> > +	movl	$0, %edx
> 
> All 4: use xor

XOR changes EFLAGS, can not use them here.

> > +
> > +	/* Reset CR0 to get out of protected mode */
> > +	movl	$0x60000010, %ecx
> 
> Another magic naked number.

This is the CR0 reset value. I have updated the comment to make this
more clear.

Thanks,

-- 
J?rg R?del
jroedel at suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N?rnberg
Germany
 
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev


