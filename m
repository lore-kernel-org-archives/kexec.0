From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Wed, 9 Feb 2022 10:32:24 +0100
Subject: Is it possible to use a stream for initrd=
In-Reply-To: <YgOJSlK/0UW6rJIS@MiWiFi-R3L-srv>
References: <CAHfPjO9MPOP4ZhmLtoyp+YxdreMNCOiy7nApm+uweaSJX5XvpQ@mail.gmail.com>
 <YgMzVA7rzLYAHWNi@MiWiFi-R3L-srv>
 <CAHfPjO-RXk4vo0noptQJ28LxTRQWGCd6yifBqGqPup_aD7h6Ug@mail.gmail.com>
 <YgOJSlK/0UW6rJIS@MiWiFi-R3L-srv>
Message-ID: <CAHfPjO8XAmK9tbPNpMZO9D9h7MJqMjixhn9hTYmgVK1T2Fxcig@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Sorry you misunderstood, I don't want to create the initrd.img file.
I want to pass the zstd directly to kexec initrd= option.
greetings
tpowa

Am Mi., 9. Feb. 2022 um 10:28 Uhr schrieb Baoquan He <bhe@redhat.com>:
>
> On 02/09/22 at 10:16am, Tobias Powalowski wrote:
> > Hi,
> > I have a tmp directory with all files placed in:
> > find . -mindepth 1 -printf '%P\0' | sort -z | LANG=C bsdtar --uid 0
> > --gid 0 --null -cnf - -T - |\
> >     LANG=C bsdtar --null -cf - --format=newc @- | zstd -T0 > /initrd.img
> >
> > and this initrd.img I want to write into kexec without creating the initrd file.
> >
> > kexec -l /vmlinuz-linux --initrd=/initrd.img --reuse-cmdline
> >  systemctl kexec
>
> See manpage of kexec, the EXAMPLE part:
>
> kexec -l /boot/vmlinux  --initrd=/boot/initrd --reuse-cmdline
> kexec -e
>


-- 
Tobias Powalowski
Archlinux Developer & Package Maintainer (tpowa)
https://www.archlinux.org
tpowa at archlinux.org

St. Martin-Apotheke
Herzog-Georg-Str. 25
89415 Lauingen
https://www.st-martin-apo.de
info at st-martin-apo.de

