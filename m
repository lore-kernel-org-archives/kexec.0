Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN9h2-000Cds-LN
 for kexec@lists.infradead.org; Mon, 06 Sep 2021 08:09:29 +0000
Date: Mon, 6 Sep 2021 10:09:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kernel/kexec_file.o: failed: Cannot find symbol for section 10:
 .text.unlikely.
Message-ID: <YTXMsxY9I6VdtVsS@kroah.com>
References: <CA+G9fYvMaHgSied79QBs3D=eDVETGH=3gxA8owCSRj313yEhVg@mail.gmail.com>
 <YTTbD+BKRpd0g4hq@kroah.com>
 <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYs-K2f+eZW55u5uh1gQedTQpm=TGDNk7K1uOk8AeDNUQA@mail.gmail.com>
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

On Mon, Sep 06, 2021 at 01:10:34PM +0530, Naresh Kamboju wrote:
> On Sun, 5 Sept 2021 at 20:28, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Sep 05, 2021 at 07:28:35PM +0530, Naresh Kamboju wrote:
> > > Following build errors noticed while building stable rc Linux 5.13.14
> > > with gcc-11 for powerpc architecture.
> 
> <trim>
> > Is this a regression?  Has this compiler ever been able to build this
> > arch like this?
> 
> Yes. It is a regression with gcc-11.
> 
> stable rc Linux 5.13.14 with gcc-11 - powerpc - FAILED
> stable rc Linux 5.13.14 with gcc-10 - powerpc - PASSED

Ah, ok, and does 5.14 or newer work properly?

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
