Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ek98N-0003i4-5C
 for kexec@lists.infradead.org; Fri, 09 Feb 2018 13:54:36 +0000
Received: by mail-qk0-x241.google.com with SMTP id w128so10046830qkb.5
 for <kexec@lists.infradead.org>; Fri, 09 Feb 2018 05:54:23 -0800 (PST)
MIME-Version: 1.0
From: Gioh Kim <gurugio@gmail.com>
Date: Fri, 9 Feb 2018 14:54:22 +0100
Message-ID: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
Subject: how to use kexec to jump back to the original kernel
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
To: kexec@lists.infradead.org

Hello,

"echo c > /proc/sysrq-trigger" generates the kernel dump but it
reboots the system.
I'd like to generate kernel dump without system reboot.

I think it is possible to jump to the kdump kernel and generate kernel
dump, and come back to the operating kernel with kexec.
I know I can jump to the kdump kernel with "kexec -e" but I cannot
figure out how to come back to the operating kernel.

For example, I tried following sequences after reading kexec manual page.

0. rebuild kernel with CONFIG_KEXEC_JUMP option
1. kexec --load=/boot/vmlinuz --initrd=/boot/initrd --reuse-cmdline
2. kexec -e
3. now kdump kernel is running
4. kexec --load-jump-back-helper --entry=<ADDRESS>
5. kexec -e

I can jump to the kdump kernel with step 1 and step 2.
kexec manual says I need an entry address.
I don't know what address I should use.
I found a email thread about jump_back_entry= but there is no
parameter like jump_back_entry in kernel booting parameters of
v4.4~v4.14.

Does anybody know how to use kexec to jump between kdump kernel and
operating kernel?


-- 

Best regards,
Gioh Kim

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
