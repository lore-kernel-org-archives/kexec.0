From: Baoquan He <bhe@redhat.com>
Date: Wed, 9 Feb 2022 17:28:42 +0800
Subject: Is it possible to use a stream for initrd=
In-Reply-To: <CAHfPjO-RXk4vo0noptQJ28LxTRQWGCd6yifBqGqPup_aD7h6Ug@mail.gmail.com>
References: <CAHfPjO9MPOP4ZhmLtoyp+YxdreMNCOiy7nApm+uweaSJX5XvpQ@mail.gmail.com>
 <YgMzVA7rzLYAHWNi@MiWiFi-R3L-srv>
 <CAHfPjO-RXk4vo0noptQJ28LxTRQWGCd6yifBqGqPup_aD7h6Ug@mail.gmail.com>
Message-ID: <YgOJSlK/0UW6rJIS@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 02/09/22 at 10:16am, Tobias Powalowski wrote:
> Hi,
> I have a tmp directory with all files placed in:
> find . -mindepth 1 -printf '%P\0' | sort -z | LANG=C bsdtar --uid 0
> --gid 0 --null -cnf - -T - |\
>     LANG=C bsdtar --null -cf - --format=newc @- | zstd -T0 > /initrd.img
> 
> and this initrd.img I want to write into kexec without creating the initrd file.
> 
> kexec -l /vmlinuz-linux --initrd=/initrd.img --reuse-cmdline
>  systemctl kexec

See manpage of kexec, the EXAMPLE part:

kexec -l /boot/vmlinux  --initrd=/boot/initrd --reuse-cmdline
kexec -e


