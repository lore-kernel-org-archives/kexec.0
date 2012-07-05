Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SmeIL-0006Py-IX
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 05:08:04 +0000
Date: Thu, 5 Jul 2012 14:05:59 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/8] makedumpfile: Add Snappy Compression Support
Message-Id: <20120705140559.fcaac5a58fa4ab9b6532734c@mxc.nes.nec.co.jp>
In-Reply-To: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
References: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hello HATAYAMA-san,

On Tue, 03 Jul 2012 12:07:27 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> This patch series add snappy compression support, applied on top of
> v1.4.4. snappy is fast compressoin algorhythm like lzo, but it's more
> optimized than lzo on x86 machines and some others.
> 
> A lot of benchmark is available on the web. Here I only point at my
> benchmark I posted a few weeks ago,
> 
> - http://lists.infradead.org/pipermail/kexec/2012-June/006425.html
> 
>   where snappy shows mostly as good performance as simple copying on
>   the worst case that input data increases its data size during
>   compression; this means we can use snappy with mostly NO risk.
> 
> How to get snappy libraries:
> 
>   1) Use yum framework to get snappy and snappy-devel packages, or
> 
>   2) Visit official website: http://code.google.com/p/snappy/,
>     download snappy-<version>.tar.gz and then build it.
> 
> How to build makedumpfile with snappy support:
> 
>   Do make as follows:
> 
>   $ make USESNAPPY=on

Thank you for your work.

I will merge your patches into the next version with small addition:

diff --git a/README b/README
index ae986d1..638b111 100644
--- a/README
+++ b/README
@@ -45,6 +45,9 @@
   6.Build with lzo support:
     # make USELZO=on ; make install
     The user has to prepare lzo library.
+  7.Build with snappy support:
+    # make USESNAPPY=on ; make install
+    The user has to prepare snappy library.

 * SUPPORTED KERNELS
   This makedumpfile supports the following kernels.


In addition, I did brief performance test with your patches:
  - The source data is a vmcore saved on the disk, it might be sparse data.
  - makedumpfile writes dumpfile to the same disk as the source data.
  - execution time is average of 5 times.

                        |    source     |    zlib     |     LZO     |   snappy  
------------------------+---------------+-------------+-------------+-------------
       size (byte)      | 5,107,498,116 | 242,398,239 | 309,549,499 | 487,542,710 
  compression  ratio(%) |      ---      |     4.75    |     6.06    |    9.55
   execution time (sec) |      ---      |      143    |     49.6    |    51.2


It seems that LZO still has worth in the case that good compression ratio is expected,
as you said in your benchmark report.


Thanks
Atsushi Kumagai

> ---
> 
> HATAYAMA Daisuke (8):
>       Add manual description
>       Add help message
>       Add uncompression processing
>       Add compression processing
>       Notify snappy unsupporting when disabled
>       Add snappy build support
>       Add command-line processing for snappy
>       Add dump header for snappy
> 
> 
>  Makefile       |    5 +++++
>  diskdump_mod.h |    2 ++
>  makedumpfile.8 |    9 +++++---
>  makedumpfile.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>  makedumpfile.h |    3 +++
>  print_info.c   |   16 ++++++++++-----
>  6 files changed, 80 insertions(+), 15 deletions(-)
> 
> -- 
> 
> Thanks.
> HATAYAMA, Daisuke

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
