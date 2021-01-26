Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4XPA-0007Th-9a
 for kexec@lists.infradead.org; Tue, 26 Jan 2021 23:05:50 +0000
Received: by mail-ed1-x52e.google.com with SMTP id c2so38894edr.11
 for <kexec@lists.infradead.org>; Tue, 26 Jan 2021 15:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
 <20210126225847.GC30941@willie-the-truck>
In-Reply-To: <20210126225847.GC30941@willie-the-truck>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 26 Jan 2021 18:05:10 -0500
Message-ID: <CA+CK2bBT6OZwh_zSbhRDVAEptVMQGywV_E42iXS4YywGkqJQaQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/18] arm64: MMU enabled kexec relocation
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
To: Will Deacon <will@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vladimir Murzin <vladimir.murzin@arm.com>, Jonathan Corbet <corbet@lwn.net>, Catalin Marinas <catalin.marinas@arm.com>, Selin Dag <selindag@gmail.com>, steve.capper@arm.com, kexec mailing list <kexec@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>, linux-mm <linux-mm@kvack.org>, Tyler Hicks <tyhicks@linux.microsoft.com>, James Morse <james.morse@arm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Marc Zyngier <maz@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Jan 26, 2021 at 5:58 PM Will Deacon <will@kernel.org> wrote:
>
> Hi Pavel,
>
> On Mon, Jan 25, 2021 at 02:19:05PM -0500, Pavel Tatashin wrote:
> > Changelog:
> > v10:
> >       - Addressed a lot of comments form James Morse and from  Marc Zyngier
> >       - Added review-by's
> >       - Synchronized with mainline
>
> This series has been doing the rounds for a while, but still isn't fully
> reviewed. Would it help if I merged, e.g. the first 12 patches to reduce the
> amount you have to repost?

Hi Will,

Yes, it would. The first 10 patches of this series were already merged
sometime ago:

a2c2e67923ec arm64: hibernate: add trans_pgd public functions
7ea4088938b7 arm64: hibernate: add PUD_SECT_RDONLY
13373f0e6580 arm64: hibernate: rename dst to page in create_safe_exec_page
a89d7ff933b0 arm64: hibernate: remove gotos as they are not needed
051a7a94aaa9 arm64: hibernate: use get_safe_page directly
d234332c2815 arm64: hibernate: pass the allocated pgdp to ttbr0
621516789ee6 arm64: kexec: make dtb_mem always enabled
3b54b743397e arm64: kexec: remove unnecessary debug prints
de68e4daea90 kexec: add machine_kexec_post_load()
d42cc530b18d kexec: quiet down kexec reboot

So, merging another ~12, would substantially help with getting
everything reviewed and merged.

Thank you,
Pavel

>
> Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
