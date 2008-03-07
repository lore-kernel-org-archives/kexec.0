Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from outbound-va3.frontbridge.com ([216.32.180.16]
	helo=outbound2-va3-R.bigfish.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JXhtU-0001BS-UQ
	for kexec@lists.infradead.org; Fri, 07 Mar 2008 19:06:13 +0000
Message-ID: <47D19114.1090700@am.sony.com>
Date: Fri, 07 Mar 2008 11:01:40 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
Subject: Re: Fwd: Kexec support for PS3 (ppc64)
References: <C5065F118AFB3D478B052FC1E9810D9CA9041B@tec-mail.ttec.soc-soft.com>
	<4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
In-Reply-To: <4574cb3d0803062155k7da6be9al30ee3f35d01f9f0@mail.gmail.com>
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
Cc: kexec@lists.infradead.org

Hi,

I maintain kexec for PS3, but have just done what was needed to
make it work for kboot.  I am not a kexec expert, and have
never tried to use kdump, or other features of kexec, only the
things needed for kboot.

On 03/06/2008 09:55 PM, Rajasekaran P wrote:
>> On Thu, Mar 06, 2008 at 04:55:04PM +0530, Rajasekaran Periyasamy
> wrote:
>> > Hi,
>> > I put a printk() in the early lines of early_parse_crashk() with
>> > KERN_EMERG, but not able to see that on the boot screen. I think the
>> > control is not transferred to early_parse_crashk() at all. With out
> this
>> > "crashkernel" argument, the same kernel boots up properly.


This kind of thing is what kboot uses, and is known to work:

  kexec -l -t elf-ppc64 --append='root=XXX video=YYY' /boot/vmlinux.strip
  kexec -e

I recommend you get it to work first.


>> Looks strange.
>>
>> Could you please include more debug printks in the function
>> do_early_param in init/main.c to check whether early_parse_crashk is
>> called or not?


That won't work, since it is hanging before the video driver is up,
and you'll never see those.


> I've tried, but no result... Please have a look at the snapshot of boot
> process.
> 
> I think the kernel is not at all getting initiated to boot up.


Your photo shows that the first stage kernel has gone down, and it
hung up either very late going down, or early coming back up in the
second stage.


> Whatever you see in the snapshot,
> 1. "Modified cmdline:" is from
> "kexec-tools-1.101/kexec/arch/ppc64/fs2dt.c" putnode() function,


I guess that version of exec-tools (kexec-tools-1.101) may be too old,
and doesn't have the bug-fixes I needed to make to kexec-tools for it
to work with PS3.  Those fixes were merged into kexec-tools several
month ago.

I recommend you try with an up-to-date kexec from here:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/kexec-tools-testing.git

I have tested both 32 and 64 bit builds.

I also recommend to start with a known good second stage kernel.
I tested Linux 2.6.25-rc4 built with ps3_defconfig and it works.
Do not use an initrd at first try.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
