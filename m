Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from scorn.kernelslacker.org ([2600:3c03:e000:2fb::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHxAq-0007Ch-GL
 for kexec@lists.infradead.org; Tue, 08 Oct 2019 21:37:42 +0000
Date: Tue, 8 Oct 2019 17:37:33 -0400
From: Dave Jones <davej@codemonkey.org.uk>
Subject: Re: makedumpfile: Fix divide by zero in print_report()
Message-ID: <20191008213733.GA21304@codemonkey.org.uk>
References: <20190924194005.GA7666@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359079B@BPXM09GP.gisp.nec.co.jp>
 <20190926193253.GA10258@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035909ED@BPXM09GP.gisp.nec.co.jp>
 <20191004170357.GA12416@codemonkey.org.uk>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0359146E@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0359146E@BPXM09GP.gisp.nec.co.jp>
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

On Mon, Oct 07, 2019 at 08:13:07PM +0000, Kazuhito Hagio wrote:
 
 > > [  518.819690] Original pages  : 0x0000000000000000
 > > [  518.828894]   Excluded pages   : 0x0000000003decd15
 > > [  518.838635]     Pages filled with zero  : 0x00000000000210ee
 > > [  518.849920]     Non-private cache pages : 0x000000000000271a
 > > [  518.861218]     Private cache pages     : 0x000000000000da47
 > > [  518.872502]     User process data pages : 0x0000000003d6bdc8
 > > [  518.883786]     Free pages              : 0x000000000004fcfe
 > > [  518.895070]     Hwpoison pages          : 0x0000000000000000
 > > [  518.906356]     Offline pages           : 0x0000000000000000
 > > [  518.917659]   Remaining pages  : 0xfffffffffc2132eb
 > > [  518.927398] Memory Hole     : 0x0000000004080000
 >
 > This is the known issue that I wrote above and am looking for a safe fix.
 > How does this patch work?

I'll give this a try, and see how it goes for a few days.

 > If it looks good, I'll look into its side effects further,
 > but might take some time..


 > > And the crashdump seems corrupt:
 > > 
 > Could you show me the output of "readelf -a vmcore"?

See below.

 > Does this issue always reproduce?

Not 100% the time. Sometimes we do get valid dumps from these hosts.
My guess so far is that it has something to do with how much of memory
makedumpfile was able to discard with -d31


Common case seems to be:

<F28>ELF Header:
  Magic:   7f 45 4c 46 02 01 01 00 00 00 00 00 00 00 00 00 
  Class:                             ELF64
  Data:                              2's complement, little endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              CORE (Core file)
  Machine:                           Advanced Micro Devices X86-64
  Version:                           0x1
  Entry point address:               0x0
  Start of program headers:          64 (bytes into file)
  Start of section headers:          0 (bytes into file)
  Flags:                             0x0
  Size of this header:               64 (bytes)
  Size of program headers:           56 (bytes)
  Number of program headers:         23881
  Size of section headers:           0 (bytes)
  Number of section headers:         0
  Section header string table index: 0

There are no sections in this file.

There are no sections to group in this file.

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
... <repeats for thousands of lines>
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0
  NULL           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000         0

There is no dynamic section in this file.

There are no relocations in this file.

The decoding of unwind sections for machine type Advanced Micro Devices X86-64 is not currently supported.

Dynamic symbol information is not available for displaying symbols.

No version information found in this file.



There are some other failure cases with non-null data, so maybe there's >1 bug here.
I've not seen an obvious pattern to this. eg...

https://pastebin.com/2uM4sBCF



I'll put your patch on some of the affected hosts and see if this
changes behaviour in any way.

thanks,
	Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
