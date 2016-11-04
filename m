Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c2gfQ-0007gz-3i
 for kexec@lists.infradead.org; Fri, 04 Nov 2016 15:44:33 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA4FhsiU076560
 for <kexec@lists.infradead.org>; Fri, 4 Nov 2016 11:44:06 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26gunqec86-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 04 Nov 2016 11:44:05 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 4 Nov 2016 13:44:03 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id F19561DC0054
 for <kexec@lists.infradead.org>; Fri,  4 Nov 2016 11:44:00 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA4Fi02139518322
 for <kexec@lists.infradead.org>; Fri, 4 Nov 2016 13:44:00 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA4Fi0YI022579
 for <kexec@lists.infradead.org>; Fri, 4 Nov 2016 13:44:00 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC]  kexec_file: Add support for purgatory built as PIE
Date: Fri, 04 Nov 2016 13:43:55 -0200
In-Reply-To: <20161104073840.GD4314@x1>
References: <3476672.cGrsQmUQKg@morokweng> <20161104073840.GD4314@x1>
MIME-Version: 1.0
Message-Id: <1558014.uilYosVS7M@morokweng>
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
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

Hello Baoquan,

Am Freitag, 4. November 2016, 15:38:40 BRST schrieb Baoquan He:
> On 11/02/16 at 04:00am, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > The kexec_file code currently builds the purgatory as a partially linked
> > object (using ld -r). Is there a particular reason to use that instead of
> > a position independent executable (PIE)?
> 
> It's taken as "-r", relocatable in user space kexec-tools too originally.
> I think Vivek just keeps it the same when moving into kernel.

Ok. If that's the only reason then PIE is better suited at least for powerpc.

> > I found a discussion from 2013 in the archives but from what I understood
> > it was about the purgatory as a separate object vs having it linked into
> > the kernel, which is different from what I'm asking:
> > 
> > http://lists.infradead.org/pipermail/kexec/2013-December/010535.html
> > 
> > Here is my motivation for this question:
> >  On ppc64 purgatory.ro has 12 relocation types when built as a partially
> > 
> > linked object. This makes arch_kexec_apply_relocations_add duplicate a lot
> > of code with module_64.c:apply_relocate_add to implement these
> > relocations. The alternative is to do some refactoring so that both
> > functions can share the implementation of the relocations. This is done
> > in patches 5 and 6 of the
> > kexec_file_load implementation for powerpc:
> In user space kexec-tools utility, you also got this problem?

Yes, kexec-tools' purgatory.ro has 10 relocation types instead of 12 (I don't 
know why), but that's still a lot.

> > @@ -942,7 +1085,13 @@ static Elf_Sym *kexec_purgatory_find_symbol(struct
> > purgatory_info *pi,> 
> >  		/* Go through symbols for a match */
> >  		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
> > 
> > -			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
> > +			/*
> > +			 * FIXME: See if we can or should export the .TOC.
> > +			 * symbol as global instead of searching local symbols
> > +			 * here.
> > +			 */
> > +			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL &&
> > +			    ELF_ST_BIND(syms[k].st_info) != STB_LOCAL)
> > 
> >  				continue;
> >  			
> >  			if (strcmp(strtab + syms[k].st_name, name) != 0)
> > 

I don't need the change above anymore. I found a way to obtain the TOC pointer 
without looking for the .TOC. symbol.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
