Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V1tBD-0002si-IO
 for kexec@lists.infradead.org; Wed, 24 Jul 2013 07:08:13 +0000
Date: Wed, 24 Jul 2013 16:06:40 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: makefumpfile tool to estimate vmcore file size
Message-Id: <20130724160640.84e00a3a2e4d811fbdfaa34e@mxc.nes.nec.co.jp>
In-Reply-To: <51E64EA6.9040209@redhat.com>
References: <51E64EA6.9040209@redhat.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: bhe@redhat.com
Cc: kexec@lists.infradead.org

Hello Baoquan,

On Wed, 17 Jul 2013 15:58:30 +0800
Baoquan <bhe@redhat.com> wrote:

> 
> Hi Atsushi,
> 
> Our customer want us to provide a tool to estimate the required dump
> file size based on the current system memory footprint. The following is
> detailed requirement I tried to conclude, what's your opinion?
> 
> In customer's place there are thousands of machines and they don't want
> to budget for significant increases in storage if unnecessary. This
> becomes particularly expensive with large memory (1tb+) systems booting
> off san disk.
> 
> Customer would like to achieve this by below example:
> ##########################################################
> #makedumpfile -d31 -c/-l/-p
> 
> TYPE			PAGES		INCLUDED
> 
> Zero Page		x		no
> Cache Without Private	x           	no
> Cache With Private	x		no
> User Data		x		no
> Free Page		x		no
> Kernel Code		x		yes
> Kernel Data		x		yes
> 
> Total Pages on system:			311000  (Just for example)
> Total Pages included in kdump:		160000  (Just for example)
> Estimated vmcore file size:		48000  (30% compression ratio)
> ##########################################################

Does this image mean that you want to run makedumpfile in 1st
kernel without generating a actual dumpfile ?
Unfortunately, makedumpfile can't work in 1st kernel because it
only supports /proc/vmcore as input data. 

If you don't persist in doing in 1st kernel, your desire can be
achieved by modifying print_report() and discarding a output
data to /dev/null, and running makedumpfile via kdump as usual.

> By configured dump level, total pages included in kdump can be computed.
> Then with option which specify a compression algorithm, an estimated
> vmcore file size can be given. Though the estimated value is changed
> dynamically with time, it does give user a valuable reference.

Compression ratio is very dependent on the memory usage.
So I think it's difficult to estimate the size when any compression
algorithm is specified.
 

Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
