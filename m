Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X2UjF-0007qd-OW
 for kexec@lists.infradead.org; Thu, 03 Jul 2014 00:18:22 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: makedumpfile and elfutils
Date: Thu, 3 Jul 2014 00:16:04 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9723B871@BPXM01GP.gisp.nec.co.jp>
References: <007BD92917A2324FA403BCF9A464CF845CBC0690@ALA-MBB.corp.ad.wrs.com>
In-Reply-To: <007BD92917A2324FA403BCF9A464CF845CBC0690@ALA-MBB.corp.ad.wrs.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: "joe.slater@windriver.com" <joe.slater@windriver.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Joe,

> I am updating a bitbake recipe to build makedumpfile 1.5.6.  The current
> recipe builds 1.4.4 and includes a version of elfutils.  For 1.5.6 you say
> to use elfutils-0.142 but we already have version 0.158 so I don't see why
> we should need an older version, too.  makedumpfile builds linking to
> elfutils-0.158.
>
>
>
> Do we really need elfutils-0.142?

No, 0.142 or later are OK, you don't need to downgrade it.
However, I didn't test the recent versions of elfutils, so please let me
know if you find any problems.

  commit ecafa7639b931151ff62d33e26f3746981c7c128
  Author: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
  Date:   Wed Sep 5 16:10:34 2012 +0900

      [PATCH] Update necessary elfutils version.

      For some vmlinux, -g option needs new elfutils(0.142 or later).
      Therefore, this patch updates the version in README file.

      Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>


Thanks
Atsushi Kumagai

>
>
>
>Joe
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
