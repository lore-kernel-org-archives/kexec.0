Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TsJ7m-00009I-UQ
 for kexec@lists.infradead.org; Mon, 07 Jan 2013 20:16:47 +0000
Received: by mail-bk0-f44.google.com with SMTP id w11so8834247bku.31
 for <kexec@lists.infradead.org>; Mon, 07 Jan 2013 12:16:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1593084.QhbTkmoq3N@hammer82.arch.suse.de>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <50B8D571.3000000@jp.fujitsu.com>
 <CAE9FiQVaqXMfju5j7qBsk+g=RpES-adBBdrDcnkW=YQTQOfugQ@mail.gmail.com>
 <1593084.QhbTkmoq3N@hammer82.arch.suse.de>
Date: Mon, 7 Jan 2013 12:16:42 -0800
Message-ID: <CAE9FiQWTiFu0+ymVroK84L-LCc7FBU1trdZAcaXqMGM2My6LzQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
From: Yinghai Lu <yinghai@kernel.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Thomas Renninger <trenn@suse.de>
Cc: Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

On Mon, Jan 7, 2013 at 11:09 AM, Thomas Renninger <trenn@suse.de> wrote:
> e820: BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000100-0x000000000009bfff] usable
> BIOS-e820: [mem 0x0000000000100000-0x00000000bd2effff] usable
> BIOS-e820: [mem 0x00000000bd2f0000-0x00000000bd31bfff] reserved
> BIOS-e820: [mem 0x00000000bd31c000-0x00000000bd35afff] ACPI data
> BIOS-e820: [mem 0x00000000bd35b000-0x00000000bfffffff] reserved
> BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
> BIOS-e820: [mem 0x00000000fe000000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000603fffffff] usable
> debug: ignoring loglevel setting.
> e820: last_pfn = 0x6040000 max_arch_pfn = 0x400000000
> NX (Execute Disable) protection: active
> e820: user-defined physical RAM map:
> user: [mem 0x0000000000000000-0x000000000009ffff] usable
> user: [mem 0x00000000070a0000-0x000000001effafff] usable
> user: [mem 0x00000000bd31c000-0x00000000bd35afff] ACPI data

can you make sure kdump kernel command line take
"memmap=256M$3584M" ?

it will make mmconf working.

> megasas: 06.504.01.00-rc1 Mon. Oct. 1 17:00:00 PDT 2012

also need to append "debug ignore_loglevel" to see why the disks are not
probed.

Thanks

Yinghai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
