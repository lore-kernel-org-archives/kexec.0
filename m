Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mMsfd-00FsqX-1y
 for kexec@lists.infradead.org; Sun, 05 Sep 2021 13:58:54 +0000
Received: by mail-ej1-x633.google.com with SMTP id e21so7785037ejz.12
 for <kexec@lists.infradead.org>; Sun, 05 Sep 2021 06:58:47 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 5 Sep 2021 19:28:35 +0530
Message-ID: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
Subject: kernel/kexec_file.o: failed: Cannot find symbol for section 10:
 .text.unlikely.
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
To: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>, linux-stable <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org

Following build errors noticed while building stable rc Linux 5.13.14
with gcc-11 for powerpc architecture.

# to reproduce this build locally:
tuxmake --target-arch=powerpc --kconfig=defconfig --toolchain=gcc-11
--wrapper=sccache --environment=KBUILD_BUILD_TIMESTAMP=@1630691419
--environment=KBUILD_BUILD_USER=tuxmake
--environment=KBUILD_BUILD_HOST=tuxmake
--environment=SCCACHE_BUCKET=sccache.tuxbuild.com --runtime=podman
--image=855116176053.dkr.ecr.us-east-1.amazonaws.com/tuxmake/powerpc_gcc-11
config default kernel xipkernel modules dtbs dtbs-legacy debugkernel
headers

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc' defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/current ARCH=powerpc
CROSS_COMPILE=powerpc64le-linux-gnu- 'CC=sccache
powerpc64le-linux-gnu-gcc' 'HOSTCC=sccache gcc'
Cannot find symbol for section 10: .text.unlikely.
kernel/kexec_file.o: failed
make[2]: *** [/builds/linux/scripts/Makefile.build:273:
kernel/kexec_file.o] Error 1
make[2]: *** Deleting file 'kernel/kexec_file.o'


Build config:
https://builds.tuxbuild.com/1xdiIZVZuLCW3X1WO2YT6Fsl19w/config

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

meta data:
-----------
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
    git_sha: a603798fb16829e56f80f57879611e67bba4910d
    git_short_log: a603798fb168 (\Linux 5.13.14\)
    kconfig:  defconfig
    kernel_version: 5.13.14
    target_arch: powerpc
    toolchain: gcc-11

steps to reproduce:
https://builds.tuxbuild.com/1xdiIZVZuLCW3X1WO2YT6Fsl19w/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
