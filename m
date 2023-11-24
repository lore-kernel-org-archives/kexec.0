Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49594C61D85
	for <kexec@archiver.kernel.org>; Fri, 24 Nov 2023 01:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v669aqwyh5ussC6pAdAFA17aOhUMrPXaj7sB5SbYHhQ=; b=P37sOV8q43AQUK
	WI8Ka6X2k8qkGnqh3FsQgWprlexRwlv9NiZHC3Wor0eZY7TgbjkZTneK31wAjxfSjMrO3rZGjIS7D
	DRgFShuOrusXN5Y+hY90klJ4SYlMsrCbbmupg3Ff9PTxUqA5Bc9WdJs7aZDv086J1nWLTrkx0mJ/a
	iscgJ92l3B4L3Tp+0dX9Vr4oxExdzwGo0r+4K6QmuwwgoJDN3Fa8aDMUewen3fDYV3ZpYIvDIUX8s
	6ug5ZBdKRLqO/oOXfn2njXyZJCkbXZsisAjXB5x+uxyiaCgRgHb+eIaCjs5NkIzTzwD8xrzCJHyDG
	6BMWC5hWCjqFbxbs6e+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6LSM-005xQT-1W;
	Fri, 24 Nov 2023 01:58:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6LSJ-005xPB-0b
	for kexec@lists.infradead.org;
	Fri, 24 Nov 2023 01:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700791086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SiHqBG5n3pSa5R94END0/8W0OBeOhpXL3D/OFSohC2M=;
	b=ijRXAftj8POW/y+UTgPvOP2WCvvQLP/poHkJ8GaGZv4HXe1owr3938fZAoc8et9G8KW4dV
	3jIiq5LzyIZYHq3c8wfqMI5wbJlJbgfj75SL0EiiBW6Jhc2gWDyN4QfL6JCerO+jv2fZBu
	vOf6I+bari0+hY1HBzlxmL4HHfYUdhs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-_W8SERA3N_Gf5HeqVWenIA-1; Thu,
 23 Nov 2023 20:58:02 -0500
X-MC-Unique: _W8SERA3N_Gf5HeqVWenIA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A870E28EC110;
	Fri, 24 Nov 2023 01:58:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03C1B2166B2A;
	Fri, 24 Nov 2023 01:58:00 +0000 (UTC)
Date: Fri, 24 Nov 2023 09:57:57 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
To: Yujie Liu <yujie.liu@intel.com>
Cc: lkp <lkp@intel.com>,
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
Message-ID: <ZWADJcg5smQHZzMT@MiWiFi-R3L-srv>
References: <20231114153253.241262-3-bhe@redhat.com>
 <202311160431.BXPc7NO9-lkp@intel.com>
 <ZVcvBft/T3cbRBWr@MiWiFi-R3L-srv>
 <39ccb4fda795a76996cf6d1c3b25909692358211.camel@intel.com>
 <ZVdyLdAzgNBXfjiW@MiWiFi-R3L-srv>
 <ZV9YYEK4L160ECQ+@MiWiFi-R3L-srv>
 <ZV/55OkN7bV02LY8@yujie-X299>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZV/55OkN7bV02LY8@yujie-X299>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_175807_387355_FB936801 
X-CRM114-Status: GOOD (  26.10  )
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

On 11/24/23 at 09:18am, Yujie Liu wrote:
> On Thu, Nov 23, 2023 at 09:49:20PM +0800, bhe@redhat.com wrote:
> > On 11/17/23 at 10:01pm, Baoquan He wrote:
> > > On 11/17/23 at 09:37am, Liu, Yujie wrote:
> > > > Hi Baoquan,
> > > > =

> > > > On Fri, 2023-11-17 at 17:14 +0800, Baoquan He wrote:
> > > > > Hi,
> > > > > =

> > > > > On 11/16/23 at 05:04am, kernel test robot wrote:
> > > > > > Hi Baoquan,
> > > > > > =

> > > > > > kernel test robot noticed the following build errors:
> > > > > > =

> > > > > > [auto build test ERROR on arm64/for-next/core]
> > > > > > [also build test ERROR on tip/x86/core powerpc/next powerpc/fix=
es linus/master v6.7-rc1 next-20231115]
> > > > > > [If your patch is applied to the wrong git tree, kindly drop us=
 a note.
> > > > > > And when submitting patch, we suggest to use '--base' as docume=
nted in
> > > > > > https://git-scm.com/docs/git-format-patch#_base_tree_informatio=
n]
> > > > > > =

