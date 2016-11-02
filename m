Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c1kSA-0000V1-Fv
 for kexec@lists.infradead.org; Wed, 02 Nov 2016 01:34:59 +0000
Date: Wed, 2 Nov 2016 09:34:33 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kexec: Export memory sections virtual addresses to
 vmcoreinfo
Message-ID: <20161102013433.GA3928@x1>
References: <1475743561-23912-1-git-send-email-bhe@redhat.com>
 <20161101051019.GB4625@dhcp-128-65.nay.redhat.com>
 <20161101053353.GC20838@x1>
 <115590076.11735656.1478009614692.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <115590076.11735656.1478009614692.JavaMail.zimbra@redhat.com>
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
To: Dave Anderson <anderson@redhat.com>
Cc: panand@redhat.com, keescook@chromium.org, ats-kumagai@wm.jp.nec.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, takahiro akashi <takahiro.akashi@linaro.org>, mingo@redhat.com, ebiederm@xmission.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, thgarnie@google.com, tonli@redhat.com

Hi Dave,

On 11/01/16 at 10:13am, Dave Anderson wrote:
> 
> 
> > > But we have this in mainline which also introduced the VMCOREINFO
> > > numbers, can you send a patch to revert them?
> > 
> > OK, will do.
> > 
> > However for find_vmemmap_x86_64() in makedumpfile, vmemmap_start is
> > still needed. I checked code, seems no better way to avoid. I am not
> > sure how many people are really using "-e" option to exclude unused
> > vmemmap pages.
> > 
> > Maybe just leave it as is, and fix it when people complain?
> 
> Speaking of complaints, is there any chance you can make the
> x86_64 "phys_base" value available?  The VMCOREINFO_SYMBOL(phys_base)
> is useless since its contents are needed in order to access the
> symbol address.

Yeah, the current exporting of virt addr of phys_base is really useless
for x86_64. While I saw you have got phys_base from kdump-ed vmcore elf
program header since kexec-tools has created that pt_load for kernel text
region.

machdep->machspec->phys_base = phdr->p_paddr - (phdr->p_vaddr & ~(__START_KERNEL_map));

Do you still want the value of phys_base? If yes, I can change it to
export the real value of phys_base, not &phys_base.

In fact, exporting &phys_base was done in 2008, makedumpfile has taken
the similar way you use in crash to get value of phys_base. Means it has
been ignored very earlier. You could be the first person to complain
about it.

Thanks
Baoquan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
