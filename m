From: Tobias Powalowski <tobias.powalowski@googlemail.com>
Date: Wed, 9 Feb 2022 10:16:31 +0100
Subject: Is it possible to use a stream for initrd=
In-Reply-To: <YgMzVA7rzLYAHWNi@MiWiFi-R3L-srv>
References: <CAHfPjO9MPOP4ZhmLtoyp+YxdreMNCOiy7nApm+uweaSJX5XvpQ@mail.gmail.com>
 <YgMzVA7rzLYAHWNi@MiWiFi-R3L-srv>
Message-ID: <CAHfPjO-RXk4vo0noptQJ28LxTRQWGCd6yifBqGqPup_aD7h6Ug@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi,
I have a tmp directory with all files placed in:
find . -mindepth 1 -printf '%P\0' | sort -z | LANG=C bsdtar --uid 0
--gid 0 --null -cnf - -T - |\
    LANG=C bsdtar --null -cf - --format=newc @- | zstd -T0 > /initrd.img

and this initrd.img I want to write into kexec without creating the initrd file.

kexec -l /vmlinuz-linux --initrd=/initrd.img --reuse-cmdline
 systemctl kexec

Thanks for your help.
greetings
tpowa

Am Mi., 9. Feb. 2022 um 04:22 Uhr schrieb Baoquan He <bhe@redhat.com>:
>
> On 02/08/22 at 04:36pm, Tobias Powalowski wrote:
> > Hi,
> > just a quick question, is it possible to use a stream for initrd= parameter?
> > I want to save RAM/Space and directly load the ramdisk into memory for reboot.
> > initrd=< ... does not work.
>
> Are you using kexec -l or kexec -p to reboot? Can you write down your
> operation steps?
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

