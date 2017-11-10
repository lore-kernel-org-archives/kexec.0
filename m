Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eD6Su-0005Of-3j
 for kexec@lists.infradead.org; Fri, 10 Nov 2017 10:23:17 +0000
Received: by mail-oi0-x244.google.com with SMTP id s144so5967711oih.3
 for <kexec@lists.infradead.org>; Fri, 10 Nov 2017 02:22:49 -0800 (PST)
MIME-Version: 1.0
From: Yang Shunyong <yang.shunyong@gmail.com>
Date: Fri, 10 Nov 2017 18:22:48 +0800
Message-ID: <CAHnJXBhSY1ms_ts=pXJo+kSjCFUuProJjg5vY8MLM_kDsPY1Jw@mail.gmail.com>
Subject: About command line for kdump on ARM64
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
To: kexec@lists.infradead.org

Hi, All,
    I am trying to enable kdump on ARM64, based on 4.14 kernel.  I met
EFI reserved memory(eg. ACPI tables) being released issue, in function
arm64_memblock_init() . It will cause the memory attribute incorrect
and kernel crash in ACPI parsing.
    From the discussions about kdump on ARM64 I searched via Google,
it needs to set some memory configurations, like "mem=". I have set
the "mem=64M", but it still failed.
    Could you please share me some sample command line settings for
kdump ARM64? Or how to set options to avoid  the crash?

following is my command line from "kdump-config show", I have reserved
256M for crash in first kernel "crashkernel=256M@0x0efe00000",

  /sbin/kexec -p --command-line="BOOT_IMAGE=/vmlinuz-4.14.0-rc2-hxtysy
root=/dev/mapper/ubuntu--vg-root ro rqpoll mem=256M nr_cpus=1 nousb
systemd.unit=kdump-tools.service ns_log_on=on"
--initrd=/var/lib/kdump/initrd.img /var/lib/kdump/vmlinuz

Thanks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
