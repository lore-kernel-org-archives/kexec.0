Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from borg.tf-network.de ([62.75.218.204])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XKY1O-0002JH-Pi
 for kexec@lists.infradead.org; Thu, 21 Aug 2014 19:27:43 +0000
Message-ID: <53F64815.8010206@whissi.de>
Date: Thu, 21 Aug 2014 21:27:17 +0200
From: "Thomas D." <whissi@whissi.de>
MIME-Version: 1.0
Subject: Re: kexec fails to boot kernels where CONFIG_RANDOMIZE_BASE=y is set
References: <53F11882.3060803@whissi.de> <20140818145718.GD4745@redhat.com>
 <20140819090724.GB21724@dhcp-17-37.nay.redhat.com>
 <20140820143315.GC16303@redhat.com>
 <CAGXu5jLxEoKEy0nw8qj0MW0f2Vpog-DtDi7OwnUrkh7jGSkdWw@mail.gmail.com>
 <20140821181000.GB21891@redhat.com> <20140821190226.GE21891@redhat.com>
In-Reply-To: <20140821190226.GE21891@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>, Kees Cook <keescook@chromium.org>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, WANG Chao <chaowang@redhat.com>

Hi,

Vivek Goyal wrote:
> Thomas, can you please test kexec with "nokaslr" specified in command
> line. This can atleast get you going for now till the problem is actually
> fixed.

I booted linux-3.15.10 with "nokaslr"

>  # dmesg | grep -i command
> [    0.000000] Command line: BOOT_IMAGE=/kernel dolvm video=1280x1024 root=UUID=6d42... rootfs=ext4 nokaslr initrd=/initramfs
> [    0.000000] Kernel command line: BOOT_IMAGE=/kernel dolvm video=1280x1024 root=UUID=6d42... rootfs=ext4 nokaslr initrd=/initramfs

and run kexec with

> --reuse-cmdline -l /boot/kernel root=/dev/dm-3  --initrd=/boot/initramfs

But it still doesn't reboot. I see no difference between using "nokaslr"
or not.


-Thomas


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
