Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TtLfZ-00075q-FK
 for kexec@lists.infradead.org; Thu, 10 Jan 2013 17:11:58 +0000
Received: by mail-bk0-f43.google.com with SMTP id jf20so463869bkc.30
 for <kexec@lists.infradead.org>; Thu, 10 Jan 2013 09:11:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130110170147.GC32223@redhat.com>
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <201301081747.17853.trenn@suse.de>
 <CAE9FiQW=gT86Eo0gwPHi5iFi4sg=1SHkBohBAo2KXdoB_Ouqvw@mail.gmail.com>
 <1586060.uJlkOEQfVW@hammer82.arch.suse.de>
 <20130110142643.GB32223@redhat.com>
 <CAE9FiQUGHKqbGk_GNfDuinwd0AMDGKeno44KWCLw7hGZs5OaKQ@mail.gmail.com>
 <20130110170147.GC32223@redhat.com>
Date: Thu, 10 Jan 2013 09:11:55 -0800
Message-ID: <CAE9FiQXEJ-pYpo7rCg+DpYw9hAFTRz97gR1NgRHBheCxdt0+yw@mail.gmail.com>
Subject: Re: [PATCH] Only reset e820 once,
 even with multiple memmap=exactmap params
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: horms@verge.net.au, Takao Indoh <indou.takao@jp.fujitsu.com>, MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, Thomas Renninger <trenn@suse.de>, khalid@gonehiking.org

On Thu, Jan 10, 2013 at 9:01 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
> On Thu, Jan 10, 2013 at 08:53:18AM -0800, Yinghai Lu wrote:
>> On Thu, Jan 10, 2013 at 6:26 AM, Vivek Goyal <vgoyal@redhat.com> wrote:
>> >
>> > This happens only in case of kdump and not kexec. In case of kdump
>> > we want second kernel to use only selected memory areas.
>> >
>> > In fact this is one improvement area. Instead of using memmap= entries
>> > in kdump case, we should probably modify the e820 map passed in
>> > zero page and get rid of memmap= entries.
>>
>> then how the kdump kernel get saved_max_pfn?
>>
>
> Oh, I forgot about that. May be we can pass saved_max_pfn on command line
> instead of passing all memmap= entries.

then we create another kernel version/kexec tools dependency.

kexec tools need to check kernel version, to see if saved_max_pfn= is supported.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
