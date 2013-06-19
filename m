Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UpIWI-0003V7-AS
 for kexec@lists.infradead.org; Wed, 19 Jun 2013 13:33:55 +0000
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 50BB8A52D8
 for <kexec@lists.infradead.org>; Wed, 19 Jun 2013 15:33:29 +0200 (CEST)
Date: Wed, 19 Jun 2013 15:33:29 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: Cross architecture analysis for Crash
Message-ID: <20130619153329.1bae4324@azariah.suse.cz>
In-Reply-To: <51BAEBFA.3080204@in.ibm.com>
References: <51BAEBFA.3080204@in.ibm.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Fri, 14 Jun 2013 15:40:02 +0530
"Suzuki K. Poulose" <suzuki@in.ibm.com> wrote:

> Hi,
> 
> We have been working on enabling 'cross' analysis support for
> Crash, where the target and the host differ in endian-ness.
> 
> For e.g, analysing a powerpc dump on an Intel box.
> 
> This would be useful for debugging the dumps captured on an
> embedded board (say ppc44x), on a normal desktop PC(Intel based).
> 
> While the patches are being tested for 'Crash' utility we came
> across a problem with the analysis of the compressed dump formats(aka 
> diskdump). There is no information about the endian-ness of the dump
> unlike the ELF format. Hence, we need to embed this information during
> the makedumpfile processing of vmcores.
> 
> Here are some of the options we thought about :
> 
> 1) Interpret the new_utsname.machine and decode the endian-ness/word
> size.
> 
> 2) Extend the signature string to contain information about the
> endian-ness / word size.
> 
> 	e.g, KDUMPB64 - for KDUMP, BigEndian 64bit

I had the same issue with a dump identification tool. I ended up with
checking whether the fields are "sane" if interpreted in a specific
way. You may want to check my code here:

http://sourceforge.net/projects/kdumpid/

I agree that this is ugly and a better approach would be to store the
information in the header, but then you would not be able to read
legacy dumps, which is a major drawback.

BTW how far did you get with a cross-platform crash? I did some research
on this subject earlier, so maybe I can help you avoid some dead ends..?

HTH,
Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
