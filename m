Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6JZI-0008CS-GZ
 for kexec@lists.infradead.org; Fri, 06 Sep 2019 19:06:49 +0000
Received: by mail-ed1-x542.google.com with SMTP id f19so7207459eds.12
 for <kexec@lists.infradead.org>; Fri, 06 Sep 2019 12:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-13-pasha.tatashin@soleen.com>
 <d4a5bb7b-21c0-9f39-ad96-3fa43684c6c6@arm.com>
In-Reply-To: <d4a5bb7b-21c0-9f39-ad96-3fa43684c6c6@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 6 Sep 2019 15:06:36 -0400
Message-ID: <CA+CK2bDxK5DHARkAUxzodhMDqokqEy3Y12F-bgHPF9g9K496hA@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] arm64,
 trans_pgd: complete generalization of trans_pgds
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

On Fri, Sep 6, 2019 at 11:23 AM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 21/08/2019 19:31, Pavel Tatashin wrote:
> > Make the last private functions in page table copy path generlized for use
> > outside of hibernate.
> >
> > Switch to use the provided allocator, flags, and source page table. Also,
> > unify all copy function implementations to reduce the possibility of bugs.
>
> By changing it? No one has reported any problems. We're more likely to break it making
> unnecessary changes.
>
> Why is this necessary?

I tried to make it cleaner, but if you think the final version does
not make it better, I will keep the current versions.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
