Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr1410047.outbound.protection.outlook.com
 ([40.107.141.47] helo=JPN01-OS2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR3ek-00CwI3-U6
 for kexec@lists.infradead.org; Fri, 17 Sep 2021 02:31:17 +0000
From: =?utf-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?=
 <k-hagio-ab@nec.com>
Subject: RE: [PATCH 00/11] makedumpfile: Add zstd support for makedumpfile
Date: Fri, 17 Sep 2021 02:31:11 +0000
Message-ID: <TYYPR01MB6777BCF88306C1D2D092E0C8DDDD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
References: <20210910103318.292017-1-ltao@redhat.com>
 <TYYPR01MB677786B29FF77911EE5E06F2DDDA9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
 <YUBeQta7k03HU6qL@localhost.localdomain>
 <TYYPR01MB67774235656CC28211067CF6DDDD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB67774235656CC28211067CF6DDDD9@TYYPR01MB6777.jpnprd01.prod.outlook.com>
Content-Language: ja-JP
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
To: Tao Liu <ltao@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

-----Original Message-----
> > > > This patch set adds ZSTD compression support to makedumpfile. With ZSTD compression
> > > > support, the vmcore dump size and time consumption can have a better balance than
> > > > zlib/lzo/snappy.
> > > >
> > > > How to build:
> > > >
> > > >   Build using make:
> > > >     $ make USEZSTD=on
> > > >
> > > > Performance Comparison:
> > > >
> > > >   How to measure
> > > >
> > > >     I took a x86_64 machine which had 4T memory, and the compression level
> > > >     range from (-3 to 4) for ZSTD, as well as zlib/lzo/snappy compression.
> > > >     All testing was done by makedumpfile single thread mode.
> > > >
> > > >     As for compression performance testing, in order to avoid the performance
> > > >     bottle neck of disk I/O, I used the following makedumpfile cmd, which took
> > > >     lzo compression as an example. "--dry-run" will not write any data to disk,
> > > >     "--show-stat" will output the vmcore size after compression, and the time
> > > >     consumption can be collected from the output logs.
> > > >
> > > >     $ makedumpfile -d 0 -l /proc/kcore vmcore --dry-run --show-stat
> > > >
> > > >
> > > >     As for decompression performance testing, I only tested the (-d 31) case,
> > > >     because the vmcore size of (-d 0) case is too big to fit in the disk, in
> > > >     addtion, to read a oversized file from disk will encounter the disk I/O
> > > >     bottle neck.
> > > >
> > > >     I triggered a kernel crash and collected a vmcore. Then I converted the
> > > >     vmcore into specific compression format using the following makedumpfile
> > > >     cmd, which would get a lzo format vmcore as an example:
> > > >
> > > >     $ makedumpfile -l vmcore vmcore.lzo
> > > >
> > > >     After all vmcores were ready, I used the following cmd to perform the
> > > >     decompression, the time consumption can be collected from the logs.
> > > >
> > > >     $ makedumpfile -F vmcore.lzo --dry-run --show-stat
> > > >
> > > >
> > > >   Result charts
> > > >
> > > >     For compression:
> > > >
> > > >             makedumpfile -d31			|  makedumpfile -d0
> > > >             Compression time	vmcore size	|  Compression time  vmcore size
> > > >     zstd-3  325.516446	        5285179595	|  8205.452248	     51715430204
> > > >     zstd-2  332.069432	        5319726604	|  8057.381371	     51732062793
> > > >     zstd-1  309.942773	        5730516274	|  8138.060786	     52136191571
> > > >     zstd0   439.773076	        4673859661	|  8873.059963	     50993669657
> > > >     zstd1   406.68036	        4700959521	|  8259.417132	     51036900055
> > > >     zstd2   397.195643	        4699263608	|  8230.308291	     51030410942
> > > >     zstd3   436.491632	        4673306398	|  8803.970103	     51043393637
> > > >     zstd4   543.363928	        4668419304	|  8991.240244	     51058088514
> > > >     zlib    561.217381	        8514803195      | 14381.755611	     78199283893
> > > >     lzo	    248.175953	       16696411879	|  6057.528781	     90020895741
> > > >     snappy  231.868312	       11782236674	|  5290.919894	    245661288355
> > > >
> > > >     For decompression:
> > > >
> > > >             makedumpfile -d31
> > > >             decompress time	   vmcore size
> > > >     zstd-3	477.543396	       5289373448
> > > >     zstd-2	478.034534	       5327454123
> > > >     zstd-1	459.066807	       5748037931
> > > >     zstd0	561.687525	       4680009013
> > > >     zstd1	547.248917	       4706358547
> > > >     zstd2	544.219758	       4704780719
> > > >     zstd3	555.726343	       4680009013
> > > >     zstd4	558.031721	       4675545933
> > > >     zlib	630.965426	       8555376229
> > > >     lzo	    	427.292107	      16849457649
> > > >     snappy	446.542806	      11841407957
> > > >
> > > >   Discussion
> > > >
> > > >     For zstd range from -3 to 4, compression level 2 (ZSTD_dfast) has
> > > >     the best time consumption and vmcore dump size balance.
> > >
> > > Do you have a result of -d 1 compression test?  I think -d 0 is not
> > > practical, I would like to see a -d 1 result of such a large vmcore.
> > >
> >
> > No, I haven't tested the -d 1 case. I have returned the machine which used
> > for performance testing, I will borrow and test on it again, please wait for
> > a while...
> 
> Thanks, it would be helpful.
> 
> >
> > > And just out of curiosity, what version of zstd are you using?
> > > When I tested zstd last time, compression level 1 was faster than 2, iirc.
> > >
> >
> > The OS running on the machine is fedora34, I used its default zstd package, whose
> > version is v1.4.9.
> 
> Thanks for the info.
> 
> >
> > > btw, ZSTD_dfast is an enum of ZSTD_strategy, not for compression level?
> >
> > Yes, it's enum of ZSTD_strategy [1].
> 
> ok, so it'll have to be replaced with "2" to avoid confusion.
> 
> >
> > [1]: https://zstd.docsforge.com/dev/api-documentation/#advanced-compression-api-requires-v140
> >
> > Thanks,
> > Tao Liu
> >
> > > (no need to update for now, I will review later)
> 
> The series almost looks good to me (though I will merge those into a patch),
> just two questions are:
> - whether 2 is the best balanced compression level,

> - how much ZSTD_decompressDCtx() is faster than the current ZSTD_decompress().

Looking at this further, we will need some effort to use it especially with
threads and decompression is not the main usage (it's only for refiltering),
so please ignore this for now.  We can improve it later if it's very faster.

Thanks,
Kazu

> 
> I'll evaluate these, but it would be helpful if you could do some, too.
> 
> I think that compression time and ratio will vary with the data, it'll be
> better to use some real data, I'm looking for it.. kernel source or something.
> 
> Thanks,
> Kazu
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
