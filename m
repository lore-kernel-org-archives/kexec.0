Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VeFlM-00026L-Dt
 for kexec@lists.infradead.org; Thu, 07 Nov 2013 02:56:05 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 0/2] makedumpfile: write out a whole part of the 1st
 bitmap before entering cyclic process
Date: Thu, 7 Nov 2013 02:52:57 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971BBEC2@BPXM01GP.gisp.nec.co.jp>
References: <20131104152202.2556.83382.stgit@localhost6.localdomain6>
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
To: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>

(2013/11/05 0:23), HATAYAMA Daisuke wrote:
> This patch set changes the implementation so that a whole part of the
> 1st bitmap is written out before entering cyclic process. By this:
>
> - we no longer need to keep buffer for the 1st bitmap during cyclic
>    process, and
>
> - it's possible for incomplete crash dump, for example, generated in
>    case of ENOSPC, to avoid the case that we don't know where memory is
>    present.
>
> Note that this patch only deal with a conversion from ELF to
> kdump-compressed format only, not from ELF to ELF.
>
> ChangeLog
>
> v1 => v2)
>
> - Fix a bug of assigning wrong cyclic buffer size from free memory
>    size.

Thanks for fixing, I'll merge this into v1.5.5.


Atsushi Kumagai

>
> ---
>
> HATAYAMA Daisuke (2):
>        Use memset() to improve the 1st bitmap initialization performance
>        Write out a whole part of the 1st bitmap before entering cyclic process
>
>
>   makedumpfile.c |  268 ++++++++++++++++++++++++++++++++++++++++++++++++++------
>   1 file changed, 241 insertions(+), 27 deletions(-)
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
