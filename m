Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNUNT-002Xg7-V1
 for kexec@lists.infradead.org; Tue, 07 Sep 2021 06:14:41 +0000
Received: by mail-ed1-x52c.google.com with SMTP id u19so12354378edb.3
 for <kexec@lists.infradead.org>; Mon, 06 Sep 2021 23:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
 <YTTbD+BKRpd0g4hq@kroah.com>
 <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
 <YTXMsxY9I6VdtVsS@kroah.com>
 <CA+G9fYvzqidCJYOoA9eX4ayf9HGyJ_jBjMS42NuuzFK_tFAmzg@mail.gmail.com>
In-Reply-To: <CA+G9fYvzqidCJYOoA9eX4ayf9HGyJ_jBjMS42NuuzFK_tFAmzg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 7 Sep 2021 11:44:23 +0530
Message-ID: <CA+G9fYv_guwJLpk+8poPKsSw7NOxw9-AXuEDy=iceXimfStxfQ@mail.gmail.com>
Subject: Re: kernel/kexec_file.o: failed: Cannot find symbol for section 10:
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
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, open list <linux-kernel@vger.kernel.org>, linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, lkft-triage@lists.linaro.org

> > > > Is this a regression?  Has this compiler ever been able to build this
> > > > arch like this?
> > >
> > > Yes. It is a regression with gcc-11.
> > >
> > > stable rc Linux 5.13.14 with gcc-11 - powerpc - FAILED
> > > stable rc Linux 5.13.14 with gcc-10 - powerpc - PASSED
> >
> > Ah, ok, and does 5.14 or newer work properly?
>
> No.
> stable rc Linux 5.14.1-rc1 with gcc-11 - powerpc - FAILED
> stable rc Linux 5.14.1-rc1 with gcc-10 - powerpc - PASS
>
>
> I will check Linux mainline and Linux next and get back to you.

Since we started building with gcc-11 last weekend and started
noticing these build failures on stable-rc, mainline and next.
and today's stable-rc review also failed with these combinations.

Linux next master with gcc-11 - powerpc-defconfig - FAILED
Linux mainline master with gcc-11 - powerpc-defconfig - FAILED
stable rc Linux 5.14.2-rc1 with gcc-11 - powerpc-defconfig - FAILED
stable rc Linux 5.13.15-rc1 with gcc-11 - powerpc-defconfig - FAILED
stable rc Linux 5.10.63-rc1 with gcc-11 - powerpc-defconfig - FAILED

FYI,
The following powerpc config build PASS with gcc-11
  - allnoconfig
  - mpc83xx_defconfig
  - tqm8xx_defconfig
  - maple_defconfig
  - cell_defconfig
  - ppc64e_defconfig
  - ppc6xx_defconfig


- Naresh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
