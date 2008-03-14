Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qb-out-0506.google.com ([72.14.204.239])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Ja8BF-0000Pe-8F
	for kexec@lists.infradead.org; Fri, 14 Mar 2008 11:34:33 +0000
Received: by qb-out-0506.google.com with SMTP id e6so3360170qbe.2
	for <kexec@lists.infradead.org>; Fri, 14 Mar 2008 04:34:32 -0700 (PDT)
Message-ID: <4574cb3d0803140418t41a84b93g9e25694b4c919e74@mail.gmail.com>
Date: Fri, 14 Mar 2008 04:18:52 -0700
From: "Rajasekaran P" <rajasekaran83@gmail.com>
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
In-Reply-To: <20080314110212.GA9643@in.ibm.com>
MIME-Version: 1.0
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
	<47D19114.1090700@am.sony.com>
	<4574cb3d0803110325u759a411ckbae3ff69557b0230@mail.gmail.com>
	<47D6B92D.2020205@am.sony.com> <47D6D406.8050209@am.sony.com>
	<4574cb3d0803140336g59236cf2w7e14405b2dc795a5@mail.gmail.com>
	<20080314110212.GA9643@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0330214882=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: mohan@in.ibm.com
Cc: kexec@lists.infradead.org, Geoff Levand <geoffrey.levand@am.sony.com>

--===============0330214882==
Content-Type: multipart/alternative; 
	boundary="----=_Part_758_14917942.1205493532650"

------=_Part_758_14917942.1205493532650
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, Mar 14, 2008 at 4:02 AM, Mohan Kumar M <mohan@in.ibm.com> wrote:

> On Fri, Mar 14, 2008 at 03:36:58AM -0700, Rajasekaran P wrote:
> > On Tue, Mar 11, 2008 at 11:48 AM, Geoff Levand <
> geoffrey.levand@am.sony.com>
> > wrote:
> >
> > Initially I made mistake by referring /proc/meminfo and thought the
> total
> > RAM was > 200M iB (actually it shows around 211MiB in /proc/meminfo
> > excluding swap space). But actual available memory is 128MiB only. Thats
> why
> > reserving 128MiB on 32MiB failed and kernel was not booting up.
> >
> > Now "crashkernel" argument works properly for 64MB@64MB and kernel
> reserves
> > 64MB for crash dump capture kernel.
>
> In PPC64, crashkernel base address is hard coded i.e it is always loaded
> at 32MB, even though you have passed 64MB@64MB. Did you get any warning
> message like crashkernel reserved at 32MB?
>
> >
> > This memory is reserved for "dump capture kernel" which will be loaded
> later
> > by using kexec. Please refer linux_src/Documentation/kdump/kdump.txt for
> > more information.
> >
> > I tried to load dump capture configured kernel and facing similar kind
> of
> > problem. After successful loading, Dump capture kernel is NOT BOOTING UP
> > upon kernel crash.
>
> Do you get any message from the dump capture kernel? How do you trigger
> the dump?
>
> > I used the following command to load:
> >
> > # kexec -t elf-ppc64 --append="video=ps3fb:mode:166 rhgb
> root=/dev/ps3da3
> > single maxcpus=1 noirqdistrib" \
> >  --initrd=/boot/initrd-2.6.23-kdump.img \
> >  -p vmlinux.strip.kdump
>
>         ^^ Is this kernel compiled with CRASH_DUMP enabled? If yes, it
> should build the kernel for 32MB.


>
> > *
> > Output:*
> > *setup_memory_ranges memory_range[0] start:585001, end:8000000
> > get memory ranges:1
> > setup_memory_ranges memory_range[0] start:585001, end:8000000
> > Modified cmdline:video=ps3fb:mode:166 rhgb root=/dev/ps3da3 single
> maxcpus=1
> > noirqdistrib elfcorehdr=71068K savemaxmem=64M
> > segment[0].mem:0x4000000 memsz:5599232
>
>                         ^^ Says the vmlinux is loaded at 64MB
> > segment[1].mem:0x4557000 memsz:65536
> > segment[2].mem:0x4567000 memsz:4096
> > segment[3].mem:0x4568000 memsz:36864
> > segment[4].mem:0x4571000 memsz:3469312
> > segment[5].mem:0x7fff000 memsz:4096
> > *
> > One more thing I confirmed was, this same dump capture kernel boots up
> > properly when I load it on normal mode (kexec -l and then kexec -e). I
> am
> > having no clue on this..
>

Yes,I built this kernel with CRASH_DUMP and VMCORE file system  enabled.
Moreover, I disabled SMP as well.
My system kernel is (First kernel) is SMP enabled, does it matter?

I dont get any message from dump capture kernel.

I trigger crash dump using :

echo c > /proc/sysrq-trigger
Initially capture kernel was loaded into 32MB only, but still it was not
booting. So I tweaked the KDUMP_KERNELBASE macro to load capture kernel to
64MB ( My idea is, first 64MB for system kernel and second 64MB for capture
kernel). Should it be 32MB only?

