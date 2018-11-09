Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gL0eh-0003DW-Sk
 for kexec@lists.infradead.org; Fri, 09 Nov 2018 06:52:37 +0000
Date: Fri, 9 Nov 2018 14:51:46 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 2/2 v5] x86/kexec_file: add reserved e820 ranges to kdump
 kernel e820 table
Message-ID: <20181109065146.GD31064@MiWiFi-R3L-srv>
References: <20181107050019.6663-1-lijiang@redhat.com>
 <20181107050019.6663-3-lijiang@redhat.com>
 <20181107052345.GQ27491@MiWiFi-R3L-srv>
 <cc579d02-19e9-8749-ea48-3ff0fbf6461d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cc579d02-19e9-8749-ea48-3ff0fbf6461d@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On 11/07/18 at 05:10pm, lijiang wrote:
> In fact, these patches are really simple. As the subject mentioned, this patch
> [PATCH 2/2] adds the reserved e820 ranges to kdump kernel e820 table, and the
> first patch [PATCH 1/2] helps to exactly add the e820(E820_TYPE_RESERVED) type
> to kdump kernel e820 table, that is to say, it will filter out some unnecessary
> type(E820_TYPE_RAM/E820_TYPE_UNUSABLE/E820_TYPE_RESERVED_KERN).
> 
> At present, when we use the kexec to load the kernel image and initramfs(for
> example: kexec -s -p xxxx), the latest kernel does not pass the e820 reserved
> ranges to the second kernel, which might produce two problems:
> 
> The first one is the MMCONFIG issue, although which does not make the system
> crash or hang, this issue is still a potential risk, because my test can't
> cover all cases due to resource constraints(Machine), and i'm not sure what
> it will happen on other machine.
> 
> The second issue is that the e820 reserved ranges do not setup in kdump kernel,
> which will cause some functions which are related to the e820 reserved ranges
> to become invalid. For example:
> 
> early_memremap()->
> early_memremap_pgprot_adjust()->
> memremap_should_map_decrypted()->
> e820__get_entry_type()
> 
> Please focus on these functions, early_memremap_pgprot_adjust() and memremap_should_map_decrypted().
> 
> In the first kernel, these ranges sit in e820 reserved ranges, so the memremap_should_map_decrypted()
> will return true, that is to say, the reserved memory is decrypted, then the early_memremap_pgprot_adjust()
> will call the pgprot_decrypted() to clear the memory encryption mask.
> 
> In the second kernel, because the e820 reserved ranges are not passed to the second kernel, these ranges
> don't sit in the e820 reserved ranges, so the the memremap_should_map_decrypted() will return false, that
> is to say, the reserved memory is encrypted, and then the early_memremap_pgprot_adjust() will also call the
> pgprot_encrypted() to set the memory encryption mask.
> 
> Obviously, in the second kernel, the e820 reserved memory is still decrypted, it has gone wrong. So, if
> don't fix, kdump won't work when we use the command(kexec -s -p xxx) to load the kernel image and initramfs.

Yes, this looks better. In fact, I searched cover-letter and both patch
lg, didn't find anything to tell what will happen without these
patchset. We should at least tell the patch is for cleanup/improvement/fix/feature.
This "if don't fix, kdump won't work ..." is the sentence I first saw
telling the sequence or the problem.

Please do not misunderstand those questions from me with unfriendly tone,
words are cold and can't express emotions exactly, and appearance. Those
questions are just meaning that people may get confusion from those
places.

What: describe the problem you met.
Why:  tell the root cause
How:  how you fix it

This is what I usually use to write patch log. Just for your reference.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
