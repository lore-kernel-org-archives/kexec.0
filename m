Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JDAQW-0002L7-FH
	for kexec@lists.infradead.org; Fri, 11 Jan 2008 03:19:30 +0000
Date: Fri, 11 Jan 2008 12:19:18 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: minor patch to kexec-elf-rel-x86_64.c
Message-ID: <20080111031918.GB13135@verge.net.au>
References: <26DE1597-CE35-45A9-A765-BC0D2B6ED77D@lanl.gov>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <26DE1597-CE35-45A9-A765-BC0D2B6ED77D@lanl.gov>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kevint <kevint@lanl.gov>
Cc: kexec@lists.infradead.org

On Thu, Jan 10, 2008 at 11:07:53AM -0700, kevint wrote:
> I included a one-line patch to kexec-tools-testing, at Bernhard Walle's 
> request.  This prints the relocation type as a string.  I noticed that 
> other architectures do not use reloc_name, but instead just print the 
> r_type.  I find the reloc_name useful.

Hi Kevin,

that looks fine to me. I notice that other archs don't seem to have
reloc_name(), so unfortunately it looks like a bit of a chore to switch
them over to use it in the log message.

I'm wondering if you could provide a sign-off line as per
section 5 of http://linux.yyz.us/patch-format.html

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
