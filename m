Return-path: <kexec-bounces@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IidkI-0002yf-RE
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 23:21:42 +0100
Date: Fri, 19 Oct 2007 00:20:37 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 1/3] Add BSS to resource tree
Message-ID: <20071018222037.GC3459@bingen.suse.de>
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
	<20071018142642.5b3f6ba4.akpm@linux-foundation.org>
	<20071018214836.GA3459@bingen.suse.de>
	<20071018215827.GB23708@uranus.ravnborg.org>
	<20071018220048.GB3459@bingen.suse.de>
	<20071018221813.GA23801@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071018221813.GA23801@uranus.ravnborg.org>
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
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>

> Grepping for _text shows that there are plenty of different ways to declare
> that symbol extern - this does not look correct.

They really don't have a specific type and using the type that happens to be convenient 
to whatever calculation you want to do with it is useful.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
