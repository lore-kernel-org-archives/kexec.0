Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFB0C5AD4C
	for <kexec@archiver.kernel.org>; Thu, 23 Nov 2023 15:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NfwzhJSf29Q4L+IkfPfmK+lDF0TM/YKnpwcBVgIopZY=; b=mu+tSfdGfWsIM7
	xDc48km3i+nnqt+QtolkaLuO5SMuRFv+J0STvICaY7t900cE4+q0nSX4a5X8/NhIrcKV942OszmNL
	iUF48W2qLwmzyl0TwOUwbxLdr6z9ybZhpgYAPaYkuEr+TSP/sWD5E43m2ozubcodIgAtDk3nqlIME
	aRuahHqfnTB9MoHqOZNPPyUrMJnidQtb83nptp+GncmqQns8gOi4bGBScf6OabVSNSwrjPgvi1Rv5
	aqi1ctnSQcUhtulnGzJTbykwK+szNNYk2BzkcIfpk7IWvwwyylJCKeMzHHqxfT3mhkgQSxexWBeuH
	+zuXGEgHaWbKYbsinMag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Bpg-005CG1-1i;
	Thu, 23 Nov 2023 15:41:36 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6Bpc-005CEt-1y;
	Thu, 23 Nov 2023 15:41:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7FEDCB82DAB;
	Thu, 23 Nov 2023 15:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D54C433C8;
	Thu, 23 Nov 2023 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700754089;
	bh=wYo7fAMqhxFyBFMQMLKccEbNB96HsajO4uuHMmp53Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDDf/GUUb7F28lHZof2kZ/ExvVGLi3nSeT3k5MbpJeP7J0VRZNmeH0n0637NQXiJB
	 hXe8WuNM4qKqZGi8AinuhXcYMqOENZ9/wzckFUhv+cEJRM4/HmSMMksK/WN6Dy5Ma8
	 crPwiGQ3GaiSK00zr+Kr3EpqT8dPwQzDEBl05EUafOfTas5YObKWcowYE6HhNzwKX4
	 gyZ7Z+k9Vr2SNTiHif5d2ZK3xPjSD8Mo/PvaRTgwaABEKoQRtpYp2i3PjOPpa3mV3f
	 8LRmCGmlgs78DL4EGWUkJDk7QoF8PY4psFMdIZKb0OGYKJMHSvVD3m8M16G4YVYpCF
	 3WbWtHvt69uMQ==
Date: Thu, 23 Nov 2023 08:41:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "bhe@redhat.com" <bhe@redhat.com>
Cc: "Liu, Yujie" <yujie.liu@intel.com>, lkp <lkp@intel.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 2/7] kexec_file: print out debugging message if required
Message-ID: <20231123154127.GA3487126@dev-arch.thelio-3990X>
References: <20231114153253.241262-3-bhe@redhat.com>
 <202311160431.BXPc7NO9-lkp@intel.com>
 <ZVcvBft/T3cbRBWr@MiWiFi-R3L-srv>
 <39ccb4fda795a76996cf6d1c3b25909692358211.camel@intel.com>
 <ZVdyLdAzgNBXfjiW@MiWiFi-R3L-srv>
 <ZV9YYEK4L160ECQ+@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZV9YYEK4L160ECQ+@MiWiFi-R3L-srv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_074132_944837_AE3DCE99 
