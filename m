Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qk1-f171.google.com ([209.85.222.171])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lpWX3-00Gd0p-1E
 for kexec@lists.infradead.org; Sat, 05 Jun 2021 13:40:12 +0000
Received: by mail-qk1-f171.google.com with SMTP id q10so12203850qkc.5
 for <kexec@lists.infradead.org>; Sat, 05 Jun 2021 06:40:08 -0700 (PDT)
Subject: Re: [RFC v2 00/43] PKRAM: Preserved-over-Kexec RAM
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Message-ID: <6e74451b-6a29-d0fc-cf26-b3700a099a09@soleen.com>
Date: Sat, 5 Jun 2021 09:39:04 -0400
MIME-Version: 1.0
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Language: en-US
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
To: Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org



On 3/30/21 5:35 PM, Anthony Yznaga wrote:
> This patchset implements preserved-over-kexec memory storage or PKRAM as a
> method for saving memory pages of the currently executing kernel so that
> they may be restored after kexec into a new kernel. The patches are adapted
> from an RFC patchset sent out in 2013 by Vladimir Davydov [1]. They
> introduce the PKRAM kernel API and implement its use within tmpfs, allowing
> tmpfs files to be preserved across kexec.
> 
> One use case for PKRAM is preserving guest memory and/or auxillary supporting
> data (e.g. iommu data) across kexec in support of VMM Fast Restart[2].
> VMM Fast Restart is currently using PKRAM to support preserving "Keep Alive
> State" across reboot[3].  PKRAM provides a flexible way for doing this
> without requiring that the amount of memory used by a fixed size created
> a priori.  Another use case is for databases to preserve their block caches
> in shared memory across reboot.

Hi Anthony,

I have several concerns about preserving arbitrary not prereserved segments across reboot.

1. PKRAM does not work across firmware reboots
With emulated persistent memory it is possible to do reboot through firmware and not loose the preserved-memory. The firmware can be modified to mark the required ranges pages as PRAM, and Linux will treat them as such. The benefit of this is that it works for both cases kexec and reboot through firmware. The disadvantage is that you have to know in advance how much memory needs to be preserved. However, with the ability to hot-plug/hot-remove the PMEM, the second point becomes moot as it is possible to mark a large chunk of memory as PMEM if needed. I have designed something like this for one of our projects, and it is already been used in the fleet. Reboot through firmware, allows us to service firmware in addition to kernel.

2. Boot failures due to memory fragmentation
We also considered using PRAM instead of PMEM. PRAM was one of the previous attempts to do the persistent memory thing via tmpfs flag: mount -t tmpfs -o pram=mytmpfs none /mnt/crdump"; that project was never upstreamed. However, we gave up with that idea because in addition to loosing possibility to reboot through the firmware, it also adds memory fragmentation. For example, if the new kernel require larger contiguous memory chunks to be allocated during boot than the previous kernel (i.e. the next kernel has new drivers, or some debug feature enabled), the boot might simply fail because of the extra memory ranges being reserved.

3. New intra-kernel dependencies
Kexec reboot is when one Linux kernel works as a bootloader for the next one. Currently, there is very little information that is passed from the old kernel to the next kernel. Adding more information that two independent kernels must know about each other is not a very good thing from architectural point of view. It limits the flexibility of kexec.

However, we do need PKRAM and ability to preserve kernel memory across reboot for fast hypervisor updates or such. User pages can already be preserved across reboot on emulated or real persistent memory. The easiest way is via DAXFS placed on that memory.
Kernel cannot preserve its memory on  PMEM across the reboot. However, functionality can be extended so kernel memory can be preserved on both emulated persistent memory or on real persistent memory. PKRAM could provide an interface to save kernel data to a file, and that file could be placed on any filesystem including DAXFS. When placed on DAXFS, that file can be used as iommu data, as it is actually located in physical memory and not moving anywhere. It is preserved across firmware/kexec reboot with having the devices survive the reboot state intact. During boot, have the device drivers that use PKRAM preserve functionality map saved files from DAXFS in order to have IOMMU functionality working again.

Thank you,
Pasha

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
