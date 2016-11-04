Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c2k2O-0006x8-NH
 for kexec@lists.infradead.org; Fri, 04 Nov 2016 19:20:29 +0000
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA4JIb6S011601
 for <kexec@lists.infradead.org>; Fri, 4 Nov 2016 15:20:02 -0400
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26gwj1d72a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 04 Nov 2016 15:20:02 -0400
Received: from localhost
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 4 Nov 2016 17:19:59 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.18.232.225])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A76BD1DC006E
 for <kexec@lists.infradead.org>; Fri,  4 Nov 2016 15:19:56 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA4JJuB830015736
 for <kexec@lists.infradead.org>; Fri, 4 Nov 2016 17:19:56 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA4JJu9s025914
 for <kexec@lists.infradead.org>; Fri, 4 Nov 2016 17:19:56 -0200
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [RFC]  kexec_file: Add support for purgatory built as PIE
Date: Fri, 04 Nov 2016 17:19:53 -0200
In-Reply-To: <871syrcm70.fsf@xmission.com>
References: <3476672.cGrsQmUQKg@morokweng> <20161104073840.GD4314@x1>
 <871syrcm70.fsf@xmission.com>
MIME-Version: 1.0
Message-Id: <3998943.Ju5lgDeipl@morokweng>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Vivek Goyal <vgoyal@redhat.com>

Hello Eric,

Am Freitag, 4. November 2016, 10:13:39 BRST schrieb Eric W. Biederman:
> Baoquan He <bhe@redhat.com> writes:
> > On 11/02/16 at 04:00am, Thiago Jung Bauermann wrote:
> >> Hello,
> >> 
> >> The kexec_file code currently builds the purgatory as a partially linked
> >> object (using ld -r). Is there a particular reason to use that instead
> >> of a position independent executable (PIE)?
> > 
> > It's taken as "-r", relocatable in user space kexec-tools too originally.
> > I think Vivek just keeps it the same when moving into kernel.
> 
> At least on x86 using just -r removed the need for a GOT and all of the
> other nasty dynamic relocatable bits, that are not needed when the you
> don't want to share your text bits with the page cache.
> 
> I can see reaons for refactoring code but I expect PIE expecutables need
> a GOT and all of that pain in the neck stuff that can just be avoided by
> building the code to run at an absolute address.

At least on powerpc, building the purgatory as PIE resulted in only the 
following differences:

1. A lot less relocation types to deal with.
2. __kexec_load_purgatory needs to use the program headers rather than the 
   section headers to figure out how to load the binary.
3. Symbol values are absolute addresses instead of relative to the start of 
   the section.

2. is an advantage too because it's actually easier to use the program headers 
because unlike section headers, the purpose of program headers is to provide 
the information needed by a program loader. You can see this by comparing the 
two implementations of __kexec_load_purgatory in the WIP patch I posted. The 
one using program headers is simpler.

3. isn't a problem, it's easy to convert the absolute addresses back into 
relative ones, as can be seen in my patch.

> So far I have not seen ELF relocations that are difficult to process.

The problem is not that it's difficult to process, but that on powerpc it 
takes a lot of code to implement that processing. In v9 of the kexec_file_load 
implementation for powerpc, the switch statement implementing all the 
relocation types (shared by powerpc's module_64.c and machine_kexec_file_64.c) 
has 200 lines. The switch statement implementing only the relocation types 
used by the PIE purgatory has 26 lines.

This is not a problem in x86, though: the purgatory built as a relocatable 
object has only two relocation types.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
