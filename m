Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-vc0-x22e.google.com ([2607:f8b0:400c:c03::22e])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WOhJw-0007uq-42
 for kexec@lists.infradead.org; Sat, 15 Mar 2014 05:39:44 +0000
Received: by mail-vc0-f174.google.com with SMTP id ld13so3669883vcb.19
 for <kexec@lists.infradead.org>; Fri, 14 Mar 2014 22:39:19 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 14 Mar 2014 22:39:18 -0700
Message-ID: <CAGXD9OcJZGPaqy+=p7_gio_vRXVxrK73LjSjteto6iiqo2a=nA@mail.gmail.com>
Subject: vmcore-dmesg ends with "No program header covering vaddr"
From: Prasad Koya <prasad.koya@gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Hi

I'm increasing dmesg buffer size at runtime by passing log_buf_len=1M
(or 512K) at command line. At compile time, I have LOG_BUF_LEN as
256K. However, when this kernel crashes (crashkernel set at 64M),
vmcore-dmesg fails with below error.

No program header covering vaddr 0xffff88013ff00000found kexec bug?

Am I missing something here?

Thank you.

Here are some debugs I added to kernel. This is with 3.4 kernel and
I've tried with kexec-tools-2.0.4.

[    0.000000] log_buf_len_setup: log_buf_len 262144 new 1048576
ffffffff8170b140
[    0.000000] setup_log_buf: early 1 262144 new_log_buf_len 1048576
[    0.000000] log_buf_len: 1048576 ffff880037d58000
[    0.000000] early log buf free: 258671(98%)
[    0.000000] setup_log_buf: early 0 1048576 new_log_buf_len 0
[    0.503752] log_buf_kexec_setup: lbl 1048576 new 0 ffffffff816198c4
logbuf ffff880037d58000
In kdump, running vmcore_dmesg /proc/vmcore
No program header covering vaddr 0xffff88013ff00000found kexec bug?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
