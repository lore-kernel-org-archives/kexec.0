From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Thu, 17 Mar 2022 09:45:33 +0100
Subject: Qemu does not like kexec initrd
In-Reply-To: <CAO7dBbVC9qKp0BHicpU_AVh7for9c0YWpucDyC3wN9YP_hwB5Q@mail.gmail.com>
References: <CAHfPjO_Ln_yzU5_Crgk+SWyXWU=KALwTx6tWa7PSN2Wag-si-A@mail.gmail.com>
 <YjHMEsXiraMrOLN4@MiWiFi-R3L-srv>
 <CAO7dBbVUoU2Go7z6Y+Uv-fKF5+L0sC_e4Y3-Exktq-G2jJ+D6g@mail.gmail.com>
 <CAHfPjO-dFs2xfySzmOgasJfdNTxgh8YFH2FAUK+nCv93hOW6sQ@mail.gmail.com>
 <CAO7dBbXzUH8zLH32QnB0EnVJ6a7rq-oanHQnhz8hCbU4v8wg6g@mail.gmail.com>
 <CAHfPjO8ayenR7Q0JX00if1yHwq_Uy1N27=KtRAizqja-94D-kQ@mail.gmail.com>
 <CAO7dBbVC9qKp0BHicpU_AVh7for9c0YWpucDyC3wN9YP_hwB5Q@mail.gmail.com>
Message-ID: <CAHfPjO_bSkjA5coG_9diTvM1fiKJoHBmavFCcM1bAw7zws5FVA@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,
Which upstream code?
Arch Linux kernel is upstream
Qemu is upstream
- Kernel message prints the error
greetings
tpowa

Am Do., 17. M?rz 2022 um 09:34 Uhr schrieb Tao Liu <ltao@redhat.com>:
>
> Hi Tobias,
>
> The kernel you provided is not an upstream kernel, which contains
> distribution specific modification, as well as the kexec. Since you
> are reporting an issue to the upstream, I suggest you:
>
> 1) re-run your tests against the upstream code, instead of
> distribution specific code.
> 2) if the issue still persists, you can report the issue to upstream,
> as well as the detailed log information, such as:
>     what is the log message?
>     who prints the log message, qemu? kernel? kexec?
>     what is the behaviour when the error occurs? kernel panic? error
> logs? qemu crash?
> For your case, Loading zstd initrd will cause an error(what error? who
> prints the error?) ZSTD-data is corrupt error on qemu(how do you know
> the data is corrupt? what attempts did you make?).
>
> Please note upstream is not responsible for the distribution specific issues.
>
> Thanks,
> Tao Liu
>
>
> On Wed, Mar 16, 2022 at 10:33 PM Tobias Powalowski
> <tobias.powalowski@googlemail.com> wrote:
> >
> > Kernel and zstd initrds are located here:
> > https://pkgbuild.com/~tpowa/archboot-images/x86_64/latest/boot/
> > kexec -l kernel --initrd=initrd --reuse-cmdline
> > systemctl kexec
> >
> > Am Mi., 16. M?rz 2022 um 15:19 Uhr schrieb Tao Liu <ltao@redhat.com>:
> > >
> > > Hi Tobias,
> > >
> > > On Wed, Mar 16, 2022 at 10:10 PM Tobias Powalowski
> > > <tobias.powalowski@googlemail.com> wrote:
> > > >
> > > > Hi,
> > > > Do you need anything from my side?
> > > > Test files?
> > > > Test system is latest Arch Linux with qemu 6.2.0
> > > > greetings
> > > > tpowa
> > > >
> > >
> > > Could you briefly introduce your test steps please? I will try to reproduce it.
> > >
> > > Thanks,
> > > Tao Liu
> > >
> > > > Am Mi., 16. M?rz 2022 um 14:58 Uhr schrieb Tao Liu <ltao@redhat.com>:
> > > > >
> > > > > Hi Baoquan,
> > > > >
> > > > > On Wed, Mar 16, 2022 at 7:38 PM Baoquan He <bhe@redhat.com> wrote:
> > > > > >
> > > > > > Cc Tao,
> > > > > >
> > > > > > On 03/16/22 at 11:57am, Tobias Powalowski wrote:
> > > > > > > Hi
> > > > > > > I just discovered this:
> > > > > > > https://githubhot.com/repo/talos-systems/talos/issues/4947
> > > > > > > I also suffer from this in my project:
> > > > > > > Loading zstd initrd will cause an error:
> > > > > > > ZSTD-data is corrupt error on qemu.
> > > > > > > Is there a fix or workaround for this issue?
> > > > > >
> > > > > > Hi Tao,
> > > > > >
> > > > > > Did you ever met this when you introduce zstd to kexec/kdump?
> > > > > >
> > > > > No, I haven't encountered this issue before.
> > > > >
> > > > > Thanks,
> > > > > Tao Liu
> > > > >
> > > > > > Thanks
> > > > > > Baoquan
> > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Tobias Powalowski
> > > > > > > Arch Linux Developer & Package Maintainer (tpowa)
> > > > > > > https://www.archlinux.org
> > > > > > > tpowa at archlinux.org
> > > > > > >
> > > > > > > St. Martin-Apotheke
> > > > > > > Herzog-Georg-Str. 25
> > > > > > > 89415 Lauingen
> > > > > > > https://www.st-martin-apo.de
> > > > > > > info at st-martin-apo.de
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > kexec mailing list
> > > > > > > kexec at lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/kexec
> > > > > > >
> > > > > >
> > > > >
> > > >
> > > >
> > > > --
> > > > Tobias Powalowski
> > > > Arch Linux Developer & Package Maintainer (tpowa)
> > > > https://www.archlinux.org
> > > > tpowa at archlinux.org
> > > >
> > > > St. Martin-Apotheke
> > > > Herzog-Georg-Str. 25
> > > > 89415 Lauingen
> > > > https://www.st-martin-apo.de
> > > > info at st-martin-apo.de
> > > >
> > >
> >
> >
> > --
> > Tobias Powalowski
> > Arch Linux Developer & Package Maintainer (tpowa)
> > https://www.archlinux.org
> > tpowa at archlinux.org
> >
> > St. Martin-Apotheke
> > Herzog-Georg-Str. 25
> > 89415 Lauingen
> > https://www.st-martin-apo.de
> > info at st-martin-apo.de
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

