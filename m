Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cHMLf-0005WB-K0
 for kexec@lists.infradead.org; Thu, 15 Dec 2016 03:04:48 +0000
Received: by mail-io0-x241.google.com with SMTP id b194so7019120ioa.3
 for <kexec@lists.infradead.org>; Wed, 14 Dec 2016 19:04:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5851DC40.8000102@redhat.com>
References: <1481695887-21090-1-git-send-email-piliu@redhat.com>
 <1481695887-21090-2-git-send-email-piliu@redhat.com>
 <5851DC40.8000102@redhat.com>
From: Liu ping fan <kernelfans@gmail.com>
Date: Thu, 15 Dec 2016 11:04:25 +0800
Message-ID: <CAFgQCTurkNe2KcYWFFMZUfHZK2KvwoCc5SWawP4uGAGuF-tymA@mail.gmail.com>
Subject: Re: [PATCH 2/2] [fs] proc/vmcore: check the dummy place holder for
 offline cpu to avoid warning
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
To: xlpang@redhat.com
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>, Pingfan Liu <piliu@redhat.com>

On Thu, Dec 15, 2016 at 7:56 AM, Xunlei Pang <xpang@redhat.com> wrote:
> On 12/14/2016 at 02:11 PM, Pingfan Liu wrote:
>> kexec-tools always allocates program headers for possible cpus. But
>> when crashing, offline cpus have dummy headers. We do not copy these
>> dummy notes into ELF file, also have no need of warning on them.
>>
>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>> ---
>>  fs/proc/vmcore.c | 21 +++++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
>> index 8ab782d..bbc9dad 100644
>> --- a/fs/proc/vmcore.c
>> +++ b/fs/proc/vmcore.c
>> @@ -526,9 +526,10 @@ static u64 __init get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
>>   */
>>  static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
>>  {
>> -     int i, rc=0;
>> +     int i, j, rc = 0;
>>       Elf64_Phdr *phdr_ptr;
>>       Elf64_Nhdr *nhdr_ptr;
>> +     bool warn;
>>
>>       phdr_ptr = (Elf64_Phdr *)(ehdr_ptr + 1);
>>       for (i = 0; i < ehdr_ptr->e_phnum; i++, phdr_ptr++) {
>> @@ -536,6 +537,7 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
>>               u64 offset, max_sz, sz, real_sz = 0;
>>               if (phdr_ptr->p_type != PT_NOTE)
>>                       continue;
>> +             warn = true;
>>               max_sz = phdr_ptr->p_memsz;
>>               offset = phdr_ptr->p_offset;
>>               notes_section = kmalloc(max_sz, GFP_KERNEL);
>> @@ -547,7 +549,7 @@ static int __init update_note_header_size_elf64(const Elf64_Ehdr *ehdr_ptr)
>>                       return rc;
>>               }
>>               nhdr_ptr = notes_section;
>> -             while (nhdr_ptr->n_namesz != 0) {
>> +             for (j = 0; nhdr_ptr->n_namesz != 0; j++) {
>
> Hi Pingfan,
>
> I think we don't need to be this complex, how about simply check before while loop,
> if it is the cpu dummy note(initialize it with some magic), then handle it differently,
> e.g. set a "nowarn" flag to use afterwards and make sure it has zero p_memsz?
>
I had thought that how the percpu note section was filled. But you are
right,  we can suppose that for all archs, cpus just overwrite the
note, not append the note.

> Also do the similar thing for update_note_header_size_elf32()?
>
Yes, will fix it.

Thx,

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
