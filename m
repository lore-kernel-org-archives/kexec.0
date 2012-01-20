Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f49.google.com ([209.85.213.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ro2NQ-0006rm-Pi
 for kexec@lists.infradead.org; Fri, 20 Jan 2012 00:30:45 +0000
Received: by yhjj72 with SMTP id j72so11333yhj.36
 for <kexec@lists.infradead.org>; Thu, 19 Jan 2012 16:30:43 -0800 (PST)
Message-ID: <4F18B5AF.3040107@gmail.com>
Date: Thu, 19 Jan 2012 16:30:39 -0800
From: Jay Lan <jay.zen.lan@gmail.com>
MIME-Version: 1.0
Subject: Re: kdump kernel tried to load modules not included in the kdump
 initrd?
References: <4F17CA71.6040405@gmail.com> <jf924s$rn1$1@dough.gmane.org>
In-Reply-To: <jf924s$rn1$1@dough.gmane.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi Cong,

Thanks for your reply. It is good to know about lsinitrd. :)

I noticed that I ran out of memory during booting of 2nd kernel.
After I increased the crashkernel=xxx to 512M, it worked
correctly. Maybe OOM killed some processes and
things got confused... Anyway, it works now.

Thanks,
Jay


On 01/19/2012 04:26 AM, Cong Wang wrote:
> On Thu, 19 Jan 2012 at 07:46 GMT, Jay Lan<jay.zen.lan@gmail.com>  wrote:
>> Hi,
>>
> Hi, Jay,
>
> This mailing list is not proper for reporting problems of distro's
> mkdumprd, please file a bug in bugzilla of centos.
>
>> I have a 2.6.32-131.6.1.el6 kernel, and kexec-tools-2.0.0-145.el6.x86_64
>> rpm on a cent6 machine.
>>
>> When i forced a kdump by 'echo c>  /proc/sysrq-trigger',
>> the kdump kernel panicked during the boot. Surprisingly,
>> it tried to load lustre modules that should not be part of
>> the initrd and panicked!
>>
>> The syslog showed the --initrd specified a kdump.img
>> when kdump was started. I dumped out the kdump.img
>> (with zcat) and verified that no lustre module was included
>> in the initrd image.
> lsinitrd can do that too.
>
>> So, how did this have happened?
>>
> Odd, el6 mkdumprd picks all modules listed by lsmod in your *first
> kernel*, so it is not surprised mkdumprd picks it. But if it is not
> picked into kdump initrd, it is almost impossible that it will be
> loaded in the second kernel.
>
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
