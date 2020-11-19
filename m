Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfrvC-0005Sk-AR
 for kexec@lists.infradead.org; Thu, 19 Nov 2020 21:56:55 +0000
Received: from mail-ed1-f69.google.com ([209.85.208.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <guilherme.piccoli@canonical.com>) id 1kfrvA-0001bM-2D
 for kexec@lists.infradead.org; Thu, 19 Nov 2020 21:56:52 +0000
Received: by mail-ed1-f69.google.com with SMTP id y11so2873914edv.6
 for <kexec@lists.infradead.org>; Thu, 19 Nov 2020 13:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
In-Reply-To: <20201118232431.21832-1-saeed.mirzamohammadi@oracle.com>
From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Thu, 19 Nov 2020 18:56:14 -0300
Message-ID: <CAHD1Q_yA37wWrOscBHpSFEjFecGFcrzY6R6qU_iMESzYArV_Kg@mail.gmail.com>
Subject: Re: [PATCH 1/1] kernel/crash_core.c - Add crashkernel=auto for x86
 and ARM
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
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Anson Huang <Anson.Huang@nxp.com>, Jonathan Corbet <corbet@lwn.net>, Dann Frazier <dann.frazier@canonical.com>, x86@kernel.org, Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, john.p.donnelly@oracle.com, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Randy Dunlap <rdunlap@infradead.org>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "# v4 . 16+" <stable@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Michael Walle <michael@walle.cc>, =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>, Olof Johansson <olof@lixom.net>, Shawn Guo <shawnguo@kernel.org>

Hi Saeed, thanks for your patch/idea! Comments inline, below.

On Wed, Nov 18, 2020 at 8:29 PM Saeed Mirzamohammadi
<saeed.mirzamohammadi@oracle.com> wrote:
>
> This adds crashkernel=auto feature to configure reserved memory for
> vmcore creation to both x86 and ARM platforms based on the total memory
> size.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
> Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> ---
>  Documentation/admin-guide/kdump/kdump.rst |  5 +++++
>  arch/arm64/Kconfig                        | 26 ++++++++++++++++++++++-
>  arch/arm64/configs/defconfig              |  1 +
>  arch/x86/Kconfig                          | 26 ++++++++++++++++++++++-
>  arch/x86/configs/x86_64_defconfig         |  1 +
>  kernel/crash_core.c                       | 20 +++++++++++++++--
>  6 files changed, 75 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
> index 75a9dd98e76e..f95a2af64f59 100644
> --- a/Documentation/admin-guide/kdump/kdump.rst
> +++ b/Documentation/admin-guide/kdump/kdump.rst
> @@ -285,7 +285,12 @@ This would mean:
>      2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
>      3) if the RAM size is larger than 2G, then reserve 128M
>
> +Or you can use crashkernel=auto if you have enough memory. The threshold
> +is 1G on x86_64 and arm64. If your system memory is less than the threshold,
> +crashkernel=auto will not reserve memory. The size changes according to
> +the system memory size like below:
>
> +    x86_64/arm64: 1G-64G:128M,64G-1T:256M,1T-:512M

As mentioned in the thread, this was tried before and never got merged
- I'm not sure the all the reasons, but I speculate that a stronger
reason is that it'd likely fail in many cases. I've seen cases of 256G
servers that require crashkernel=600M (or more), due to the amount of
devices. Also, the minimum nowadays would likely be 96M or more - I'm
looping Cascardo and Dann (Debian/Ubuntu maintainers of kdump stuff)
so they maybe can jump in with even more examples/considerations.

What we've been trying to do in Ubuntu/Debian is using an estimator
approach [0] - this is purely userspace and tries to infer the amount
of necessary memory a kdump minimal[1] kernel would take. I'm not
-1'ing your approach totally, but I think a bit more consideration is
needed in the ranges, at least accounting the number of devices of the
machine or something like that.

Cheers,


Guilherme

[0] https://salsa.debian.org/debian/makedumpfile/-/merge_requests/7
[1] Minimal as having a reduced initrd + "shrinking" parameters (like
nr_cpus=1).

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
