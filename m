Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TlzNr-0001S0-Je
 for kexec@lists.infradead.org; Fri, 21 Dec 2012 09:59:17 +0000
Received: by mail-ie0-f171.google.com with SMTP id 17so5902402iea.16
 for <kexec@lists.infradead.org>; Fri, 21 Dec 2012 01:59:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
Date: Fri, 21 Dec 2012 17:59:12 +0800
Message-ID: <CAK4g67ZEUfCqqpa1-4wkN4+OXZYQqLTiJC+6OpwVWVLfO2_7xQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
From: oliver yang <yangoliver@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8510998269326219100=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

--===============8510998269326219100==
Content-Type: multipart/alternative; boundary=14dae93405c94b56fe04d159e6ed

--14dae93405c94b56fe04d159e6ed
Content-Type: text/plain; charset=ISO-8859-1

Hi Takao,

Because I want to config the kdump in our lab, I have some questions
about the backgroud of your patch.

1. Will you patch only work while IOMMU is enabled?

2. Looks like kdump doesn't disable DMA and interrupts in the systems,
how can Linux make sure second kernel's memory is not corrupted by
devices initialized by first kernel?


2012/11/27 Takao Indoh <indou.takao@jp.fujitsu.com>

> These patches reset PCIe devices at boot time to address DMA problem on
> kdump with iommu. When "reset_devices" is specified, a hot reset is
> triggered on each PCIe root port and downstream port to reset its
> downstream endpoint.
>
> Background:
> A kdump problem about DMA has been discussed for a long time. That is,
> when a kernel is switched to the kdump kernel, DMA derived from first
> kernel affects second kernel. Especially this problem surfaces when
> iommu is used for PCI passthrough on KVM guest. In the case of the
> machine I use, when intel_iommu=on is specified, DMAR error is detected
> in kdump kernel and PCI SERR is also detected. Finally kdump fails
> because some devices does not work correctly.
>
> The root cause is that ongoing DMA from first kernel causes DMAR fault
> because page table of DMAR is initialized while kdump kernel is booting
> up. Therefore to solve this problem DMA needs to be stopped before DMAR
> is initialized at kdump kernel boot time. By these patches, PCIe devices
> are reset by hot reset and its DMA is stopped when reset_devices is
> specified. One problem of this solution is that the monitor blacks out
> when VGA controller is reset. So this patch does not reset the port
> whose child endpoint is VGA device.
>
> What I tried:
> - Clearing bus master bit and INTx disable bit at boot time
>     This did not solve this problem. I still got DMAR error on devices.
> - Resetting devices in fixup_final(v1 patch)
>     DMAR error disappeared, but sometimes PCI SERR was detected. This
>     is well explained here.
>     https://lkml.org/lkml/2012/9/9/245
>     This PCI SERR seems to be related to interrupt remapping.
> - Clearing bus master in setup_arch() and resetting devices in
>   fixup_final
>     Neither DMAR error nor PCI SERR occurred. But on certain machine
>     kdump kernel hung up when resetting devices. It seems to be a
>     problem specific to the platform.
> - Resetting devices in setup_arch() (v2 and later patch)
>     This solution solves all problems I found so far.
>
> Changelog:
> v7:
> Update Yinghai's dummy-pci patch with macros in linux/pci.h, and fix
> some bugs
>
> v6:
> Rewrite using Yinghai's dummy-pci patch
> https://lkml.org/lkml/2012/11/13/118
>
> v5:
> Do bus reset after all devices are scanned and its config registers are
> saved. This fixes a bug that config register is accessed without delay
> after reset.
> https://lkml.org/lkml/2012/10/17/47
>
> v4:
> Reduce waiting time after resetting devices. A previous patch does reset
> like this:
>   for (each device) {
>     save config registers
>     reset
>     wait for 500 ms
>     restore config registers
>   }
>
> If there are N devices to be reset, it takes N*500 ms. On the other
> hand, the v4 patch does:
>   for (each device) {
>     save config registers
>     reset
>   }
>   wait 500 ms
>   for (each device) {
>     restore config registers
>   }
> Though it needs more memory space to save config registers, the waiting
> time is always 500ms.
> https://lkml.org/lkml/2012/10/15/49
>
> v3:
> Move alloc_bootmem and free_bootmem to early_reset_pcie_devices so that
> they are called only once.
> https://lkml.org/lkml/2012/10/10/57
>
> v2:
> Reset devices in setup_arch() because reset need to be done before
> interrupt remapping is initialized.
> https://lkml.org/lkml/2012/10/2/54
>
> v1:
> Add fixup_final quirk to reset PCIe devices
> https://lkml.org/lkml/2012/8/3/160
>
> Takao Indoh (5):
>   x86, pci: add dummy pci device for early stage
>   PCI: Define the maximum number of PCI function
>   Make reset_devices available at early stage
>   x86, pci: Reset PCIe devices at boot time
>   x86, pci: Enable PCI INTx when MSI is disabled
>
>  arch/x86/include/asm/pci-direct.h |    3 +
>  arch/x86/kernel/setup.c           |    3 +
>  arch/x86/pci/common.c             |    4 +-
>  arch/x86/pci/early.c              |  315
> +++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h               |    2 +
>  init/main.c                       |    4 +-
>  6 files changed, 328 insertions(+), 3 deletions(-)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
------------------
Oliver Yang

