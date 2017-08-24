Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dkiQn-00015I-2m
 for kexec@lists.infradead.org; Thu, 24 Aug 2017 03:03:43 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2 0/2] makedumpfile/ppc64: enable mem-usage option
Date: Thu, 24 Aug 2017 03:00:58 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701EFF64E@BPXM01GP.gisp.nec.co.jp>
References: <1503285846-11432-1-git-send-email-piliu@redhat.com>
In-Reply-To: <1503285846-11432-1-git-send-email-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Pingfan,

>v1->v2:
>    follow the scheme for arch dependent code

This is what I expected, thanks!
I'll merge this into v1.6.3.

Regards,
Atsushi Kumagai

>Pingfan Liu (2):
>  makedumpfile/ppc64: set page_offset in get_versiondep_info_ppc64()
>  makedumpfile/ppc64: get the info of mem reserved for crashkernel
>
> arch/ppc64.c   | 37 +++++++++++++++++++++++++++++++++++++
> makedumpfile.c |  3 +++
> makedumpfile.h | 11 +++++++++++
> 3 files changed, 51 insertions(+)
>
>--
>2.7.4
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
