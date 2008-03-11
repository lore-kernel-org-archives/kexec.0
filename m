Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-dub.frontbridge.com ([213.199.154.16]
	helo=outbound6-dub-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JZ9Wq-0002d7-3O
	for kexec@lists.infradead.org; Tue, 11 Mar 2008 18:48:48 +0000
Message-ID: <47D6D406.8050209@am.sony.com>
Date: Tue, 11 Mar 2008 11:48:38 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>	
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>	
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com>
In-Reply-To: <47D6B92D.2020205@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Rajasekaran P <rajasekaran83@gmail.com>
Cc: kexec@lists.infradead.org

Geoff Levand wrote:
> Rajasekaran P wrote:
>> Hi Geoff,
>> Thanks for your information.
>> =

>> I used latest kexec tools with 2.6.23 kernel built with ps3_defconfig.
>> This kernel boots normally on PS3. But when I  add "crashkernel"
>> argument, it goes on hang.
>> =

>> # kexec --command-line=3D"video=3Dps3fb:mode:166 rhgb root=3D/dev/ps3da3
>> crashkernel=3D128M@32M" \
>> --initrd=3D/boot/initrd-2.6.23.img \
>> -l /boot/vmlinux-2.6.23
>> =

>> # taskset 1 kexec =96e
>> =

>> Nothing happens after this. As you said earlier in your mail, I am not
>> getting any PRINTK outputs from kernel on screen.
> =

> As I said, this usage is currently unsupported.  Could you tell me what y=
ou
> want to do?  I mean, why do you want to use this 'crashkernel=3D' option?
> =

> As a note, the ps3 has 128MiB of boot memory, so I guess 128M@32M won't
> work.

Just FYI, I tried this and the kernel booted:

./kexec -l -t elf-ppc64 --append=3D'crashkernel=3D64M@32M root=3D/dev/nfs r=
w ip=3Ddhcp video=3Dwuxga' /boot/vmlinux.strip

I saw this output:

kexec: waiting for cpu 1 (physical 1) to go down
Reserving 64MB of memory at 32MB for crashkernel (System RAM: 128MB)
...
Kernel command line: crashkernel=3D64M@32M root=3D/dev/nfs rw ip=3Ddhcp vid=
eo=3Dwuxga

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
