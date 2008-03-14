Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1Ja7g1-0000dX-La
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 11:02:18 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2EB2Hrf028220
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 07:02:17 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2EB2HpB249196
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 07:02:17 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2EB2Gff011270
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 07:02:16 -0400
Date: Fri, 14 Mar 2008 16:32:12 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
Message-ID: <20080314110212.GA9643@in.ibm.com>
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
	<4574cb3d0803140336g59236cf2w7e14405b2dc795a5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4574cb3d0803140336g59236cf2w7e14405b2dc795a5@mail.gmail.com>
Reply-To: mohan@in.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Rajasekaran P <rajasekaran83@gmail.com>
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>

On Fri, Mar 14, 2008 at 03:36:58AM -0700, Rajasekaran P wrote:
> On Tue, Mar 11, 2008 at 11:48 AM, Geoff Levand <geoffrey.levand@am.sony.com>
> wrote:
> 
> Initially I made mistake by referring /proc/meminfo and thought the total
> RAM was > 200M iB (actually it shows around 211MiB in /proc/meminfo
> excluding swap space). But actual available memory is 128MiB only. Thats why
> reserving 128MiB on 32MiB failed and kernel was not booting up.
> 
> Now "crashkernel" argument works properly for 64MB@64MB and kernel reserves
> 64MB for crash dump capture kernel.

In PPC64, crashkernel base address is hard coded i.e it is always loaded
at 32MB, even though you have passed 64MB@64MB. Did you get any warning
message like crashkernel reserved at 32MB?

> 
> This memory is reserved for "dump capture kernel" which will be loaded later
> by using kexec. Please refer linux_src/Documentation/kdump/kdump.txt for
> more information.
> 
> I tried to load dump capture configured kernel and facing similar kind of
> problem. After successful loading, Dump capture kernel is NOT BOOTING UP
> upon kernel crash.

Do you get any message from the dump capture kernel? How do you trigger
the dump?

> I used the following command to load:
> 
> # kexec -t elf-ppc64 --append="video=ps3fb:mode:166 rhgb root=/dev/ps3da3
> single maxcpus=1 noirqdistrib" \
>  --initrd=/boot/initrd-2.6.23-kdump.img \
>  -p vmlinux.strip.kdump

	^^ Is this kernel compiled with CRASH_DUMP enabled? If yes, it
should build the kernel for 32MB.

> *
> Output:*
> *setup_memory_ranges memory_range[0] start:585001, end:8000000
> get memory ranges:1
> setup_memory_ranges memory_range[0] start:585001, end:8000000
> Modified cmdline:video=ps3fb:mode:166 rhgb root=/dev/ps3da3 single maxcpus=1
> noirqdistrib elfcorehdr=71068K savemaxmem=64M
> segment[0].mem:0x4000000 memsz:5599232

			^^ Says the vmlinux is loaded at 64MB
> segment[1].mem:0x4557000 memsz:65536
> segment[2].mem:0x4567000 memsz:4096
> segment[3].mem:0x4568000 memsz:36864
> segment[4].mem:0x4571000 memsz:3469312
> segment[5].mem:0x7fff000 memsz:4096
> *
> One more thing I confirmed was, this same dump capture kernel boots up
> properly when I load it on normal mode (kexec -l and then kexec -e). I am
> having no clue on this..

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
