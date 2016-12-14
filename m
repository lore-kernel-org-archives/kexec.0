Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cH5WR-0008Rz-Hl
 for kexec@lists.infradead.org; Wed, 14 Dec 2016 09:06:48 +0000
Received: by mail-io0-x244.google.com with SMTP id p13so3584368ioi.0
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 01:06:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214084402.GB9239@x1>
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
 <20161214074046.GP1034@x1>
 <CAFgQCTvOiWzKbYOBF-L0A2cmw4OR76Hz33ChHB6VTh0REQEmEA@mail.gmail.com>
 <20161214082501.GA9239@x1>
 <CAFgQCTvcywxOxGm-LvHeTzksYSWrxzwN7zCa9y-LJbsgnjr9Xg@mail.gmail.com>
 <20161214084402.GB9239@x1>
From: Liu ping fan <kernelfans@gmail.com>
Date: Wed, 14 Dec 2016 17:06:26 +0800
Message-ID: <CAFgQCTtoGF-tH9+gfQQEFS_WyOr-8npGurba3Xj8k6jOY2XDHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] kexec: add a dummy note for each offline cpu
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
To: Baoquan He <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>

[...]
>> >> >
>> >> > When you execute dmesg on your testing machine and grep nr_cpu_ids,
>> >> > what's the value of nr_cpu_ids?
>> >> >
>> >> nr_cpu_ids=128
>> >
>> > And what's the cpu number of in "lscpu" command?
>>
>> NUMA node1 CPU(s):     0-7
>>
>> The system booted up with 128 possible cpu and only 8 online.
>> Also I tested on x86 guest, after bootup with 8 cpus, then  offline 4
>> of them, the zero PT_NOTE warning buzz too.
>
> Yes, this is what I think not quite appropriate using
> for_each_cpu_not(cpu, cpu_online_mask). Maybe it need try to save on
> those cpus which is present but not online. not online seems not good,
> it's not reasonable to save those getting apic but no cpu plugged.
>
In the file:    kexec-tools/kexec/crashdump-elf.c
   nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
And this is why this patch needs to make a mark on these offline cpu.
This is no something like "_SC_NPROCESSORS_PRESENT" option, so just
work around it in kernel side.
Anyway for crash kernel, we only write "core" in percpu notes without
no more info, and it costs nothing when capture kernel gather the
PT_NOTE.

Thx,
Pingfan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
