Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eD7R7-0005oG-E7
 for kexec@lists.infradead.org; Fri, 10 Nov 2017 11:25:27 +0000
Received: by mail-qt0-x242.google.com with SMTP id 31so11361237qtz.9
 for <kexec@lists.infradead.org>; Fri, 10 Nov 2017 03:25:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHnJXBhSY1ms_ts=pXJo+kSjCFUuProJjg5vY8MLM_kDsPY1Jw@mail.gmail.com>
References: <CAHnJXBhSY1ms_ts=pXJo+kSjCFUuProJjg5vY8MLM_kDsPY1Jw@mail.gmail.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Fri, 10 Nov 2017 16:55:03 +0530
Message-ID: <CAFTCetSMsD7ykTeKFiZV8ZiA8Kr3aBRyh16=XKZcLAY4_n6Fqw@mail.gmail.com>
Subject: Re: About command line for kdump on ARM64
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
To: Yang Shunyong <yang.shunyong@gmail.com>
Cc: Bhupesh Sharma <bhsharma@redhat.com>, kexec@lists.infradead.org

Hello Yang Shunyong,

On Fri, Nov 10, 2017 at 3:52 PM, Yang Shunyong <yang.shunyong@gmail.com> wrote:
> Hi, All,
>     I am trying to enable kdump on ARM64, based on 4.14 kernel.  I met
> EFI reserved memory(eg. ACPI tables) being released issue, in function
> arm64_memblock_init() . It will cause the memory attribute incorrect
> and kernel crash in ACPI parsing.
>     From the discussions about kdump on ARM64 I searched via Google,
> it needs to set some memory configurations, like "mem=". I have set
> the "mem=64M", but it still failed.
>     Could you please share me some sample command line settings for
> kdump ARM64? Or how to set options to avoid  the crash?
>
> following is my command line from "kdump-config show", I have reserved
> 256M for crash in first kernel "crashkernel=256M@0x0efe00000",
>
>   /sbin/kexec -p --command-line="BOOT_IMAGE=/vmlinuz-4.14.0-rc2-hxtysy
> root=/dev/mapper/ubuntu--vg-root ro rqpoll mem=256M nr_cpus=1 nousb
> systemd.unit=kdump-tools.service ns_log_on=on"
> --initrd=/var/lib/kdump/initrd.img /var/lib/kdump/vmlinuz
>

Yes, I am aware of this issue and debugging the same (see
https://bugzilla.redhat.com/show_bug.cgi?id=1505314 for details).

I plan to post a patch fixing this issue early next week.
I will keep you posted and also share an early version of the patch
with you so that you can check if the same works for you.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
