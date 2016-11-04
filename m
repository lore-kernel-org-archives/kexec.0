Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c2bvl-00056B-KD
 for kexec@lists.infradead.org; Fri, 04 Nov 2016 10:41:06 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Makedumpfile PATCH V2 0/4] x86_64: Fix page_offset for
 randomized base enabled
Date: Fri, 4 Nov 2016 10:35:29 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E7CFDE@BPXM01GP.gisp.nec.co.jp>
References: <cover.1477901442.git.panand@redhat.com>
In-Reply-To: <cover.1477901442.git.panand@redhat.com>
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
To: Pratyush Anand <panand@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "louis.bouchard@canonical.com" <louis.bouchard@canonical.com>, "dyoung@redhat.com" <dyoung@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

Hello Pratyush,

>Patch 1/4 fixes page_offset calculation, so that it is correctly calculated
>on KASLR enabled kernel as well.
>Patch 2/4 simplifies VA to PA translation. New code has been benchmarked
>against old code on a 4T system.
>Patch 3/4 and 4/4 is removal of (now) unnecessary code.
>
>I think, we should find a way to kill find_vememmap() as well, so that
>VMEMMAP_START can be removed. I have very limited idea about x86, so unable
>to do that as of now.
>
>Changes since V1:
>* A bug in patch 1/4 fixed
>* Patch log of 2/4 improved to include more number of trials

The most of concern was the performance degradation, but
there is no degradation in the additional benchmark.
So I decide to merge this patch set into v1.6.1,
thanks for your work.


Regards,
Atsushi Kumagai

>Pratyush Anand (4):
>  x86_64: Calculate page_offset from pt_load
>  x86_64: translate all VA to PA using page table values
>  x86_64: kill is_vmalloc_addr_x86_64()
>  x86_64: kill some unused initialization
>
> arch/x86_64.c  | 84 ++++++++++++++++++++--------------------------------------
> makedumpfile.h |  9 +++----
> 2 files changed, 32 insertions(+), 61 deletions(-)
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