------=_Part_758_14917942.1205493532650
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div class="gmail_quote">On Fri, Mar 14, 2008 at 4:02 AM, Mohan Kumar M &lt;<a href="mailto:mohan@in.ibm.com">mohan@in.ibm.com</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">On Fri, Mar 14, 2008 at 03:36:58AM -0700, Rajasekaran P wrote:<br>
&gt; On Tue, Mar 11, 2008 at 11:48 AM, Geoff Levand &lt;<a href="mailto:geoffrey.levand@am.sony.com">geoffrey.levand@am.sony.com</a>&gt;<br>
&gt; wrote:<br>
&gt;<br>
</div><div class="Ih2E3d">&gt; Initially I made mistake by referring /proc/meminfo and thought the total<br>
&gt; RAM was &gt; 200M iB (actually it shows around 211MiB in /proc/meminfo<br>
&gt; excluding swap space). But actual available memory is 128MiB only. Thats why<br>
&gt; reserving 128MiB on 32MiB failed and kernel was not booting up.<br>
&gt;<br>
&gt; Now &quot;crashkernel&quot; argument works properly for 64MB@64MB and kernel reserves<br>
&gt; 64MB for crash dump capture kernel.<br>
<br>
</div>In PPC64, crashkernel base address is hard coded i.e it is always loaded<br>
at 32MB, even though you have passed 64MB@64MB. Did you get any warning<br>
message like crashkernel reserved at 32MB?<br>
<div class="Ih2E3d"><br>
&gt;<br>
&gt; This memory is reserved for &quot;dump capture kernel&quot; which will be loaded later<br>
&gt; by using kexec. Please refer linux_src/Documentation/kdump/kdump.txt for<br>
&gt; more information.<br>
&gt;<br>
&gt; I tried to load dump capture configured kernel and facing similar kind of<br>
&gt; problem. After successful loading, Dump capture kernel is NOT BOOTING UP<br>
&gt; upon kernel crash.<br>
<br>
</div>Do you get any message from the dump capture kernel? How do you trigger<br>
the dump?<br>
<div class="Ih2E3d"><br>
&gt; I used the following command to load:<br>
&gt;<br>
&gt; # kexec -t elf-ppc64 --append=&quot;video=ps3fb:mode:166 rhgb root=/dev/ps3da3<br>
&gt; single maxcpus=1 noirqdistrib&quot; \<br>
&gt; &nbsp;--initrd=/boot/initrd-2.6.23-kdump.img \<br>
&gt; &nbsp;-p vmlinux.strip.kdump<br>
<br>
</div> &nbsp; &nbsp; &nbsp; &nbsp;^^ Is this kernel compiled with CRASH_DUMP enabled? If yes, it<br>
should build the kernel for 32MB.</blockquote><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><br>
<div class="Ih2E3d"><br>
&gt; *<br>
&gt; Output:*<br>
&gt; *setup_memory_ranges memory_range[0] start:585001, end:8000000<br>
&gt; get memory ranges:1<br>
&gt; setup_memory_ranges memory_range[0] start:585001, end:8000000<br>
&gt; Modified cmdline:video=ps3fb:mode:166 rhgb root=/dev/ps3da3 single maxcpus=1<br>
&gt; noirqdistrib elfcorehdr=71068K savemaxmem=64M<br>
&gt; segment[0].mem:0x4000000 memsz:5599232<br>
<br>
</div> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;^^ Says the vmlinux is loaded at 64MB<br>
<div><div></div><div class="Wj3C7c">&gt; segment[1].mem:0x4557000 memsz:65536<br>
&gt; segment[2].mem:0x4567000 memsz:4096<br>
&gt; segment[3].mem:0x4568000 memsz:36864<br>
&gt; segment[4].mem:0x4571000 memsz:3469312<br>
&gt; segment[5].mem:0x7fff000 memsz:4096<br>
&gt; *<br>
&gt; One more thing I confirmed was, this same dump capture kernel boots up<br>
&gt; properly when I load it on normal mode (kexec -l and then kexec -e). I am<br>
&gt; having no clue on this..</div></div></blockquote><div><span style="color: rgb(0, 0, 153);"><br>Yes,I built this kernel with CRASH_DUMP and VMCORE file system&nbsp; enabled. Moreover, I disabled SMP as well.</span><br style="color: rgb(0, 0, 153);">
<span style="color: rgb(0, 0, 153);">My system kernel is (First kernel) is SMP enabled, does it matter?<br><br>I dont get any message from dump capture kernel.<br><br>I trigger crash dump using :</span><br style="color: rgb(51, 51, 255);">
<p style="color: rgb(0, 0, 153);"><font face="Verdana" size="2"><span style="font-size: 10pt; font-family: Verdana;">echo c &gt; /proc/sysrq-trigger</span></font></p>

<span style="color: rgb(0, 0, 153);">Initially capture kernel was loaded into 32MB only, but still it was not booting. So I tweaked the </span><font style="color: rgb(0, 0, 153);" face="Verdana" size="2"><span style="font-size: 10pt; font-family: Verdana;">KDUMP_KERNELBASE macro to load capture kernel to 64MB ( My idea is, first 64MB for system kernel and second 64MB for capture kernel). Should it be 32MB only?<br>
</span></font></div></div><br>

------=_Part_758_14917942.1205493532650--


--===============0330214882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0330214882==--

