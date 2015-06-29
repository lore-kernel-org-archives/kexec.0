Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z9UYg-0005ek-QL
 for kexec@lists.infradead.org; Mon, 29 Jun 2015 08:36:55 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 1/2] makedumpfile: Add description of pages lost by
 ENOSPACE in IMPLEMENTATION
Date: Mon, 29 Jun 2015 08:33:37 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DCA526@BPXM01GP.gisp.nec.co.jp>
References: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
In-Reply-To: <1435220576-32595-1-git-send-email-zhouwj-fnst@cn.fujitsu.com>
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
To: "zhouwj-fnst@cn.fujitsu.com" <zhouwj-fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Zhou,

>Currently, there is no obvious description in IMPLEMENTATION for
>distinguishing the lost pages resulted by ENOSPACE errors or others.
>So, it is added.
>
>Signed-off-by: Zhou Wenjian <zhouwj-fnst@cn.fujitsu.com>
>---
> IMPLEMENTATION |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
>diff --git a/IMPLEMENTATION b/IMPLEMENTATION
>index 72df5d5..70a3f7c 100644
>--- a/IMPLEMENTATION
>+++ b/IMPLEMENTATION
>@@ -240,6 +240,8 @@
>     The page header and page data are written in pairs. When writing page data
>     (pfn N+1), if ENOSPACE error happens, the page headers after N won't be
>     written either.
>+    When reading page from incomplete core, only the page lost by ENOSPACE errors
>+    has 0 in its corresponding page descriptor's member offset.

I'm not sure this is correct.
Could you point me where is the code which sets 0 to the page_desc->offset
of the lost page ?


Thanks
Atsushi Kumagai

>     If there is no page data dumped into the DUMPFILE, the DUMPFILE can't be
>     analysed by crash.
>--
>1.7.1
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
