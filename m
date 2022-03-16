From: Baoquan He <bhe@redhat.com>
Date: Wed, 16 Mar 2022 19:37:54 +0800
Subject: Qemu does not like kexec initrd
In-Reply-To: <CAHfPjO_Ln_yzU5_Crgk+SWyXWU=KALwTx6tWa7PSN2Wag-si-A@mail.gmail.com>
References: <CAHfPjO_Ln_yzU5_Crgk+SWyXWU=KALwTx6tWa7PSN2Wag-si-A@mail.gmail.com>
Message-ID: <YjHMEsXiraMrOLN4@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Cc Tao,

On 03/16/22 at 11:57am, Tobias Powalowski wrote:
> Hi
> I just discovered this:
> https://githubhot.com/repo/talos-systems/talos/issues/4947
> I also suffer from this in my project:
> Loading zstd initrd will cause an error:
> ZSTD-data is corrupt error on qemu.
> Is there a fix or workaround for this issue?

Hi Tao,

Did you ever met this when you introduce zstd to kexec/kdump?

Thanks
Baoquan

> 
> -- 
> Tobias Powalowski
> Arch Linux Developer & Package Maintainer (tpowa)
> https://www.archlinux.org
> tpowa at archlinux.org
> 
> St. Martin-Apotheke
> Herzog-Georg-Str. 25
> 89415 Lauingen
> https://www.st-martin-apo.de
> info at st-martin-apo.de
> 
> _______________________________________________
> kexec mailing list
> kexec at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 


