Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zt8BP-0005Gn-So
 for kexec@lists.infradead.org; Mon, 02 Nov 2015 06:01:32 +0000
Received: by lfbn126 with SMTP id n126so56748881lfb.2
 for <kexec@lists.infradead.org>; Sun, 01 Nov 2015 22:01:10 -0800 (PST)
MIME-Version: 1.0
Date: Mon, 2 Nov 2015 11:31:09 +0530
Message-ID: <CAF4mCy1_k96TsBVBowZXT7dqaM76KZyBSxrAzw7BDd28u_0SwQ@mail.gmail.com>
Subject: PCI device dump in kdump
From: shalini singhal <embshalini01@gmail.com>
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

Hi,

Does the dump provided by kdump has information about PCI devices?
The information can be name of PCI device, physical memory, registers
mapped etc. Can I check the state of  PCI register set also with
machine specific register set while debugging dump generated with
kdump.


Thanks &Regards,
Shalini

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
