Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WVXZr-0005gP-50
 for kexec@lists.infradead.org; Thu, 03 Apr 2014 02:40:29 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 0/2]  Allow Xen Dom0 page filtering
Date: Thu, 3 Apr 2014 02:38:17 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971FCBD1@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE971FAC57@BPXM01GP.gisp.nec.co.jp>
 <1396008496-15151-1-git-send-email-ptesarik@suse.cz>
In-Reply-To: <1396008496-15151-1-git-send-email-ptesarik@suse.cz>
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

This looks good to me, I'll merge it into v1.5.6.


Thanks
Atsushi Kumagai

>Trying to use makedumpfile on a Xen Dom0 ELF file currently fails, but there
>are in fact only a few missing pieces. With the following two patches, I was
>able to produce a dump even with high dump levels (-d17 and -d31).
>
>Needless to say, this can reduce the size of Dom0 dumps considerably.
>
>Changes in v2:
>
>* Call get_machdep_info() after cache_init(), so it can use readmem(VADDR, ...)
>
>This now works for me after reverting commit ebe2fa3a.
>
>Petr Tesarik (2):
>  Earlier initialization of dom0_mapnr
>  Get Dom0 max_pfn using pfn_mfn_frame_list if max_pfn unavailable
>
> makedumpfile.c | 35 ++++++++++++++++++++++++++++-------
> 1 file changed, 28 insertions(+), 7 deletions(-)
>
>--
>1.8.4.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
