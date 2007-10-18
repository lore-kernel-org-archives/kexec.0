Return-path: <kexec-bounces@lists.infradead.org>
Received: from ns1.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Iie8i-00043a-3I
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 23:46:52 +0100
Date: Fri, 19 Oct 2007 00:45:51 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/3] Add BSS to resource tree
Message-ID: <20071018224550.GD3459@bingen.suse.de>
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
	<20071018142642.5b3f6ba4.akpm@linux-foundation.org>
	<20071018214836.GA3459@bingen.suse.de>
	<20071018215827.GB23708@uranus.ravnborg.org>
	<20071018220048.GB3459@bingen.suse.de>
	<20071018221813.GA23801@uranus.ravnborg.org>
	<20071018153751.c9c458c8.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071018153751.c9c458c8.akpm@linux-foundation.org>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: bwalle@suse.de, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Sam Ravnborg <sam@ravnborg.org>

On Thu, Oct 18, 2007 at 03:37:51PM -0700, Andrew Morton wrote:
> On Fri, 19 Oct 2007 00:18:13 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > And I recall that extern char sym[] is considered correct by binutils 
> > people - but I'm not 100% sure and google did not give me an appropriate hit.
> 
> An ancient memory tells me that these things are traditionally
> declared as plain old int:
> 
> extern int start;
> extern int edata;

int is probably one of the less useful types. Typical operation is computing
the difference between two symbols in bytes. &int without cast would give
you a useless scaled size.

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
