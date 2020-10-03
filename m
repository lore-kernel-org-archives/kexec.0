Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [157.25.102.26] (helo=orcam.me.uk)
 by casper.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kOp1T-0002BJ-CB
 for kexec@lists.infradead.org; Sat, 03 Oct 2020 21:24:57 +0000
Date: Sat, 3 Oct 2020 22:07:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 1/3] MIPS: Crash kernel should be able to see old memories
In-Reply-To: <20200923030847.GM25604@MiWiFi-R3L-srv>
Message-ID: <alpine.LFD.2.21.2010032200470.333514@eddie.linux-mips.org>
References: <1600828257-31316-1-git-send-email-chenhc@lemote.com>
 <20200923024548.GL25604@MiWiFi-R3L-srv>
 <CAAhV-H66O77hK7kB8cCcM6XUOc-TFEg_TJG+GrCSEdD89Qxb7g@mail.gmail.com>
 <20200923030847.GM25604@MiWiFi-R3L-srv>
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, kexec@lists.infradead.org, "open list:MIPS" <linux-mips@vger.kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Eric Biederman <ebiederm@xmission.com>, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhc@lemote.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 23 Sep 2020, Baoquan He wrote:

> > > And we don't have mem=X@Y, only mem=nn[KMG].
> > The relocatable kernel of MIPS is still unusable now, so MIPS should
> > use mem=X@Y, and the crash kernel is always different from normal
> > kernel.
> 
> Interesting. Seems MIPS does support mem=X@Y, even though the document
> of 'mem=' says it's used to specify amount of memory, but not memory
> region. Anyway, leave this to mips reviewers, thanks for replying.
> 
> ~~~~~~~~~~~~~~~~~~~
>         mem=nn[KMG]     [KNL,BOOT] Force usage of a specific amount of memory
>                         Amount of memory to be used in cases as follows:

 Yep, I implemented it for the DECstation back in 2000:

commit 97b7ae4257ef7ba8ed9b7944a4f56a49af3e8abb
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Mon Dec 11 16:41:05 2000 +0000

    Memmap fixes from Maciej.

(from the LMO repo) in line with the x86 syntax.  I don't know why it 
hasn't ever been documented in "Kernel Parameters" (for any port), but I'm 
fairly sure it has been somewhere.

 FWIW,

  Maciej

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
