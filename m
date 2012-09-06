Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T9ZtL-0003QG-7B
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 11:05:00 +0000
From: "Matthew Leach" <matthew.leach@arm.com>
References: <1346845443-32242-1-git-send-email-matthew.leach@arm.com>
 <20120905123850.GA11453@verge.net.au>
 <000001cd8b73$82e6b4f0$88b41ed0$@leach@arm.com>
 <20120906032901.GG6432@verge.net.au>
In-Reply-To: <20120906032901.GG6432@verge.net.au>
Subject: RE: [RFC PATCH 0/4]  Add device-tree support to kexec-tools for ARM
Date: Thu, 6 Sep 2012 12:04:50 +0100
Message-ID: <000101cd8c1f$6f758520$4e608f60$@leach@arm.com>
MIME-Version: 1.0
Content-Language: en-gb
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
To: 'Simon Horman' <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Will Deacon <Will.Deacon@arm.com>

Hi Simon,

I have been having some issues using kexec with your dtb patches...

> Thanks. It was that part of the code that I spent the bulk of my time
> on.
> And although it is still has a few rough edges I would be happy for it
> to be used.

I have looked at the output from your generic fs2dt and compared
it to the original dts and all looks okay so I'm happy that this
part of your code works fine.

> I would prefer to avoid requiring kernel changes unless necessary -
> the kernels some of the boards I work with require DT since 3.5.
> However, I am happy to discuss this further, there certainly is
> merit to a clean implementation.

I believe that you are loading the dtb at an offset from the base
of 0x1000, this is where the problem lies in that the dtb can be
corrupted by the page tables of the decompressor.

Also, device trees can contain firmware and as such be on the
order of megabytes in size. This could potentially corrupt the
decompressor image depending upon the order that these two blobs
are written to memory.


I suggest that we put the DTB out of the way, perhaps just after
the initrd segment, or at the initrd_offset in the case that
there is no initrd. This would require a kernel change to set the
correct parameter to the relocate_new_kerenel function, but the
change is minimal.

If you are happy with this, I have a set of patches that does the
job.

Matt



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
