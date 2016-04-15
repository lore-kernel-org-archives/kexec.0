Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqwJe-00017N-RL
 for kexec@lists.infradead.org; Fri, 15 Apr 2016 05:29:15 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: makedumpfile utility optimization
Date: Fri, 15 Apr 2016 05:24:31 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E3ACB9@BPXM01GP.gisp.nec.co.jp>
References: <D33479A1.2ECC3%hsiddulugari@nimblestorage.com>
In-Reply-To: <D33479A1.2ECC3%hsiddulugari@nimblestorage.com>
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
To: Hemanth Siddulugari <Hemanth.Siddulugari@nimblestorage.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

(CC'ing kexec-ML)

Hello Hemanth,

>Hi 'makedumpfile' utility developers,
>
>I'm using version 1.5.6 and I see that we can optimize the utility using this patch:
>
>--- makedumpfile-1.5.6/makedumpfile.c   2014-04-20 18:59:18.000000000 -0700
>+++ makedumpfile-1.5.6-changed/makedumpfile.c   2016-04-11 18:47:50.019563738 -0700
>@@ -6475,6 +6475,15 @@
>
>        for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>
>+               /*
>+                * There's no point in checking other pages if we've already dumped
>+                * all the pages that are dumpable
>+                */
>+               if (num_dumped == info->num_dumpable) {
>+                       ret = TRUE;
>+                       goto out;
>+               }
>+
>                if ((num_dumped % per) == 0)
>                        print_progress(PROGRESS_COPY, num_dumped, info->num_dumpable);
>
>Why are we looping even after we are done with all the dumpable pages to start with?
>I'm concerned if I'm missing something with this patch.

You are right, it's better to break the loop after the last dumpable page
is written. I neglected that since the remains of loop just check the
bitmap and call continue, I thought the wasteful processing cost is little.
I'm curious to know how much does this patch improve the performance.


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
