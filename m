Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iP6nM-00021v-Rq
 for kexec@lists.infradead.org; Mon, 28 Oct 2019 15:19:02 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide
 by zero in print_report())
Date: Mon, 28 Oct 2019 15:18:00 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03593DA7@BPXM09GP.gisp.nec.co.jp>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
 <20191009213855.GA14574@codemonkey.org.uk>
In-Reply-To: <20191009213855.GA14574@codemonkey.org.uk>
Content-Language: en-US
MIME-Version: 1.0
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
To: Dave Jones <davej@codemonkey.org.uk>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

> -----Original Message-----
>  > > There are some other failure cases with non-null data, so maybe there's >1 bug here.
>  > > I've not seen an obvious pattern to this. eg...
>  > >
>  > > https://pastebin.com/2uM4sBCF
>  > >
>  >
>  > As for this case, I suspect that Elf64_Ehdr.e_phnum overflows
>  > (i.e. num_loads_dumpfile > 65535):
> 
> Oh, good catch.  These are 256GB machines, so after discarding
> everything, that explains why we end up with so many sections.
> This also explains why it sometimes works I think, when the discarding
> manages to get the total nr headers <64k.

I think this will be the one of the causes, and had a look at how
we can fix it.  If you get a vmcore where this pattern occurs,
you can try this tree:
https://github.com/k-hagio/makedumpfile/tree/support-extended-elf

Then, the crash utility also needs a patch to support a dumpfile
that has more than 64k program headers:
https://github.com/k-hagio/crash/tree/support-extended-elf

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
