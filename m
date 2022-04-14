From: Baoquan He <bhe@redhat.com>
Date: Thu, 14 Apr 2022 18:32:28 +0800
Subject: [PATCH v2] mm/vmalloc: fix spinning drain_vmap_work after
 reading from /proc/vmcore
In-Reply-To: <Ylb5PLNDFIif6vZ2@relinquished.localdomain>
References: <52f819991051f9b865e9ce25605509bfdbacadcd.1649277321.git.osandov@fb.com>
 <Yk72+9UFwsaFXoZe@chrisdown.name> <Yk+l1/xLzhB02aIU@MiWiFi-R3L-srv>
 <Ylb5PLNDFIif6vZ2@relinquished.localdomain>
Message-ID: <Ylf4POlvtmYwkGrI@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 04/13/22 at 09:24am, Omar Sandoval wrote:
> On Fri, Apr 08, 2022 at 11:02:47AM +0800, Baoquan He wrote:
......
> > Since redhat mail server has issue, the body content of patch is empty
> > from my mail client. So reply here to add comment.
> > 
> > As replied in v1 to Omar, I think this is a great fix. That would be
> > also great to state if this is a real issue which is breaking thing,
> > then add 'Fixes' tag and Cc stable like "Cc: <stable@vger.kernel.org> # 5.17",
> > or a fantastic improvement from code inspecting.
> > 
> > Concern this because in distros, e.g in our rhel8, we maintain old kernel
> > and back port necessary patches into the kernel, those patches with
> > 'Fixes' tag definitely are good candidate. This is important too to LTS
> > kernel.
> > 
> > Thanks
> > Baoquan
> 
> Hi, Baoquan,
> 
> Sorry I missed your replies. I'll answer your questions from your first
> email.
> 
> > I am wondering if this is a real issue you met, or you just found it
> > by code inspecting
> 
> I hit this issue with the test suite for drgn
> (https://github.com/osandov/drgn). We run the test cases in a virtual
> machine on various kernel versions
> (https://github.com/osandov/drgn/tree/main/vmtest). Part of the test
> suite crashes the kernel to run some tests against /proc/vmcore
> (https://github.com/osandov/drgn/blob/13144eda119790cdbc11f360c15a04efdf81ae9a/setup.py#L213,
> https://github.com/osandov/drgn/blob/main/vmtest/enter_kdump.py,
> https://github.com/osandov/drgn/tree/main/tests/linux_kernel/vmcore).
> When I tried v5.18-rc1 configured with !SMP and !PREEMPT, that part of
> the test suite got stuck, which is how I found this issue.
> 
> > I am wondering how your vmcore dumping is handled. Asking this because
> > we usually use makedumpfile utility
> 
> In production at Facebook, we don't run drgn directly against
> /proc/vmcore. We use makedumpfile and inspect the captured file with
> drgn once we reboot.
> 
> > While using makedumpfile, we use mmap which is 4M at one time by
> > default, then process the content. So the copy_oldmem_page() may only
> > be called during elfcorehdr and notes reading.
> 
> We also use vmcore-dmesg
> (https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/vmcore-dmesg)
> on /proc/vmcore before calling makedumpfile. From what I can tell, that
> uses read()/pread()
> (https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c),
> so it would also hit this issue.

Thanks for these details and great patch. It's clear to me now about the
situation and motivation.

We also use vmcore-dmesg to collect dmesg log before running
makedumpfile. That could be a small probability event, but worth adding
Fixes just in case.

> 
> I'll send a v3 adding Fixes: 690467c81b1a ("mm/vmalloc: Move draining
> areas out of caller context"). I don't think a stable tag is necessary
> since this was introduced in v5.18-rc1 and hasn't been backported as far
> as I can tell.
> 
> Thanks,
> Omar
> 


