Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d00WZ-0001Wd-LS
 for kexec@lists.infradead.org; Mon, 17 Apr 2017 06:52:37 +0000
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E04D57AE93
 for <kexec@lists.infradead.org>; Mon, 17 Apr 2017 06:44:42 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
Subject: [PATCH 2/2] kdumpctl: verify the kernel cmdline
Date: Mon, 17 Apr 2017 14:44:36 +0800
Message-Id: <1492411476-10548-2-git-send-email-piliu@redhat.com>
In-Reply-To: <1492411476-10548-1-git-send-email-piliu@redhat.com>
References: <1492411476-10548-1-git-send-email-piliu@redhat.com>
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

The invalid console param in cmdline could cause the emergency service's failure with STDIN error,
and the system can not reboot or enter the shell. This patch verify the cmdline and erase the
buggy param.

The invalid param can be reproduce by the following cmds
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
have no real backend device.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
---
 kdumpctl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kdumpctl b/kdumpctl
index d7f25d9..ee1b8c4 100755
--- a/kdumpctl
+++ b/kdumpctl
@@ -176,6 +176,26 @@ is_dump_to_rootfs()
 	grep "^default[[:space:]]dump_to_rootfs" /etc/kdump.conf >/dev/null
 }
 
+verify_cmdline()
+{
+	condevs=$(echo $1 | tr " " "\n" | grep "console=" | awk -F "=" '{ print $2 }')
+	echo $condevs
+	verified_cmdline=$1
+	for condev in $condevs
+	do
+	        echo "test $condev"
+	        if [[ $condev =~ /dev/* ]]; then
+	                echo "kexec-tools test $condev" > $condev
+	        else
+	                echo "kexec-tools test $condev" > /dev/$condev
+	        fi
+	        if [ $? -ne 0 ]; then
+	                verified_cmdline=$(echo $verified_cmdline | sed -n "s/console=$condev/ /p")
+	        fi
+	done
+	echo $verified_cmdline
+}
+
 # This function performs a series of edits on the command line.
 # Store the final result in global $KDUMP_COMMANDLINE.
 prepare_cmdline()
@@ -211,6 +231,7 @@ prepare_cmdline()
 		cmdline=`append_cmdline "${cmdline}" disable_cpu_apicid ${id}`
 	fi
 
+	cmdline=`verify_cmdline "$cmdline"`
 	KDUMP_COMMANDLINE=$cmdline
 
 	check_kdump_cpus
-- 
2.7.4


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
