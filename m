Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a6wR0-0004KA-QO
 for kexec@lists.infradead.org; Thu, 10 Dec 2015 08:19:19 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH 0/4] ARM64: 3 Level page support
Date: Thu, 10 Dec 2015 08:14:52 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E0C31E@BPXM01GP.gisp.nec.co.jp>
References: <cover.1449332470.git.panand@redhat.com>
In-Reply-To: <cover.1449332470.git.panand@redhat.com>
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
Cc: "timur@codeaurora.org" <timur@codeaurora.org>, "asamson@codeaurora.org" <asamson@codeaurora.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "rruigrok@codeaurora.org" <rruigrok@codeaurora.org>, "sgoel@codeaurora.org" <sgoel@codeaurora.org>, "dyoung@redhat.com" <dyoung@redhat.com>

Hello Pratyush,

>Hi Atsushi,
>
>ARM64 was supporting only two level page support. These patches add support
>for 3 level page table as well.
>
>~Pratyush

Thanks for your work, I'll merge these patches into v1.6.0.

Regards,
Atsushi Kumagai

>Pratyush Anand (3):
>  ARM64: Refactor code to support multiple page level
>  arm64: Decide VA Bits on the basis of _stext symbol value
>  arm64: Fix KVBASE
>
>Sameer Goel (1):
>  arm64: Fix for ARM64 3 level translation tables
>
> arch/arm64.c   | 103 +++++++++++++++++++++++++++++++++++++++++++++++++++------
> makedumpfile.h |  29 +++-------------
> 2 files changed, 98 insertions(+), 34 deletions(-)
>
>--
>2.5.0
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