--14dae93405c94b56fe04d159e6ed
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra">Hi=A0Takao,</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra" style>Because I want =
to config the kdump in our lab,=A0I have some questions</div><div class=3D"=
gmail_extra" style>
about the backgroud of your patch.</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra" style>1. Will you patch only work while IOMMU =
is enabled?</div><div class=3D"gmail_extra" style><br></div><div class=3D"g=
mail_extra" style>
2. Looks like kdump doesn&#39;t disable DMA and interrupts in the systems,=
=A0</div><div class=3D"gmail_extra" style>how can Linux make sure second ke=
rnel&#39;s memory is not corrupted by</div><div class=3D"gmail_extra" style=
>devices initialized by first kernel?</div>
<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">2012/11/27 Ta=
kao Indoh <span dir=3D"ltr">&lt;<a href=3D"mailto:indou.takao@jp.fujitsu.co=
m" target=3D"_blank">indou.takao@jp.fujitsu.com</a>&gt;</span><br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-widt=
h:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-le=
ft:1ex">
These patches reset PCIe devices at boot time to address DMA problem on<br>
kdump with iommu. When &quot;reset_devices&quot; is specified, a hot reset =
is<br>
triggered on each PCIe root port and downstream port to reset its<br>
downstream endpoint.<br>
<br>
Background:<br>
A kdump problem about DMA has been discussed for a long time. That is,<br>
when a kernel is switched to the kdump kernel, DMA derived from first<br>
kernel affects second kernel. Especially this problem surfaces when<br>
iommu is used for PCI passthrough on KVM guest. In the case of the<br>
machine I use, when intel_iommu=3Don is specified, DMAR error is detected<b=
r>
in kdump kernel and PCI SERR is also detected. Finally kdump fails<br>
because some devices does not work correctly.<br>
<br>
The root cause is that ongoing DMA from first kernel causes DMAR fault<br>
because page table of DMAR is initialized while kdump kernel is booting<br>
up. Therefore to solve this problem DMA needs to be stopped before DMAR<br>
is initialized at kdump kernel boot time. By these patches, PCIe devices<br=
>
are reset by hot reset and its DMA is stopped when reset_devices is<br>
specified. One problem of this solution is that the monitor blacks out<br>
when VGA controller is reset. So this patch does not reset the port<br>
whose child endpoint is VGA device.<br>
<br>
What I tried:<br>
- Clearing bus master bit and INTx disable bit at boot time<br>
=A0 =A0 This did not solve this problem. I still got DMAR error on devices.=
<br>
- Resetting devices in fixup_final(v1 patch)<br>
=A0 =A0 DMAR error disappeared, but sometimes PCI SERR was detected. This<b=
r>
=A0 =A0 is well explained here.<br>
=A0 =A0 <a href=3D"https://lkml.org/lkml/2012/9/9/245" target=3D"_blank">ht=
tps://lkml.org/lkml/2012/9/9/245</a><br>
=A0 =A0 This PCI SERR seems to be related to interrupt remapping.<br>
- Clearing bus master in setup_arch() and resetting devices in<br>
=A0 fixup_final<br>
=A0 =A0 Neither DMAR error nor PCI SERR occurred. But on certain machine<br=
>
=A0 =A0 kdump kernel hung up when resetting devices. It seems to be a<br>
=A0 =A0 problem specific to the platform.<br>
- Resetting devices in setup_arch() (v2 and later patch)<br>
=A0 =A0 This solution solves all problems I found so far.<br>
<br>
Changelog:<br>
v7:<br>
Update Yinghai&#39;s dummy-pci patch with macros in linux/pci.h, and fix<br=
>
some bugs<br>
<br>
v6:<br>
Rewrite using Yinghai&#39;s dummy-pci patch<br>
<a href=3D"https://lkml.org/lkml/2012/11/13/118" target=3D"_blank">https://=
lkml.org/lkml/2012/11/13/118</a><br>
<br>
v5:<br>
Do bus reset after all devices are scanned and its config registers are<br>
saved. This fixes a bug that config register is accessed without delay<br>
after reset.<br>
<a href=3D"https://lkml.org/lkml/2012/10/17/47" target=3D"_blank">https://l=
kml.org/lkml/2012/10/17/47</a><br>
<br>
v4:<br>
Reduce waiting time after resetting devices. A previous patch does reset<br=
>
like this:<br>
=A0 for (each device) {<br>
=A0 =A0 save config registers<br>
=A0 =A0 reset<br>
=A0 =A0 wait for 500 ms<br>
=A0 =A0 restore config registers<br>
=A0 }<br>
<br>
If there are N devices to be reset, it takes N*500 ms. On the other<br>
hand, the v4 patch does:<br>
=A0 for (each device) {<br>
=A0 =A0 save config registers<br>
=A0 =A0 reset<br>
=A0 }<br>
=A0 wait 500 ms<br>
=A0 for (each device) {<br>
=A0 =A0 restore config registers<br>
=A0 }<br>
Though it needs more memory space to save config registers, the waiting<br>
time is always 500ms.<br>
<a href=3D"https://lkml.org/lkml/2012/10/15/49" target=3D"_blank">https://l=
kml.org/lkml/2012/10/15/49</a><br>
<br>
v3:<br>
Move alloc_bootmem and free_bootmem to early_reset_pcie_devices so that<br>
they are called only once.<br>
<a href=3D"https://lkml.org/lkml/2012/10/10/57" target=3D"_blank">https://l=
kml.org/lkml/2012/10/10/57</a><br>
<br>
v2:<br>
Reset devices in setup_arch() because reset need to be done before<br>
interrupt remapping is initialized.<br>
<a href=3D"https://lkml.org/lkml/2012/10/2/54" target=3D"_blank">https://lk=
ml.org/lkml/2012/10/2/54</a><br>
<br>
v1:<br>
Add fixup_final quirk to reset PCIe devices<br>
<a href=3D"https://lkml.org/lkml/2012/8/3/160" target=3D"_blank">https://lk=
ml.org/lkml/2012/8/3/160</a><br>
<br>
Takao Indoh (5):<br>
=A0 x86, pci: add dummy pci device for early stage<br>
=A0 PCI: Define the maximum number of PCI function<br>
=A0 Make reset_devices available at early stage<br>
=A0 x86, pci: Reset PCIe devices at boot time<br>
=A0 x86, pci: Enable PCI INTx when MSI is disabled<br>
<br>
=A0arch/x86/include/asm/pci-direct.h | =A0 =A03 +<br>
=A0arch/x86/kernel/setup.c =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +<br>
=A0arch/x86/pci/common.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-<br>
=A0arch/x86/pci/early.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0315 +++++++++++++++=
++++++++++++++++++++++<br>
=A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +<br>
=A0init/main.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A04 +-<br=
>
=A06 files changed, 328 insertions(+), 3 deletions(-)<br>
<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
Please read the FAQ at =A0<a href=3D"http://www.tux.org/lkml/" target=3D"_b=
lank">http://www.tux.org/lkml/</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>------------=
------<br>Oliver Yang
</div></div>

--14dae93405c94b56fe04d159e6ed--


--===============8510998269326219100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============8510998269326219100==--