> > > > > > url:=A0=A0=A0 https://github.com/intel-lab-lkp/linux/commits/Ba=
oquan-He/kexec_file-add-kexec_file-flag-to-control-debug-printing/20231114-=
234003
> > > > > > base:=A0=A0 https://git.kernel.org/pub/scm/linux/kernel/git/arm=
64/linux.git=A0for-next/core
> > > > > > patch link:=A0=A0=A0 https://lore.kernel.org/r/20231114153253.2=
41262-3-bhe%40redhat.com
> > > > > > patch subject: [PATCH 2/7] kexec_file: print out debugging mess=
age if required
> > > > > > config: hexagon-comet_defconfig (https://download.01.org/0day-c=
i/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/config)
> > > > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-pr=
oject.git=A0ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0da=
y-ci/archive/20231116/202311160431.BXPc7NO9-lkp@intel.com/reproduce)
> > > > > > =

> > > > > =

> > > > > Thanks for reporting.
> > > > > =

> > > > > I met below failure when following the steps of provided reproduc=
er.
> > > > > Could anyone help check what's wrong with that?
> > > > =

> > > > Sorry this seems to be a bug in the reproducer. Could you please ch=
ange
> > > > the compiler parameter to "COMPILER=3Dclang-16" and rerun the comma=
nd? We
> > > > will fix the issue ASAP.
> > =

> > Any update for the reproducer? I would like to post v2 with the fix. I
> > doubt it's the same issue as another report on this patch, while not
> > quite sure.
> =

> Setting "COMPILER=3Dclang-16" is exactly the correct fix and should
> reproduce the issue in this report. We've fixed the steps of reproducer
> but this will only take effect in future reports.

Thanks, Yujie. I thought you were asking me to use "COMPILER=3Dclang-16"
to get information to debug. I have done the testing according to
Nathan's suggestion and can confirm it's the same issue as the one on
arm64. Will post v2.

> =

> > > =

> > > Here you are. Thanks for your quick response.
> > > ------------------------------
> > > [root@~ linux]# COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang-1=
6 ~/bin/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
> > > Compiler will be installed in /root/0day
> > > lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/./llvm-16.0.6-=
x86_64.tar.xz
> > > /root/linux                                                          =
                   =

> > > tar Jxf /root/0day/./llvm-16.0.6-x86_64.tar.xz -C /root/0day
> > > PATH=3D/root/0day/llvm-16.0.6-x86_64/bin:/root/.local/bin:/root/bin:/=
usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin
> > > make --keep-going LLVM=3D1 CROSS_COMPILE=3Dhexagon-linux- LLVM_IAS=3D=
1 --jobs=3D128 KCFLAGS=3D-Warray-bounds -Wundef -fstrict-flex-arrays=3D3 -f=
unsigned-char -Wenum-conversion W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefco=
nfig
> > > make[1]: Entering directory '/root/linux/build_dir'
> > >   GEN     Makefile
> > >   HOSTCC  scripts/basic/fixdep
> > >   HOSTCC  scripts/kconfig/conf.o
> > >   HOSTCC  scripts/kconfig/confdata.o
> > >   HOSTCC  scripts/kconfig/expr.o
> > >   HOSTCC  scripts/kconfig/lexer.lex.o
> > >   HOSTCC  scripts/kconfig/menu.o
> > >   HOSTCC  scripts/kconfig/parser.tab.o
> > >   HOSTCC  scripts/kconfig/preprocess.o
> > >   HOSTCC  scripts/kconfig/symbol.o
> > >   HOSTCC  scripts/kconfig/util.o
> > >   HOSTLD  scripts/kconfig/conf
> > > #
> > > # configuration written to .config
> > > #
> > > make[1]: Leaving directory '/root/linux/build_dir'
> > > =

> > > > =

> > > > > [root@~ linux]# COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dcla=
ng ~/bin/make.cross W=3D1 O=3Dbuild_dir ARCH=3Dhexagon olddefconfig
> > > > > Compiler will be installed in /root/0day
> > > > > lftpget -c https://cdn.kernel.org/pub/tools/llvm/files/
> > > > > get1: /pub/tools/llvm/files/: files/: Is a directory
> > > > > Failed to download https://cdn.kernel.org/pub/tools/llvm/files/
> > > > > clang crosstool install failed
> > > > > Install clang compiler failed
> > > > > setup_crosstool failed
> > > > =

> > > > =

> > > =

> > =

> =



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
