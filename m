Return-path: <kexec-bounces@lists.infradead.org>
Received: from gw.goop.org ([64.81.55.164] helo=mail.goop.org)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Iifie-0007Mh-Bi
	for kexec@lists.infradead.org; Fri, 19 Oct 2007 01:28:07 +0100
Message-ID: <4717F9E6.6080705@goop.org>
Date: Thu, 18 Oct 2007 17:27:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [patch 1/3] Add BSS to resource tree
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
	<20071018142642.5b3f6ba4.akpm@linux-foundation.org>
	<20071018214836.GA3459@bingen.suse.de>
	<20071018215827.GB23708@uranus.ravnborg.org>
	<20071018220048.GB3459@bingen.suse.de>
	<20071018221813.GA23801@uranus.ravnborg.org>
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

Sam Ravnborg wrote:
> And I recall that extern char sym[] is considered correct by binutils 
> people - but I'm not 100% sure and google did not give me an appropriate hit.

Yes, I generally prefer char[] - but only because gcc irritatingly
rejects void []...

    J

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
