Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bl2nam02on0626.outbound.protection.outlook.com
 ([2a01:111:f400:fe46::626]
 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eJzGI-0007i9-32
 for kexec@lists.infradead.org; Wed, 29 Nov 2017 10:06:44 +0000
From: "Gurumurthy, Anil" <Anil.Gurumurthy@cavium.com>
Subject: RE: kdump issues with 4.11 kernel
Date: Wed, 29 Nov 2017 10:06:14 +0000
Message-ID: <BY2PR0701MB2023FFA00EC7445B005BCB498E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
References: <BY2PR0701MB202342812CFB9669B01930D98E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
 <20171129073841.GA2129@dhcp-128-65.nay.redhat.com>
 <BY2PR0701MB2023DAF450CE2EB7270E05A38E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
 <CACi5LpP9+5YVVh1DtnWXCMQbFMRJ1NVYh=_nQYcpShZS0es7hg@mail.gmail.com>
In-Reply-To: <CACi5LpP9+5YVVh1DtnWXCMQbFMRJ1NVYh=_nQYcpShZS0es7hg@mail.gmail.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Dave Young <dyoung@redhat.com>



-----Original Message-----
From: Bhupesh Sharma [mailto:bhsharma@redhat.com] 
Sent: 29 November 2017 15:16
To: Gurumurthy, Anil <Anil.Gurumurthy@cavium.com>
Cc: Dave Young <dyoung@redhat.com>; kexec@lists.infradead.org
Subject: Re: kdump issues with 4.11 kernel

Hi Anil,

On Wed, Nov 29, 2017 at 2:44 PM, Gurumurthy, Anil <Anil.Gurumurthy@cavium.com> wrote:
> Thanks. That did help getting kexec to work.
> However I still do not get a crash dump - echo c  > 
> /proc/sysrq-trigger does not get a crash dump.
>
> Any thoughts?

Cam you share the console messages you see when the crash kernel boots? Or do you see nothing after the crash is introduced via echo c
> /proc/sysrq-trigger
[Anil]  I do not see any messages after introducing the crash.

Generally, depending on your test machine arch, it is useful to use earlycon/earlyprintk to see if the crash kernel produced any useful message until the actual console device became operational.

Can you try setting the earlycon/earlyprintk settings and share the crash kernel logs messages after the same?

Thanks,
Bhupesh

> -----Original Message-----
> From: Dave Young [mailto:dyoung@redhat.com]
> Sent: 29 November 2017 13:09
> To: Gurumurthy, Anil <Anil.Gurumurthy@cavium.com>
> Cc: kexec@lists.infradead.org
> Subject: Re: kdump issues with 4.11 kernel
>
> Hi,
> On 11/29/17 at 05:29am, Gurumurthy, Anil wrote:
>> Hello,
>>   I was facing trouble getting a crash dump on 4.11 kernel. Debugging a bit, I see that the kexec run from the cmd line fails. Any ideas on what I could be missing?
>>
>> [root@localhost ~]# kexec -p /boot/vmlinuz-`uname -r` 
>> --initrd=/boot/initramfs-`uname -r`kdump.img ELF core (kcore) parse 
>> failed Cannot load /boot/vmlinuz-4.11.12+
>>
>
> Can you try below kexec-tools commit:
> commit ed15ba1b9977e506637ff1697821d97127b2c919
> Author: Pratyush Anand <panand@redhat.com>
> Date:   Wed Mar 1 11:19:42 2017 +0530
>
>     build_mem_phdrs(): check if p_paddr is invalid
>
> Thanks
> Dave
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
