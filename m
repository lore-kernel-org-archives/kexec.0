Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
Date: Tue, 12 Feb 2019 23:03:13 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
In-Reply-To: <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
Content-Language: en-US
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
To: Bhupesh Sharma <bhsharma@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
> mentioned that the changes look necessary.
> 
> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html

> > > The increased 'PTRS_PER_PGD' value for such cases needs to be then
> > > calculated as is done by the underlying kernel (see
> > > 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
> > >
> > > #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))

Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
It is used for pgd_index() also in makedumpfile to walk page tables.

/* to find an entry in a page-table-directory */
#define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))

Thanks,
Kazu

> > >
> > > Also, note that 'arch/arm64/include/asm/memory.h' defines 'MAX_USER_VA_BITS'
> > > as 'VA_BITS' in case 'CONFIG_ARM64_USER_VA_BITS_52' is set to 'n':
> > >
> > > #ifdef CONFIG_ARM64_USER_VA_BITS_52
> > > #define MAX_USER_VA_BITS      52
> > > #else
> > > #define MAX_USER_VA_BITS      VA_BITS
> > > #endif
> > >
> > > So, makedumpfile will need this symbol exported in vmcore to make the above
> > > determination.
> > >
> > > [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022425.html
> > >
> > > Thanks,
> > > Bhupesh
> >
> > Thanks
> > Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
