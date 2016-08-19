Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bala6-00049Q-Rl
 for kexec@lists.infradead.org; Fri, 19 Aug 2016 15:19:41 +0000
Received: by mail-yw0-f176.google.com with SMTP id j12so14612803ywb.2
 for <kexec@lists.infradead.org>; Fri, 19 Aug 2016 08:19:18 -0700 (PDT)
Date: Fri, 19 Aug 2016 20:49:13 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH] fixup! arm64: kdump: add kdump support
Message-ID: <20160819151913.GC22221@localhost.localdomain>
References: <57B2E759.201@arm.com>
 <1471448011-20386-1-git-send-email-james.morse@arm.com>
 <20160819080020.GA584@localhost.localdomain>
 <57B70AF8.1000603@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57B70AF8.1000603@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: mark.rutland@arm.com, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 19/08/2016:02:34:48 PM, James Morse wrote:
> On 19/08/16 09:00, Pratyush Anand wrote:
> > On 17/08/2016:04:33:31 PM, James Morse wrote:
> >> copy_oldmem_page() and mmap_vmcore() provide two ways for userspace to read
> >> from /proc/vmcore. Neither of these check with memblock to see if the page
> >> they are accessing is nomap. On Seattle this causes:
> > 
> > Thanks for the patch.It did resolve the kernel crash issue with makedumpfile,
> > however neither there was any data in vmcore-dmesg nor crash utility was able to
> > work the saved vmcore.
> 
> vmcore-dmesg doesn't work for me, but crash did once I'd rebuilt it from the
> most recent source.

Yes, saved vmcore  worked with latest crash. However, we will need to correct
phys_offset and page_offset in kexec-tools to get meaningful output from vmcore-dmesg.

~Pratyush
> 
> The most recent commit I have is:
> b349598bb755 ("Fix for the ARM64 "bt -R <symbol>" option if the only reference")
> 
> Are you using an older version?
> 
> 
> Thanks,
> 
> James
> 
> 
> [0] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/447597.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
