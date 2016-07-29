Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bTBQ7-0003tk-K0
 for kexec@lists.infradead.org; Fri, 29 Jul 2016 17:18:00 +0000
Received: by mail-pf0-f176.google.com with SMTP id h186so34364549pfg.3
 for <kexec@lists.infradead.org>; Fri, 29 Jul 2016 10:17:38 -0700 (PDT)
Date: Fri, 29 Jul 2016 22:47:35 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v23 0/9] arm64: add kdump support
Message-ID: <20160729171735.GC478@localhost.localdomain>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
 <1469812107.16559.37.camel@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1469812107.16559.37.camel@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, Ruslan Bilovol <ruslan.bilovol@gmail.com>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On 29/07/2016:10:08:27 AM, Geoff Levand wrote:
> Hi,
> 
> On Fri, 2016-07-29 at 19:26 +0300, Ruslan Bilovol wrote:
> 
> > Also for some reason in case of 'load and kexec the kernel' it
> > takes 1-2 minutes to start booting after I do kexec -e, need to
> > investigate it further.
> 
> You could try my patch ("purgatory: Change default sha256
> optimization to -O2") in my master branch:

Yep, that did bring my 2 Min 30 sec to almost 20 sec, and then it came down to
fraction of second after D-cache enabling.

~Pratyush
> 
>   https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git/log/
> 
> Other have said it helped.
> 
> -Geoff
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
