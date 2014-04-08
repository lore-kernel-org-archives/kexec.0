Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo200.gate.nec.co.jp ([210.143.35.50])
 by casper.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WXQ9i-00060F-UU
 for kexec@lists.infradead.org; Tue, 08 Apr 2014 07:09:17 +0000
Received: from tyo202.gate.nec.co.jp ([10.7.69.202])
 by tyo200.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id s3876onp018146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <kexec@lists.infradead.org>; Tue, 8 Apr 2014 16:06:50 +0900 (JST)
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 0/3] Generic multi-page exclusion
Date: Tue, 8 Apr 2014 07:02:09 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FF12B@BPXM01GP.gisp.nec.co.jp>
References: <cover.1396632131.git.ptesarik@suse.cz>
In-Reply-To: <cover.1396632131.git.ptesarik@suse.cz>
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

>Kumagai-san,
>
>this patch was inspired by this post of yours:
>
>http://lists.infradead.org/pipermail/kexec/2013-November/010445.html
>
>Unfortunately, this rewrite never happened, so I took the liberty of
>overtaking the job. I hope you don't mind.
>
>This is in fact a preparatory series to add hugepage support without
>having to care about the appropriate size of the cyclic buffer.

First, I'm sorry for my late work. This patch set will be very helpful
to me, so I'll wait for the fixed version.

I'm preparing to release v1.5.6 now and I'll focus on the work for
hugepage support after releasing v1.5.6.


Thanks
Atsushi Kumagai

>Changelog:
>* v2:
>  - Keep excluded regions per mem_map_data
>  - Process excluded pages in chunks
>
>Petr Tesarik (3):
>  Pass mmd pointer to __exclude_unnecessary_pages
>  Generic handling of multi-page exclusions
>  Get rid of overrun adjustments
>
> makedumpfile.c | 118 +++++++++++++++++++--------------------------------------
> makedumpfile.h |   7 ++++
> 2 files changed, 46 insertions(+), 79 deletions(-)
>
>--
>1.8.4.5
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
