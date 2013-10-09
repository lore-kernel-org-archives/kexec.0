Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VTqnu-0006UC-Ey
 for kexec@lists.infradead.org; Wed, 09 Oct 2013 10:15:43 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6DABB3EE1D6
 for <kexec@lists.infradead.org>; Wed,  9 Oct 2013 19:15:13 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4303545DE60
 for <kexec@lists.infradead.org>; Wed,  9 Oct 2013 19:15:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 204AA45DE6F
 for <kexec@lists.infradead.org>; Wed,  9 Oct 2013 19:15:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 119781DB8051
 for <kexec@lists.infradead.org>; Wed,  9 Oct 2013 19:15:13 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B60421DB804D
 for <kexec@lists.infradead.org>; Wed,  9 Oct 2013 19:15:12 +0900 (JST)
Message-ID: <52552C9F.2030404@jp.fujitsu.com>
Date: Wed, 09 Oct 2013 19:14:55 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: mmap for /proc/vmcore broken since 3.12-rc1
References: <20131002140356.63706540@holzheu>	<524D0ADF.2010507@jp.fujitsu.com>	<52521FA5.3040101@jp.fujitsu.com>
 <CACVxJT8S7kA92=80DWVmVJJvbnaQ6WkyvsiFq4wP37WHV=tfuA@mail.gmail.com>
In-Reply-To: <CACVxJT8S7kA92=80DWVmVJJvbnaQ6WkyvsiFq4wP37WHV=tfuA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: kexec@lists.infradead.org, Linux Kernel <linux-kernel@vger.kernel.org>, Jan Willeke <willeke@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>

Hello,

(2013/10/08 21:49), Alexey Dobriyan wrote:
> On Mon, Oct 7, 2013 at 5:42 AM, HATAYAMA Daisuke
> <d.hatayama@jp.fujitsu.com> wrote:
>
>> +static unsigned long
>> +get_unmapped_area_vmcore(struct file *filp, unsigned long addr,
>> +                        unsigned long len, unsigned long pgoff,
>> +                        unsigned long flags)
>> +{
>> +#ifdef CONFIG_MMU
>> +       return current->mm->get_unmapped_area(filp, addr, len, pgoff,
>> flags);
>> +#else
>> +       return -EIO;
>> +#endif
>> +}
>> +
>>   static const struct file_operations proc_vmcore_operations = {
>>          .read           = read_vmcore,
>>          .llseek         = default_llseek,
>>          .mmap           = mmap_vmcore,
>> +       .get_unmapped_area = get_unmapped_area_vmcore,
>
> I think current->mm->get_unmapped_area should be used by core proc code.

What do you actually suggest here? You mean moving this code in proc code?
I don't think you suggest so.

> ENOMEM bug looks unrelated though.
>

Next step I'll do is to look into vm_unmapped_region() that looks for
for a region fit to a given mmap request and returns its address.
In particular, I'll focus on when vm_unmapped_region() could return
kernel-space address.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
