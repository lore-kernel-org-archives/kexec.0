Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-wy0-f177.google.com ([74.125.82.177])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1PtMsR-0006TM-Pm
	for kexec@lists.infradead.org; Sat, 26 Feb 2011 16:20:16 +0000
Received: by wyf23 with SMTP id 23so2629397wyf.36
	for <kexec@lists.infradead.org>; Sat, 26 Feb 2011 08:20:13 -0800 (PST)
Date: Sat, 26 Feb 2011 18:20:08 +0200
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Subject: Saveoops: Making Kexec purgatory position-independent?
Message-ID: <20110226162008.GA23879@laptop>
MIME-Version: 1.0
Content-Disposition: inline
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Simon Horman <horms@verge.net.au>, Vivek Goyal <vgoyal@redhat.com>, Haren Myneni <hbabu@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, X86-ML <x86@kernel.org>, KEXEC-ML <kexec@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>

Hi,

I'm continuing work on 'Saveoops', saving both early and normal Linux
oops log to disk upon panic [*], using Kexec and bootloaders this time.

Purgatory, the transitional mini-kernel used by kexec, is a relocatable
ELF file. Userspace kexec-tools finds the final load address of such
code (by parsing /proc/iomem, etc) and then applies the relocations
itself before passing the now-ready executable image to kernel.

Since capturing early oopses is the major goal, doing such relocation
in userspace won't fit my purposes. Two options remain:
   - relocate purgatory entries in the kernel early boot path
   - or compile purgatory as position-independent, thus simplifying
     the kernel load logic

The former will add extra logic in a sensitive path (early boot), while
the latter will require changes inside the purgatory code itself,
especially i386 assembly files.

Any preferable option from our kexec and x86 maintainers?

thanks!

[*] http://news.gmane.org/find-root.php?message_id=<20110125134748.GA10051@laptop>
    http://news.gmane.org/find-root.php?message_id=<20110126124954.GC24527@laptop>

-- 
Darwish
http://darwish.07.googlepages.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
