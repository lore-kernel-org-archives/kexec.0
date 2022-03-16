From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Wed, 16 Mar 2022 14:45:45 +0100
Subject: Qemu does not like kexec initrd
In-Reply-To: <YjHMEsXiraMrOLN4@MiWiFi-R3L-srv>
References: <CAHfPjO_Ln_yzU5_Crgk+SWyXWU=KALwTx6tWa7PSN2Wag-si-A@mail.gmail.com>
 <YjHMEsXiraMrOLN4@MiWiFi-R3L-srv>
Message-ID: <CAHfPjO_yUy=vaLVNsLh0nj0CUJVZdTT4CyZ+CUQPOg3KV=YNkw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,
here the result of my tests with qemu:
zstd is broken
xz --check=crc32 is broken
lz4 -l works
gzip works
Is there a bugtracker to report this or only this ML?
Thanks for your help.
greetings
tpowa

Am Mi., 16. M?rz 2022 um 12:38 Uhr schrieb Baoquan He <bhe@redhat.com>:
>
> Cc Tao,
>
> On 03/16/22 at 11:57am, Tobias Powalowski wrote:
> > Hi
> > I just discovered this:
> > https://githubhot.com/repo/talos-systems/talos/issues/4947
> > I also suffer from this in my project:
> > Loading zstd initrd will cause an error:
> > ZSTD-data is corrupt error on qemu.
> > Is there a fix or workaround for this issue?
>
> Hi Tao,
>
> Did you ever met this when you introduce zstd to kexec/kdump?
>
> Thanks
> Baoquan
>
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
> > _______________________________________________
> > kexec mailing list
> > kexec at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
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

