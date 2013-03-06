Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDARB-0005FE-A2
 for kexec@lists.infradead.org; Wed, 06 Mar 2013 09:15:06 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id AC1EA3EE0BC
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 18:14:59 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 947A245DEB7
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 18:14:59 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7924345DEB5
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 18:14:59 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6E3321DB803E
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 18:14:59 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 251DD1DB8038
 for <kexec@lists.infradead.org>; Wed,  6 Mar 2013 18:14:59 +0900 (JST)
Date: Wed, 06 Mar 2013 18:14:57 +0900 (JST)
Message-Id: <20130306.181457.101447189.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 04/20] vmcore: allocate buffer for ELF headers on
 page-size alignment
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <5136E8EE.6080301@cn.fujitsu.com>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083610.31252.18601.stgit@localhost6.localdomain6>
 <5136E8EE.6080301@cn.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: zhangyanfei@cn.fujitsu.com
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Subject: Re: [PATCH v2 04/20] vmcore: allocate buffer for ELF headers on page-size alignment
Date: Wed, 6 Mar 2013 14:57:50 +0800

> 于 2013年03月02日 16:36, HATAYAMA Daisuke 写道:
>> Allocate buffer for ELF headers on page-size aligned boudary to
>> satisfy mmap() requirement. For this, __get_free_pages() is used
>> instead of kmalloc().
>> 
>> Also, later patch will decrease actually used buffer size for ELF
>> headers, so it's necessary to keep original buffer size and actually
>> used buffer size separately. elfcorebuf_sz_orig keeps the original one
>> and elfcorebuf_sz the actually used one.
>> 
>> Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
>> ---
>> 
>>  fs/proc/vmcore.c |   30 +++++++++++++++++++++---------
>>  1 files changed, 21 insertions(+), 9 deletions(-)
>> 

....

>> @@ -665,26 +671,31 @@ static int __init parse_crash_elf32_headers(void)
>>  
>>  	/* Read in all elf headers. */
>>  	elfcorebuf_sz = ehdr.e_phoff + ehdr.e_phnum * sizeof(Elf32_Phdr);
>> -	elfcorebuf = kmalloc(elfcorebuf_sz, GFP_KERNEL);
>> +	elfcorebuf_sz_orig = elfcorebuf_sz;
>> +	elfcorebuf = (void *) __get_free_pages(GFP_KERNEL | __GFP_ZERO,
>> +					       get_order(elfcorebuf_sz));
> 
> Why not elfcorebuf_sz_orig here?
> 

Thanks. I'll fix this.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
