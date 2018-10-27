Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gGL4B-0005Zl-Dc
 for kexec@lists.infradead.org; Sat, 27 Oct 2018 09:39:36 +0000
Date: Sat, 27 Oct 2018 17:39:17 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Message-ID: <20181027093917.GA14493@MiWiFi-R3L-srv>
References: <20181026093630.8520-1-lijiang@redhat.com>
 <053CC83A-9A95-4C12-9627-AABD1427DA9C@alien8.de>
 <1263471c-a27d-a698-15f0-b5947f13ea93@redhat.com>
 <20181026182440.20a4b107@ezekiel.suse.cz>
 <20181026222517.GB26927@nazgul.tnic>
 <20181027081343.GA1884@MiWiFi-R3L-srv>
 <20181027091007.GB1046@nazgul.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181027091007.GB1046@nazgul.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: lijiang <lijiang@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com

On 10/27/18 at 11:10am, Borislav Petkov wrote:
> On Sat, Oct 27, 2018 at 04:13:43PM +0800, Baoquan He wrote:
> > Yes, agree. So sme_me_mask itself or the encryption bit number, both is
> > fine.
> 
> You need the encryption bit position and it better be properly formatted
> and extracted into a vmcoreinfo-specific variable because we don't
> expose arch-specific details like sme_me_mask to the outside.

Not very sure about this, we have arch_crash_save_vmcoreinfo() in
arch/x86/kernel/machine_kexec_64.c to export arch-specific stuffs
outside. Is there any special reason about a mask in one architecture
when expose it out? In fact it's only that bit position set mask, no
other information. Surely it's also fine if we export encryption bit
position, then convert it to mask in makedumpfile.

> 
> >  we may use cp to copy /proc/vmcore to a file directly, then analyze
> > it in another compupter. This often happen when there's something
> > wrong with makedumpfile, we need debug makedumpfile with the complete
> > copied file.
> 
> So for the analyze-on-another-computer scenario you absolutely must copy
> anything from the first kernel decrypted because you can't decrypt it on
> the other machine.
> 
> Which means, in a sensitive environment, you probably should copy and
> *encrypt* the dump again with gpg or so.

Hmm, no matter it's makedumpfile or cp directly, when we read
/proc/vmcore in kdump kernel, it will call __read_vmcore() or related
functions in fs/proc/vmcore.c. With regarding to SME memory reading,
Lianbo should have handle it in previous SME support in kdump patches.
Just those page tables in crashed kernel are also memory content, they
are decrypted and copied out, while with SME bit position enabled to
indicate encryption, that bit position is added by kernel, now the 1st
kernel is dead, we need wipe it out in makedumpfile when parsing. So
this 'cp', it's still need be done in kdump kernel by 'cp' /proc/vmcore.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
