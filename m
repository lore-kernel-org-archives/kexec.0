Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goLuI-0005PZ-8g
 for kexec@lists.infradead.org; Tue, 29 Jan 2019 05:25:59 +0000
Received: by mail-it1-x144.google.com with SMTP id w18so2383812ite.1
 for <kexec@lists.infradead.org>; Mon, 28 Jan 2019 21:25:57 -0800 (PST)
MIME-Version: 1.0
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
In-Reply-To: <20190125140823.GC27998@zn.tnic>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 29 Jan 2019 13:25:45 +0800
Message-ID: <CAFgQCTsuuOSSLKXOaF7jchDRevegZkzZVNiTgB6D+S4=dpc5Xg@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
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
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com

On Fri, Jan 25, 2019 at 10:08 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jan 25, 2019 at 09:45:18PM +0800, Dave Young wrote:
> > AFAIK, some people prefer to explictly reserve crash memory at high
> > region even if it is possible to reserve at low area.  May because
> > <4G memory is limited on large server, they want to leave this for other
> > use.
> >
> > Yinghai or Vivek should know more about the history, probably they can
> > recall some initial reason.
>
Go through the git log, and I found the initial introduction of
crashkernel_high option. Refer to
commit 55a20ee7804ab64ac90bcdd4e2868a42829e2784
Author: Yinghai Lu <yinghai@kernel.org>
Date:   Mon Apr 15 22:23:47 2013 -0700

    x86, kdump: Retore crashkernel= to allocate under 896M

    Vivek found old kexec-tools does not work new kernel anymore.

    So change back crashkernel= back to old behavoir, and add crashkernel_high=
    to let user decide if buffer could be above 4G, and also new
kexec-tools will
    be needed.

But kexec-tools-2.0.3, released at 2012, can run 4.20 kernel with
crashkernel=256M@5G, so I think only very old kexec-tools requires
memory under 896M. Due to -1.few people running latest kernel with
very old kexec-tools to date, -2. crashkernel=X is more popular than
crashkernel=X.high, it should be time to eliminate this limit of
crashkernel=X parameter, otherwise we will run into this bug.
As for crashkernel=,high, I think it is a more professional option for
who cares about the DMA32. On high-end machine, big reserved region is
used for crashkernel(e.g. in this case 384M), which make the crowed
situation under under 4GB memory worse.

> Yes, just "prefer" is not good enough. There should be a technical
> reason why that's there.
>
> Also, if the user doesn't care, then the code should be free to force
> "high" and thus probe a different range for allocation.
>
Do you suggest to remove crashkernel=X,high parameter?

Thanks,
Pingfan
> > Good question, still it may be some historical reason, but it is good to
> > make them clear and rethink about it after long time.
> >
> > I also want to understand, need dig the log more.
>
> Good idea. That would be a very nice cleanup. :-)
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
