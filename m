Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eC5tr-0007RE-Qr
 for kexec@lists.infradead.org; Tue, 07 Nov 2017 15:34:54 +0000
Date: Tue, 7 Nov 2017 16:34:28 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171107153428.ex27nwkvelhm2nm7@dwarf.suse.cz>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
 <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
 <20171106092729.GB3669@x1>
 <20171106095638.7iwlyjmlom3tqelt@dwarf.suse.cz>
 <20171107113956.GC3669@x1>
 <20171107134212.tmjdt7rdailtbosa@dwarf.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171107134212.tmjdt7rdailtbosa@dwarf.suse.cz>
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
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

On Tue, Nov 07, 2017 at 02:42:12PM +0100, Jiri Bohac wrote:
> On Tue, Nov 07, 2017 at 07:39:56PM +0800, Baoquan He wrote:
> > don't worry about the user space kexec utility either. 
> 
> What's the problem with the userspace kexec? The bug is in
> reading /proc/vmcore by makedumpfile. kexec would only operate
> within the preallocated crashkernel area, right?

right, I see it (without -s the kexec userspace creates the ELF header
later used the second kernel for /proc/vmcore).

No idea how to fix that nicely...

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
