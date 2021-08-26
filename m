Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJGvB-00AROl-I1
 for kexec@lists.infradead.org; Thu, 26 Aug 2021 15:04:05 +0000
Received: by mail-ed1-x52a.google.com with SMTP id s25so5206192edw.0
 for <kexec@lists.infradead.org>; Thu, 26 Aug 2021 08:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210802215408.804942-1-pasha.tatashin@soleen.com>
 <20210824180555.GD623@arm.com>
In-Reply-To: <20210824180555.GD623@arm.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 26 Aug 2021 11:03:21 -0400
Message-ID: <CA+CK2bCakwsqS1RqXPJr+ewe=gsO98cOxhXye8-AcRLwtqhZ+g@mail.gmail.com>
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

On Tue, Aug 24, 2021 at 2:06 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Hi Pavel,
>
> This series is still missing reviews from those who understand kexec
> better than me.

Hi Catalin,

Yes, I am looking for reviewers.

>
> On Mon, Aug 02, 2021 at 05:53:53PM -0400, Pavel Tatashin wrote:
> > Enable MMU during kexec relocation in order to improve reboot performance.
> >
> > If kexec functionality is used for a fast system update, with a minimal
> > downtime, the relocation of kernel + initramfs takes a significant portion
> > of reboot.
> >
> > The reason for slow relocation is because it is done without MMU, and thus
> > not benefiting from D-Cache.
>
> The performance improvements are indeed significant on some platforms
> (going from 7s to ~40ms), so I think the merging the series is worth it.
> Some general questions so I better understand the impact:
>
> - Is the kdump path affected in any way? IIUC that doesn't need any
>   relocation but we should also make sure we don't create the additional
>   page table unnecessarily (should keep as much memory intact as
>   possible). Maybe that's already handled.

Because kdump does not need relocation, we do not reserve pages for
the page table in the kdump reboot case. In fact, with this series,
kdump reboot becomes more straightforward as we skip the relocation
function entirely, and jump directly into the crash kernel (or
purgatory if kexec tools loaded them).

>
> - What happens if trans_pgd_create_copy() fails to allocate memory. Does
>   it fall back to an MMU-off relocation?

In case we are so low on memory that trans_pgd_create_copy() fails to
allocate the linear map that uses the large pages (the size of the
page table is tiny) the kexec fails during kexec load time (not during
reboot time), as out of memory. The MMU enabled kexec reboot is always
on, and we should not have several ways to do kexec reboot as it makes
the kexec reboot unpredictable in terms of performance, and also prone
to bugs by having a common MMU enabled path and less common path when
we are low on memory which is never tested.

>
> And I presume this series does not introduce any changes to the kexec
> tools ABI.

Correct.

Thanks for taking a look at this series.

Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
