Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUBuG-005eBk-DR
 for kexec@lists.infradead.org; Wed, 07 Apr 2021 17:23:59 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <CAK5_k=Lao5dYtAWrBMXViM0iEdT0QOj-fPiEsuvkfTogfF=6dA@mail.gmail.com>
 <20210331024745.GB29970@MiWiFi-R3L-srv>
 <CAK5_k=LeBQnmr7HfBZT9HismdfN65oJvrNU8KH1QgP=uYZaezg@mail.gmail.com>
 <20210331034851.GH13786@MiWiFi-R3L-srv>
 <20210331080324.GC29970@MiWiFi-R3L-srv> <YGQujxhxgOvtwb7n@kroah.com>
 <m1pmzfquyr.fsf@fess.ebiederm.org>
 <CAO7dBbWPcjOTcugLkpV9S9uOEhetCg=MiW=xDbAX4EAotBMOHg@mail.gmail.com>
 <m1mtuhq4h0.fsf@fess.ebiederm.org>
 <CAO7dBbU=Q7yMKv-Hp8cUxgPffE=vxtKYvfP7NLKejf-Q8x+H=w@mail.gmail.com>
Date: Wed, 07 Apr 2021 12:23:25 -0500
In-Reply-To: <CAO7dBbU=Q7yMKv-Hp8cUxgPffE=vxtKYvfP7NLKejf-Q8x+H=w@mail.gmail.com>
 (Liu Tao's message of "Tue, 6 Apr 2021 18:45:37 +0800")
Message-ID: <m1sg42ggaa.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec does not work for kernel version with patch level >= 256
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
To: Liu Tao <ltao@redhat.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Baoquan He <bhe@redhat.com>, Patrick Sung <patricksung@gmail.com>, sashal@kernel.org, kexec@lists.infradead.org, RuiRui Yang <dyoung@redhat.com>, horms@verge.net.au

Liu Tao <ltao@redhat.com> writes:

> Hello Eric,
>
> Please correct me if I'm wrong. After my research, I found that the
> KERNEL_VERSION
> check cannot be removed.
>
> In x86_64 case, function get_kernel_page_offset set different hard coded
> values into
> elf_info->page_offset according to KERNEL_VERSION, then in function
> get_kernel_vaddr_and_size,
> elf_info->page_offset gets refreshed by reading program segments of
> /proc/kcore.
> The refresh can fail when KASLR is off, thus the hard coded values are
> still needed as pre-set
> default values.

I see that the code is conditional upon KASLR, but I don't see any
particular reason why the code in get_kernel_vaddr_and_size is
conditional upon KASLR.

Skimming through arch/x86/kernel/vmlinux.lds.S and fs/proc/kcore.c I
don't see anything that is ASLR specific.  So everything should work
simply by removing the unnecessary gate on the presence of the
page_address_base symbol.

I suspect the code will even correctly compute PAGE_OFFSET on all
architectures, but we don't need to go that far to remove our use of the
kernel version.

> In addition, If I set a wrong value in elf_info->page_offset, readelf -l
> vmcore will give the value I set,
> reading symbols in crash-utility is not affected.

Especially if the reading the symbols is not affected by a wrong value
just auto-detecting the value really seems to make the most sense.

> From my point of view, extending the patch number from 8bit to 16bit is the
> solution. Any thoughts?

My thought is that in general the kernel version can not be depended
upon for anything as there exist enterprise kernels that get feature
backports.  So there very easily could be a kernel where the kernel
version does not accurately reflect what is going on.  So unless we can
say with certainty that there is no other way to detect the base address
of the kernel we really don't want to use the kernel version.

Right now it just looks like one all that is necessary is the removal of
an unnecessary if check.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
