Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it0-f52.google.com ([209.85.214.52])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cdSCf-0005Dv-67
 for kexec@lists.infradead.org; Tue, 14 Feb 2017 01:46:51 +0000
Received: by mail-it0-f52.google.com with SMTP id 203so13387293ith.0
 for <kexec@lists.infradead.org>; Mon, 13 Feb 2017 17:46:28 -0800 (PST)
Subject: Re: [PATCH] /proc/kcore: Update physical address for kcore ram and
 text
References: <f951340d2917cdd2a329fae9837a83f2059dc3b2.1485318868.git.panand@redhat.com>
 <CAHB_GupwpXiZjmy+4SQLvoJaJkAo9VvNVxQgxqvXeACRR--exg@mail.gmail.com>
 <CAGXu5jL89e33t0g+iVm8o7sstn3B9QCiFP_AhxZj8QiyaTjNZw@mail.gmail.com>
From: Pratyush Anand <panand@redhat.com>
Message-ID: <5b28ea05-24ab-b8db-e3d1-216399734297@redhat.com>
Date: Tue, 14 Feb 2017 07:16:22 +0530
MIME-Version: 1.0
In-Reply-To: <CAGXu5jL89e33t0g+iVm8o7sstn3B9QCiFP_AhxZj8QiyaTjNZw@mail.gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: Baoquan He <bhe@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Dave Anderson <anderson@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>



On Tuesday 14 February 2017 03:55 AM, Kees Cook wrote:
> On Mon, Jan 30, 2017 at 11:00 AM, Pratyush Anand <panand@redhat.com> wrote:
>> CCing Andrew and Kees for their review comments.
>>
>>
>> On Wednesday 25 January 2017 10:14 AM, Pratyush Anand wrote:
>>> Currently all the p_paddr of PT_LOAD headers are assigned to 0, which is
>>> not true and could be misleading, since 0 is a valid physical address.
>>>
>>> User space tools like makedumpfile needs to know physical address for
>>> PT_LOAD segments of direct mapped regions. Therefore this patch updates
>>> paddr for such regions. It also sets an invalid paddr (-1) for other
>>> regions, so that user space tool can know whether a physical address
>>> provided in PT_LOAD is correct or not.
>>>
>>> Signed-off-by: Pratyush Anand <panand@redhat.com>
>>> ---
>>> fs/proc/kcore.c | 5 ++++-
>>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
>>> index 0b80ad87b4d6..ea9f3d1ae830 100644
>>> --- a/fs/proc/kcore.c
>>> +++ b/fs/proc/kcore.c
>>> @@ -373,7 +373,10 @@ static void elf_kcore_store_hdr(char *bufp, int
>>> nphdr, int dataoff)
>>> phdr->p_flags = PF_R|PF_W|PF_X;
>>> phdr->p_offset = kc_vaddr_to_offset(m->addr) + dataoff;
>>> phdr->p_vaddr = (size_t)m->addr;
>>> - phdr->p_paddr = 0;
>>> + if (m->type == KCORE_RAM || m->type == KCORE_TEXT)
>>> + phdr->p_paddr = __pa(m->addr);
>>> + else
>>> + phdr->p_paddr = (elf_addr_t)-1;
>>> phdr->p_filesz = phdr->p_memsz = m->size;
>>> phdr->p_align = PAGE_SIZE;
>>> }
>>>
>
> Well, CONFIG_PROC_KCORE is a generalized root KASLR exposure (though
> there are lots of such exposures). Why is the actual physical address
> needed? Can this just report the virtual address instead? Then the
> tool can build a map, but it looks like an identity map, rather than
> creating a new physical/virtual memory ASLR offset exposure?

Well, having an ASLR offset information can help to translate an 
identity mapped virtual address to a physical address. But that would be 
an additional field in PT_LOAD header structure and an arch dependent value.

Moreover, sending a valid physical address like 0 does not seem right. 
So, IMHO it is better to fix that and send valid physical address when 
available (identity mapped).

Thanks for the review.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
