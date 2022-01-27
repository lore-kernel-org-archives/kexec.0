From: Joerg Roedel <jroedel@suse.de>
Date: Thu, 27 Jan 2022 10:01:31 +0100
Subject: [PATCH v2 08/12] x86/sev: Park APs on AP Jump Table with GHCB
 protocol version 2
In-Reply-To: <YY6XQfmvmpmUiIGj@zn.tnic>
References: <20210913155603.28383-1-joro@8bytes.org>
 <20210913155603.28383-9-joro@8bytes.org> <YY6XQfmvmpmUiIGj@zn.tnic>
Message-ID: <YfJfa955Pkg1y6Gv@suse.de>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Fri, Nov 12, 2021 at 05:33:05PM +0100, Borislav Petkov wrote:
> On Mon, Sep 13, 2021 at 05:55:59PM +0200, Joerg Roedel wrote:
> > +		     "ljmpl	*%0" : :
> > +		     "m" (real_mode_header->sev_real_ap_park_asm),
> > +		     "b" (sev_es_jump_table_pa >> 4));
> 
> In any case, this asm needs comments: why those regs, why
> sev_es_jump_table_pa >> 4 in rbx (I found later in the patch why) and so
> on.

Turned out the jump_table_pa is not used in asm code anymore. It was a
left-over from a previous version of the patch, it is removed now.

> > +SYM_INNER_LABEL(sev_ap_park_paging_off, SYM_L_GLOBAL)
> 
> Global symbol but used only in this file. .L-prefix then?

It needs to be a global symbol so the pa_ variant can be generated.

Regards,

-- 
J?rg R?del
jroedel at suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 N?rnberg
Germany
 
(HRB 36809, AG N?rnberg)
Gesch?ftsf?hrer: Ivo Totev


