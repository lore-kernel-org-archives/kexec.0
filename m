Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fCtsk-0004CI-Oz
 for kexec@lists.infradead.org; Sun, 29 Apr 2018 21:29:20 +0000
Received: by mail-pg0-f66.google.com with SMTP id m21-v6so5009897pgv.8
 for <kexec@lists.infradead.org>; Sun, 29 Apr 2018 14:29:08 -0700 (PDT)
From: Bhupesh Sharma <bhsharma@redhat.com>
Subject: [PATCH v3 0/2] Add capability to dump fdt blob for arm64 platforms
Date: Mon, 30 Apr 2018 02:52:34 +0530
Message-Id: <1525036956-7440-1-git-send-email-bhsharma@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Bhupesh Sharma <bhsharma@redhat.com>, takahiro.akashi@linaro.org, horms@verge.net.au, james.morse@arm.com, bhupesh.linux@gmail.com, dyoung@redhat.com

Changes since v1:
----------------
 - Added ascii prints for printing bootargs.
 - v2 can be viewed here: http://lists.infradead.org/pipermail/kexec/2018-April/020532.html

Changes since v1:
----------------
 - No functional changes: Just added a cover letter to explain the
   background better and also capture some details on where I found this
   patchset handy. Also added some dtb dumps logs from 'kexec -p -d' for
   reference (with this patchset applied) for clarity.
 - v1 can be viewed here: http://lists.infradead.org/pipermail/kexec/2018-April/020407.html

While working on a couple of issues related to primary kernel crash on freescale
and huawei arm64 boards, I noticed that the primary kernel crashed before it could reach
the command prompt but was able to launch some early initramfs scriptware. 

In the initial initramfs scriptware crashkernel loading was automated along
with auto load of other userspace applications (for e.g. on the freescale board
there are networking applications like ODP/DPDK which can be launched automatically via
scriptware).

I was hoping that the crashkernel would be able to load when the primary kernel crashes,
and using the crash core dump thus obtained, I would be able to debug the problem which
caused the primary kernel to crash late in the boot flow (before reaching the boot prompt).

Unfortunately currently we can experience an early crash in crashkernel itself
(on such example is the 'acpi table access' issue in the arm64 crashkernel
which we discussed some time back upstream
<https://www.spinics.net/lists/arm-kernel/msg616632.html>):

In such cases, we have no opportunity to obtain the crash core dump which can be
used to debug the primary kernel crash.

Now, looking at just the panic messages from the crashkernel in such cases is sometimes
not very useful in debugging what might have caused it to crash when the primary kernel
is able to atleast boot past that point on the same hardware platform.

Debugging the issue closer (especially on the request for help on the freescale board), I
realized that the crashkernel crash may be caused by improper/buggy fixing of 'dtb'
being passed to the crashkernel - especially the 'linux,usable-memory-range' property.

For such cases, I found that dumping the dtb blob entries from kexec-tools is
a useful debugging tip as I could identify the 'linux,usable-memory-range'
property did not contain ACPI RECLAIM region entries.

Please note that since the primary kernel crashes before the command prompt
can be reached, it is not possible to run a dtc interpreter there (and it
also adds the requirement for an additional 'dtc' tool to be present in the initramfs).

Also, it might not be possible to always correctly time the 'dtc' interpreter loading
via the initramfs scriptware and store the binary/hex output to a storage device
just after the crashkernel is loaded via 'kexec -p' as the storage driver itself
might have panick'ed during the meanwhile.

In view of the above, it would be useful to dump the fdt blob being passed to the second
(kexec/kdump) kernel when '-d' flag is specified while invoking kexec/kdump. This allows
 one to look at the device-tree fields that is being passed to the secondary
kernel and accordingly debug issues.

This can be specially useful for the arm64 case, where we are still fixing up some issues
with the upstream kexec-tools/arm64 kernel.

I loathe to keep this patch locally and apply it locally on top of the upstream 'kexec-tools'
patches when debugging such issues, so it would be probably good to have this feature
available in upstream itself.

Here is an example output of the dtb dump(on an arm64 board), on serial console with
the patchset applied and 'kexec -p' launched used with a '-d' flag using initramfs scriptware:

<..snip..>

setup_2nd_dtb: found /sys/firmware/fdt
 / {
    #size-cells = <0x00000002>;
    #address-cells = <0x00000002>;
    chosen {
        linux,usable-memory-range = <0x00000000 0xdfe00000 0x00000000 0x20000000>;
        linux,elfcorehdr = <0x00000000 0xffdf0000 0x00000000 0x00001400>;
        kaslr-seed = <0x00000000 0x00000000>;
        linux,uefi-mmap-desc-ver = <0x00000001>;
        linux,uefi-mmap-desc-size = <0x00000030>;
        linux,uefi-mmap-size = <0x000020a0>;
        linux,uefi-mmap-start = <0x00000000 0x07a81018>;
        linux,uefi-system-table = <0x00000000 0x17fc0018>;
	bootargs = "root=/dev/mapper/rhel_qualcomm--amberwing--rep--15-root ro rd.lvm.lv=rhel_qualcomm-amberwing-rep-15/root rd.lvm.lv=rhel_qualcomm-amberwing-rep-15/swap";
        linux,initrd-end = <0x00000000 0x05e8a7a1>;
        linux,initrd-start = <0x00000000 0x04b49000>;
    };
 };

<..snip..>

Bhupesh Sharma (2):
  dt-ops: Add helper API to dump fdt blob
  kexec-arm64: Add functionality to dump 2nd dtb

 kexec/arch/arm64/kexec-arm64.c |   3 +-
 kexec/dt-ops.c                 | 143 +++++++++++++++++++++++++++++++++++++++++
 kexec/dt-ops.h                 |   1 +
 3 files changed, 146 insertions(+), 1 deletion(-)

-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
