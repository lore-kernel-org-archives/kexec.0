Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bfkE6-00059r-8X
 for kexec@lists.infradead.org; Fri, 02 Sep 2016 08:53:32 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: "kernel version not supported" message is causing concerns
Date: Fri, 2 Sep 2016 08:50:45 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E63A46@BPXM01GP.gisp.nec.co.jp>
References: <57C58A20.7000704@canonical.com>
In-Reply-To: <57C58A20.7000704@canonical.com>
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
To: Louis Bouchard <louis.bouchard@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Louis,

>Hello,
>
>Every so often, I get questions or bug report about the fact that makedumpfile
>issues the following message when running :
>
>   The kernel version is not supported.
>   The created dumpfile may be incomplete.
>
>While I understand the requirement for this message, it almost systematically is
>understood by users as "makedumpfile is broken".

I don't think the message itself is bad, the situation for users has
a problem, I guess.
If a distribution provides a combination of a kernel and a makedumpfile
which doesn't support it, it stands to reason that users send a bug report.

>I would like to discuss the opportunity of changing the wording of this message
>so it appears less confusing. Maybe something like :
>
>Warning: makedumpfile has not been tested on this version of the kernel.
>         If the created dumpfile is incomplete, you may need to upgrade to a
>         newer version of makedumpfile.

I suspect such message doesn't make sense because even the latest makedumpfile
doesn't support the kernel version in your most cases, right ?

I know I have to work harder for following up the latest kernel ASAP,
but I don't agree with your suggestion.


Thanks,
Atsushi Kumagai

>I would be happy to propose a pull request for such a change if accepted.
>
>Kind regards,
>
>...Louis
>
>
>--
>Louis Bouchard
>Software engineer, Cloud & Sustaining eng.
>Canonical Ltd
>Ubuntu developer                       Debian Maintainer
>GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
