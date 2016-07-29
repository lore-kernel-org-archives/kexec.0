Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTBLg-0000w3-Ur
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 17:13:26 +0000
Received: by mail-pa0-f51.google.com with SMTP id ks6so32961900pab.0
 for <kexec@lists.infradead.org>; Fri, 29 Jul 2016 10:13:04 -0700 (PDT)
Date: Fri, 29 Jul 2016 22:43:00 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v23 0/9] arm64: add kdump support
Message-ID: <20160729171300.GA478@localhost.localdomain>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
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
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Ruslan,

On 29/07/2016:07:26:03 PM, Ruslan Bilovol wrote:
> Hi,
> 
> On Tue, Jul 26, 2016 at 11:09 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> > On Tue, Jul 26, 2016 at 04:56:51PM +0900, AKASHI Takahiro wrote:
> >> This patch series adds kdump support on arm64.
> >>
> >> To load a crash-dump kernel to the systems, a series of patches to
> >> kexec-tools, which have not yet been merged upstream, are needed.
> >> Please pick Geoff's kexec patches [1] and my kdump patches [2].
> >>
> >> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> >>   - crash utility (coming v7.1.6 or later) [3]
> >>     (Necessary patches have already been queued in the master.)
> >>
> >> [1]  http://lists.infradead.org/pipermail/kexec/2016-July/016532.html
> >> [2]  TBD
> >
> > See my kexec-tools patches in:
> > http://lists.infradead.org/pipermail/kexec/2016-July/016642.html
> 
> I tired this patch series with mentioned Geoff's kexec patches and
> your kdump patches, but unfortunately it doesn't work for me.
> 
> While I can successfully load and kexec the kernel ('kexec --load' +
> 'kexec -e'), same combination of kernel+ramdisk+dtb doesn't boot
> if I do kdump combination ('kexec -p' + sysrq crash), there is no
> any output after sysrq crash trace.
> Unfortunately I don't have any debugger here for deep investigation
> of this issue.

Which type of image do you have? I did face issue with binary image which I
fixed in my branch, while elf would work fine for kdump as well.

> 
> Also for some reason in case of 'load and kexec the kernel' it
> takes 1-2 minutes to start booting after I do kexec -e, need to
> investigate it further.

Because, D-cache is disabled.

> 
> Which hardware do you use for validating your patches?
> 
> Also, could you please share exact commands you use for
> kdump validation?

Well, I have some patches for D-cache enabling, which will be sent for review
after these set of kexec and kdump patches are merged.

Meanwhile, you can use them and give your feedback. They are here:
https://github.com/pratyushanand/kexec-tools.git : upstream_arm64_devel

I use following command with my test branch. You can ignore --port and
--port-lsr in your setup. You may use --enable-dcache and  let me know if it
works for you and improves execution speed. You may need to change vmlinux and
inird name as per your setup.

for kexec test:
kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`.img
--reuse-cmdline --enable-dcache --port=0x1c020000
--port-lsr=0x1c020014,0x60;kexec -e

for kdump test:
kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname -r`kdump.img
--reuse-cmdline --enable-dcache --port=0x1c020000 --port-lsr=0x1c020014,0x60
--append="irqpoll maxcpus=1 reset_devices"; echo c > /proc/sysrq-trigger

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
