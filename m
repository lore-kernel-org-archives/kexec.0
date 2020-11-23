Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kh56i-0004Wo-Qm
 for kexec@lists.infradead.org; Mon, 23 Nov 2020 06:13:49 +0000
Received: by mail-pg1-x544.google.com with SMTP id 81so13291265pgf.0
 for <kexec@lists.infradead.org>; Sun, 22 Nov 2020 22:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20201123043758.105713-1-alexander.kamensky42@gmail.com>
 <CAFTCetQJysinU1E6kPFs9puNazNHLfOhvWz8ETetu85JHBjRxQ@mail.gmail.com>
In-Reply-To: <CAFTCetQJysinU1E6kPFs9puNazNHLfOhvWz8ETetu85JHBjRxQ@mail.gmail.com>
From: Alexander Kamensky <alexander.kamensky42@gmail.com>
Date: Sun, 22 Nov 2020 22:13:35 -0800
Message-ID: <CACBYKvQV1hm7OCT4TG6r7Upvgqt_U0Vu6koj2HNS0KRHib2GOQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] makedumpfile: about failing on arm64 with kernel
 > 5.4
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org, Kazuhito Hagio <k-hagio-ab@nec.com>

Hi Bhupesh,

Appreciate your response while you're on holiday!

Please see responses inline below.

On Sun, Nov 22, 2020 at 8:57 PM Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>
> Hi Alexander,
>
> Thanks for the patchset.
> I am not sure why this new patchset is needed for makedumpfile
> upstream - if you need a separate patchset for Yocto please feel free
> to submit it to the Yocto list and Cc us.
>
> However for upstream makedumpfile project these are _probably_ not
> required - I have tested my patch on several arm64 boards and it works
> fine there.

Maybe I am missing something, I am new to makedumpfile.

Please consider the following use cases:

1) Primary kernel version is 5.8.1 but secondary kernel, that takes control
after primary crash, version is 5.2.1, according to your patch logic
makedumpfile running secondary, in populate_kernel_version function will issue
a uname call and gets 5.2.1 kernel_version. Acting on it makedumpfile reading
/proc/vmcore will handle __pa logic in the old pre 5.4 kernel way, but this
vmcore came from a 5.8.1 kernel and requires a new way of __pa handling.

2) Or in a similar case, consider a device with kernel 4.4 produced vmcore.
On the host machine running a 5.8 kernel, one would want to refilter vmcore
with different -d value. Since the current kernel version is 5.8 __pa
function will
use the new way, but the vmcore was created by an old kernel that requires the
old way of __pa handling.

My understanding is that this was the issue that Kazu pointed out in feedback
to your patch [1]. He wrote:

> The populate_kernel_version() uses uname(), so this means that there will
> be some cases that makedumpfile doesn't work with vmcores which were
> captured on other kernels than running one.  This is a rather big limitation
> especially to backward-compatibility test, and it would be better to
> avoid changing behavior depending on environment, not on data.
>
> Is there no room to avoid it?
>
> Just an idea, but can we use the OSRELEASE vmcoreinfo in ELF note first
> to determine the kernel version?  It's from init_uts_ns.name.release,
> why can't we use it?

I just implemented the suggestion.

Thanks,
Alexander

[1] http://lists.infradead.org/pipermail/kexec/2020-September/021488.html

>
> I will send the next version of my patch once I am back from my
> holidays later this week.
> If you see any breakage with the same, please feel free to report here
> with relevant logs and I can help further
>
> Thanks,
> Bhupesh
>
> On Mon, Nov 23, 2020 at 10:10 AM Alexander Kamensky
> <alexander.kamensky42@gmail.com> wrote:
> >
> > Hi Kazu, Bhupesh,
> >
> > I am hitting the linear mapping swap issue with makedumpfile failing on
> > arm64 Yocto Project qemuarm64 machine with 5.8 kernel as it was discussed
> > several times on this mailing list:
> >
> > root@qemuarm64:~# makedumpfile -c -F /proc/vmcore > /dev/null
> > readpage_elf: Attempt to read non-existent page at 0x0.
> > readmem: type_addr: 1, addr:440, size:8
> > vaddr_to_paddr_arm64: Can't read pmd
> > readmem: Can't convert a virtual address(ffffffc01107f94c) to physical address.
> > readmem: type_addr: 0, addr:ffffffc01107f94c, size:390
> > check_release: Can't get the address of system_utsname.
> >
> > I've have tried Bhupesh's remaining third patch [1] from [2] series,
> > it does help. But I am a bit hesitant to submit it to the Yocto Project,
> > since Kazu pointed out [3] that this patch uses current kernel version to
> > make decision how __pa is handled and it may mismatch the version where
> > vmcore was collected, and in such case it may not operate correctly.
> >
> > In this RFC series I have tried to implement Kazu's suggestion and use
> > kernel version retrieved from OSRELEASE string from vmcoreinfo note. I
> > wonder whether it will help to merge arm64 5.4+ makedumpfile fix? Is
> > there anything else outstanding that prevents such merge?
> >
> > My RFC patches series does include Bhupesh's patch [1], and I posted
> > my modifications on top of it as separate patch for readability.
> >
> > Thanks,
> > Alexander
> >
> > [1] http://lists.infradead.org/pipermail/kexec/2020-September/021336.html
> > [2] http://lists.infradead.org/pipermail/kexec/2020-September/021333.html
> > [3] http://lists.infradead.org/pipermail/kexec/2020-September/021488.html
> >
> > Alexander Kamensky (2):
> >   added way to determine kernel version that vmcore is from
> >   arm64: use kernel version from OSRELEASE to determine linear mapping
> >     position
> >
> > Bhupesh Sharma (1):
> >   makedumpfile/arm64: Add support for ARMv8.2-LVA (52-bit kernel VA
> >     support)
> >
> >  arch/arm64.c   | 229 ++++++++++++++++++++++++++++++++++++++++++-------
> >  common.h       |  10 +++
> >  makedumpfile.c |  23 +++++
> >  makedumpfile.h |   6 +-
> >  4 files changed, 234 insertions(+), 34 deletions(-)
> >
> > --
> > 2.26.2
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
