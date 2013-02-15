Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U6OXX-0004tB-2G
 for kexec@lists.infradead.org; Fri, 15 Feb 2013 16:53:36 +0000
Date: Fri, 15 Feb 2013 11:53:27 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 09/13] vmcore: copy ELF note segments in buffer on 2nd
 kernel
Message-ID: <20130215165327.GH27784@redhat.com>
References: <20130214100945.22466.4172.stgit@localhost6.localdomain6>
 <20130214101232.22466.44026.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130214101232.22466.44026.stgit@localhost6.localdomain6>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, cpw@sgi.com

On Thu, Feb 14, 2013 at 07:12:32PM +0900, HATAYAMA Daisuke wrote:
> Objects exported from ELF note segments are in fact located apart from
> each other on old memory. But on /proc/vmcore they are exported as a
> single ELF note segment. To satisfy mmap()'s page-size boundary
> requirement, copy them in a page-size aligned buffer allocated by
> __get_free_pages() on 2nd kernel and remap the buffer to user-space.
> 
> The buffer for ELF note segments is added to vmcore_list as the object
> of VMCORE_2ND_KERNEL type.
> 
> Copy of ELF note segments is done in two pass: first pass tries to
> calculate real total size of ELF note segments, and then 2nd pass
> copies the segment data into the buffer of the real total size.

Ok, this is the part I am not very happy with. I don't like the idea
of copying notes into second kernel. It has potential to bloat our
memory usage requirements in second kernel.

For example, we allocate a 4K page for each cpu and a huge machine
say 4096 cpu, 16MB of more memory is required. Not that it is big
concern for a 4K cpu machine, still if we can avoid copying notes from
previous kernel, it will be good.

So the problem is that note size from previous kernel might not be
page aligned. And in /proc/vmcore view all the notes are supposed
to be contiguous. 

Thinking loud.

- Can we introduce multiple PT_NOTE program headers. One for each note
  data. I am not sure if this will break existing user space tools like
  gdb, crash etc.

- Or can we pad the notes with a new note type say "VMCORE_PAD". This is
  similar to "VMCOREINFO" just that it is used for padding to make sure
  notes can be page aligned. User space tools should simple ignore
  the VMCORE_PAD notes and move on to next note.

I think I like second idea better and given the fact that gdb did not
break with introduction of "VMCOREINFO" note type, it should not break
when we introduce another note type.

If this works, you don't have to copy notes in second kernel?

Eric, do you have any thoughts on this. What makes more sense.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
