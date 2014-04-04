Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-qc0-x231.google.com ([2607:f8b0:400d:c01::231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WW92v-00045b-5u
 for kexec@lists.infradead.org; Fri, 04 Apr 2014 18:40:58 +0000
Received: by mail-qc0-f177.google.com with SMTP id w7so3847539qcr.8
 for <kexec@lists.infradead.org>; Fri, 04 Apr 2014 11:40:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140404111456.GD29058@dhcp-16-105.nay.redhat.com>
References: <CAGXD9OcJZGPaqy+=p7_gio_vRXVxrK73LjSjteto6iiqo2a=nA@mail.gmail.com>
 <20140404111456.GD29058@dhcp-16-105.nay.redhat.com>
Date: Fri, 4 Apr 2014 11:40:34 -0700
Message-ID: <CAGXD9OfhfSEOdjGEnUh1iKsWmC9jT50SvAMWZOeo9-3T0GXgRA@mail.gmail.com>
Subject: Re: vmcore-dmesg ends with "No program header covering vaddr"
From: Prasad Koya <prasad.koya@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org

Thanks for replying Baoquan.

Our production kernel is 3.4 and it has legacy dmesg buffer. I was
able to dump it from oldmem. If this change is of any use for
community I could try submit the patch.

On Fri, Apr 4, 2014 at 4:14 AM, Baoquan He <bhe@redhat.com> wrote:
> On 03/14/14 at 10:39pm, Prasad Koya wrote:
>> Hi
>>
>> I'm increasing dmesg buffer size at runtime by passing log_buf_len=1M
>> (or 512K) at command line. At compile time, I have LOG_BUF_LEN as
>> 256K. However, when this kernel crashes (crashkernel set at 64M),
>> vmcore-dmesg fails with below error.
>>
>> No program header covering vaddr 0xffff88013ff00000found kexec bug?
>>
>> Am I missing something here?
>>
>> Thank you.
>>
>> Here are some debugs I added to kernel. This is with 3.4 kernel and
>> I've tried with kexec-tools-2.0.4.
>>
>> [    0.000000] log_buf_len_setup: log_buf_len 262144 new 1048576
>> ffffffff8170b140
>> [    0.000000] setup_log_buf: early 1 262144 new_log_buf_len 1048576
>> [    0.000000] log_buf_len: 1048576 ffff880037d58000
>> [    0.000000] early log buf free: 258671(98%)
>> [    0.000000] setup_log_buf: early 0 1048576 new_log_buf_len 0
>> [    0.503752] log_buf_kexec_setup: lbl 1048576 new 0 ffffffff816198c4
>> logbuf ffff880037d58000
>> In kdump, running vmcore_dmesg /proc/vmcore
>> No program header covering vaddr 0xffff88013ff00000found kexec bug?
>
> Hi Prasad,
>
> Did you try the latest kernel and vmcore-dmesg? Mine is OK. Surely you
> need apply below patch since it's not merged yet.
>
> Author: Lubomir Rintel <lkundrak@v3.sk>
> Date:   Wed Sep 18 14:21:43 2013 +0200
>
>     vmcore-dmesg: Understand >= v3.11-rc4 dmesg
>
>     Symbol name changed with the following commit:
>     62e32ac printk: rename struct log to struct printk_log
>
> Thanks
> Baoquan
>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
