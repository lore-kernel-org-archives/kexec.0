Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6GHI-0003ez-V1
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 15:36:02 +0000
Received: by mail-ed1-x542.google.com with SMTP id f19so6627532eds.12
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 08:35:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-2-pasha.tatashin@soleen.com>
 <0f83b70e-2f8f-aa05-84d8-41290679003b@arm.com>
In-Reply-To: <0f83b70e-2f8f-aa05-84d8-41290679003b@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 11:35:47 -0400
Message-ID: <CA+CK2bBzCnxk8X8R=_70ECT=kn8QRm7OioZP4LNJioTNXYDhXQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] kexec: quiet down kexec reboot
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
To: James Morse <james.morse@arm.com>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, will@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Sep 6, 2019 at 11:17 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Here is a regular kexec command sequence and output:
> > =====
> > $ kexec --reuse-cmdline -i --load Image
> > $ kexec -e
> > [  161.342002] kexec_core: Starting new kernel
> >
> > Welcome to Buildroot
> > buildroot login:
> > =====
> >
> > Even when "quiet" kernel parameter is specified, "kexec_core: Starting
> > new kernel" is printed.
> >
> > This message has  KERN_EMERG level, but there is no emergency, it is a
> > normal kexec operation, so quiet it down to appropriate KERN_NOTICE.
>
> As this doesn't have a dependency with the rest of the series, you may want to post it
> independently so it can be picked up independently.

Hi James,

I have posted it previously, but it has not been picked up. So, I
decided to include it together with this series. Is this alright with
you, otherwise I can remove it from this series.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
