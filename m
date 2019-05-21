Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f193.google.com ([209.85.166.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hT0fv-0007ym-Qy
 for kexec@lists.infradead.org; Tue, 21 May 2019 09:03:13 +0000
Received: by mail-it1-f193.google.com with SMTP id 9so3495881itf.4
 for <kexec@lists.infradead.org>; Tue, 21 May 2019 02:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190424092944.30481-2-bhe@redhat.com>
 <20190429002318.GA25400@MiWiFi-R3L-srv>
 <20190429135536.GC2324@zn.tnic> <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic> <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic> <20190513080210.GC16774@MiWiFi-R3L-srv>
 <20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp>
 <20190515065843.GA24212@zn.tnic>
 <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20190515070942.GA17154@jeru.linux.bs1.fc.nec.co.jp>
From: Kairui Song <kasong@redhat.com>
Date: Tue, 21 May 2019 17:02:59 +0800
Message-ID: <CACPcB9cyiPc8JYmt1QhYNipSsJ5z3wTOJ90LS5LTx4YqwaG8rA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
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
To: Junichi Nomura <j-nomura@ce.jp.nec.com>, Borislav Petkov <bp@alien8.de>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

On Wed, May 15, 2019 at 3:10 PM Junichi Nomura <j-nomura@ce.jp.nec.com> wrote:
>
> On 5/15/19 3:58 PM, Borislav Petkov wrote:
> > On Wed, May 15, 2019 at 05:17:19AM +0000, Junichi Nomura wrote:
> >> Hi Kairui,
> >>
> >> On 5/13/19 5:02 PM, Baoquan He wrote:
> >>> On 05/13/19 at 09:50am, Borislav Petkov wrote:
> >>>> On Mon, May 13, 2019 at 03:32:54PM +0800, Baoquan He wrote:
> >>>> So we're going to try it again this cycle and if there's no fallout, it
> >>>> will go upstream. If not, it will have to be fixed. The usual thing.
> >>>>
> >>>> And I don't care if Kairui's patch fixes this one problem - judging by
> >>>> the fragility of this whole thing, it should be hammered on one more
> >>>> cycle on as many boxes as possible to make sure there's no other SNAFUs.
> >>>>
> >>>> So go test it on more machines instead. I've pushed it here:
> >>>>
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=next-merge-window
> >>>
> >>> Pingfan has got a machine to reproduce the kexec breakage issue, and
> >>> applying these two patches fix it. He planned to paste the test result.
> >>> I will ask him to try this branch if he has time, or I can get his
> >>> machine to test.
> >>>
> >>> Junichi, also have a try on Boris's branch in NEC's test environment?
> >>
> >> while the patch set works on most of the machines I'm testing around,
> >> I found kexec(1) fails to load kernel on a few machines if this patch
> >> is applied.  Those machines don't have IORES_DESC_ACPI_TABLES region
> >> and have ACPI tables in IORES_DESC_ACPI_NV_STORAGE region instead.
> >
> > Why? What kind of machines are those?
>
> I don't know.  They are just general purpose Xeon-based servers
> and not some special purpose machines.  So I guess there are other
> such machines in the wild.
>

Hi, I think it's reasonable to update the patch to include the
NV_STORAGE regions as well, most likely the firmware only provided
NV_STORAGE region? Can you help confirm if the e820 didn't contain
ACPI data, and only ACPI NVS?

I had a try with this update patch, it worked and didn't break anything.

Hi Boris, would you prefer to just fold Junichi update patch into the
previous one or I should send an updated patch?


--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
