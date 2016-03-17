Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1agRpy-0007rA-Hp
 for kexec@lists.infradead.org; Thu, 17 Mar 2016 06:55:16 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: Kernel support for makedumpfile upcoming release
Date: Thu, 17 Mar 2016 06:46:37 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E326FE@BPXM01GP.gisp.nec.co.jp>
References: <56E985A5.7060104@canonical.com> <56E98663.9060303@canonical.com>
In-Reply-To: <56E98663.9060303@canonical.com>
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
To: Louis Bouchard <louis.bouchard@canonical.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Louis,

>Hello,
>
>I see in the development branch for makedumpfile that the upcoming release plans
>to support kernels for up to 4.2
>
>Are there any plans to go any higher than that before the next release comes out
>? This way I can prepare a bit as our next release will come with a 4.4 kernel
>and it will also be made available in our previous LTS release.
>
>Kind regards,

makedumpfile v1.6.0 will support kernel 4.5, and it will be released in May.

I have updated the devel branch, now it includes the fixes for 4.4 and 4.5.
(please see the tag "Required for kernel X.Y")
The fix for 4.4 is necessary to exclude hugepages correctly in 4.4 and latter.
Moreover, the upstream kernel doesn't export the required VMCOREINFO yet,
you need to pull the patch below into your 4.4 kernel.

  https://lkml.org/lkml/2016/3/1/25

Thanks,
Atsushi Kumagai

>...Louis
>
>--
>Louis Bouchard
>Software engineer, Cloud & Sustaining eng.
>Canonical Ltd
>Ubuntu developer                       Debian Maintainer
>GPG : 429D 7A3B DD05 B6F8 AF63  B9C4 8B3D 867C 823E 7A61

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
