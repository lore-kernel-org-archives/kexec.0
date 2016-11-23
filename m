Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c9Ni2-0003Yx-SE
 for kexec@lists.infradead.org; Wed, 23 Nov 2016 02:54:56 +0000
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAN2s75f045313
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2016 21:54:33 -0500
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26vku9j3gk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2016 21:54:32 -0500
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 00:54:30 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 58267352006C
 for <kexec@lists.infradead.org>; Tue, 22 Nov 2016 21:53:59 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAN2sSYF39321606
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2016 00:54:28 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAN2sR5P015016
 for <kexec@lists.infradead.org>; Wed, 23 Nov 2016 00:54:28 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v10 04/10] kexec_file: Add support for purgatory built as
 PIE.
Date: Wed, 23 Nov 2016 00:54:20 -0200
In-Reply-To: <20161123013258.GA3222@dhcp-128-65.nay.redhat.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <2486176.qfzlYnJWAn@morokweng>
 <20161123013258.GA3222@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Message-Id: <1600863.ghUE1ReoOW@morokweng>
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
To: Dave Young <dyoung@redhat.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

Am Mittwoch, 23. November 2016, 09:32:58 BRST schrieb Dave Young:
> On 11/22/16 at 11:44am, Thiago Jung Bauermann wrote:
> > Am Dienstag, 22. November 2016, 17:01:10 BRST schrieb Michael Ellerman:
> > > Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:
> > > > Am Sonntag, 20. November 2016, 10:45:46 BRST schrieb Dave Young:
> > > >> On 11/10/16 at 01:27am, Thiago Jung Bauermann wrote:
> > > >> > powerpc's purgatory.ro has 12 relocation types when built as
> > > >> > a relocatable object. To implement support for them requires
> > > >> > arch_kexec_apply_relocations_add to duplicate a lot of code with
> > > >> > module_64.c:apply_relocate_add.
> > > >> > 
> > > >> > When built as a Position Independent Executable there are only 4
> > > >> > relocation types in purgatory.ro, so it becomes practical for the
> > > >> > powerpc
> > > >> > implementation of kexec_file to have its own relocation
> > > >> > implementation.
> > > >> > 
> > > >> > Also, the purgatory is an executable and not an intermediary output
> > > >> > from
> > > >> > the compiler so it makes sense conceptually that it is easier to
> > > >> > build
> > > >> > it as a PIE than as a partially linked object.
> > > >> > 
> > > >> > Apart from the greatly reduced number of relocations, there are two
> > > >> > differences between a relocatable object and a PIE:
> > > >> > 
> > > >> > 1. __kexec_load_purgatory needs to use the program headers rather
> > > >> > than
> > > >> > the
> > > >> > 
> > > >> >    section headers to figure out how to load the binary.
> > > >> > 
> > > >> > 2. Symbol values are absolute addresses instead of relative to the
> > > >> > 
> > > >> >    start of the section.
> > > >> > 
> > > >> > This patch adds the support needed in generic code for the
> > > >> > differences
> > > >> > above and allows powerpc to load and relocate a position
> > > >> > independent
> > > >> > purgatory.
> > > >> 
> > > >> [snip]
> > > >> 
> > > >> The kexec-tools machine_apply_elf_rel is pretty simple for ppc64, it
> > > >> is
> > > >> not that complex. So could you look into simplify your kexec_file
> > > >> implementation?
> > > > 
> > > > I can try, but there is one fundamental issue here: powerpc
> > > > position-dependent code relies more on relocations than x86
> > > > position-dependent code does, so there's a limit to how simple it can
> > > > be
> > > > made without switching to position- independent code. And it will
> > > > always
> > > > be more involved than it is on x86.
> > > 
> > > I think we need to go back to the drawing board on this one.
> > > 
> > > My hope was that building purgatory as PIE would reduce the amount of
> > > complexity, but instead it's just added more. Sorry for sending you in
> > > that direction.
> > 
> > It added complexity because in my series powerpc was using a PIE purgatory
> > but x86 kept using a partially-linked object (because of the problem I
> > mentioned I had when trying out a PIE x86 purgatory), so generic code
> > needed two purgatory loaders.
> > 
> > I'll see if I can make the PIE x86 purgatory to work so that generic code
> > can have only one loader implementation. Then it will indeed be simpler.
> Do we really need the PIE purgatory, after moving generic code out of
> x86, there will be no much benefit, no?

It still makes a big difference on powerpc, even after moving out the generic 
code. I just got the PIE purgatory working on x86 and it also simplifies the 
code there, so it's a win for both architectures.

I'll clean up the code and post tomorrow so that you can see what you think.

> Anyway, the first step should be
> making the purgatory code more generic so that it can be easier for
> other arches to support kexec_file in the future.

I'll try putting sha256.c in lib/purgatory/ as you suggested.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
