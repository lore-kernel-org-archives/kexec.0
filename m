Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr700047.outbound.protection.outlook.com
 ([40.107.70.47] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gG21C-00086H-6U
 for kexec@lists.infradead.org; Fri, 26 Oct 2018 13:19:17 +0000
From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Subject: Re: [BUG] vmcore-dmesg cant' read dmesg log from /proc/vmcore if
 log_buf is reallocated due to large number of CPUs
Date: Fri, 26 Oct 2018 13:18:59 +0000
Message-ID: <20181026131856.GA32207@localhost.localdomain>
References: <MWHPR07MB3007D9D79825933D958943EC8AF60@MWHPR07MB3007.namprd07.prod.outlook.com>
 <CACi5LpO6JH=Fepu97GVa-oZK7v4kj0+RL9WqYZuMp=KRJ2=diQ@mail.gmail.com>
 <20181025104017.GA29339@localhost.localdomain>
 <CACi5LpO56hq4jC76d7B5vLoG-wVoe-rGQoqeWYhYhjOEWG0sqA@mail.gmail.com>
 <20181026101133.GA31868@localhost.localdomain>
 <CACi5LpO_3PWBuNZPse_CppkyE5UMym_wgChkuy12TLGztzMdBQ@mail.gmail.com>
In-Reply-To: <CACi5LpO_3PWBuNZPse_CppkyE5UMym_wgChkuy12TLGztzMdBQ@mail.gmail.com>
Content-Language: en-US
Content-Type: multipart/mixed;
 boundary="_003_20181026131856GA32207localhostlocaldomain_"
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bhupesh Sharma <bhsharma@redhat.com>
Cc: "Lomovtsev, Vadim" <Vadim.Lomovtsev@cavium.com>, kexec mailing list <kexec@lists.infradead.org>

--_003_20181026131856GA32207localhostlocaldomain_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15B91664AFEDF444AFD2EAE247CE948C@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Hi Bhupesh,

On Fri, Oct 26, 2018 at 03:49:11PM +0530, Bhupesh Sharma wrote:
>=20
> Hi Vadim,
> On Fri, Oct 26, 2018 at 3:41 PM Vadim Lomovtsev
> <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> >
> > Hi Bhupesh,
> >
> > On Fri, Oct 26, 2018 at 12:25:17PM +0530, Bhupesh Sharma wrote:
> > >
> > > ease p
> > > before seiHi Vadim,
> > >
> > > On Thu, Oct 25, 2018 at 4:10 PM Vadim Lomovtsev
> > > <Vadim.Lomovtsev@caviumnetworks.com> wrote:
> > > >
> > > > Hello Bhupesh,
> > > >
> > > > On Thu, Oct 25, 2018 at 03:00:08AM +0530, Bhupesh Sharma wrote:
> > > > > External Email
> > > > >
> > > > > Hello Vadim,
> > > > >
> > > > > On Wed, Oct 24, 2018 at 6:23 PM Lomovtsev, Vadim
> > > > > <Vadim.Lomovtsev@cavium.com> wrote:
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > Following issue has been found for vmcore-dmesg app with latest=
 release (94159bc3c264fa26395e56302072276a139d18af 2.0.18-rc1) of kexec-too=
ls at CentOS 7.5 distro:
> > > > > >
> > > > > > While having systems with large number of CPUs (e.g. Cavium Thu=
nderX2 has 224) the log_buf gets reallocated by memblock_virt_alloc() at th=
e setup_log_buf routine (https://elixir.bootlin.com/linux/v4.16.18/source/k=
ernel/printk/printk.c#L1108).
> > > > > >
> > > > > > Then while dumping vmcore the vmcore-dmesg can't find dmesg log=
 at /proc/vmcore file and exits with following message:
> > > > > >   Failed to read log text of size 0 bytes: Bad address
> > > > > >
> > > > > > However it (vmcore-dmesg app) reads properly the log_buf symbol=
, it's address and eventually it's value from /proc/vmcore but fails to fin=
d dmesg data then.
> > > > > >
> > > > > > In the same time the makedumpfile is able to find and extract d=
mesg buffer from /proc/vmcore.
> > > > > > The makedumpfile comes with kexec-tools-2.0.15-13.el7_5.2.aarch=
64 package.
> > > > > >
> > > > > > The issue is not reproduced for systems with small number of CP=
Us and log_buf not reallocated to memblock section.
> > > > >
> > > > > Seems like you are hitting a known issue we saw on qualcomm amber=
wing
> > > > > platforms as well.
> > > > > I have sent a patch-series titled 'kexec-tools/arm64: Add support=
 to
> > > > > read PHYS_OFFSET from vmcoreinfo inside '/proc/kcore' to this lis=
t
> > > > > just a few minutes back.
> > > > >
> > > > > I have Cc'ed you to the patchset as I think it might fix the issu=
e for
> > > > > you.
> > > >
> > > > Got them, thank you.
> > > >
> > > > > Kindly try the patchset on your platform (cavium?) and let me
> > > > > know if this fixes the issue for you.
> > > >
> > > > Sure, I'd like to check them at my side, but..
> > > > I fall into merge conflicts while trying to apply them onto
> > > > https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/
> > > > master, kexec-tools 2.0.18-rc1 94159bc3c264fa26395e56302072276a139d=
18af
> > >
> > > Hmm.. that's strange as I rebased them on kexec-tools 2.0.18-rc1
> > > (94159bc3c264fa26395e56302072276a139d18af)
> > > before sending out the patchset.
> > >
> > > > Are there any specific branch/revision for them to be applied ?
> > > > (or it might be my mail server issues with formatting emails).
> > > >
> > >
> > > Can you please try picking them up from my public github tree instead=
?
> > > Here you can find the same:
> > > https://github.com/bhupesh-sharma/kexec-tools/tree/read-phys-offset-f=
rom-kcore-upstream-v1
> > >
> > > Please pick the top 2 commit from here.
> >
> > Applied them onto commit '94159bc kexec-tools 2.0.18-rc1'.
> >
> > Still having following error while saving dmesg by vmcore-dmesg:
> >
> > kdump: saving vmcore-dmesg.txt
> > Failed to read log text of size 0 bytes: Bad address
> > kdump: saving vmcore-dmesg.txt failed
> >
> > So far tried kernels 4.14.78, 4.16.18.
>=20
> You would need kernel 4.19-rc5 or above as the same exposes VMCOREINFO
> as '/proc/kcore'.

So far with 4.19-rc6 (and updated kexec, vmcore-dmesg but having kdump scri=
pts from CentOS)
the crashkernel can't found sysroot and thus it can't dump anything, so it =
timeouts and reboot system.

> If you are having issues while switching to newer kernel, please share
> the output(s) of following on your platform:
>=20
> # kexec -p /boot/vmlinuz-`uname -r` --initrd=3D/boot/initramfs-`uname
> -r`.img --reuse-cmdline -d
>

attached as kexec-start.log.xz

> and,
>=20
> # readelf -l vmcore

[root@2sgbt-53 vlomovts]# readelf -l vmcore
readelf: vmcore: Error: No such file
[root@2sgbt-53 vlomovts]# uname -r
4.19.0-rc6+

>=20
> and,
>=20
> # cat /proc/iomem

attached as cat-proc-iomem.log.xz

WBR,
Vadim

>=20
> And then I can suggest a hack, which you can try and test on your
> platform and then we can take it forward from there.
>=20
> Thanks,
> Bhupesh
>=20
> > >
> > > Thanks,
> > > Bhupesh
> > >
> > > >
> > > > >
> > > > > Thanks,
> > > > > Bhupesh

--_003_20181026131856GA32207localhostlocaldomain_
Content-Type: application/x-xz; name="cat-proc-iomem.log.xz"
Content-Description: cat-proc-iomem.log.xz
Content-Disposition: attachment; filename="cat-proc-iomem.log.xz"; size=2172;
	creation-date="Fri, 26 Oct 2018 13:18:59 GMT";
	modification-date="Fri, 26 Oct 2018 13:18:59 GMT"
Content-ID: <343C97FE3D0CF348BED23882FA43BED9@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

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
AAAABFla

--_003_20181026131856GA32207localhostlocaldomain_
Content-Type: application/x-xz; name="kexec-start.log.xz"
Content-Description: kexec-start.log.xz
Content-Disposition: attachment; filename="kexec-start.log.xz"; size=2784;
	creation-date="Fri, 26 Oct 2018 13:18:59 GMT";
	modification-date="Fri, 26 Oct 2018 13:18:59 GMT"
Content-ID: <537EF837A48E7B438CAB349D83815ECD@namprd07.prod.outlook.com>
Content-Transfer-Encoding: base64

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

--_003_20181026131856GA32207localhostlocaldomain_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--_003_20181026131856GA32207localhostlocaldomain_--

