Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdsM-00CTpu-FO
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:35:20 +0000
Received: by mail-pg1-f199.google.com with SMTP id
 v33-20020a634821000000b002530e4cca7bso1031257pga.10
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:26 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 00/11] makedumpfile: Add zstd support for makedumpfile
Date: Fri, 10 Sep 2021 18:33:07 +0800
Message-Id: <20210910103318.292017-1-ltao@redhat.com>
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
To: kexec@lists.infradead.org
Cc: k-hagio-ab@nec.com, Tao Liu <ltao@redhat.com>

This patch set adds ZSTD compression support to makedumpfile. With ZSTD compression
support, the vmcore dump size and time consumption can have a better balance than
zlib/lzo/snappy.

How to build:

  Build using make:
    $ make USEZSTD=on
    
Performance Comparison:
      
  How to measure
  
    I took a x86_64 machine which had 4T memory, and the compression level
    range from (-3 to 4) for ZSTD, as well as zlib/lzo/snappy compression.
    All testing was done by makedumpfile single thread mode.
    
    As for compression performance testing, in order to avoid the performance 
    bottle neck of disk I/O, I used the following makedumpfile cmd, which took
    lzo compression as an example. "--dry-run" will not write any data to disk,
    "--show-stat" will output the vmcore size after compression, and the time
    consumption can be collected from the output logs.
    
    $ makedumpfile -d 0 -l /proc/kcore vmcore --dry-run --show-stat

    
    As for decompression performance testing, I only tested the (-d 31) case,
    because the vmcore size of (-d 0) case is too big to fit in the disk, in
    addtion, to read a oversized file from disk will encounter the disk I/O
    bottle neck.

    I triggered a kernel crash and collected a vmcore. Then I converted the
    vmcore into specific compression format using the following makedumpfile
    cmd, which would get a lzo format vmcore as an example:
    
    $ makedumpfile -l vmcore vmcore.lzo
    
    After all vmcores were ready, I used the following cmd to perform the
    decompression, the time consumption can be collected from the logs.
    
    $ makedumpfile -F vmcore.lzo --dry-run --show-stat

    
  Result charts
  
    For compression:

            makedumpfile -d31			|  makedumpfile -d0	
            Compression time	vmcore size	|  Compression time  vmcore size
    zstd-3  325.516446	        5285179595	|  8205.452248	     51715430204
    zstd-2  332.069432	        5319726604	|  8057.381371	     51732062793
    zstd-1  309.942773	        5730516274	|  8138.060786	     52136191571
    zstd0   439.773076	        4673859661	|  8873.059963	     50993669657
    zstd1   406.68036	        4700959521	|  8259.417132	     51036900055
    zstd2   397.195643	        4699263608	|  8230.308291	     51030410942
    zstd3   436.491632	        4673306398	|  8803.970103	     51043393637
    zstd4   543.363928	        4668419304	|  8991.240244	     51058088514
    zlib    561.217381	        8514803195      | 14381.755611	     78199283893
    lzo	    248.175953	       16696411879	|  6057.528781	     90020895741
    snappy  231.868312	       11782236674	|  5290.919894	    245661288355

    For decompression:

            makedumpfile -d31
            decompress time	   vmcore size
    zstd-3	477.543396	       5289373448
    zstd-2	478.034534	       5327454123
    zstd-1	459.066807	       5748037931
    zstd0	561.687525	       4680009013
    zstd1	547.248917	       4706358547
    zstd2	544.219758	       4704780719
    zstd3	555.726343	       4680009013
    zstd4	558.031721	       4675545933
    zlib	630.965426	       8555376229
    lzo	    	427.292107	      16849457649
    snappy	446.542806	      11841407957

  Discussion
  
    For zstd range from -3 to 4, compression level 2 (ZSTD_dfast) has
    the best time consumption and vmcore dump size balance. 
    
    For zstd2/zlib/lzo/snappy, zstd2 has the smallest vmcore size, also
    the best time consumption and vmcore dump size balance.

Tao Liu (11):
  Add dump header for zstd.
  Add command-line processing for zstd
  Add zstd build support
  Notify zstd unsupporting when disabled
  Add single thread zstd compression processing
  Add parallel threads zstd compression processing
  Add single thread zstd uncompression processing
  Add parallel threads zstd uncompression processing
  Add zstd help message
  Add zstd manual description
  Add zstd README description

 Makefile       |   5 +++
 README         |   5 ++-
 diskdump_mod.h |   1 +
 makedumpfile.8 |   7 ++--
 makedumpfile.c | 101 +++++++++++++++++++++++++++++++++++++++++++++----
 makedumpfile.h |  10 +++++
 print_info.c   |  30 ++++++++++-----
 7 files changed, 138 insertions(+), 21 deletions(-)

-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
