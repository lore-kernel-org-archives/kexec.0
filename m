Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fTKu5-0006DP-Gu
 for kexec@lists.infradead.org; Thu, 14 Jun 2018 05:34:40 +0000
Received: by mail-lf0-f66.google.com with SMTP id i15-v6so7407411lfc.2
 for <kexec@lists.infradead.org>; Wed, 13 Jun 2018 22:34:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEwzPJ0qLgQrNwmgqNdJOuyUCVTLXG-JokojMauem+nk1GSRMA@mail.gmail.com>
References: <CAEwzPJ3BVLEv8eZurPRN2FeZSnrq3TgH=9dtERTorPwH5CgG2A@mail.gmail.com>
 <CAEwzPJ0qLgQrNwmgqNdJOuyUCVTLXG-JokojMauem+nk1GSRMA@mail.gmail.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 14 Jun 2018 11:04:24 +0530
Message-ID: <CACi5LpNDps+ALt0phbNG2wWESTP4ky0NGePNZ37YaBTUsCKQEQ@mail.gmail.com>
Subject: Re: kexec over 4.1.27 for arm64?
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
To: Mahesh V <maheshvenkateshwaran@gmail.com>
Cc: kexec mailing list <kexec@lists.infradead.org>

Hi Mahesh,

On Wed, Jun 13, 2018 at 3:51 PM, Mahesh V
<maheshvenkateshwaran@gmail.com> wrote:
> Hi folks
> Is there a patch that I can directly apply over 4.1.27
> to support kexec for arm64?

Can you be more descriptive about the problem you are facing?
kexec arm64 support was introduced in newer kernels, so please share
the environment (including the kernel version and kexec-tools version)
you are using.

Also if you are facing any particular crash (with back porting the
patches to 4.1.27), kindly share the appropriate logs with kexec being
invoked with -d (debug) flag.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
