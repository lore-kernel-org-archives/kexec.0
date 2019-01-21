Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1glVkJ-0008Vt-O0
 for kexec@lists.infradead.org; Mon, 21 Jan 2019 09:19:57 +0000
Date: Mon, 21 Jan 2019 10:19:50 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/2] x86, kexec_file_load: make it work with
 efi=noruntime or efi=old_map
Message-ID: <20190121091939.GC29166@zn.tnic>
References: <20190115095834.22617-1-kasong@redhat.com>
 <20190115095834.22617-3-kasong@redhat.com>
 <20190115231005.GF6596@zn.tnic>
 <CACPcB9dYD2zR7ssXFibkefo3EZuvVnLegovwTMA8MaaLP1UsYQ@mail.gmail.com>
 <20190116094619.GB15409@zn.tnic>
 <CACPcB9d0dKLPmZ=b++m5LYRjFUCFyLL3deDBcS4m3N-UWZ_Hyw@mail.gmail.com>
 <20190118102636.GB622@zn.tnic>
 <20190121011830.GA1554@localhost.localdomain>
 <20190121082932.GA29166@zn.tnic>
 <20190121084352.GA15754@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190121084352.GA15754@localhost.localdomain>
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
To: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: rafael.j.wysocki@intel.com, Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, erik.schmauss@intel.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robert.moore@intel.com, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, Len Brown <lenb@kernel.org>

On Mon, Jan 21, 2019 at 04:43:52PM +0800, Chao Fan wrote:
> Since I didn't see where Xen to fill the value, if
> boot_params->acpi_rsdp_addr is filled before my code, I just need to
> read it. If when I try to read it but not found, then parse RSDP and
> fill the RSDP address to boot_params->acpi_rsdp_addr.

And you can't simply do:

	if (boot_params.acpi_rsdp_addr)
		return;

at the beginning of that function?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
