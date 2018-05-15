Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fIUMp-0005vB-1W
 for kexec@lists.infradead.org; Tue, 15 May 2018 07:27:28 +0000
Received: by mail-lf0-f65.google.com with SMTP id r25-v6so21815941lfd.1
 for <kexec@lists.infradead.org>; Tue, 15 May 2018 00:27:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524459622-2059-1-git-send-email-bhsharma@redhat.com>
References: <1524459622-2059-1-git-send-email-bhsharma@redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Tue, 15 May 2018 12:51:52 +0530
Message-ID: <CACi5LpNuPzNKhLac6Mfpn5P9LUr=QaaCeyz=6RLTjV8YVoTW9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Remove obsolete kdump tool and add missing uninstall
 rule
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
To: kexec@lists.infradead.org
Cc: Russell King <rmk@armlinux.org.uk>, Russell King <rmk@arm.linux.org.uk>, Bhupesh Sharma <bhsharma@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Simon Horman <horms@verge.net.au>, ebiederm@xmission.com, Bhupesh SHARMA <bhupesh.linux@gmail.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hello Russell, Simon,

On Mon, Apr 23, 2018 at 10:30 AM, Bhupesh Sharma <bhsharma@redhat.com> wrote:
> This patchset contains two patches:
>
> [1/2] - Adds a missing uninstall rule to 'Makefile.in' to allow easier
>         uninstallation of executables and man pages installed via
>         'make install'
> [2/2] - Removes obsolete kdump tool as per the discussion on kexec
>         mailing list (see [1] for details), where a conclusion was
>         reached that with the availability of tools like crash/gdb the
>         analysis of the crashdump core has become rather easy, and it
>         makes the kdump tool obsolete.
>
>         Also the same naming convention (man page) causes confusion
>         when compared to similarly named distribution specific kdump
>         service/utilities, so its better to remove the same from
>         kexec-tools.
>
> I tested the patchset on my apm mustang and qualcomm arm64 boards and
> the changes seem to work fine.
>
> [1] http://lists.infradead.org/pipermail/kexec/2018-April/020483.html
>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>

Ping. Any comments on this?

Thanks,
Bhupesh

> Bhupesh Sharma (2):
>   Makefile.in: Add uninstall rule
>   Remove obsolete kdump tool
>
>  Makefile.in         |  92 +++++++++++++--
>  kdump/Makefile      |  30 -----
>  kdump/kdump.8       |  39 -------
>  kdump/kdump.c       | 327 ----------------------------------------------------
>  kexec-tools.spec.in |   2 -
>  5 files changed, 83 insertions(+), 407 deletions(-)
>  delete mode 100644 kdump/Makefile
>  delete mode 100644 kdump/kdump.8
>  delete mode 100644 kdump/kdump.c
>
> --
> 2.7.4
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
