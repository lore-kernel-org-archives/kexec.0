Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnfWs-00Btso-Gu
 for kexec@lists.infradead.org; Mon, 31 May 2021 10:52:19 +0000
Date: Mon, 31 May 2021 12:52:06 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/efi: unconditionally hold the whole low-1MB
 memory regions
Message-ID: <YLS/1sqz6Bncg5VU@zn.tnic>
References: <20210531090023.16471-1-lijiang@redhat.com>
 <YLSnkKeoQnokXVsK@zn.tnic> <YLSzUBQ/7CyINu87@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLSzUBQ/7CyINu87@kernel.org>
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
To: Mike Rapoport <rppt@kernel.org>
Cc: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, kexec@lists.infradead.org, ardb@kernel.org, dvhart@infradead.org, andy@infradead.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, luto@amacapital.net, bhe@redhat.com, dyoung@redhat.com

On Mon, May 31, 2021 at 12:58:40PM +0300, Mike Rapoport wrote:
> Right, but TBH, I didn't update efi_free_boot_services() in my initial
> version. I've added similar change there now and I'm waiting now to see if
> kbuild is happy with this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=x86/reservelow

Right, also I'm guessing that first patch should be

Cc: <stable@vger.kernel.org>

as there was one report with failing boot, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
