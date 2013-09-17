Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VLogX-0004Uy-F5
 for kexec@lists.infradead.org; Tue, 17 Sep 2013 06:22:55 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH 0/2] makedumpfile, sadump: fix two GUID print bugs
Date: Tue, 17 Sep 2013 06:20:54 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971B1AA1@BPXM01GP.gisp.nec.co.jp>
References: <20130913105216.2332.8060.stgit@localhost6.localdomain6>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello HATAYAMA-san,

(2013/09/13 19:54), HATAYAMA Daisuke wrote:
> Hello Kumagai-san,
>
> These are fixing the two bugs in printing GUID on sadump format.
> Could you apply these?

Sure, I'll merge these into v1.5.5.


Thanks
Atsushi Kumagai

> These patchs are built on top of v1.5.4.
>
> ---
>
> HATAYAMA Daisuke (2):
>        sadump: correct buffer size for GUID EFI text representation
>        sadump: convert the first three fields of EFI GUID from little-endian into big-endian
>
>
>   sadump_info.c |   10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
