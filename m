Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UEqbB-0001ox-Of
 for kexec@lists.infradead.org; Mon, 11 Mar 2013 00:28:20 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E150D3EE0AE
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:28:06 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C871445DE52
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:28:06 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AF91445DE4D
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:28:06 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A31C11DB803A
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:28:06 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 56690E08004
 for <kexec@lists.infradead.org>; Mon, 11 Mar 2013 09:28:06 +0900 (JST)
Date: Mon, 11 Mar 2013 09:27:19 +0900 (JST)
Message-Id: <20130311.092719.142837234.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH v2 07/20] vmcore: copy non page-size aligned head and
 tail pages in 2nd kernel
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <513C2553.5050402@cn.fujitsu.com>
References: <20130302083447.31252.93914.stgit@localhost6.localdomain6>
 <20130302083627.31252.41277.stgit@localhost6.localdomain6>
 <513C2553.5050402@cn.fujitsu.com>
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
Subject: Re: [PATCH v2 07/20] vmcore: copy non page-size aligned head and tail pages in 2nd kernel
Date: Sun, 10 Mar 2013 14:16:51 +0800

> 于 2013年03月02日 16:36, HATAYAMA Daisuke 写道:
<cut>
>>  		/* Update the program header offset. */
>>  		phdr_ptr->p_offset = vmcore_off;
>> -		vmcore_off = vmcore_off + phdr_ptr->p_memsz;
>> +		vmcore_off +=roundup(end,PAGE_SIZE)-rounddown(start,PAGE_SIZE);
> 
> Here the code changes phdr_ptr->p_offset to a new page-size aligned offset.
> But it seems the phdr_ptr->p_paddr is still the non page-size aligned
> physical address? Does the mismatch of a PT_LOAD segment and the physical
> memory occur?
> 
> Or, later in makedumpfile, it will check the phdr_ptr->paddr to see if it
> is page-size aligned and also phdr_ptr->p_memsz to get the real memory size,
> not including padding?
> 

No, it doesn't happen. p_offset is made page-size aligned for
requirement to user-space linear-address vs file offset. The
requirement for physical address is handled internally in vmcore_list,
which is transparent to to user-space.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
