Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VT0pf-0007hc-WC
 for kexec@lists.infradead.org; Mon, 07 Oct 2013 02:46:05 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id A49743EE1D9
 for <kexec@lists.infradead.org>; Mon,  7 Oct 2013 11:45:34 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 93DF545DEBB
 for <kexec@lists.infradead.org>; Mon,  7 Oct 2013 11:45:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7A09E45DEB6
 for <kexec@lists.infradead.org>; Mon,  7 Oct 2013 11:45:34 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6B11C1DB8041
 for <kexec@lists.infradead.org>; Mon,  7 Oct 2013 11:45:34 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 192261DB803E
 for <kexec@lists.infradead.org>; Mon,  7 Oct 2013 11:45:34 +0900 (JST)
Message-ID: <52521FA5.3040101@jp.fujitsu.com>
Date: Mon, 07 Oct 2013 11:42:45 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: mmap for /proc/vmcore broken since 3.12-rc1
References: <20131002140356.63706540@holzheu> <524D0ADF.2010507@jp.fujitsu.com>
In-Reply-To: <524D0ADF.2010507@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, "David S. Miller" <davem@davemloft.net>, Vivek Goyal <vgoyal@redhat.com>, Jan Willeke <willeke@de.ibm.com>

(2013/10/03 15:12), HATAYAMA Daisuke wrote:
> (2013/10/02 21:03), Michael Holzheu wrote:
>> Hello Alexey,
>>
>> Looks like the following commit broke mmap for /proc/vmcore:
>>
>> commit c4fe24485729fc2cbff324c111e67a1cc2f9adea
>> Author: Alexey Dobriyan <adobriyan@gmail.com>
>> Date:   Tue Aug 20 22:17:24 2013 +0300
>>
>>      sparc: fix PCI device proc file mmap(2)
>>
>> Because /proc/vmcore (fs/proc/vmcore.c) does not implement the
>> get_unmapped_area() fops function mmap now always returns EIO.
>>
>> Michael
>>
>
> I confirmed the bug on v3.12-rc3. According to makedumpfile's log,
> mmap failed on /proc/vmcore.
>
> mem_map (271)
>    mem_map    : ffffea001da40000
>    pfn_start  : 878000
>    pfn_end    : 880000
> Kernel can't mmap vmcore, using reads.
> STEP [Excluding unnecessary pages] : 1.268799 seconds
> STEP [Excluding unnecessary pages] : 1.268756 seconds
> STEP [Copying data               ] : 44.847924 seconds
> Writing erase info...
>
> I'll post a patch later.
>

I've not completed this. I thought it was short task but after I
tried to fix, makedumpfile became frequently failing with -ENOMEM and
I'm not sure why even now.

Here's current progress.

First, on v3.12-rc3 mmap() on /proc/vmcore fails while returning -EIO.
This is due to the commit c4fe24485729fc2cbff324c111e67a1cc2f9adea,
just as reported by Holzheu, where proc_reg_get_unmapped_area was
newly added to proc_reg_file_ops_no_compat file operations as
get_unmapped_area method. Looking at get_unmapped_area function,
it calls current->mm->get_unmapped_area at default, but calls
f_ops->get_unmapped_area_function if it's assigned.

         get_area = current->mm->get_unmapped_area;
         if (file && file->f_op && file->f_op->get_unmapped_area)
                 get_area = file->f_op->get_unmapped_area;
         addr = get_area(file, addr, len, pgoff, flags);
         if (IS_ERR_VALUE(addr))
                 return addr;

For regular files in procfs, proc_reg_file_ops_no_compat is used
first and then this behaves as wrapper.

static unsigned long proc_reg_get_unmapped_area(struct file *file, unsigned long orig_addr, unsigned long len, unsigned long pgoff, unsigned long flags)
{
         struct proc_dir_entry *pde = PDE(file_inode(file));
         int rv = -EIO;
         unsigned long (*get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
         if (use_pde(pde)) {
                 get_unmapped_area = pde->proc_fops->get_unmapped_area;
                 if (get_unmapped_area)
                         rv = get_unmapped_area(file, orig_addr, len, pgoff, flags);
                 unuse_pde(pde);
         }
         return rv;
}

Since this was added in proc_reg_file_ops_no_compat, proc_reg_get_unmapped_area
is used in get_unmapped_area now and it always returns -EIO since proc_vmcore_operations
has no get_unmapped_area method now.

So, immediate fix idea is to define get_unmapped_area method in proc_vmcore_operations
and to design it so that it just calls current->mm->get_unmapped_area.

---
  fs/proc/vmcore.c | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 9100d69..9583419 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -412,10 +412,23 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
  }
  #endif

+static unsigned long
+get_unmapped_area_vmcore(struct file *filp, unsigned long addr,
+                        unsigned long len, unsigned long pgoff,
+                        unsigned long flags)
+{
+#ifdef CONFIG_MMU
+       return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+#else
+       return -EIO;
+#endif
+}
+
  static const struct file_operations proc_vmcore_operations = {
         .read           = read_vmcore,
         .llseek         = default_llseek,
         .mmap           = mmap_vmcore,
+       .get_unmapped_area = get_unmapped_area_vmcore,
  };

  static struct vmcore* __init get_new_element(void)
--
1.8.3.1

However, after applying this patch, makedumpfile now somehow fails returning -ENOMEM
frequently. It's about 50/128 on my box.

Searching for where to return -ENOMEM in mmap path by printk debug, I found instance
of get_unmapped_area returns kernel-space address:

         get_area = current->mm->get_unmapped_area;
         if (file && file->f_op && file->f_op->get_unmapped_area)
                 get_area = file->f_op->get_unmapped_area;
         addr = get_area(file, addr, len, pgoff, flags);
         if (IS_ERR_VALUE(addr))
                 return addr;

         if (addr > TASK_SIZE - len)   <---- Here
                 return -ENOMEM;

The log is:

kdump:/# cd /mnt/
kdump:/mnt# for ((i=0; i<128; ++i)) ; do
> makedumpfile -f -p -d 31 /proc/vmcore vmcore-pd31
> done
The kernel version is not supported.
The created dumpfile may be incomplete.
cyclic buffer size has been changed: 65535 => 64512
[   49.462536] addr: 0xffffffff8ef28000
[   49.463686] TASK_SIZE: 0x007ffffffff000
[   49.464952] len: 0x00000000400000

Note that makedumpfile tries to mmap some area in 4MiB size here,
get_unmapped_area tries to find some area to cover such requested 4MiB size
within user-space address space limit but it returns somehow kernel-space
address.

The actual instance of current->mm->get_unmapped_area on my environment
is arch_get_unmapped_area_topdown.

Finally, note: I tried to run makedumpfile using mmap on /proc/vmcore 128-times. Then,
- v3.12-rc3 returns -EIO in every case (trivial),
- v3.12-rc3 with the above patch applied returns -ENOMEM at 50/128,
- v3.12-rc3 with commit c4fe24485729fc2cbff324c111e67a1cc2f9adea reverted
   works well in every case, and
- v3.11.1-201.fc19.x86_64 works well in every case.

So, I suspect procfs wrapper affects arch_get_unmapped_region_topdown?

Any comments are helpful.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
