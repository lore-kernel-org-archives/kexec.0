Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDm9o-0003jR-KG
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 01:31:38 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2F19B3EE0AE
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:31:29 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 1896245DE6C
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:31:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 00E0045DE6B
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:31:29 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id E88E51DB802C
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:31:28 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A02361DB8038
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 10:31:28 +0900 (JST)
Date: Fri, 08 Mar 2013 10:31:22 +0900 (JST)
Message-Id: <20130308.103122.225284544.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel
 to speedup kernel dump process
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130307152108.GC2790@redhat.com>
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, hpa@zytor.com, yinghai@kernel.org, jingbai.ma@hp.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to speedup kernel dump process
Date: Thu, 7 Mar 2013 10:21:08 -0500

> On Thu, Mar 07, 2013 at 10:58:18PM +0800, Jingbai Ma wrote:
<cut>
>> 
>> 2. Scans all memory pages in makedumpfile is a very slow process. On
>> system with 1TB or more memory installed, the scanning process is very
>> long. Typically on 1TB idle system, it takes about 19 minutes. On system
>> with 4TB or more memory installed, it even doesn't work. To address the
>> out of memory issue on system with big memory (4TB or more memory
>> installed),  makedumpfile v1.5.1 introduces a new cyclic mode. It only
>> scans a piece of memory pages each time, and do it cyclically to scan
>> all memory pages. But it runs more slowly, on 1TB system, takes about 33
>> minutes.
> 
> One of the reasons it is slow because we don't support mmpa() interface.
> That means for every read, we map 4K page, flush TLB, read it, unmap it
> and flush TLB again. This is lot of processing overhead per 4K page.
> 
> Hatayama is now working on making mmap() interface and allow user space
> to bigger chunks of memory in one so. So that in one mmap() call we can
> map a bigger range instead of just 4K. And his numbers show that it
> has helped a lot.

Yes, so when are you able to get down to reviewing the patch set?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
