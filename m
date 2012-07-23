Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1StRfy-0007o3-8Y
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 23:04:40 +0000
Received: from joe.kanocho.kobe.vergenet.net
 (101-140-169-19f1.hyg1.eonet.ne.jp [101.140.169.19])
 by kirsty.vergenet.net (Postfix) with ESMTP id 1F10225BF08
 for <kexec@lists.infradead.org>; Tue, 24 Jul 2012 09:04:27 +1000 (EST)
Resent-Message-ID: <20120723230425.GC2966@verge.net.au>
Resent-To: kexec@lists.infradead.org
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1StIjH-0007qv-46
 for kexec@lists.infradead.org; Mon, 23 Jul 2012 13:31:22 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] kexec-tools: Read always one vmcoreinfo file
Date: Mon, 23 Jul 2012 15:30:55 +0200
References: <20120705121635.GA2007@host-192-168-1-59.local.net-space.pl>
 <201207231456.07783.ptesarik@suse.cz>
In-Reply-To: <201207231456.07783.ptesarik@suse.cz>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_PIVDQAtrL2qk27+"
Message-Id: <201207231530.55871.ptesarik@suse.cz>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, horms@verge.net.au
Cc: Daniel Kiper <daniel.kiper@oracle.com>, xen-devel@lists.xensource.com, olaf@aepfle.de, konrad.wilk@oracle.com

--Boundary-00=_PIVDQAtrL2qk27+
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dne Po 23. =C4=8Dervence 2012 14:56:07 Petr Tesarik napsal(a):
> Dne =C4=8Ct 5. =C4=8Dervence 2012 14:16:35 Daniel Kiper napsal(a):
> > vmcoreinfo file could exists under /sys/kernel (valid on baremetal only)
> > and/or under /sys/hypervisor (valid when Xen dom0 is running).
> > Read only one of them. It means that only one PT_NOTE will be
> > always created. Remove extra code for second PT_NOTE creation.
>=20
> Hi Daniel,
>=20
> are you absolutely sure this is the right thing to do? IIUC these two
> VMCORINFO notes are very different. The one from /sys/kernel/vmcoreinfo
> describes the Dom0 kernel (type 'VMCOREINFO'), while the one from
> /sys/hypervisor describes the Xen hypervisor (type 'XEN_VMCOREINFO'). If
> you keep only the hypervisor note, then e.g. makedumpfile won't be able to
> use dumplevel greater than 1, nor will it be able to extract the log
> buffer.

I've just verified this, and I'm confident we have to keep both notes in th=
e=20
dump file. Simon, please revert Daniel's patch to avoid regressions.

I'm attaching a sample VMCOREINFO_XEN and VMCOREINFO to demonstrate the=20
difference. Note that the VMCOREINFO_XEN note is actually too big, because =
Xen=20
doesn't bother to maintain the correct note size in the note header, so it=
=20
always spans a complete page minus sizeof(Elf64_Nhdr)...

Regards,
Petr Tesarik

> Petr Tesarik
> SUSE Linux
>=20
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > ---
> >=20
> >  kexec/crashdump-elf.c |   33 +++++++--------------------------
> >  1 files changed, 7 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
> > index 8d82db9..ec66548 100644
> > --- a/kexec/crashdump-elf.c
> > +++ b/kexec/crashdump-elf.c
> > @@ -40,8 +40,6 @@ int FUNC(struct kexec_info *info,
> >=20
> >  	uint64_t notes_addr, notes_len;
> >  	uint64_t vmcoreinfo_addr, vmcoreinfo_len;
> >  	int has_vmcoreinfo =3D 0;
> >=20
> > -	uint64_t vmcoreinfo_addr_xen, vmcoreinfo_len_xen;
> > -	int has_vmcoreinfo_xen =3D 0;
> >=20
> >  	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
> >  =09
> >  	if (xen_present())
> >=20
> > @@ -53,16 +51,14 @@ int FUNC(struct kexec_info *info,
> >=20
> >  		return -1;
> >  =09
> >  	}
> >=20
> > -	if (get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len) =3D=3D 0=
) {
> > -		has_vmcoreinfo =3D 1;
> > -	}
> > -
> > -	if (xen_present() &&
> > -	    get_xen_vmcoreinfo(&vmcoreinfo_addr_xen, &vmcoreinfo_len_xen) =3D=
=3D=20
0)
> > { -		has_vmcoreinfo_xen =3D 1;
> > -	}
> > +	if (xen_present()) {
> > +		if (!get_xen_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> > +			has_vmcoreinfo =3D 1;
> > +	} else
> > +		if (!get_kernel_vmcoreinfo(&vmcoreinfo_addr, &vmcoreinfo_len))
> > +			has_vmcoreinfo =3D 1;
> >=20
> > -	sz =3D sizeof(EHDR) + (nr_cpus + has_vmcoreinfo + has_vmcoreinfo_xen)=
=20
*
> > sizeof(PHDR) + +	sz =3D sizeof(EHDR) + (nr_cpus + has_vmcoreinfo) *
> > sizeof(PHDR) +
> >=20
> >  	     ranges * sizeof(PHDR);
> >  =09
> >  	/*
> >=20
> > @@ -179,21 +175,6 @@ int FUNC(struct kexec_info *info,
> >=20
> >  		dbgprintf_phdr("vmcoreinfo header", phdr);
> >  =09
> >  	}
> >=20
> > -	if (has_vmcoreinfo_xen) {
> > -		phdr =3D (PHDR *) bufp;
> > -		bufp +=3D sizeof(PHDR);
> > -		phdr->p_type	=3D PT_NOTE;
> > -		phdr->p_flags	=3D 0;
> > -		phdr->p_offset  =3D phdr->p_paddr =3D vmcoreinfo_addr_xen;
> > -		phdr->p_vaddr   =3D 0;
> > -		phdr->p_filesz	=3D phdr->p_memsz	=3D vmcoreinfo_len_xen;
> > -		/* Do we need any alignment of segments? */
> > -		phdr->p_align	=3D 0;
> > -
> > -		(elf->e_phnum)++;
> > -		dbgprintf_phdr("vmcoreinfo_xen header", phdr);
> > -	}
> > -
> >=20
> >  	/* Setup an PT_LOAD type program header for the region where
> >  =09
> >  	 * Kernel is mapped if elf_info->kern_size is non-zero.
> >  	 */
>=20
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

