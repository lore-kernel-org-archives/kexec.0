Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WrKLA-0000Cw-CY
 for kexec@lists.infradead.org; Mon, 02 Jun 2014 04:59:21 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v4 0/2] Generic multi-page exclusion
Date: Mon, 2 Jun 2014 04:58:01 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE97216561@BPXM01GP.gisp.nec.co.jp>
References: <cover.1401098094.git.ptesarik@suse.cz>
In-Reply-To: <cover.1401098094.git.ptesarik@suse.cz>
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
To: "ptesarik@suse.cz" <ptesarik@suse.cz>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Petr,

>Kumagai-san,
>
>this patch was inspired by this post of yours:
>
>http://lists.infradead.org/pipermail/kexec/2013-November/010445.html
>
>This is a preparatory series to add hugepage support without having
>to care about the appropriate size of the cyclic buffer.
>
>Changelog:
>* v2:
>  - Keep excluded regions per mem_map_data
>  - Process excluded pages in chunks
>
>* v3:
>  - Keep excluded region extents in struct cycle
>
>* v4:
>  - Make sure that the excluded region extents are reset when
>    a new ELF segment is processed.

This version looks good to me, I'll merge it into v1.5.7.
Thanks for your great work!


Atsushi Kumagai

>Petr Tesarik (2):
>  Generic handling of multi-page exclusions
>  Get rid of overrun adjustments
>
> makedumpfile.c | 111 ++++++++++++++++++++-------------------------------------
> makedumpfile.h |   5 +++
> 2 files changed, 43 insertions(+), 73 deletions(-)
>
>--
>1.8.4.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
