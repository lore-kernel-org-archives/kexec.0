From: Baoquan He <bhe@redhat.com>
Date: Wed, 18 May 2022 18:11:41 +0800
Subject: [PATCH] kexec_file: Drop pr_err in weak implementations of
 arch_kexec_apply_relocations[_add]
In-Reply-To: <1652864763.xpq371r1wx.naveen@linux.ibm.com>
References: <20220425174128.11455-1-naveen.n.rao@linux.vnet.ibm.com>
 <YoNqJ/MOSIVwKP/o@MiWiFi-R3L-srv>
 <1652782155.56t7mah8ib.naveen@linux.ibm.com>
 <8735h8b2f1.fsf@email.froward.int.ebiederm.org>
 <87v8u3o9tk.fsf@mpe.ellerman.id.au>
 <YoSk+jRjNQtUL50d@MiWiFi-R3L-srv>
 <1652864763.xpq371r1wx.naveen@linux.ibm.com>
Message-ID: <YoTGXQvQutAR5PZY@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/18/22 at 02:48pm, Naveen N. Rao wrote:
> Baoquan He wrote:
> > On 05/18/22 at 12:26pm, Michael Ellerman wrote:
> > > 
> > > It seems that recordmcount is not really maintained anymore now that x86
> > > uses objtool?
> > > 
> > > There've been several threads about fixing recordmcount, but none of
> > > them seem to have lead to a solution.
> > > 
> > > These weak symbol vs recordmcount problems have been worked around going
> > > back as far as 2020:
> > 
> > It gives me feeling that llvm or recordmcount should make adjustment,
> > but not innocent kernel code, if there are a lot of places reported.
> > I am curious how llvm or recordmcount dev respond to this.
> 
> As Michael stated, this is not just llvm - binutils has also adopted the
> same and "unused" section symbols are being dropped.
> 
> For recordmcount, there were a few threads and approaches that have been
> tried:
> - https://patchwork.ozlabs.org/project/linuxppc-dev/patch/cd0f6bdfdf1ee096fb2c07e7b38940921b8e9118.1637764848.git.christophe.leroy at csgroup.eu/
> - https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=297434&state=*
> 
> Objtool has picked up a more appropriate fix for this recently, and
> long-term, we would like to move to using objtool for ftrace purposes:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/objtool/elf.c?id=4abff6d48dbcea8200c7ea35ba70c242d128ebf3
> 
> While that is being pursued, we want to unbreak some of the CI and users who
> are hitting this.

I see, thanks for the details. I would persue fix in recordmcount if
possible, while has no objection to fix it in kernel with justification
if have to. Given my limited linking knowledge, leave this to other
expert to decide.


