Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Iie0J-0003Xv-K7
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 23:38:15 +0100
Date: Thu, 18 Oct 2007 15:37:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/3] Add BSS to resource tree
Message-Id: <20071018153751.c9c458c8.akpm@linux-foundation.org>
In-Reply-To: <20071018221813.GA23801@uranus.ravnborg.org>
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
	<20071018142642.5b3f6ba4.akpm@linux-foundation.org>
	<20071018214836.GA3459@bingen.suse.de>
	<20071018215827.GB23708@uranus.ravnborg.org>
	<20071018220048.GB3459@bingen.suse.de>
	<20071018221813.GA23801@uranus.ravnborg.org>
Mime-Version: 1.0
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
Cc: bwalle@suse.de, vgoyal@in.ibm.com, kexec@lists.infradead.org, ak@suse.de, linux-kernel@vger.kernel.org

On Fri, 19 Oct 2007 00:18:13 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> And I recall that extern char sym[] is considered correct by binutils 
> people - but I'm not 100% sure and google did not give me an appropriate hit.

An ancient memory tells me that these things are traditionally
declared as plain old int:

extern int start;
extern int edata;

etc.

However
http://techpubs.sgi.com/library/tpl/cgi-bin/getdoc.cgi?coll=0650&db=man&fname=/usr/share/catman/p_man/cat3/standard/_rt_symbol_table_size.z
disagrees with me.

http://www.psych.upenn.edu/~saul/parasite/man/man3/end.3.html agrees with me

http://docsrv.sco.com:507/en/man/html.S/end.S.html agrees with me

http://www.rocketaware.com/man/man3/end.3.htm agrees with me

http://bama.ua.edu/cgi-bin/man-cgi?etext+3C agrees with me



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
