Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VVaE2-0004CW-GE
 for kexec@lists.infradead.org; Mon, 14 Oct 2013 04:57:51 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 286453EE0B6
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 13:57:22 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1AB1045DE55
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 13:57:22 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id EEDCC45DE54
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 13:57:21 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DF814E08001
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 13:57:21 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 86CC21DB804B
 for <kexec@lists.infradead.org>; Mon, 14 Oct 2013 13:57:21 +0900 (JST)
Message-ID: <525B7898.6010802@jp.fujitsu.com>
Date: Mon, 14 Oct 2013 13:52:40 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: mmap for /proc/vmcore broken since 3.12-rc1
References: <20131002140356.63706540@holzheu>
 <524D0ADF.2010507@jp.fujitsu.com> <52521FA5.3040101@jp.fujitsu.com>
 <CACVxJT8S7kA92=80DWVmVJJvbnaQ6WkyvsiFq4wP37WHV=tfuA@mail.gmail.com>
 <52552C9F.2030404@jp.fujitsu.com> <20131012203250.GA3458@p183.telecom.by>
In-Reply-To: <20131012203250.GA3458@p183.telecom.by>
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

(2013/10/13 5:32), Alexey Dobriyan wrote:
> On Wed, Oct 09, 2013 at 07:14:55PM +0900, HATAYAMA Daisuke wrote:
>> Hello,
>>
>> (2013/10/08 21:49), Alexey Dobriyan wrote:
>>> On Mon, Oct 7, 2013 at 5:42 AM, HATAYAMA Daisuke
>>> <d.hatayama@jp.fujitsu.com> wrote:
>>>
>>>> +static unsigned long
>>>> +get_unmapped_area_vmcore(struct file *filp, unsigned long addr,
>>>> +                        unsigned long len, unsigned long pgoff,
>>>> +                        unsigned long flags)
>>>> +{
>>>> +#ifdef CONFIG_MMU
>>>> +       return current->mm->get_unmapped_area(filp, addr, len, pgoff,
>>>> flags);
>>>> +#else
>>>> +       return -EIO;
>>>> +#endif
>>>> +}
>>>> +
>>>>    static const struct file_operations proc_vmcore_operations = {
>>>>           .read           = read_vmcore,
>>>>           .llseek         = default_llseek,
>>>>           .mmap           = mmap_vmcore,
>>>> +       .get_unmapped_area = get_unmapped_area_vmcore,
>>>
>>> I think current->mm->get_unmapped_area should be used by core proc code.
>>
>> What do you actually suggest here? You mean moving this code in proc code?
>> I don't think you suggest so.
>
> Please, try this patch, I don't have kexec setup handy.
>
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -291,7 +291,11 @@ static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long
>   	int rv = -EIO;
>   	unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
>   	if (use_pde(pde)) {
> -		get_unmapped_area = pde->proc_fops->get_unmapped_area;
> +		get_unmapped_area = current->mm->get_unmapped_area;
> +#ifdef CONFIG_MMU
> +		if (pde->proc_fops->get_unmapped_area)
> +			get_unmapped_area = pde->proc_fops->get_unmapped_area;
> +#endif
>   		if (get_unmapped_area)
>   			rv = get_unmapped_area(file, orig_addr, len, pgoff, flags);
>   		unuse_pde(pde);
>

Slight modification to #ifdef ...

get_unmapped_area = NULL;
#ifdef CONFIG_MMU
get_unmapped_area = current->mm->get_unmapped_area
#endif
if (pde->proc_fops->get_unmapped_area)
   get_unmapped_area = pde->proc_fops->get_unmapped_area;

And, I found the bug. The variable rv should have been defined as unsigned
long. sizeof(int) is 4 bytes but sizeof(long) is 8 bytes at least on x86_64.

The reason why returned value looked like kernel virtual address was due to
signed extension performed during conversion from negative 32-bit signed
integer to 64-bit unsigned long integer.

Hmm, I first checked signature of related functions but overlooked...

Anyway, I'll post fixing patch soon.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
