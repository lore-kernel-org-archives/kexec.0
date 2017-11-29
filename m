Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-co1nam03on0061.outbound.protection.outlook.com
 ([104.47.40.61] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eJySO-00045L-Uk
 for kexec@lists.infradead.org; Wed, 29 Nov 2017 09:15:11 +0000
From: "Gurumurthy, Anil" <Anil.Gurumurthy@cavium.com>
Subject: RE: kdump issues with 4.11 kernel
Date: Wed, 29 Nov 2017 09:14:42 +0000
Message-ID: <BY2PR0701MB2023DAF450CE2EB7270E05A38E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
References: <BY2PR0701MB202342812CFB9669B01930D98E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
 <20171129073841.GA2129@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20171129073841.GA2129@dhcp-128-65.nay.redhat.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Thanks. That did help getting kexec to work.
However I still do not get a crash dump - =

echo c  > /proc/sysrq-trigger does not get a crash dump.

Any thoughts?

Thanks,
Anil

-----Original Message-----
From: Dave Young [mailto:dyoung@redhat.com] =

Sent: 29 November 2017 13:09
To: Gurumurthy, Anil <Anil.Gurumurthy@cavium.com>
Cc: kexec@lists.infradead.org
Subject: Re: kdump issues with 4.11 kernel

Hi,
On 11/29/17 at 05:29am, Gurumurthy, Anil wrote:
> Hello,
> =A0 I was facing trouble getting a crash dump on 4.11 kernel. Debugging a=
 bit, I see that the kexec run from the cmd line fails. Any ideas on what I=
 could be missing?
> =

> [root@localhost ~]# kexec -p /boot/vmlinuz-`uname -r` =

> --initrd=3D/boot/initramfs-`uname -r`kdump.img ELF core (kcore) parse =

> failed Cannot load /boot/vmlinuz-4.11.12+
> =


Can you try below kexec-tools commit:
commit ed15ba1b9977e506637ff1697821d97127b2c919
Author: Pratyush Anand <panand@redhat.com>
Date:   Wed Mar 1 11:19:42 2017 +0530

    build_mem_phdrs(): check if p_paddr is invalid

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
