Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZVMV-0003Tg-AZ
 for kexec@lists.infradead.org; Tue, 26 Nov 2019 07:34:16 +0000
Received: by mail-il1-x143.google.com with SMTP id f6so12729265ilh.9
 for <kexec@lists.infradead.org>; Mon, 25 Nov 2019 23:34:14 -0800 (PST)
MIME-Version: 1.0
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Tue, 26 Nov 2019 13:04:02 +0530
Message-ID: <CAJ2QiJLBcmdVrmJmfKehadUzzUkmMsn8b2BxmGh7LHXzo7PtJw@mail.gmail.com>
Subject: kexec-tools/vmcore-demsg: No program header covering vaddr
 0xffff000be7a00000found kexec bug?
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
To: kexec mailing list <kexec@lists.infradead.org>, Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, Prabhakar Kushwaha <pkushwaha@marvell.com>

Hi All,

I am facing issue below error with latest kexec-tools/vmcore-demsg tools.

$ ./build/sbin/vmcore-dmesg /proc/vmcore
No program header covering vaddr 0xffff000be7a00000found kexec bug?

I am testing on AARM64 platform with following git repos.
A) kexec tools:
https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
top commit: bd077966e2b9041c (kexec-tools: Fix conversion overflow
when compiling on 32-bit platforms)

B) Linux:git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
top commit: af42d3466bdc8f3980 (Linux 5.4-rc8)

I am seeing similar issue in past also in couple of discussions. has
it not fixed earlier or it keep arises with time to time

Please suggest.

--pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
