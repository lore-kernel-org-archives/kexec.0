Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eJwxa-0001hf-Ep
 for kexec@lists.infradead.org; Wed, 29 Nov 2017 07:39:16 +0000
Date: Wed, 29 Nov 2017 15:38:41 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kdump issues with 4.11 kernel
Message-ID: <20171129073841.GA2129@dhcp-128-65.nay.redhat.com>
References: <BY2PR0701MB202342812CFB9669B01930D98E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY2PR0701MB202342812CFB9669B01930D98E3B0@BY2PR0701MB2023.namprd07.prod.outlook.com>
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
To: "Gurumurthy, Anil" <Anil.Gurumurthy@cavium.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,
On 11/29/17 at 05:29am, Gurumurthy, Anil wrote:
> Hello,
> =A0 I was facing trouble getting a crash dump on 4.11 kernel. Debugging a=
 bit, I see that the kexec run from the cmd line fails. Any ideas on what I=
 could be missing?
> =

> [root@localhost ~]# kexec -p /boot/vmlinuz-`uname -r` --initrd=3D/boot/in=
itramfs-`uname -r`kdump.img
> ELF core (kcore) parse failed
> Cannot load /boot/vmlinuz-4.11.12+
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
