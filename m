Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icRJW-000254-DK
 for kexec@lists.infradead.org; Wed, 04 Dec 2019 09:51:20 +0000
Received: by mail-wm1-x342.google.com with SMTP id p17so7080680wmi.3
 for <kexec@lists.infradead.org>; Wed, 04 Dec 2019 01:51:18 -0800 (PST)
MIME-Version: 1.0
References: <20191203201410.28045-1-msys.mizuma@gmail.com>
In-Reply-To: <20191203201410.28045-1-msys.mizuma@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 4 Dec 2019 09:51:13 +0000
Message-ID: <CAKv+Gu-teb+3a29cZVc0cxZrXonQeO-EtPugPaQ1QFbeBYjGTw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] efi: arm64: Introduce /proc/efi/memreserve to tell
 the persistent pages
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
To: Masayoshi Mizuma <msys.mizuma@gmail.com>, James Morse <james.morse@arm.com>
Cc: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>, linux-efi <linux-efi@vger.kernel.org>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Matthias Brugger <matthias.bgg@gmail.com>, d.hatayama@fujitsu.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, 3 Dec 2019 at 20:14, Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> kexec reboot sometime fails in early boot sequence on aarch64 machine.
> That is because kexec overwrites the LPI property tables and pending
> tables with the initrd.
>
> To avoid the overwrite, introduce /proc/efi/memreserve to tell the
> tables region to kexec so that kexec can avoid the memory region to
> locate initrd.
>
> kexec also needs a patch to handle /proc/efi/memreserve. I'm preparing
> the patch for kexec.
>
> Changelog
>     v2: - Change memreserve file location from sysfs to procfs.
>           memreserve may exceed the PAGE_SIZE in case efi_memreserve_root
>           has a lot of entries. So we cannot use sysfs_kf_seq_show().
>           Use seq_printf() in procfs instead.
>
> Masayoshi Mizuma (2):
>   efi: add /proc/efi directory
>   efi: arm64: Introduce /proc/efi/memreserve to tell the persistent
>     pages
>

Apologies for the tardy response.

Adding /proc/efi is really out of the question. *If* we add any
special files to expose this information, it should be under sysfs.

However, this is still only a partial solution, since it only solves
the problem for userspace based kexec, and we need something for
kexec_file_load() as well.

The fundamental issue here is that /proc/iomem apparently lacks the
entries that describe these regions as 'reserved', so we should try to
address that instead.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
