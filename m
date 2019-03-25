Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h8JHn-0006tK-Rm
 for kexec@lists.infradead.org; Mon, 25 Mar 2019 06:40:48 +0000
Date: Mon, 25 Mar 2019 07:40:46 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/3 v9] x86/mm: Change the examination condition to avoid
 confusion
Message-ID: <20190325064046.GB12016@zn.tnic>
References: <20190321103309.27883-1-lijiang@redhat.com>
 <20190321103309.27883-2-lijiang@redhat.com>
 <20190322175114.GL12472@zn.tnic>
 <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa4af285-0aa2-3477-76a8-87f93d4db599@redhat.com>
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
To: lijiang <lijiang@redhat.com>
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Mar 25, 2019 at 11:11:45AM +0800, lijiang wrote:
> I mean it needs to find all the value of the 'IORES_DESC_ACPI_*' type.

A function called __ioremap_check_desc_other() needs to find
IORES_DESC_ACPI_* types...

No, still don't know what you're trying to do.

> As above mentioned, it needs to find all the value of the 'IORES_DESC_ACPI_*'
> type, so we should explicitly use the 'IORES_DESC_ACPI_*' type as the check
> condition instead of the 'IORES_DESC_NONE'.

And now the same question I'm asking you each time: WHY does it need to find
the ACPI types?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