--Boundary-00=_PIVDQAtrL2qk27+
Content-Type: text/plain;
  charset="UTF-8";
  name="VMCOREINFO_XEN"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="VMCOREINFO_XEN"

UEFHRVNJWkU9NDA5NgpTWU1CT0woZG9tYWluX2xpc3QpPWZmZmY4MmM0ODAyOWUwZjAKU1lNQk9M
KGZyYW1lX3RhYmxlKT1mZmZmODJjNDgwMjBkOTA4ClNZTUJPTChtYXhfcGFnZSk9ZmZmZjgyYzQ4
MDJjMWE2OApTSVpFKHBhZ2VfaW5mbyk9MzIKU0laRShkb21haW4pPTU1MDQKT0ZGU0VUKHBhZ2Vf
aW5mby5jb3VudF9pbmZvKT04Ck9GRlNFVChwYWdlX2luZm8uX2RvbWFpbik9MjQKT0ZGU0VUKGRv
bWFpbi5kb21haW5faWQpPTAKT0ZGU0VUKGRvbWFpbi5uZXh0X2luX2xpc3QpPTk2ClNZTUJPTChk
b21feGVuKT1mZmZmODJjNDgwMmMxYTc4ClNZTUJPTChkb21faW8pPWZmZmY4MmM0ODAyYzFhODAK
U1lNQk9MKHBnZF9sNCk9ZmZmZjgyYzQ4MDI5NDAwMAoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAA

--Boundary-00=_PIVDQAtrL2qk27+
Content-Type: text/plain;
  charset="UTF-8";
  name="VMCOREINFO"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="VMCOREINFO"

OSRELEASE=3.0.34-0.7-xen
PAGESIZE=4096
SYMBOL(init_uts_ns)=ffffffff806b2fc0
SYMBOL(node_online_map)=ffffffff8070e968
SYMBOL(swapper_pg_dir)=ffffffff80783000
SYMBOL(_stext)=ffffffff80004000
SYMBOL(vmlist)=ffffffff8082ea40
SYMBOL(mem_map)=ffffffff8082e950
SYMBOL(contig_page_data)=ffffffff80700f80
SIZE(page)=56
SIZE(pglist_data)=6912
SIZE(zone)=1664
SIZE(free_area)=88
SIZE(list_head)=16
SIZE(nodemask_t)=8
OFFSET(page.flags)=0
OFFSET(page._count)=8
OFFSET(page.mapping)=24
OFFSET(page.lru)=40
OFFSET(pglist_data.node_zones)=0
OFFSET(pglist_data.nr_zones)=6744
OFFSET(pglist_data.node_mem_map)=6752
OFFSET(pglist_data.node_start_pfn)=6768
OFFSET(pglist_data.node_spanned_pages)=6784
OFFSET(pglist_data.node_id)=6792
OFFSET(zone.free_area)=88
OFFSET(zone.vm_stat)=1304
OFFSET(zone.spanned_pages)=1576
OFFSET(free_area.free_list)=0
OFFSET(list_head.next)=0
OFFSET(list_head.prev)=8
OFFSET(vm_struct.addr)=8
LENGTH(zone.free_area)=11
SYMBOL(log_buf)=ffffffff806b8470
SYMBOL(log_end)=ffffffff80796ac0
SYMBOL(log_buf_len)=ffffffff806b8464
SYMBOL(logged_chars)=ffffffff807d6bc0
LENGTH(free_area.free_list)=5
NUMBER(NR_FREE_PAGES)=0
NUMBER(PG_lru)=6
NUMBER(PG_private)=12
NUMBER(PG_head)=16
NUMBER(PG_swapcache)=18
SYMBOL(init_level4_pgt)=ffffffff80783000
CRASHTIME=1341922380
--Boundary-00=_PIVDQAtrL2qk27+
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--Boundary-00=_PIVDQAtrL2qk27+--


