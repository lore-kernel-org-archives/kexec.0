Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hbENb-0006Ic-PA
 for kexec@lists.infradead.org; Thu, 13 Jun 2019 01:18:17 +0000
Date: Thu, 13 Jun 2019 09:18:04 +0800
From: "dyoung@redhat.com" <dyoung@redhat.com>
Subject: Re: [PATCH 0/3 v11] add reserved e820 ranges to the kdump kernel
 e820 table
Message-ID: <20190613011804.GA27786@dhcp-128-65.nay.redhat.com>
References: <20190608035451.GB26148@MiWiFi-R3L-srv>
 <20190608091030.GB32464@zn.tnic>
 <20190608100139.GC26148@MiWiFi-R3L-srv>
 <20190608100623.GA9138@zn.tnic>
 <20190608102659.GA9130@MiWiFi-R3L-srv>
 <20190610113747.GD5488@zn.tnic>
 <20190612015549.GI26148@MiWiFi-R3L-srv>
 <20190612151033.GJ32652@zn.tnic>
 <3dfa5985-008a-20d8-5171-cfe96807c303@amd.com>
 <20190612180724.GP32652@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190612180724.GP32652@zn.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "x86@kernel.org" <x86@kernel.org>, lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "luto@kernel.org" <luto@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On 06/12/19 at 08:07pm, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 04:52:22PM +0000, Lendacky, Thomas wrote:
> > I think the discussion ended up being that debuginfo wasn't being stripped
> > from the kernel and initrd (mainly the initrd).  What are the sizes of
> > the kernel and initrd that you are loading for kdump via kexec?
> > 
> > From previous post:
> >   kexec -s -p /boot/vmlinuz-5.2.0-rc3+ --initrd=/boot/initrd.img-5.2.0-rc3+
> 
> You mean those sizes?
> 
> $ ls -lh /boot/vmlinuz-5.2.0-rc3+ /boot/initrd.img-5.2.0-rc3+
> -rw-r--r-- 1 root root 7.8M Jun 10 12:53 /boot/initrd.img-5.2.0-rc3+
> -rw-r--r-- 1 root root 6.7M Jun 10 12:53 /boot/vmlinuz-5.2.0-rc3+
> 
> That should fit easily in 256M :)

The final used size is uncompressed size, for example in my case:

$ ls -lth arch/x86/boot/bzImage 
-rw-rw-r-- 1 dyoung dyoung 6.3M May 24 11:19 arch/x86/boot/bzImage
$ ls -lth arch/x86/boot/compressed/vmlinux.bin
-rwxrwxr-x 1 dyoung dyoung 25M May 24 11:19 arch/x86/boot/compressed/vmlinux.bin

The vmlinuz is 6.3M, uncompressed kernel is about 25M, since yours
bzImage is 7.8M, I would expect the final size is around 29M

for initramfs, you can check it by:

$ ls -lth /boot/initramfs-5.0.9-301.fc30.x86_64kdump.img
-rw------- 1 root root 16M May 28 08:59 /boot/initramfs-5.0.9-301.fc30.x86_64kdump.img
$ mkdir tmp
$ cd tmp
$ sudo lsinitrd --unpack /boot/initramfs-5.0.9-301.fc30.x86_64kdump.img
$ du -hs .
46M	.

You can see my kdump initrd is 46M after unpacking.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
