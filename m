Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aTd60-00085H-AG
 for kexec@lists.infradead.org; Wed, 10 Feb 2016 22:18:49 +0000
Received: by mail-wm0-x22a.google.com with SMTP id g62so46094337wme.0
 for <kexec@lists.infradead.org>; Wed, 10 Feb 2016 14:18:27 -0800 (PST)
Date: Wed, 10 Feb 2016 23:18:17 +0100
From: Ivan Delalande <colona@arista.com>
Subject: Re: [PATCH 3/3] makedumpfile: Rewrite readpage_elf
Message-ID: <20160210221817.GJ382@ycc.fr>
References: <20160210084737.3060fb5a@hananiah.suse.cz>
 <20160210085009.4df4d14d@hananiah.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160210085009.4df4d14d@hananiah.suse.cz>
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
To: Petr Tesarik <ptesarik@suse.cz>
Cc: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>, kexec mailing list <kexec@lists.infradead.org>

On Wed, Feb 10, 2016 at 08:50:09AM +0100, Petr Tesarik wrote:
> The current code in readpage_elf (and readpage_elf_parallel) is extremely
> hard to follow. Additionally, it still does not cover all possible cases.
> For example, attempts to read outside of any ELF segment will end up with
> phys_start being 0, frac_head a negative number, interpreted as a large
> positive number by memset() and write past buffer end.
> 
> Instead of trying to handle even more "corner cases", I rewrote the
> algorithm from scratch. The basic idea is simple: set a goal to fill the
> page buffer with data, then work towards that goal by:
> 
>   - filling holes with zeroes (see Note below),
>   - p_filesz portions with file data and
>   - remaining p_memsz portions again with zeroes.
> 
> Repeat this method for each LOAD until the goal is achieved, or an error
> occurs. In most cases, the loop runs only once.
> 
> Note: A "hole" is data at a physical address that is not covered by any
> ELF LOAD program header. In other words, the ELF file does not specify
> any data for such a hole (not even zeroes). So, why does makedumpfile
> fill them with zeroes? It's because makedumpfile works with page
> granularity (the compressed format does not even have a way to store
> a partial page), so if only part of a page is stored, a complete page
> must be provided to make this partial data accessible.
> 
> Credits to Ivan Delalande <colona@arista.com> who first found the
> problem and wrote the original fix.
> 
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>

Tested-by: Ivan Delalande <colona@arista.com>

Dump-dmesg works well and gives the expected results with our various
setups (x86_64 only). Thanks for your work Petr!

-- 
Ivan "Colona" Delalande
Arista Networks

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
