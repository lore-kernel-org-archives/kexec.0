Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Y98BM-0003JQ-Ub
 for kexec@lists.infradead.org; Thu, 08 Jan 2015 08:11:05 +0000
Received: by mail-pd0-f176.google.com with SMTP id r10so9822044pdi.7
 for <kexec@lists.infradead.org>; Thu, 08 Jan 2015 00:10:40 -0800 (PST)
Message-ID: <54AE3B7A.4070301@linaro.org>
Date: Thu, 08 Jan 2015 17:10:34 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
MIME-Version: 1.0
Subject: Re: Kdump on ARM64
References: <54AE2544.2010801@huawei.com>
In-Reply-To: <54AE2544.2010801@huawei.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Anurup M <anurup.m@huawei.com>, kexec@lists.infradead.org
Cc: geoff@infradead.org, sanil.kumar@hisilicon.com

Hi Anurup,

On 01/08/2015 03:35 PM, Anurup M wrote:
> Hi Akashi, Geoff,
>
> 	I tried to check kdump on arm64 on Foundation model. The/proc/vmcore is generated.
> But I couldnot check if it is proper. Is there a makedumpfile binary for arm64? and also crash tool.
> I used the master branch of https://git.linaro.org/people/geoff.levand/linux-kexec.git to verify.
>   	Please provide some information about the current status or support for kdump on arm64?
> and the ways to verify or start development on Foundation model.

The story is that I used to work on kdump, but handed it off
to Geoff at some time. Since then, he merged it into his repo
but I don't think that he has tested (verified) it yet.
So please take it as a study work (or prototype), although I'm
pretty sure that it works well on model except some issues.

Regarding /proc/vmcore, if you can retrieve it to your host machine,
you can simply verify the contents as follows:
   $ aarch64-linux-gnu-gdb vmlinux core(=vmcore)
   (gdb) info threads
   (gdb) bt
    ...

I also have a trivial patch for crash tool to cross-build it, but
arm64 support (by RedHat folk) is already there.

Thanks,
-Takahiro AKASHI

> Thanks,
> Anurup M
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
