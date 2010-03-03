Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1NmrWi-0004DV-VC
	for kexec@lists.infradead.org; Wed, 03 Mar 2010 16:34:29 +0000
Received: by gyd12 with SMTP id 12so779063gyd.36
	for <kexec@lists.infradead.org>; Wed, 03 Mar 2010 08:34:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100303110527.11233.20400.stgit@muvarov>
References: <20100303110527.11233.20400.stgit@muvarov>
Date: Thu, 4 Mar 2010 00:34:22 +0800
Message-ID: <e997b7421003030834r7bec3295s7917bb91a3fa2d27@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS kexec,kdump support
From: "wilbur.chan" <wilbur512@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Maxim Uvarov <muvarov@gmail.com>
Cc: linux-mips@linux-mips.org, horms@verge.net.au, kexec@lists.infradead.org, ralf@linux-mips.org

2010/3/3 Maxim Uvarov <muvarov@gmail.com>:
> Hello folks,
>
> Please find here MIPS crash and kdump patches.
> This is patch set of 3 patches:
> 1. generic MIPS changes (kernel);
> 2. MIPS Cavium Octeon board kexec/kdump code (kernel);
> 3. Kexec user space MIPS changes.
>
> Patches were tested on the latest linux-mips@ git kernel and the latest
> kexec-tools git on Cavium Octeon 50xx board.
>
> I also made the same code working on RMI XLR/XLS boards for both
> mips32 and mips64 kernels.
>
> Best regards,
> Maxim Uvarov.
>

> Signed-off-by: Maxim Uvarov <muvarov@gmail.com>
>
>
>

Hi, Maxim

In XLR series ,

1)How to protect  boardinfo and pass it to second kernel ?

2)If all cpus jumped to same entry point , did you change head.s  ,if so , how ?



Thank you!

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
