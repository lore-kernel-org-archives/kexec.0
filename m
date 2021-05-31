Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnisX-00CZUs-6M
 for kexec@lists.infradead.org; Mon, 31 May 2021 14:26:54 +0000
Date: Mon, 31 May 2021 16:26:42 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/efi: unconditionally hold the whole low-1MB
 memory regions
Message-ID: <YLTyIn2S9wCB88Es@zn.tnic>
References: <20210531090023.16471-1-lijiang@redhat.com>
 <YLSnkKeoQnokXVsK@zn.tnic> <YLSzUBQ/7CyINu87@kernel.org>
 <YLS/1sqz6Bncg5VU@zn.tnic> <YLTTR5bpOv3XNu32@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLTTR5bpOv3XNu32@kernel.org>
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

On Mon, May 31, 2021 at 03:15:03PM +0300, Mike Rapoport wrote:
> Hmm, why?
> The regression is from v5.13-rc1, isn't it?

Ah ok

a799c2bd29d1 ("x86/setup: Consolidate early memory reservations")

went into -rc1.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
