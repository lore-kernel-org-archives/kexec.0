Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qb-out-0506.google.com ([72.14.204.237])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ja7WF-00028o-00
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 10:52:11 +0000
Received: by qb-out-0506.google.com with SMTP id e6so3345058qbe.2
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 03:52:10 -0700 (PDT)
Message-ID: <4574cb3d0803140336g59236cf2w7e14405b2dc795a5@mail.gmail.com>
Date: Fri, 14 Mar 2008 03:36:58 -0700
From: "Rajasekaran P" <rajasekaran83@gmail.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
In-Reply-To: <47D6D406.8050209@am.sony.com>
MIME-Version: 1.0
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1553863718=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: mohan@in.ibm.com, kexec@lists.infradead.org

--===============1553863718==
Content-Type: multipart/alternative; 
	boundary="----=_Part_661_14247566.1205491018131"

------=_Part_661_14247566.1205491018131
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, Mar 11, 2008 at 11:48 AM, Geoff Levand <geoffrey.levand@am.sony.com>
wrote:

> Geoff Levand wrote:
>
>
> Just FYI, I tried this and the kernel booted:
>
> ./kexec -l -t elf-ppc64 --append='crashkernel=64M@32M root=/dev/nfs rw
> ip=dhcp video=wuxga' /boot/vmlinux.strip
>
> I saw this output:
>
> kexec: waiting for cpu 1 (physical 1) to go down
> Reserving 64MB of memory at 32MB for crashkernel (System RAM: 128MB)
> ...
> Kernel command line: crashkernel=64M@32M root=/dev/nfs rw ip=dhcp
> video=wuxga
>
> -Geoff
>
> This works properly. Thanks Geoff.

Initially I made mistake by referring /proc/meminfo and thought the total
RAM was > 200M iB (actually it shows around 211MiB in /proc/meminfo
excluding swap space). But actual available memory is 128MiB only. Thats why
reserving 128MiB on 32MiB failed and kernel was not booting up.

Now "crashkernel" argument works properly for 64MB@64MB and kernel reserves
64MB for crash dump capture kernel.

This memory is reserved for "dump capture kernel" which will be loaded later
by using kexec. Please refer linux_src/Documentation/kdump/kdump.txt for
more information.

I tried to load dump capture configured kernel and facing similar kind of
problem. After successful loading, Dump capture kernel is NOT BOOTING UP
upon kernel crash.
I used the following command to load:

# kexec -t elf-ppc64 --append="video=ps3fb:mode:166 rhgb root=/dev/ps3da3
single maxcpus=1 noirqdistrib" \
 --initrd=/boot/initrd-2.6.23-kdump.img \
 -p vmlinux.strip.kdump
*
Output:*
*setup_memory_ranges memory_range[0] start:585001, end:8000000
get memory ranges:1
setup_memory_ranges memory_range[0] start:585001, end:8000000
Modified cmdline:video=ps3fb:mode:166 rhgb root=/dev/ps3da3 single maxcpus=1
noirqdistrib elfcorehdr=71068K savemaxmem=64M
segment[0].mem:0x4000000 memsz:5599232
segment[1].mem:0x4557000 memsz:65536
segment[2].mem:0x4567000 memsz:4096
segment[3].mem:0x4568000 memsz:36864
segment[4].mem:0x4571000 memsz:3469312
segment[5].mem:0x7fff000 memsz:4096
*
One more thing I confirmed was, this same dump capture kernel boots up
properly when I load it on normal mode (kexec -l and then kexec -e). I am
having no clue on this..

If anybody know how to debug a kernel failure during boot up, it will be
very helpful. Please help.

Thanks in advance,
Rajasekaran.P

------=_Part_661_14247566.1205491018131
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><div class="gmail_quote">On Tue, Mar 11, 2008 at 11:48 AM, Geoff Levand &lt;<a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c">Geoff Levand wrote:<br><br>
<br>
</div></div>Just FYI, I tried this and the kernel booted:<br>
<br>
./kexec -l -t elf-ppc64 --append=&#39;crashkernel=64M@32M root=/dev/nfs rw ip=dhcp video=wuxga&#39; /boot/vmlinux.strip<br>
<br>
I saw this output:<br>
<br>
kexec: waiting for cpu 1 (physical 1) to go down<br>
Reserving 64MB of memory at 32MB for crashkernel (System RAM: 128MB)<br>
...<br>
Kernel command line: crashkernel=64M@32M root=/dev/nfs rw ip=dhcp video=wuxga<br>
<font color="#888888"><br>
-Geoff<br>
<br>
</font></blockquote></div>This works properly. Thanks Geoff.<br><br>Initially I made mistake by referring
/proc/meminfo and thought the total RAM was &gt; 200M iB (actually it
shows around 211MiB in /proc/meminfo excluding swap space). But actual available memory is 128MiB only. Thats why reserving 128MiB on 32MiB failed and kernel was
not booting up.<br><br>Now &quot;crashkernel&quot; argument works properly for 64MB@64MB and kernel reserves 64MB for crash dump capture kernel.<br>
<br>This memory is reserved for &quot;dump capture kernel&quot; which will be loaded later by using kexec. Please refer linux_src/Documentation/kdump/kdump.txt for more information.<br><br>I tried to load dump capture configured kernel and facing similar kind of problem. After successful loading, Dump capture kernel is NOT BOOTING UP upon kernel crash. <br>

I used the following command to load:<br>
<br># kexec -t elf-ppc64 --append=&quot;video=ps3fb:mode:166 rhgb root=/dev/ps3da3 single maxcpus=1 noirqdistrib&quot; \<br>
&nbsp;--initrd=/boot/initrd-2.6.23-kdump.img \<br>
&nbsp;-p vmlinux.strip.kdump<br>
<i><br>Output:</i><br>
<i>setup_memory_ranges memory_range[0] start:585001, end:8000000<br>
get memory ranges:1<br>
setup_memory_ranges memory_range[0] start:585001, end:8000000<br>
Modified cmdline:video=ps3fb:mode:166 rhgb root=/dev/ps3da3 single maxcpus=1 noirqdistrib elfcorehdr=71068K savemaxmem=64M<br>
segment[0].mem:0x4000000 memsz:5599232<br>
segment[1].mem:0x4557000 memsz:65536<br>
segment[2].mem:0x4567000 memsz:4096<br>
segment[3].mem:0x4568000 memsz:36864<br>
segment[4].mem:0x4571000 memsz:3469312<br>
segment[5].mem:0x7fff000 memsz:4096<br>
</i><br>One more thing I confirmed was, this same dump capture kernel boots up
properly when I load it on normal mode (kexec -l and then kexec -e). I am having no clue
on this..<br>
<br>
If anybody know how to debug a kernel failure during boot up, it will be very helpful. Please help.<br>
<br>
Thanks in advance,<br>
Rajasekaran.P

------=_Part_661_14247566.1205491018131--


--===============1553863718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1553863718==--

