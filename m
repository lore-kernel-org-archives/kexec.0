Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHjoZ-0003cJ-Os
 for kexec@lists.infradead.org; Wed, 31 Oct 2018 06:17:17 +0000
Received: by mail-ed1-x544.google.com with SMTP id t10-v6so12586897eds.12
 for <kexec@lists.infradead.org>; Tue, 30 Oct 2018 23:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180427090045.532014306@redhat.com>
 <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
 <20180507024833.GA3895@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20180507024833.GA3895@dhcp-128-65.nay.redhat.com>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Wed, 31 Oct 2018 14:16:50 +0800
Message-ID: <CAFgQCTvqVX8pNGiWFjv2xfMMHXtrca0-Hgmgy123n=KVOeipkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
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
To: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org, vgoyal@redhat.com

Hi, I encounter a case where crashkernel=384M, and kaslr is enabled.
During the test, sometimes, the system may fail to reserve region for
crash kernel, although there is much free space above 896MB. It is
caused by the truncation of the candidate region by kaslr kernel. It
raises confusion to the end user that sometimes crashkernel=X works
while sometimes fails.
So can we have this patch to fix the issue?

Thanks,
Pingfan
On Mon, May 7, 2018 at 10:49 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 04/27/18 at 05:14pm, Dave Young wrote:
> > Hi,
> >
> > This is a resend of below patches:
> > http://lists.infradead.org/pipermail/kexec/2017-October/019569.html
> >
> > I dropped the original patch 1 since Baoquan is not happy with it.
> > For patch 2 (the 1st patch in this series), there is some improvement
> > comment from Baoquan to create some generic memblock iteration function.
> > But nobody has time to work on it for the time being.  According to
> > offline discussion with him.  That can be done in the future if someone
> > is interested.  We can go with the current kdump only fixes.
> >
> > Other than above,  the patches are just same.
>
> Hi Andrew, do you have concerns about the patches?  It has been used for
> long time in Red Hat kernel, since people do not object them, could you
> pick them if no other concerns?
>
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
