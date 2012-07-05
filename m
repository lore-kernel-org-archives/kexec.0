Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Smek0-0007xM-CN
 for kexec@lists.infradead.org; Thu, 05 Jul 2012 05:36:39 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 404653EE0C1
 for <kexec@lists.infradead.org>; Thu,  5 Jul 2012 14:36:31 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 2A1FC45DD78
 for <kexec@lists.infradead.org>; Thu,  5 Jul 2012 14:36:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 12CAC45DD74
 for <kexec@lists.infradead.org>; Thu,  5 Jul 2012 14:36:31 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 05A061DB803A
 for <kexec@lists.infradead.org>; Thu,  5 Jul 2012 14:36:31 +0900 (JST)
Received: from m024.s.css.fujitsu.com (m024.s.css.fujitsu.com [10.0.81.64])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B84E41DB8038
 for <kexec@lists.infradead.org>; Thu,  5 Jul 2012 14:36:30 +0900 (JST)
Date: Thu, 05 Jul 2012 14:36:02 +0900 (JST)
Message-Id: <20120705.143602.535885847.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/8] makedumpfile: Add Snappy Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120705140559.fcaac5a58fa4ab9b6532734c@mxc.nes.nec.co.jp>
References: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
 <20120705140559.fcaac5a58fa4ab9b6532734c@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/8] makedumpfile: Add Snappy Compression Support
Date: Thu, 5 Jul 2012 14:05:59 +0900

> On Tue, 03 Jul 2012 12:07:27 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> 
> Thank you for your work.
> 
> I will merge your patches into the next version with small addition:
> 
> diff --git a/README b/README
> index ae986d1..638b111 100644
> --- a/README
> +++ b/README
> @@ -45,6 +45,9 @@
>    6.Build with lzo support:
>      # make USELZO=on ; make install
>      The user has to prepare lzo library.
> +  7.Build with snappy support:
> +    # make USESNAPPY=on ; make install
> +    The user has to prepare snappy library.
> 
>  * SUPPORTED KERNELS
>    This makedumpfile supports the following kernels.
> 

Thanks. I overlooked README file...

> 
> In addition, I did brief performance test with your patches:
>   - The source data is a vmcore saved on the disk, it might be sparse data.
>   - makedumpfile writes dumpfile to the same disk as the source data.
>   - execution time is average of 5 times.
> 
>                         |    source     |    zlib     |     LZO     |   snappy  
> ------------------------+---------------+-------------+-------------+-------------
>        size (byte)      | 5,107,498,116 | 242,398,239 | 309,549,499 | 487,542,710 
>   compression  ratio(%) |      ---      |     4.75    |     6.06    |    9.55
>    execution time (sec) |      ---      |      143    |     49.6    |    51.2
> 
> 
> It seems that LZO still has worth in the case that good compression ratio is expected,
> as you said in your benchmark report.
> 

Yes, this is just as I'm assuming. I think it's better to use snappy
for the machine with hundreads of gigabytes or more. For the machine
with less than that, it's still reasonable to use LZO because risk at
the worst case is small.

Also, snappy is well optimized for little endian, 64-bit
machines. Though I don't see this actually to be honest, this might
show considerably bad performance on other archs except for x86_64.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
