Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YvdRc-0007st-8r
 for kexec@lists.infradead.org; Fri, 22 May 2015 03:16:21 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: Makedumpfile and kernel support
Date: Fri, 22 May 2015 03:14:38 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701DB6F8A@BPXM01GP.gisp.nec.co.jp>
References: <555DA405.1070002@canonical.com>
In-Reply-To: <555DA405.1070002@canonical.com>
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
To: "louis.bouchard@canonical.com" <louis.bouchard@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Louis,

>- From time to time, on the distribution side, we get reports that makedumpfile
>says the kernel version is not supported with the following message :
>
>"The kernel version is not supported.
>The created dumpfile may be incomplete. "
>
>Depending on the kernel and makedumpfile versions, it can be either
>disregarded or it requires fixing on the distribution. For instance, with
>Kumagai's help, I backported the required commits so makedumpfile on Jessie
>(1.5.3) would not complain about Jessie's kernels (3.16).
>
>While we can review each patch to identify those who have specific kernel
>requirements, would it be possible to identify a way to highlight those
>patches so they become easily identifiable for potential backport ?
>
>Maybe something like "[kernel]" in the git log or specific mention in the
>commit log.  I would like to avoid going back to upstream to confirm that the
>proper patches are being identified.
>
>Any comments, toughts, concerns ?

How about inserting a label like "* Required for kernel X.YY"
into the first line of the commit log ?

It's better if contributors write it by themselves, otherwise
I'll add it when merging.


Thanks,
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