X-CRM114-Status: GOOD (  24.81  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, Nov 23, 2023 at 09:49:20PM +0800, bhe@redhat.com wrote:
> On 11/17/23 at 10:01pm, Baoquan He wrote:
> > On 11/17/23 at 09:37am, Liu, Yujie wrote:
> > > Hi Baoquan,
> > > =

> > > On Fri, 2023-11-17 at 17:14 +0800, Baoquan He wrote:
> > > > Hi,
> > > > =

> > > > On 11/16/23 at 05:04am, kernel test robot wrote:
> > > > > Hi Baoquan,
> > > > > =

> > > > > kernel test robot noticed the following build errors:
> > > > > =

> > > > > [auto build test ERROR on arm64/for-next/core]
> > > > > [also build test ERROR on tip/x86/core powerpc/next powerpc/fixes=
 linus/master v6.7-rc1 next-20231115]
> > > > > [If your patch is applied to the wrong git tree, kindly drop us a=
 note.
> > > > > And when submitting patch, we suggest to use '--base' as document=
ed in
> > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > > =

> > > > > url:=A0=A0=A0 https://github.com/intel-lab-lkp/linux/commits/Baoq=
uan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-23=
4003
> > > > > base:=A0=A0 https://git.kernel.org/pub/scm/linux/kernel/git/arm64=
/linux.git=A0for-next/core
> > > > > patch link:=A0=A0=A0 https://lore.kernel.org/r/20231114153253.241=
262-3-bhe%40redhat.com
> > > > > patch subject: [PATCH 2/7] kexec_file: print out debugging messag=
e if required
> > > > > config: hexagon-comet_defconfig (https://download.01.org/0day-ci/=
archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/config)
> > > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-proj=
ect.git=A0ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-=
ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/reproduce)
> > > > > =

> > > > =

> > > > Thanks for reporting.
> > > > =

> > > > I met below failure when following the steps of provided reproducer.
> > > > Could anyone help check what's wrong with that?
> > > =

> > > Sorry this seems to be a bug in the reproducer. Could you please chan=
ge
> > > the compiler parameter to "COMPILER=3Dclang-16" and rerun the command=
? We
> > > will fix the issue ASAP.
> =

> Any update for the reproducer? I would like to post v2 with the fix. I
> doubt it's the same issue as another report on this patch, while not
> quite sure.

Shouldn't you be able to run

  $ COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-16 ~/bin/make.cross=
 W=3D1 O=3Dbuild_dir ARCH=3Dhexagon SHELL=3D/bin/bash kernel/

after the command you just ran to reproduce this now? It is
essentially the same fix that they mention above but for the second
invocation of make.cross.

You can also not even bother with the wrapper altogether if you have the
compiler installed in the default path that they provide (W=3D1 is not
necessary to reproduce this issue):

  $ mkdir -p build_dir
  $ curl -LSso build_dir/.config https://download.01.org/0day-ci/archive/20=
231116/202311160431.BXPc7NO9-lkp@intel.com/config
  $ make -skj"$(nproc)" ARCH=3Dhexagon LLVM=3D$HOME/0day/llvm-16.0.6-x86_64=
/bin/ O=3Dbuild_dir olddefconfig kernel/crash_core.o
  ...
  kernel/crash_core.c:554:3: error: call to undeclared function 'kexec_dpri=
ntk'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
                  kexec_dprintk("Crash PT_LOAD ELF header. phdr=3D%p vaddr=
=3D0x%llx, paddr=3D0x%llx, "
                  ^
  1 error generated.

> > Here you are. Thanks for your quick response.
> > ------------------------------
> > [root@~ linux]# COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-16 =
~/bin/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
> > Compiler will be installed in /root/0day
> > lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/./llvm-16.0.6-x8=
6_64.tar.xz
> > /root/linux                                                            =
                 =

> > tar Jxf /root/0day/./llvm-16.0.6-x86_64.tar.xz -C /root/0day
> > PATH=3D/root/0day/llvm-16.0.6-x86_64/bin:/root/.local/bin:/root/bin:/us=
r/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
> > make --keep-going LLVM=3D1 CROSS_COMPILE=3Dhexagon-linux- LLVM_IAS=3D1 =
--jobs=3D128 KCFLAGS=3D-Warray-bounds -Wundef -fstrict-flex-arrays=3D3 -fun=
signed-char -Wenum-conversion W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconf=
ig
> > make[1]: Entering directory '/root/linux/build_dir'
> >   GEN     Makefile
> >   HOSTCC  scripts/basic/fixdep
> >   HOSTCC  scripts/kconfig/conf.o
> >   HOSTCC  scripts/kconfig/confdata.o
> >   HOSTCC  scripts/kconfig/expr.o
> >   HOSTCC  scripts/kconfig/lexer.lex.o
> >   HOSTCC  scripts/kconfig/menu.o
> >   HOSTCC  scripts/kconfig/parser.tab.o
> >   HOSTCC  scripts/kconfig/preprocess.o
> >   HOSTCC  scripts/kconfig/symbol.o
> >   HOSTCC  scripts/kconfig/util.o
> >   HOSTLD  scripts/kconfig/conf
> > #
> > # configuration written to .config
> > #
> > make[1]: Leaving directory '/root/linux/build_dir'
> > =

> > > =

> > > > [root@~ linux]# COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang=
 ~/bin/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
> > > > Compiler will be installed in /root/0day
> > > > lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/
> > > > get1: /pub/tools/llvm/files/: files/: Is a directory
> > > > Failed to download https://cdn.kernel.org/pub/tools/llvm/files/
> > > > clang crosstool install failed
> > > > Install clang compiler failed
> > > > setup_crosstool failed
> > > =

> > > =

> > =

> =

> =


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
