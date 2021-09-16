Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQzw5-00CW9G-IK
 for kexec@lists.infradead.org; Thu, 16 Sep 2021 22:32:54 +0000
Received: by mail-lf1-x12a.google.com with SMTP id g1so24636177lfj.12
 for <kexec@lists.infradead.org>; Thu, 16 Sep 2021 15:32:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
 <20210824180555.GD623@arm.com>
 <CA+CK2bCakwsqS1RqXPJr+ewe=gsO98cOxhXye8-AcRLwtqhZ+g@mail.gmail.com>
 <YUMQZGLQl+82fL6G@arm.com>
In-Reply-To: <YUMQZGLQl+82fL6G@arm.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 16 Sep 2021 18:32:14 -0400
Message-ID: <CA+CK2bB-BV2tzeq8M_B+5M9YRJX-GmT-9ZM0fnvrfnuWhSk46g@mail.gmail.com>
Subject: Re: [PATCH v16 00/15] arm64: MMU enabled kexec relocation
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
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mm <linux-mm@kvack.org>, Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Selin Dag <selindag@gmail.com>, Tyler Hicks <tyhicks@linux.microsoft.com>, Pingfan Liu <kernelfans@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, madvenka@linux.microsoft.com

> > In case we are so low on memory that trans_pgd_create_copy() fails to
> > allocate the linear map that uses the large pages (the size of the
> > page table is tiny) the kexec fails during kexec load time (not during
> > reboot time), as out of memory. The MMU enabled kexec reboot is always
> > on, and we should not have several ways to do kexec reboot as it makes
> > the kexec reboot unpredictable in terms of performance, and also prone
> > to bugs by having a common MMU enabled path and less common path when
> > we are low on memory which is never tested.
>
> I think this makes sense, especially since it will fail during the kexec
> load time rather than reboot.
>
> I'm ok in principle with this series but I'd need to convince James
> Morse to have a another look since he followed it more closely than me.
> Could you please rebase it against 5.15-rc1?

Sure, I will send it out soon.

Thanks,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
