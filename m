From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Wed, 16 Mar 2022 15:10:07 +0100
Subject: Qemu does not like kexec initrd
In-Reply-To: <CAO7dBbVUoU2Go7z6Y+Uv-fKF5+L0sC_e4Y3-Exktq-G2jJ+D6g@mail.gmail.com>
References: <CAHfPjO_Ln_yzU5_Crgk+SWyXWU=KALwTx6tWa7PSN2Wag-si-A@mail.gmail.com>
 <YjHMEsXiraMrOLN4@MiWiFi-R3L-srv>
 <CAO7dBbVUoU2Go7z6Y+Uv-fKF5+L0sC_e4Y3-Exktq-G2jJ+D6g@mail.gmail.com>
Message-ID: <CAHfPjO-dFs2xfySzmOgasJfdNTxgh8YFH2FAUK+nCv93hOW6sQ@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,
Do you need anything from my side?
Test files?
Test system is latest Arch Linux with qemu 6.2.0
greetings
tpowa

Am Mi., 16. M?rz 2022 um 14:58 Uhr schrieb Tao Liu <ltao@redhat.com>:
>
> Hi Baoquan,
>
> On Wed, Mar 16, 2022 at 7:38 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > Cc Tao,
> >
> > On 03/16/22 at 11:57am, Tobias Powalowski wrote:
> > > Hi
> > > I just discovered this:
> > > https://githubhot.com/repo/talos-systems/talos/issues/4947
> > > I also suffer from this in my project:
> > > Loading zstd initrd will cause an error:
> > > ZSTD-data is corrupt error on qemu.
> > > Is there a fix or workaround for this issue?
> >
> > Hi Tao,
> >
> > Did you ever met this when you introduce zstd to kexec/kdump?
> >
> No, I haven't encountered this issue before.
>
> Thanks,
> Tao Liu
>
> > Thanks
> > Baoquan
> >
> > >
> > > --
> > > Tobias Powalowski
> > > Arch Linux Developer & Package Maintainer (tpowa)
> > > https://www.archlinux.org
> > > tpowa at archlinux.org
> > >
> > > St. Martin-Apotheke
> > > Herzog-Georg-Str. 25
> > > 89415 Lauingen
> > > https://www.st-martin-apo.de
> > > info at st-martin-apo.de
> > >
> > > _______________________________________________
> > > kexec mailing list
> > > kexec at lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/kexec
> > >
> >
>


-- 
Tobias Powalowski
Arch Linux Developer & Package Maintainer (tpowa)
https://www.archlinux.org
tpowa at archlinux.org

St. Martin-Apotheke
Herzog-Georg-Str. 25
89415 Lauingen
https://www.st-martin-apo.de
info at st-martin-apo.de

