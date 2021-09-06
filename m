Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN9FH-000608-6k
 for kexec@lists.infradead.org; Mon, 06 Sep 2021 07:40:48 +0000
Received: by mail-ed1-x52a.google.com with SMTP id q3so8288206edt.5
 for <kexec@lists.infradead.org>; Mon, 06 Sep 2021 00:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
 <YTTbD+BKRpd0g4hq@kroah.com>
In-Reply-To: <YTTbD+BKRpd0g4hq@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Sep 2021 13:10:34 +0530
Message-ID: <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
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

On Sun, 5 Sept 2021 at 20:28, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Sep 05, 2021 at 07:28:35PM +0530, Naresh Kamboju wrote:
> > Following build errors noticed while building stable rc Linux 5.13.14
> > with gcc-11 for powerpc architecture.

<trim>
> Is this a regression?  Has this compiler ever been able to build this
> arch like this?

Yes. It is a regression with gcc-11.

stable rc Linux 5.13.14 with gcc-11 - powerpc - FAILED
stable rc Linux 5.13.14 with gcc-10 - powerpc - PASSED

- Naresh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
