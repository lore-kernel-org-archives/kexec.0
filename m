Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRLpQ-0002Df-65
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 06:19:44 +0000
Date: Tue, 19 Feb 2008 15:19:40 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: reloc_name
Message-ID: <20080219061938.GD8917@verge.net.au>
References: <3E21B264-7964-4A77-ADD9-64934D3D6AAF@lanl.gov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3E21B264-7964-4A77-ADD9-64934D3D6AAF@lanl.gov>
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
To: kevint <kevint@lanl.gov>
Cc: kexec@lists.infradead.org

On Tue, Jan 15, 2008 at 05:53:19PM -0700, kevint wrote:
> This isn't a high priority issue- just something I am looking at in my 
> spare time.  I would appreciate any advice you can provide.
>
> I am looking through some of the kexec elf relocation code, and noticed 
> that reloc_name is only defined for x86_64.  I started writing this 
> function for the other architectures, but noticed that some of the other 
> architectures do not have contiguous r_type numbers (from include/elf.h). 
>  In the x86_64 reloc_name code, r_name is an array of strings with all of 
> the relocation names.  I can't (AFAIK) use a similar approach to 
> architectures with non-contiguous r_type numbers.
>
> My questions:
>
> Is it valuable to print out the relocation type as a string?  (I  
> personally find it helpful)
>
> If so, should the reloc_name function still reside in the kexec-elf- 
> rel-$ARCH.c file?  There are 81 IA64 relocations, which make the file  
> considerably longer.
>
> If not, should there be consistency between the different architectures 
> with regards to these types of error messages?  Should the X86_64 file 
> print out the r_type instead of the string?

I also noticed this when I applied your patch to pront out r_string on
x86_64. I'm all in favour of consistency. Though I think its ok
to have an r_type and an r_string version, where the latter can
be viewd as the aim for arhitectures that use the former.

As for bloating rel-$ARCH.c, I don't think that is much of
a problem if there is no existing header to use.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
