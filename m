Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XWhST-0004fa-5w
 for kexec@lists.infradead.org; Wed, 24 Sep 2014 07:57:54 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH v2 resend 3/3] makedumpfile: implementation of dealing
 with kdump-compressed dumpfile with ENOSPC error
Date: Wed, 24 Sep 2014 07:55:41 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701D49426@BPXM01GP.gisp.nec.co.jp>
References: <5420CA45.5050009@cn.fujitsu.com>
 <5420CB1E.7060801@cn.fujitsu.com> <54223BB8.1090505@cn.fujitsu.com>
In-Reply-To: <54223BB8.1090505@cn.fujitsu.com>
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
To: "wangx.fnst@cn.fujitsu.com" <wangx.fnst@cn.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>Hello,
>
>Does anyone have some comments about my pathes?

Could you rebase them on the current master branch and
fix space indent ? It will be helpful to review the code.


Thanks
Atsushi Kumagai

>
>--
>Regards
>Wang Xiao
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
