Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Viacl-00046x-9A
 for kexec@lists.infradead.org; Tue, 19 Nov 2013 02:01:09 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: The kernel version is not supported
Date: Tue, 19 Nov 2013 01:58:03 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971BFBF7@BPXM01GP.gisp.nec.co.jp>
References: <2415548.dh2jmZ1ojx@skinner>
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
To: "trenn@suse.de" <trenn@suse.de>
Cc: "lkundrak@v3.sk" <lkundrak@v3.sk>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Thomas,

(2013/11/13 1:24), Thomas Renninger wrote:
> Hi,
>
> there was a patch recently from Lubomir, title:
> dump-dmesg: Understand >= v3.11-rc4 dmesg
>
> But in makedumpfile.h the latest supported version still is:
> #define LATEST_VERSION          KERNEL_VERSION(3, 9, 6)/* linux-3.9.6 */
>
> resulting in:
> The kernel version is not supported.
> The created dumpfile may be incomplete.
>
> messages.
>
> I wonder whether there are other known issues with latest
> kernels which are the reason LATEST_VERSION did not get increased
> and which are those?

LATEST_VERSION is increased with a complete test when the new version
is released. So the reason is just that I didn't test v1.5.4 on
kernel 3.10 and later.

> I also wonder what the concept of LATEST_VERSION is.
> One does not know in advance which change in a newer kernel version
> might break things?
> So this one needs to be increased with every new kernel version?

There is no definite rule, but the new version is usually released
every 2-3 versions of kernel and supports them additionally.

BTW, makedumpfile-1.5.5 will be released at the beginning of December
and it will support kernel 3.10, 3.11 and 3.12 as well.


Thanks
Atsushi Kumagai

>
> Thanks for any hints,
>
>       Thomas
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
