Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TsxK1-00077K-Uh
 for kexec@lists.infradead.org; Wed, 09 Jan 2013 15:12:08 +0000
Date: Thu, 10 Jan 2013 00:09:54 +0900 (JST)
Message-Id: <20130110.000954.305449175.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130107133935.GA1207@sgi.com>
References: <E1TbGZV-0008DR-Tb@eag09.americas.sgi.com>
 <20130107133935.GA1207@sgi.com>
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
To: cpw@sgi.com
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp, lisa.mitchell@hp.com

From: Cliff Wickman <cpw@sgi.com>
Subject: Re: [PATCH v2] makedumpfile: request the kernel do page scans
Date: Mon, 7 Jan 2013 07:39:35 -0600

> An update on testing thise patches:
> 
>> This version of the patch improves the consolidation of the mem_map table
>> that is passed to the kernel.  See make_kernel_mmap().
>> Particularly the seemingly duplicate pfn ranges generated on an older
>> (2.6.32-based, rhel6) kernel.
> 
> 
> On a 2TB machine (idle) machine:
>   the crash kernel ran successfully in 512M
>   the scan for unnecessary pages takes about 40 seconds
>   it was a single scan, not cyclic
>   
> On a 16TB machine (idle) machine:
>   the crash kernel ran successfully in 512M
>   there is a pause of about 4 minutes during makedumpfile initialization
>   the scan for unnecessary pages takes about 4.8 minutes
>   it was a single scan, not cyclic
> 

I wonder why this didn't result in OOM on 16TB. Was that really done
in non-cyclic mode? Could you show me a log of makedumpfile? You can
create it by passing --message-level 31.

Also, to consider how to resolve this performance issue, this test is
not enough. We also need to benchmark that *without filtering in
kernel-space* but with making page tables, not using ioremap. As I
said before, I think the bad performance is caused by too many calls
of ioremap/iounmap. We then need to comapre two results of these
benchmarks.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
