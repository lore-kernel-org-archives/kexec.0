Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gFQjY-0003pV-U2
 for kexec@lists.infradead.org; Wed, 24 Oct 2018 21:30:34 +0000
Received: by mail-lf1-f65.google.com with SMTP id q6-v6so4399842lfh.9
 for <kexec@lists.infradead.org>; Wed, 24 Oct 2018 14:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <MWHPR07MB3007D9D79825933D958943EC8AF60@MWHPR07MB3007.namprd07.prod.outlook.com>
In-Reply-To: <MWHPR07MB3007D9D79825933D958943EC8AF60@MWHPR07MB3007.namprd07.prod.outlook.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Thu, 25 Oct 2018 03:00:08 +0530
Message-ID: <CACi5LpO6JH=Fepu97GVa-oZK7v4kj0+RL9WqYZuMp=KRJ2=diQ@mail.gmail.com>
Subject: Re: [BUG] vmcore-dmesg cant' read dmesg log from /proc/vmcore if
 log_buf is reallocated due to large number of CPUs
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
To: Vadim.Lomovtsev@cavium.com
Cc: kexec mailing list <kexec@lists.infradead.org>

Hello Vadim,

On Wed, Oct 24, 2018 at 6:23 PM Lomovtsev, Vadim
<Vadim.Lomovtsev@cavium.com> wrote:
>
> Hi all,
>
> Following issue has been found for vmcore-dmesg app with latest release (94159bc3c264fa26395e56302072276a139d18af 2.0.18-rc1) of kexec-tools at CentOS 7.5 distro:
>
> While having systems with large number of CPUs (e.g. Cavium ThunderX2 has 224) the log_buf gets reallocated by memblock_virt_alloc() at the setup_log_buf routine (https://elixir.bootlin.com/linux/v4.16.18/source/kernel/printk/printk.c#L1108).
>
> Then while dumping vmcore the vmcore-dmesg can't find dmesg log at /proc/vmcore file and exits with following message:
>   Failed to read log text of size 0 bytes: Bad address
>
> However it (vmcore-dmesg app) reads properly the log_buf symbol, it's address and eventually it's value from /proc/vmcore but fails to find dmesg data then.
>
> In the same time the makedumpfile is able to find and extract dmesg buffer from /proc/vmcore.
> The makedumpfile comes with kexec-tools-2.0.15-13.el7_5.2.aarch64 package.
>
> The issue is not reproduced for systems with small number of CPUs and log_buf not reallocated to memblock section.

Seems like you are hitting a known issue we saw on qualcomm amberwing
platforms as well.
I have sent a patch-series titled 'kexec-tools/arm64: Add support to
read PHYS_OFFSET from vmcoreinfo inside '/proc/kcore' to this list
just a few minutes back.

I have Cc'ed you to the patchset as I think it might fix the issue for
you. Kindly try the patchset on your platform (cavium?) and let me
know if this fixes the issue for you.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
