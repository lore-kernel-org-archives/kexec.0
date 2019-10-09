Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from scorn.kernelslacker.org ([2600:3c03:e000:2fb::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIJfe-0000W8-VA
 for kexec@lists.infradead.org; Wed, 09 Oct 2019 21:39:00 +0000
Date: Wed, 9 Oct 2019 17:38:55 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: makedumpfile: ELF format issues (RE: makedumpfile: Fix divide by
 zero in print_report())
Message-ID: <20191009213855.GA14574@codemonkey.org.uk>
References: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03591761@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Oct 09, 2019 at 08:03:51PM +0000, Kazuhito Hagio wrote:

 > >                  0x0000000000000000 0x0000000000000000         0
 > >   NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
 > >                  0x0000000000000000 0x0000000000000000         0
 > > 
 > 
 > In this case, was the "makedumpfile Completed." message emitted?
 > It looks like the buffer of program headers was not written to the file..

Our logging infra didn't capture the makedumpfile output. I've fixed
that up, so hopefully next time..

 > Anyway, a debugging patch attached below.
 > 
 > > There are some other failure cases with non-null data, so maybe there's >1 bug here.
 > > I've not seen an obvious pattern to this. eg...
 > > 
 > > https://pastebin.com/2uM4sBCF
 > > 
 > 
 > As for this case, I suspect that Elf64_Ehdr.e_phnum overflows
 > (i.e. num_loads_dumpfile > 65535):

Oh, good catch.  These are 256GB machines, so after discarding
everything, that explains why we end up with so many sections.
This also explains why it sometimes works I think, when the discarding
manages to get the total nr headers <64k.

 > > I'll put your patch on some of the affected hosts and see if this
 > > changes behaviour in any way.
 > 
 > If you can try the patch below, which includes the previous patch,
 > please show me:
 > - the debugging output of makedumpfile
 > - readelf -a vmcore
 > - ls -ls vmcore

Will take me a few days (travelling right now), but when hopefully by
the time I get back we'll have some data.

thanks for looking into this.

	Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
