Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bU6uK-0007bC-UL
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 06:41:03 +0000
Received: by mail-pf0-x234.google.com with SMTP id p64so52210207pfb.1
 for <kexec@lists.infradead.org>; Sun, 31 Jul 2016 23:40:40 -0700 (PDT)
Date: Mon, 1 Aug 2016 15:46:12 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v23 0/9] arm64: add kdump support
Message-ID: <20160801064611.GE7995@linaro.org>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
 <20160729171300.GA478@localhost.localdomain>
 <20160801043725.GC7995@linaro.org>
 <20160801062112.GA25203@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160801062112.GA25203@localhost.localdomain>
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
To: Pratyush Anand <panand@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, Ruslan Bilovol <ruslan.bilovol@gmail.com>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 01, 2016 at 11:51:12AM +0530, Pratyush Anand wrote:
> Hi Takahiro,
> 
> On 01/08/2016:01:37:26 PM, AKASHI Takahiro wrote:
> > Pratyush,
> > 
> > On Fri, Jul 29, 2016 at 10:43:00PM +0530, Pratyush Anand wrote:
> > > Hi Ruslan,
> > > 
> > > On 29/07/2016:07:26:03 PM, Ruslan Bilovol wrote:
> > > > Hi,
> > > > 
> > > > On Tue, Jul 26, 2016 at 11:09 AM, AKASHI Takahiro
> > > > <takahiro.akashi@linaro.org> wrote:
> > > > > On Tue, Jul 26, 2016 at 04:56:51PM +0900, AKASHI Takahiro wrote:
> > > > >> This patch series adds kdump support on arm64.
> > > > >>
> > > > >> To load a crash-dump kernel to the systems, a series of patches to
> > > > >> kexec-tools, which have not yet been merged upstream, are needed.
> > > > >> Please pick Geoff's kexec patches [1] and my kdump patches [2].
> > > > >>
> > > > >> To examine vmcore (/proc/vmcore) on a crash-dump kernel, you can use
> > > > >>   - crash utility (coming v7.1.6 or later) [3]
> > > > >>     (Necessary patches have already been queued in the master.)
> > > > >>
> > > > >> [1]  http://lists.infradead.org/pipermail/kexec/2016-July/016532.html
> > > > >> [2]  TBD
> > > > >
> > > > > See my kexec-tools patches in:
> > > > > http://lists.infradead.org/pipermail/kexec/2016-July/016642.html
> > > > 
> > > > I tired this patch series with mentioned Geoff's kexec patches and
> > > > your kdump patches, but unfortunately it doesn't work for me.
> > > > 
> > > > While I can successfully load and kexec the kernel ('kexec --load' +
> > > > 'kexec -e'), same combination of kernel+ramdisk+dtb doesn't boot
> > > > if I do kdump combination ('kexec -p' + sysrq crash), there is no
> > > > any output after sysrq crash trace.
> > > > Unfortunately I don't have any debugger here for deep investigation
> > > > of this issue.
> > > 
> > > Which type of image do you have? I did face issue with binary image which I
> > > fixed in my branch, while elf would work fine for kdump as well.
> > 
> > Can you describe in more details, please?
> > I don't see any problems with either vmlinux or image
> > in my environment.
> 
> See kexec/crashdump-elf.c:FUNC()
> We have:
> 223                 phdr->p_vaddr = phys_to_virt(elf_info, mstart);
> Now, if we do not have page_offset then we will not have correct p_vaddr, and
> then vmcore-dmesg/vmcore-dmesg.c:vaddr_to_offset() fails with

I don't see how this issue relates to Ruslan's case.

-Takahiro AKASHI

> No program header covering vaddr 0xfffffc0008c312f0found kexec bug?
> 
> Fedora/RHEL kexec-tools saves vmcore only when dmesg save is OK.
> 
> I have updated [1] with the modification where --page-offset addition has been
> moved to kdump binary image support patch.
> 
> [1] https://github.com/pratyushanand/kexec-tools.git : upstream_arm64_devel
> 
> ~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
