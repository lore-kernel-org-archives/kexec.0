Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d00Pp-00027T-2r
 for kexec@lists.infradead.org; Mon, 17 Apr 2017 06:45:38 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3576C7AE83
 for <kexec@lists.infradead.org>; Mon, 17 Apr 2017 06:44:41 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 1/2] kdump-lib-initramfs.sh: ignore the failure of echo
Date: Mon, 17 Apr 2017 14:44:35 +0800
Message-Id: <1492411476-10548-1-git-send-email-piliu@redhat.com>
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
Cc: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>

The kdump-capture.service will fail, if the following conds are meet up.
-1. boot up a VM with the following cmd:
qemu-kvm   -name 'avocado-vt-vm1'  -sandbox off    -machine pc   -nodefaults  -vga cirrus \
    -drive id=drive_image1,if=none,snapshot=off,aio=native,cache=none,format=qcow2,file=$guest_img \
    -device virtio-blk-pci,id=image1,drive=drive_image1,bootindex=0,bus=pci.0,addr=04 \
    -device virtio-net-pci,mac=9a:4d:4e:4f:50:51,id=id3DveCw,vectors=4,netdev=idgW5YRp,bus=pci.0,addr=05 \
    -netdev tap,id=idgW5YRp \
    -m 2048  \
    -smp 4,maxcpus=4,cores=2,threads=1,sockets=2  \
    -cpu 'SandyBridge',+kvm_pv_unhalt \
    -vnc :0  \
    -rtc base=utc,clock=host,driftfix=slew  \
    -boot order=cdn,once=c,menu=off,strict=off \
    -enable-kvm \
    -monitor stdio \
    -qmp tcp:localhost:4444,server,nowait
-2. in kernel cmdline with the following options: console=tty0 console=ttyS0,

Because the  "-nodefaults" option in qemu cmd excludes the emulation of serial port, the ttyS0 will
have no real backend device. We can observe such issue in 1st kernel by:
	echo teststring > /dev/console or
	echo teststring > /dev/ttyS0,
It gets the error "-bash: echo: write error: Input/output error".
Such conds cause small issue in 1st kernel, but it is a big problem for kdump-capture and emergency
service.

This patch aims to work aroundthe issue in kdump-capture service:
dump_fs() return value will affect the following code in dracut-kdump.sh
	DUMP_RETVAL=$?    <---
	do_kdump_post $DUMP_RETVAL
	if [ $? -ne 0 ]; then
	    echo "kdump: kdump_post script exited with non-zero status!"
	fi

Although kdump-capture saves the vmcore successfully, but it exit 1 and
fall on emergency service.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kdump-lib-initramfs.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kdump-lib-initramfs.sh b/kdump-lib-initramfs.sh
index 4c0e2e2..2c18c87 100755
--- a/kdump-lib-initramfs.sh
+++ b/kdump-lib-initramfs.sh
@@ -111,6 +111,8 @@ dump_fs()
     sync
 
     echo "kdump: saving vmcore complete"
+    # improper kernel cmdline can cause the failure of echo, we can ignore this kind of failure
+    return 0
 }
 
 save_vmcore_dmesg_fs() {
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
