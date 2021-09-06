Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNAKJ-000HF8-QF
 for kexec@lists.infradead.org; Mon, 06 Sep 2021 08:50:05 +0000
Received: by mail-ej1-x62e.google.com with SMTP id me10so12008917ejb.11
 for <kexec@lists.infradead.org>; Mon, 06 Sep 2021 01:50:03 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
 <YTTbD+BKRpd0g4hq@kroah.com>
 <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
 <YTXMsxY9I6VdtVsS@kroah.com>
In-Reply-To: <YTXMsxY9I6VdtVsS@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Sep 2021 14:19:50 +0530
Message-ID: <CA+G9fYvzqidCJYOoA9eX4ayf9HGyJ_jBjMS42NuuzFK_tFAmzg@mail.gmail.com>
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

On Mon, 6 Sept 2021 at 13:39, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 06, 2021 at 01:10:34PM +0530, Naresh Kamboju wrote:
> > On Sun, 5 Sept 2021 at 20:28, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sun, Sep 05, 2021 at 07:28:35PM +0530, Naresh Kamboju wrote:
> > > > Following build errors noticed while building stable rc Linux 5.13.14
> > > > with gcc-11 for powerpc architecture.
> >
> > <trim>
> > > Is this a regression?  Has this compiler ever been able to build this
> > > arch like this?
> >
> > Yes. It is a regression with gcc-11.
> >
> > stable rc Linux 5.13.14 with gcc-11 - powerpc - FAILED
> > stable rc Linux 5.13.14 with gcc-10 - powerpc - PASSED
>
> Ah, ok, and does 5.14 or newer work properly?

No.
stable rc Linux 5.14.1-rc1 with gcc-11 - powerpc - FAILED
stable rc Linux 5.14.1-rc1 with gcc-10 - powerpc - PASS


I will check Linux mainline and Linux next and get back to you.

- Naresh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
