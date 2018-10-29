Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr710086.outbound.protection.outlook.com
 ([40.107.71.86] helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gH5bk-0002IV-J1
 for kexec@lists.infradead.org; Mon, 29 Oct 2018 11:21:33 +0000
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [BUG] vmcore-dmesg cant' read dmesg log from /proc/vmcore if
 log_buf is reallocated due to large number of CPUs
Date: Mon, 29 Oct 2018 11:21:05 +0000
Message-ID: <20181029112059.GA7899@localhost.localdomain>
References: <MWHPR07MB3007D9D79825933D958943EC8AF60@MWHPR07MB3007.namprd07.prod.outlook.com>
 <CACi5LpO6JH=Fepu97GVa-oZK7v4kj0+RL9WqYZuMp=KRJ2=diQ@mail.gmail.com>
 <20181025104017.GA29339@localhost.localdomain>
 <CACi5LpO56hq4jC76d7B5vLoG-wVoe-rGQoqeWYhYhjOEWG0sqA@mail.gmail.com>
 <20181026101133.GA31868@localhost.localdomain>
 <CACi5LpO_3PWBuNZPse_CppkyE5UMym_wgChkuy12TLGztzMdBQ@mail.gmail.com>
 <20181026131856.GA32207@localhost.localdomain>
 <CACi5LpPEt+pdOPwFyhB=SB+PB7+kLTinj+bn_ne+ojiXa4A8sg@mail.gmail.com>
In-Reply-To: <CACi5LpPEt+pdOPwFyhB=SB+PB7+kLTinj+bn_ne+ojiXa4A8sg@mail.gmail.com>
Content-Language: en-US
Content-ID: <6B3BDA71D4325F46B7DEC16173BAA1CF@namprd07.prod.outlook.com>
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
Cc: "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>, kexec mailing list <kexec@lists.infradead.org>

Hi Bhupesh,

On Sat, Oct 27, 2018 at 04:41:55AM +0530, Bhupesh Sharma wrote:
> 
> Hi Vadim,
> 
> On Fri, Oct 26, 2018 at 6:49 PM Vadim Lomovtsev
> <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> >
> > Hi Bhupesh,
> >
> > On Fri, Oct 26, 2018 at 03:49:11PM +0530, Bhupesh Sharma wrote:
> > >
> > > Hi Vadim,
> > > On Fri, Oct 26, 2018 at 3:41 PM Vadim Lomovtsev
> > > <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> > > >
> > > > Hi Bhupesh,
> > > >
> > > > On Fri, Oct 26, 2018 at 12:25:17PM +0530, Bhupesh Sharma wrote:
> > > > >
> > > > > ease p
> > > > > before seiHi Vadim,
> > > > >
> > > > > On Thu, Oct 25, 2018 at 4:10 PM Vadim Lomovtsev
> > > > > <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> > > > > >
> > > > > > Hello Bhupesh,
> > > > > >
> > > > > > On Thu, Oct 25, 2018 at 03:00:08AM +0530, Bhupesh Sharma wrote:
> > > > > > > External Email
> > > > > > >
> > > > > > > Hello Vadim,
> > > > > > >
> > > > > > > On Wed, Oct 24, 2018 at 6:23 PM Lomovtsev, Vadim
> > > > > > > <Vadim.Lomovtsev@cavium.com> wrote:
> > > > > > > >
> > > > > > > > Hi all,
> > > > > > > >
> > > > > > > > Following issue has been found for vmcore-dmesg app with latest release (94159bc3c264fa26395e56302072276a139d18af 2.0.18-rc1) of kexec-tools at CentOS 7.5 distro:
> > > > > > > >
> > > > > > > > While having systems with large number of CPUs (e.g. Cavium ThunderX2 has 224) the log_buf gets reallocated by memblock_virt_alloc() at the setup_log_buf routine (https://elixir.bootlin.com/linux/v4.16.18/source/kernel/printk/printk.c#L1108).
> > > > > > > >
> > > > > > > > Then while dumping vmcore the vmcore-dmesg can't find dmesg log at /proc/vmcore file and exits with following message:
> > > > > > > >   Failed to read log text of size 0 bytes: Bad address
> > > > > > > >
> > > > > > > > However it (vmcore-dmesg app) reads properly the log_buf symbol, it's address and eventually it's value from /proc/vmcore but fails to find dmesg data then.
> > > > > > > >
> > > > > > > > In the same time the makedumpfile is able to find and extract dmesg buffer from /proc/vmcore.
> > > > > > > > The makedumpfile comes with kexec-tools-2.0.15-13.el7_5.2.aarch64 package.
> > > > > > > >
> > > > > > > > The issue is not reproduced for systems with small number of CPUs and log_buf not reallocated to memblock section.
> > > > > > >
> > > > > > > Seems like you are hitting a known issue we saw on qualcomm amberwing
> > > > > > > platforms as well.
> > > > > > > I have sent a patch-series titled 'kexec-tools/arm64: Add support to
> > > > > > > read PHYS_OFFSET from vmcoreinfo inside '/proc/kcore' to this list
> > > > > > > just a few minutes back.
> > > > > > >
> > > > > > > I have Cc'ed you to the patchset as I think it might fix the issue for
> > > > > > > you.
> > > > > >
> > > > > > Got them, thank you.
> > > > > >
> > > > > > > Kindly try the patchset on your platform (cavium?) and let me
> > > > > > > know if this fixes the issue for you.
> > > > > >
> > > > > > Sure, I'd like to check them at my side, but..
> > > > > > I fall into merge conflicts while trying to apply them onto
> > > > > > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/
> > > > > > master, kexec-tools 2.0.18-rc1 94159bc3c264fa26395e56302072276a139d18af
> > > > >
> > > > > Hmm.. that's strange as I rebased them on kexec-tools 2.0.18-rc1
> > > > > (94159bc3c264fa26395e56302072276a139d18af)
> > > > > before sending out the patchset.
> > > > >
> > > > > > Are there any specific branch/revision for them to be applied ?
> > > > > > (or it might be my mail server issues with formatting emails).
> > > > > >
> > > > >
> > > > > Can you please try picking them up from my public github tree instead?
> > > > > Here you can find the same:
> > > > > https://github.com/bhupesh-sharma/kexec-tools/tree/read-phys-offset-from-kcore-upstream-v1
> > > > >
> > > > > Please pick the top 2 commit from here.
> > > >
> > > > Applied them onto commit '94159bc kexec-tools 2.0.18-rc1'.
> > > >
> > > > Still having following error while saving dmesg by vmcore-dmesg:
> > > >
> > > > kdump: saving vmcore-dmesg.txt
> > > > Failed to read log text of size 0 bytes: Bad address
> > > > kdump: saving vmcore-dmesg.txt failed
> > > >
> > > > So far tried kernels 4.14.78, 4.16.18.
> > >
> > > You would need kernel 4.19-rc5 or above as the same exposes VMCOREINFO
> > > as '/proc/kcore'.
> >
> > So far with 4.19-rc6 (and updated kexec, vmcore-dmesg but having kdump scripts from CentOS)
> > the crashkernel can't found sysroot and thus it can't dump anything, so it timeouts and reboot system.
> >
> > > If you are having issues while switching to newer kernel, please share
> > > the output(s) of following on your platform:
> > >
> > > # kexec -p /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
> > > -r`.img --reuse-cmdline -d
> > >
> >
> > attached as kexec-start.log.xz
> >
> > > and,
> > >
> > > # readelf -l vmcore
> >
> > [root@2sgbt-53 vlomovts]# readelf -l vmcore
> > readelf: vmcore: Error: No such file
> > [root@2sgbt-53 vlomovts]# uname -r
> > 4.19.0-rc6+
> >
> > >
> > > and,
> > >
> > > # cat /proc/iomem
> >
> > attached as cat-proc-iomem.log.xz
> 
> Just to confirm: these logs are after your apply my kexec-tools patches, right?

Yes, applied, rebuild kexec and start kernel as you suggest.

> It looks likely that we are seeing differences in the value of
> 'phys_offset' on your platforms:
> 
> From, '/proc/iomem', we can see that phys_offset is 0x01400000:
> 01400000-ffedffff : System RAM

I've found start of dmesg manually at vmcore elf and found that
the offset at file and offset found by vmcore-dmesg is differs for 0x140000,
which is the PHYS_OFFSET, and it is set to 0 at my vmcore for some reason
(part of my vmcore-debug printous):
[...]
NUMBER(kimage_voffset)=0xffff000006c00000
NUMBER(PHYS_OFFSET)=0x0
[...]

> 
> while the 'kexec -p -d' logs indicate that it is 0:
> image_arm64_load: phys_offset:    0000000000000000

Yes, it is. Double-check it for 4.19-rc6 and it is still 0x0.

> 
> This tells me that the phys_offset value is not correctly calculated
> in kexec-tools which should be fixed after my patches.
> 
> BTW , by '# readelf -l vmcore', I meant the 'vmcore' dump file you
> have obtained via 'kexec'. It might be that you are saving it on some
> different location (something /var/crash?). Can you please try sharing
> the output of the same as well?

Sorry, my bad here. but the problem is that I can't get kexec wortking with
4.19-rc6 kernel and I have vmcore dump for 4.14.69+ based kernel so far.
So the output looks like following:

[vlomovts@2sgbt-53 ~]$ readelf -l ~/vmcore-full 

Elf file type is CORE (Core file)
Entry point 0x0
There are 10 program headers, starting at offset 64

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                 0x000000000000a1a0 0x000000000000a1a0         0
  LOAD           0x0000000000020000 0xffff000008080000 0x0000000001480000
                 0x0000000001bc0000 0x0000000001bc0000  RWE    0
  LOAD           0x0000000001be0000 0xffff800000000000 0x0000000001400000
                 0x00000000dea00000 0x00000000dea00000  RWE    0
  LOAD           0x00000000e05e0000 0xffff8000fea00000 0x00000000ffe00000
                 0x00000000000e0000 0x00000000000e0000  RWE    0
  LOAD           0x00000000e06c0000 0xffff8000feb00000 0x00000000fff00000
                 0x0000000000090000 0x0000000000090000  RWE    0
  LOAD           0x00000000e0750000 0xffff8000feba0000 0x00000000fffa0000
                 0x0000001f00060000 0x0000001f00060000  RWE    0
  LOAD           0x0000001fe07b0000 0xffff80ffff000000 0x0000010000400000
                 0x0000001ffaae0000 0x0000001ffaae0000  RWE    0
  LOAD           0x0000003fdb290000 0xffff811ff9bc0000 0x0000011ffafc0000
                 0x0000000004fd0000 0x0000000004fd0000  RWE    0
  LOAD           0x0000003fe0260000 0xffff811ffeba0000 0x0000011ffffa0000
                 0x0000000000010000 0x0000000000010000  RWE    0
  LOAD           0x0000003fe0270000 0xffff811ffebe0000 0x0000011ffffe0000
                 0x0000000000020000 0x0000000000020000  RWE    0

WBR,
Vadim
> 
> Regards,
> Bhupesh
> 
> > >
> > > And then I can suggest a hack, which you can try and test on your
> > > platform and then we can take it forward from there.
> > >
> > > Thanks,
> > > Bhupesh
> > >
> > > > >
> > > > > Thanks,
> > > > > Bhupesh
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
