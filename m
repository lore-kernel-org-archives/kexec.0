Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U7U72-0005W7-BX
 for kexec@lists.infradead.org; Mon, 18 Feb 2013 17:02:45 +0000
Date: Tue, 19 Feb 2013 02:02:34 +0900 (JST)
Message-Id: <20130219.020234.255275278.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 09/13] vmcore: copy ELF note segments in buffer on 2nd
 kernel
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20130215165327.GH27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101232.22466.44026.stgit@localhost6.localdomain6>
 <20130215165327.GH27784@redhat.com>
Mime-Version: 1.0
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
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 09/13] vmcore: copy ELF note segments in buffer on 2nd kernel
Date: Fri, 15 Feb 2013 11:53:27 -0500

> On Thu, Feb 14, 2013 at 07:12:32PM +0900, HATAYAMA Daisuke wrote:
>> Objects exported from ELF note segments are in fact located apart from
>> each other on old memory. But on /proc/vmcore they are exported as a
>> single ELF note segment. To satisfy mmap()'s page-size boundary
>> requirement, copy them in a page-size aligned buffer allocated by
>> __get_free_pages() on 2nd kernel and remap the buffer to user-space.
>> 
>> The buffer for ELF note segments is added to vmcore_list as the object
>> of VMCORE_2ND_KERNEL type.
>> 
>> Copy of ELF note segments is done in two pass: first pass tries to
>> calculate real total size of ELF note segments, and then 2nd pass
>> copies the segment data into the buffer of the real total size.
> 
> Ok, this is the part I am not very happy with. I don't like the idea
> of copying notes into second kernel. It has potential to bloat our
> memory usage requirements in second kernel.
> 
> For example, we allocate a 4K page for each cpu and a huge machine
> say 4096 cpu, 16MB of more memory is required. Not that it is big
> concern for a 4K cpu machine, still if we can avoid copying notes from
> previous kernel, it will be good.

I also estimated the worst case, but it was more optimistically done
than yours. In my case, estimation was at most less than 2MB on
x86_64: roundup(5112 cpus x sizeof (struct user_struct_regs),
PAGE_SIZE) is about 1MB. But I didn't consider other architectures and
now noticed s390 collects notes more agressively.

> 
> So the problem is that note size from previous kernel might not be
> page aligned. And in /proc/vmcore view all the notes are supposed
> to be contiguous. 
> 
> Thinking loud.
> 
> - Can we introduce multiple PT_NOTE program headers. One for each note
>   data. I am not sure if this will break existing user space tools like
>   gdb, crash etc.
> 
> - Or can we pad the notes with a new note type say "VMCORE_PAD". This is
>   similar to "VMCOREINFO" just that it is used for padding to make sure
>   notes can be page aligned. User space tools should simple ignore
>   the VMCORE_PAD notes and move on to next note.
> 
> I think I like second idea better and given the fact that gdb did not
> break with introduction of "VMCOREINFO" note type, it should not break
> when we introduce another note type.
> 
> If this works, you don't have to copy notes in second kernel?

I also think the second one is better. Yes, I have in fact already had
a similar idea. It's of course possible.

I have never seen tools assuming multiple PT_NOTE entries if I have
good memory. And, tools like gdb interpret note information not only
by their contents but also their order. For example, n-th NT_PRSTATUS
is considered as n-th thread or n-th CPU's data. It seems to me that
adding case of multiple PT_NOTE entires possibly make things
unnecessarily complicated.

BTW, on kexec/kdump design, we never assume that the first and the
second kernels are always the same. This means that we cannot assume
that the first kernel always puts their notes in page-size boundary in
the above way. So we need to check whether each note entry is in
page-size boundary one by one, and if one entry is not in page-size
boundary, then we need to copy it in the 2nd kernel (and appends the
pad note to it.) Copying is still necessary in the worst case.

Anyway, what I'll do in the next version, are in summary:

- append pad notes in each notes on the 1st kernel in every
  architectures, and
- check if each note is in page-size boundary, and if not so, copy it
  in the 2nd kernel and then append pad notes to it.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
