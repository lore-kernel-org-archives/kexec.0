Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WPgk0-0001p0-5T
 for kexec@lists.infradead.org; Mon, 17 Mar 2014 23:14:44 +0000
Received: by mail-pa0-f51.google.com with SMTP id kq14so6396289pab.38
 for <kexec@lists.infradead.org>; Mon, 17 Mar 2014 16:14:20 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 17 Mar 2014 16:14:20 -0700
Message-ID: <CAGXD9OdBdxQ32wv3eY1Nwg1g8dPj_83teaFb8f4pm8QJQQsuGQ@mail.gmail.com>
Subject: vmcore-dmesg exits with "No program header covering vaddr"
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

In my 64bit, 3.4 kernel, I'm increasing dmesg buffer size at runtime
by passing log_buf_len=512K at command line. At compile time, I have
LOG_BUF_LEN as
256K. However, when this kernel crashes (crashkernel set at 64M),
vmcore-dmesg fails with below error. I tried with both
kexec-tools-2.0.4 and 2.0.6.

No program header covering vaddr 0xffff88013ff00000found kexec bug?


Thank you.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
