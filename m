Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mMtbG-00FzrU-GP
 for kexec@lists.infradead.org; Sun, 05 Sep 2021 14:58:28 +0000
Date: Sun, 5 Sep 2021 16:58:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel/kexec_file.o: failed: Cannot find symbol for section 10:
 .text.unlikely.
Message-ID: <YTTbD+BKRpd0g4hq@kroah.com>
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
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
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>, linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org

On Sun, Sep 05, 2021 at 07:28:35PM +0530, Naresh Kamboju wrote:
> Following build errors noticed while building stable rc Linux 5.13.14
> with gcc-11 for powerpc architecture.
> 
> # to reproduce this build locally:
> tuxmake --target-arch=powerpc --kconfig=defconfig --toolchain=gcc-11
> --wrapper=sccache --environment=KBUILD_BUILD_TIMESTAMP=@1630691419
> --environment=KBUILD_BUILD_USER=tuxmake
> --environment=KBUILD_BUILD_HOST=tuxmake
> --environment=SCCACHE_BUCKET=sccache.tuxbuild.com --runtime=podman
> --image=855116176053.dkr.ecr.us-east-1.amazonaws.com/tuxmake/powerpc_gcc-11
> config default kernel xipkernel modules dtbs dtbs-legacy debugkernel
> headers
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
> CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
> powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc' defconfig
> 
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
> CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
> powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc'
> Cannot find symbol for section 10: .text.unlikely.
> kernel/kexec_file.o: failed
> make[2]: *** [/builds/linux/scripts/Makefile.build:273:
> kernel/kexec_file.o] Error 1
> make[2]: *** Deleting file 'kernel/kexec_file.o'
> 
> 
> Build config:
> https://builds.tuxbuild.com/1xdiIZVZuLCW3X1WO2YT6Fsl19w/config
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> meta data:
> -----------
>     git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
>     git_sha: a603798fb16829e56f80f57879611e67bba4910d
>     git_short_log: a603798fb168 (\Linux 5.13.14\)
>     kconfig:  defconfig
>     kernel_version: 5.13.14
>     target_arch: powerpc
>     toolchain: gcc-11
> 
> steps to reproduce:
> https://builds.tuxbuild.com/1xdiIZVZuLCW3X1WO2YT6Fsl19w/tuxmake_reproducer.sh
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

Is this a regression?  Has this compiler ever been able to build this
arch like this?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
