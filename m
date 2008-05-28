Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from an-out-0708.google.com ([209.85.132.249])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K19qQ-000781-QX
	for kexec@lists.infradead.org; Wed, 28 May 2008 00:48:47 +0000
Received: by an-out-0708.google.com with SMTP id c24so619154ana.99
	for <kexec@lists.infradead.org>; Tue, 27 May 2008 17:48:45 -0700 (PDT)
Message-ID: <e2ed954f0805271748s2254480at35f71c3395072def@mail.gmail.com>
Date: Tue, 27 May 2008 17:48:44 -0700
From: "Jamey Sharp" <jamey@minilop.net>
Subject: Re: [PATCH] Use 'long long' for printf() format string and ELF64
	numbers.
In-Reply-To: <20080525221154.2fd2e432@kopernikus.site>
MIME-Version: 1.0
Content-Disposition: inline
References: <20080525221154.2fd2e432@kopernikus.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

On Sun, May 25, 2008 at 1:11 PM, Bernhard Walle <bwalle@suse.de> wrote:
>  kexec/crashdump-elf.c:160: warning: format '%lx' expects type \
>        'long unsigned int', but argument 4 has type 'Elf64_Off'

This is what inttypes.h is for, right?

> dbgprintf("%s: p_type = %u, p_offset = 0x%llx p_paddr = 0x%llx " ...

Perhaps (... "p_offset = 0x" PRIx64 " p_paddr = 0x" PRIx64 ...)?

Jamey

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
